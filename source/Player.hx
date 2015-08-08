package;

import flixel.FlxG;
import flixel.FlxSprite;

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
		
		var mssx = GameProperties.Player_MaxSpeed;
		var mssy = GameProperties.Player_MaxSpeed;
		
		if (vx > mssx)
			vx = mssx;
		if (vx < -mssx)
			vx = -mssx;
			
		if (vy > mssy )
			vy = mssy;
		if (vy < -mssy)
			vy = -mssy;
			
		velocity = new flixel.util.FlxPoint(vx * GameProperties.Player_VelocityDecay , vy * GameProperties.Player_VelocityDecay);
	}
	
	private function getInput () : Void 
	{
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
		velocity.x -= GameProperties.Player_Speed;
	}
	
	public function steerRight() : Void 
	{
		velocity.x += GameProperties.Player_Speed;
	}
	
	private function steerUp() : Void 
	{
		velocity.y -= GameProperties.Player_Speed;
	}
	
	private function steerDown() : Void 
	{
		velocity.y += GameProperties.Player_Speed;
	}
	
}
