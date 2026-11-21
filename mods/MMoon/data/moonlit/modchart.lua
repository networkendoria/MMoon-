-- MMoon / Moonlit — Psych Engine 0.7.3
-- Original visual effects. No copyrighted assets required.

local beatPulse = 0
local introShown = false

function onCreate()
    makeLuaSprite('mmoonVignette', nil, 0, 0)
    makeGraphic('mmoonVignette', 1280, 720, '080512')
    setObjectCamera('mmoonVignette', 'other')
    setProperty('mmoonVignette.alpha', 0.0)
    addLuaSprite('mmoonVignette', true)

    makeLuaText('mmoonTitle', 'MMOON  //  THE SIGNAL IS AWAKE', 900, 190, 80)
    setTextSize('mmoonTitle', 24)
    setTextAlignment('mmoonTitle', 'center')
    setTextColor('mmoonTitle', 'B9D9FF')
    setObjectCamera('mmoonTitle', 'hud')
    setProperty('mmoonTitle.alpha', 0)
    addLuaText('mmoonTitle')
end

function onCreatePost()
    setProperty('camGame.zoom', 0.88)
    setProperty('camHUD.alpha', 0.85)
    doTweenAlpha('mmIntroFade', 'mmoonTitle', 1, 1.4, 'quadOut')
    runTimer('mmIntroHold', 2.6)
end

function onTimerCompleted(tag)
    if tag == 'mmIntroHold' then
        doTweenAlpha('mmIntroOut', 'mmoonTitle', 0, 1.2, 'quadIn')
        doTweenAlpha('mmVignetteIn', 'mmoonVignette', 0.22, 2, 'quadOut')
    end
end

function onBeatHit()
    beatPulse = beatPulse + 1
    if beatPulse % 4 == 0 then
        setProperty('camGame.zoom', 0.91)
        doTweenZoom('mmCameraPulse', 'camGame', 0.88, 0.22, 'quadOut')
    end
    if beatPulse % 16 == 0 then
        cameraFlash('game', '18223B', 0.12, false)
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        setProperty('camHUD.angle', direction % 2 == 0 and -0.35 or 0.35)
        doTweenAngle('mmHudReturn', 'camHUD', 0, 0.12, 'quadOut')
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    cameraShake('game', 0.006, 0.16)
    cameraFlash('hud', '5B102A', 0.18, true)
    setProperty('health', math.max(0.05, getProperty('health') - 0.025))
end

function onDestroy()
    cancelTween('mmCameraPulse')
    cancelTween('mmHudReturn')
end
