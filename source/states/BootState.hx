package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class BootState extends FlxState
{
    override public function create():Void
    {
        super.create();

        // Temporary foundation screen. The real title screen will replace this.
        FlxG.camera.bgColor = FlxColor.fromRGB(8, 8, 18);

        var title = new FlxText(0, 300, FlxG.width, "MMOON", 54);
        title.setFormat(null, 54, FlxColor.fromRGB(100, 225, 255), CENTER);
        add(title);

        var subtitle = new FlxText(0, 370, FlxG.width, "RHYTHM  //  HORROR", 18);
        subtitle.setFormat(null, 18, FlxColor.fromRGB(150, 155, 185), CENTER);
        add(subtitle);
    }
}
