package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxTextAlign;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
    static inline var HIT_Y:Float = 535;
    static inline var NOTE_SPEED:Float = 310;

    var laneX:Array<Float> = [];
    var laneColors:Array<FlxColor> = [];
    var notes:Array<FlxSprite> = [];
    var noteLanes:Array<Int> = [];
    var chart:Array<Int> = [0, 1, 2, 3, 0, 2, 1, 3, 3, 2, 0, 1, 2, 3, 1, 0, 2, 1, 3, 0, 3, 2, 1, 0];
    var chartIndex:Int = 0;
    var spawnClock:Float = 0;
    var score:Int = 0;
    var combo:Int = 0;
    var misses:Int = 0;
    var scoreText:FlxText;
    var comboText:FlxText;
    var feedbackText:FlxText;
    var ended:Bool = false;

    override public function create():Void
    {
        super.create();
        FlxG.camera.bgColor = FlxColor.fromRGB(7, 8, 18);

        laneColors = [
            FlxColor.fromRGB(75, 205, 255),
            FlxColor.fromRGB(170, 105, 255),
            FlxColor.fromRGB(80, 235, 195),
            FlxColor.fromRGB(255, 90, 145)
        ];

        var title = new FlxText(0, 18, FlxG.width, "MMOON  //  FIRST SIGNAL", 22);
        title.setFormat(null, 22, FlxColor.fromRGB(150, 225, 255), FlxTextAlign.CENTER);
        add(title);

        scoreText = new FlxText(24, 58, 500, "SCORE  0     MISSES  0", 18);
        scoreText.setFormat(null, 18, FlxColor.WHITE, FlxTextAlign.LEFT);
        add(scoreText);

        comboText = new FlxText(0, 90, FlxG.width, "READY", 22);
        comboText.setFormat(null, 22, FlxColor.fromRGB(180, 220, 255), FlxTextAlign.CENTER);
        add(comboText);

        feedbackText = new FlxText(0, 410, FlxG.width, "", 26);
        feedbackText.setFormat(null, 26, FlxColor.WHITE, FlxTextAlign.CENTER);
        add(feedbackText);

        var laneWidth:Float = 112;
        var gap:Float = 18;
        var total:Float = 4 * laneWidth + 3 * gap;
        var startX:Float = (FlxG.width - total) / 2;

        for (i in 0...4)
        {
            var x:Float = startX + i * (laneWidth + gap);
            laneX.push(x);

            var rail = new FlxSprite(x, 145);
            rail.makeGraphic(Std.int(laneWidth), 500, FlxColor.fromRGB(15, 20, 36));
            add(rail);

            var receptor = new FlxSprite(x + 8, HIT_Y);
            receptor.makeGraphic(Std.int(laneWidth - 16), 18, laneColors[i]);
            receptor.alpha = 0.75;
            add(receptor);

            var label = new FlxText(x, 590, laneWidth, ["LEFT", "DOWN", "UP", "RIGHT"][i], 16);
            label.setFormat(null, 16, laneColors[i], FlxTextAlign.CENTER);
            add(label);
        }

        var help = new FlxText(0, 655, FlxG.width, "A / S / W / D  or  tap one of the four lanes", 16);
        help.setFormat(null, 16, FlxColor.fromRGB(150, 160, 185), FlxTextAlign.CENTER);
        add(help);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (ended)
        {
            if (FlxG.mouse.justPressed || FlxG.keys.justPressed.ENTER)
                FlxG.switchState(new BootState());
            return;
        }

        spawnClock += elapsed;
        if (spawnClock >= 0.62 && chartIndex < chart.length)
        {
            spawnClock -= 0.62;
            spawnNote(chart[chartIndex]);
            chartIndex++;
        }

        var i:Int = notes.length - 1;
        while (i >= 0)
        {
            notes[i].y += NOTE_SPEED * elapsed;
            if (notes[i].y > 650)
            {
                removeNote(i);
                misses++;
                combo = 0;
                updateHud();
                feedbackText.text = "MISS";
                feedbackText.color = FlxColor.fromRGB(255, 90, 120);
            }
            i--;
        }

        if (FlxG.keys.justPressed.A || FlxG.keys.justPressed.LEFT) hitLane(0);
        if (FlxG.keys.justPressed.S || FlxG.keys.justPressed.DOWN) hitLane(1);
        if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.UP) hitLane(2);
        if (FlxG.keys.justPressed.D || FlxG.keys.justPressed.RIGHT) hitLane(3);

        // On supported mobile targets, Flixel exposes primary touch through its pointer input.
        if (FlxG.mouse.justPressed)
        {
            for (lane in 0...4)
            {
                if (FlxG.mouse.x >= laneX[lane] && FlxG.mouse.x <= laneX[lane] + 112
                    && FlxG.mouse.y >= 140 && FlxG.mouse.y <= 650)
                {
                    hitLane(lane);
                    break;
                }
            }
        }

        if (chartIndex >= chart.length && notes.length == 0)
            finishSong();
    }

    function spawnNote(lane:Int):Void
    {
        var note = new FlxSprite(laneX[lane] + 13, 135);
        note.makeGraphic(86, 28, laneColors[lane]);
        add(note);
        notes.push(note);
        noteLanes.push(lane);
    }

    function hitLane(lane:Int):Void
    {
        var bestIndex:Int = -1;
        var bestDistance:Float = 999999;

        for (i in 0...notes.length)
        {
            if (noteLanes[i] != lane) continue;
            var distance:Float = Math.abs((notes[i].y + 14) - (HIT_Y + 9));
            if (distance < bestDistance)
            {
                bestDistance = distance;
                bestIndex = i;
            }
        }

        if (bestIndex >= 0 && bestDistance <= 115)
        {
            var points:Int = bestDistance <= 38 ? 350 : (bestDistance <= 75 ? 200 : 100);
            score += points;
            combo++;
            feedbackText.text = bestDistance <= 38 ? "SICK!" : (bestDistance <= 75 ? "GOOD" : "OK");
            feedbackText.color = bestDistance <= 38 ? FlxColor.fromRGB(110, 235, 255) : FlxColor.WHITE;
            removeNote(bestIndex);
        }
        else
        {
            misses++;
            combo = 0;
            feedbackText.text = "MISS";
            feedbackText.color = FlxColor.fromRGB(255, 90, 120);
        }
        updateHud();
    }

    function removeNote(index:Int):Void
    {
        var note = notes[index];
        remove(note, true);
        note.destroy();
        notes.splice(index, 1);
        noteLanes.splice(index, 1);
    }

    function updateHud():Void
    {
        scoreText.text = "SCORE  " + score + "     MISSES  " + misses;
        comboText.text = combo > 0 ? combo + " COMBO" : "KEEP THE BEAT";
    }

    function finishSong():Void
    {
        ended = true;
        feedbackText.text = "SIGNAL ENDED";
        comboText.text = "SCORE  " + score + "   //   MISSES  " + misses;
        var endText = new FlxText(0, 455, FlxG.width, "TAP OR PRESS ENTER TO RETURN", 18);
        endText.setFormat(null, 18, FlxColor.fromRGB(150, 220, 255), FlxTextAlign.CENTER);
        add(endText);
    }
}
