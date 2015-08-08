package;

import flixel.FlxSprite;

/**
 * ...
 * @author 
 */
class Creature extends FlxSprite
{

	private var lastFacing : EFacing;
	
	public function new() 
	{
		super();
		lastFacing = EFacing.Left;
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
					lastFacing = EFacing.Right;
				}
				else
				{
					// walk left animation
					lastFacing = EFacing.Left;
				}
			}
			else
			{
				if (vy > 0)
				{
					// walk down animation
					lastFacing = EFacing.Down;
				}
				else
				{
					// walk up animation
					lastFacing = EFacing.Up;
				}
			}
		}
		else
		{
			// idle animation
		}
	}
	
	public function getLastFacing() : EFacing
	{
		return lastFacing;
	}
}