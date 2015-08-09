package;

import flixel.FlxObject;
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
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
	}
	
	override public function update()
	{
		updateHitbox();
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
					this.animation.play("walk");
					lastFacing = EFacing.Right;
					facing = FlxObject.RIGHT;
				}
				else
				{
					this.animation.play("walk");
					lastFacing = EFacing.Left;
					facing = FlxObject.LEFT;
				}
			}
			else
			{
				if (vy > 0)
				{
					this.animation.play("walk");
					// walk down animation
					lastFacing = EFacing.Down;
				}
				else
				{
					this.animation.play("walk");
					// walk up animation
					lastFacing = EFacing.Up;
				}
			}
		}
		else
		{
			// idle animation
			this.animation.play("idle");
		}
	}
	
	public function getLastFacing() : EFacing
	{
		return lastFacing;
	}
	
	
	
}