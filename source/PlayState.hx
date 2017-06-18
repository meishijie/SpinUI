package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import haxe.macro.Expr.TypeDefinition;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.themes.DefaultTheme;
import openfl.events.MouseEvent;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.themes.GradientTheme;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.style.Style;
import flixel.util.FlxColor;

enum State {
        RUN;
        END;
		OVER;
    }
class PlayState extends FlxState
{	
	private var _player:Player;
	private var _coinNum:Int = 0;
	private var _coinTxt:FlxText;
	private var _spins:Int = 5;
	private var _spinsTxt:FlxText;
	private var _exp:Int = 1000;
	private var _tofinish:Int = 15000;
	private var _level:Int = 1;
	
	public static var _anglescale:Float = 1;
	private var gamestate:State;
	
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0xFFF1F1F1;
		gamestate = RUN;
		_coinTxt = new FlxText(20, 20, 10000, "ddd", 18);
		_coinTxt.color = FlxColor.BLACK;
		_coinTxt.text = Std.string(_coinNum);
		add(_coinTxt);
		
		_spinsTxt = new FlxText(FlxG.width / 2, 50, 10000, "ddd", 18);
		_spinsTxt.color = FlxColor.BLACK;
		_spinsTxt.text = Std.string(_spins);
		add(_spinsTxt);
		//创建player
		_player = new Player(0,0);
		add(_player);
		
		
		
		Toolkit.theme = new DefaultTheme();
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			root.addChild(new LayoutsController().view);
			root.style.backgroundAlpha = 0;
		});
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		_coinTxt.text = Std.string(_coinNum);
		_spinsTxt.text = Std.string(_spins);
		for (swipe in FlxG.swipes)
		{
			//trace(swipe.distance);
			//trace(Math.floor(swipe.distance / swipe.duration));
			if(swipe.distance>50 && swipe.duration<0.5 && _spins>0){
				_player.angularVelocity += swipe.distance / swipe.duration + _anglescale * 10;
				//-1
				_spins--;
				if (_spins ==0){
					//gameend();//gameend
				}
				trace(_spins);
			}
		}
		/*if (_player.angle>=360){
			_player.angle = 0;
		}*/
		//速度快时 分数加成
		if (_player.angularVelocity > 1400){
			_exp = Std.int(_player.angle+_player.angularVelocity);
			//trace(_player.angularVelocity );
		}
		_exp = Std.int(_player.angle);
		//trace(_exp);
		//trace(_player.angularVelocity );
		if (_player.angularVelocity == 0 && gamestate == RUN){
			//只执行一次gameend
			gamestate = END;
			gameend();
		}
		
	}
	private function gameend(){
		//
		trace("game end");
	}
	
	public static function test(){
		trace("ok");
	}



}



//载入ui
private class LayoutsController extends XMLController {
	public function new() {
		super("assets/layouts.xml");
		
		for (i in 0...10){
			var btid = "bt"+i;
			var bt:Button = new Button();
			bt.id = btid;//
			bt.width = 100;
			bt.height = 100;
			bt.userData = i;//
			getComponentAs("allItem", HBox).addChild(bt);
			trace(bt.id);
			
			bt.addEventListener(MouseEvent.CLICK, function(e) {
				trace(bt.id);
				trace(bt.userData);
				for (i in 0...getComponentAs("allItem", HBox).numChildren){
					getComponentAs("allItem", HBox).findChild("bt" + i, Button).style.borderSize = 0;
					//trace(getComponentAs("allItem", HBox).numChildren);
				}
				bt.style.borderSize = 1;
				PlayState._anglescale = bt.userData;
				PlayState.test();
			});
		}
		
		//bt.style.borderSize = 1;
		/*attachEvent(btid, MouseEvent.CLICK, function(e) {
			var bt = getComponentAs(btid, Button);
			bt.style.borderSize = 1;
			PlayState._anglescale = bt.userData;
			PlayState.test();
		});*/
		//getComponentAs("theView", ScrollView).y = FlxG.height - 200;
		
		getComponentAs("mainview", VBox).y = FlxG.height-getComponentAs("mainview", VBox).height ;
		//trace(getComponentAs("theView", ScrollView).y);
	}
}