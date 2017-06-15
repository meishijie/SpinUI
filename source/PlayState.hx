package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.themes.DefaultTheme;
import openfl.events.MouseEvent;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.themes.GradientTheme;


class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		Toolkit.theme = new DefaultTheme();
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			root.addChild(new LayoutsController().view);
		});
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
private class LayoutsController extends XMLController {
	public function new() {
		super("assets/layouts.xml");
	}
}