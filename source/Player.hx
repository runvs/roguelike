package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class Player extends Creature
{
	public var properties : PlayerProperties;
	
	public function new() 
	{
		super();
		
		properties = new PlayerProperties();
		
		this.makeGraphic(GameProperties.TileSize, GameProperties.TileSize);
		
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed,  GameProperties.Player_MaxSpeed);
	}
	
	override public function update()
	{
		getInput();
		super.update();
	}
	
	private function getInput () : Void 
	{
		acceleration.set(0, 0);
		var left : Bool = false;
		var right : Bool = false;
		
		if (FlxG.keys.anyPressed(["A", "LEFT"]))
			left = true;
		if (FlxG.keys.anyPressed(["D", "RIGHT"]))
			right = true;
			
		if (left && !right)
		{
			moveLeft();
		}
		else if (right != left)
		{
			moveRight();
		}
		else
		{
			// do nothing, since both or no key is pressed
		}
		
		
		var up : Bool = false;
		var down : Bool = false;
		
		if (FlxG.keys.anyPressed(["W", "UP"]))
			up = true;
		if (FlxG.keys.anyPressed(["S", "DOWN"]))
			down = true;
			
		if (up && !down)
		{
			moveUp();
		}
		else if (down != up)
		{
			moveDown();
		}
		else
		{
			// do nothing, since both or no key is pressed
		}
		
		var shoot: Bool = false;
		if (FlxG.keys.anyPressed(["SPACE"]))
		{
			shoot = true;
		}
		if (shoot)
		{
			//Shoot();
		}
	}
	
	

}
