-- MMoon original procedural stage for Psych Engine 0.7.3.
-- Uses only generated flat-color shapes, so no external art is required.

function onCreate()
    makeLuaSprite('abyssBg', nil, -700, -400)
    makeGraphic('abyssBg', 2700, 1700, '070610')
    addLuaSprite('abyssBg', false)

    makeLuaSprite('abyssHorizon', nil, -500, 360)
    makeGraphic('abyssHorizon', 2400, 5, '243B65')
    setProperty('abyssHorizon.alpha', 0.65)
    addLuaSprite('abyssHorizon', false)

    makeLuaSprite('abyssEyeOuter', nil, 820, 30)
    makeGraphic('abyssEyeOuter', 210, 210, '10172C')
    setProperty('abyssEyeOuter.alpha', 0.95)
    addLuaSprite('abyssEyeOuter', false)

    makeLuaSprite('abyssEye', nil, 875, 85)
    makeGraphic('abyssEye', 100, 100, 'A7D7FF')
    addLuaSprite('abyssEye', false)

    makeLuaSprite('abyssPupil', nil, 910, 120)
    makeGraphic('abyssPupil', 32, 32, '03040A')
    addLuaSprite('abyssPupil', false)

    makeLuaSprite('abyssFloor', nil, -500, 590)
    makeGraphic('abyssFloor', 2400, 500, '0D0A18')
    addLuaSprite('abyssFloor', false)

    makeLuaSprite('abyssFloorLine', nil, -500, 590)
    makeGraphic('abyssFloorLine', 2400, 3, '426A9B')
    setProperty('abyssFloorLine.alpha', 0.7)
    addLuaSprite('abyssFloorLine', false)
end

function onBeatHit()
    if curBeat % 2 == 0 then
        doTweenAlpha('eyeBlink', 'abyssEye', 0.35, 0.08, 'linear')
    else
        doTweenAlpha('eyeBlinkBack', 'abyssEye', 1, 0.18, 'linear')
    end
end
