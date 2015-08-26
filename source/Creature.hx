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
	
	private var accelFactor : Float ;

	public function new() 
	{
		super();
		accelFactor = 1.0;
		lastFacing = EFacing.Left;
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
	}
	
	override public function update()
	{
		if (alive)
		{
			updateHitbox();
			doAnimationStuff();
		}
		super.update();
	}
	
	
	public function moveLeft() : Void 
	{
		lastFacing = EFacing.Left;
		acceleration.x = -GameProperties.Player_Speed * accelFactor;
	}
	
	public function moveRight() : Void 
	{
		lastFacing = EFacing.Right;
		acceleration.x = GameProperties.Player_Speed * accelFactor;
	}
	
	private function moveUp() : Void 
	{
		lastFacing = EFacing.Up;
		acceleration.y = -GameProperties.Player_Speed * accelFactor;
	}
	
	private function moveDown() : Void 
	{
		lastFacing = EFacing.Down;
		acceleration.y = GameProperties.Player_Speed * accelFactor;
	}
	
	function doAnimationStuff():Void 
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
					facing = FlxObject.RIGHT;
				}
				else
				{
					this.animation.play("walk");
					facing = FlxObject.LEFT;
				}
			}
			else
			{
				if (vy > 0)
				{
					this.animation.play("walk");
					// walk down animation
				}
				else
				{
					this.animation.play("walk");
					// walk up animation
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