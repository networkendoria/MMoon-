package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxTextAlign;
import flixel.util.FlxColor;

class BootState extends FlxState
{
    override public function create():Void
    {
        super.create();
        FlxG.camera.bgColor = FlxColor.fromRGB(5, 6, 15);

        var title = new FlxText(0, 210, FlxG.width, "MMOON", 76);
        title.setFormat(null, 76, FlxColor.fromRGB(105, 225, 255), FlxTextAlign.CENTER);
        add(title);

        var subtitle = new FlxText(0, 305, FlxG.width, "THE NIGHT IS LISTENING", 20);
        subtitle.setFormat(null, 20, FlxColor.fromRGB(180, 190, 220), FlxTextAlign.CENTER);
        add(subtitle);

        var instruction = new FlxText(0, 470, FlxG.width, "TAP ANYWHERE TO START", 24);
        instruction.setFormat(null, 24, FlxColor.WHITE, FlxTextAlign.CENTER);
        add(instruction);

        var hint = new FlxText(0, 520, FlxG.width, "Prototype 0.2  |  Touch / Keyboard", 14);
        hint.setFormat(null, 14, FlxColor.fromRGB(110, 120, 150), FlxTextAlign.CENTER);
        add(hint);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (FlxG.mouse.justPressed)
            FlxG.switchState(new PlayState());
    }
}
