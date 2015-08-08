package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class Player extends FlxSprite
{
	
	var properties : PlayerProperties;
	
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
		super.update();
		
		getInput();
		doMovement();
	}
	
	function doMovement():Void 
	{
		var vx : Float = velocity.x;
		var vy : Float = velocity.y;
		// animation stuff
		if (vx * vx + vy * vy >= 1)
		{
			if (Math.abs(vx) > Math.abs(vy))
			{
				if (vx > 0)
				{
					// walk right animation
				}
				else
				{
					// walk left animation
				}
			}
			else
			{
				if (vy > 0)
				{
					// walk down animation
				}
				else
				{
					// walk up animation
				}
			}
		}
		else
		{
			// idle animation
		}
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
			steerLeft();
		}
		else if (right != left)
		{
			steerRight();
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
			steerUp();
		}
		else if (down != up)
		{
			steerDown();
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
	
	
	public function steerLeft() : Void 
	{
		acceleration.x = -GameProperties.Player_Speed;
	}
	
	public function steerRight() : Void 
	{
		acceleration.x = GameProperties.Player_Speed;
	}
	
	private function steerUp() : Void 
	{
		acceleration.y = -GameProperties.Player_Speed;
	}
	
	private function steerDown() : Void 
	{
		acceleration.y = GameProperties.Player_Speed;
	}
	
}
