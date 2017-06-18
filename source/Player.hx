package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
import flixel.ui.FlxVirtualPad;
/**
 * ...
 * @author .:BuzzJeux:.
 */
enum MoveDirection
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}

class Player extends FlxSprite
{
	
	private static  var MOVEMENT_SPEED:Int = 2;
	
	private var moveDirection:MoveDirection;
	
	public function new(X:Float, Y:Float)
	{
		// X,Y: Starting coordinates
		super(X, Y);
		loadGraphic("assets/images/main.png");
		//setGraphicSize(300, 300);
		this.scale = new FlxPoint(0.5, 0.5);
		centerOffsets();
		screenCenter();
		this.angularVelocity = 800;
		this.angularDrag = 300;
		//this.angularAcceleration = 500;
		this.maxAngular = 2000;
		this.antialiasing = true;
			
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);  
		
	}
	
}