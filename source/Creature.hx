package;

import flixel.FlxSprite;

/**
 * ...
 * @author 
 */
class Creature extends FlxSprite
{

	public function new() 
	{
		super();
		
	}
	
	override public function update()
	{
		super.update();
		doMovement();
	}
	
	
	public function moveLeft() : Void 
	{
		acceleration.x = -GameProperties.Player_Speed;
	}
	
	public function moveRight() : Void 
	{
		acceleration.x = GameProperties.Player_Speed;
	}
	
	private function moveUp() : Void 
	{
		acceleration.y = -GameProperties.Player_Speed;
	}
	
	private function moveDown() : Void 
	{
		acceleration.y = GameProperties.Player_Speed;
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
}