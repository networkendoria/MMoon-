package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.BootState;

class Main extends Sprite
{
    public function new()
    {
        super();
        addChild(new FlxGame(1280, 720, BootState));
    }
}
