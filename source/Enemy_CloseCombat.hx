package;
import flixel.FlxG;
import flixel.util.FlxRandom;

/**
 * ...
 * @author 
 */
class Enemy_CloseCombat extends BasicEnemy
{

	public function new(l:Int) 
	{
		super(l);
		doRandomWalk = true;
	}
	
	public override function doKIStuff () : Void 
	{
		var xx:Float = x - playerX;
		var yy:Float = y - playerY;
		var distance:Float = xx * xx + yy * yy;
		
		if (distance <= GameProperties.Enemy_AggroRadius * GameProperties.Enemy_AggroRadius) 
		{
			doRandomWalk = false;
			walkTowards();
		}
		else
		{
			doRandomWalk = true;
		}
		
		
		if (attackTimer > 0)
		{
			attackTimer -= FlxG.elapsed;
		}
		
		if (doRandomWalk)
		{			
			randomwalkTimer -= FlxG.elapsed;
			if (randomwalkTimer <= 0)
			{
				randomwalkTimer = FlxRandom.floatRanged(2, 5);
				randomWalkDirection = FlxRandom.intRanged(0, 3);
			}
			
			if (randomWalkDirection == 0)
			{
				moveDown();
			}
			else if (randomWalkDirection == 1)
			{
				moveLeft();
			}
			else if (randomWalkDirection == 2)
			{
				moveUp();
			}
			else 
			{
				moveRight();
			}
		}
		// walk target is obviously in aggro range
		else
		{
			var xx = walkTarget.x - x;
			var yy = walkTarget.y - y;
			
			if (xx > 0)
			{
				// target to the right
				moveRight();
			}
			else
			{
				// target to the left
				moveLeft();
			}
			
			if (yy > 0)
			{
				// target below
				moveDown();
			}
			else
			{
				// target above
				moveUp();
			}
		}
	}
	
	
}