package;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class Enemy_CloseCombat extends BasicEnemy
{

	public function new(l:Int) 
	{
		super(l);

		loadGraphic(AssetPaths.Enemy__png, true, 32, 32);
		this.animation.add("idle", [0, 1, 2, 3, 4],FlxG.random.int(4,6));
		this.animation.add("walk", [5, 6, 7, 8], 5);
		this.animation.play("idle", false, FlxG.random.int(0, 3));
		this.animation.add("dead", [9], 30, true);
		
		type = 0;
	}
	
	public override function doKIStuff () : Void 
	{
		var xx:Float = x - playerX;
		var yy:Float = y - playerY;
		var distance:Float = xx * xx + yy * yy;
		
		if (distance <= GameProperties.Enemy_AggroRadius * GameProperties.Enemy_AggroRadius) 
		{
			// move towrads player
			var xx = playerX - x;
			var yy = playerY - y;
			
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
		else
		{
			// do random walk
			randomwalkTimer -= FlxG.elapsed;
			if (randomwalkTimer <= 0)
			{
				randomwalkTimer = FlxG.random.float(2, 5);
				randomWalkDirection = FlxG.random.int(0, 3);
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
		
		if (FlxG.collide(this, player))
		{
			//trace ("attack me");
			attack();
		}
		
	}
	
	
	public override function attack () : Void 
	{
		if (attackTimer <= 0.0)
		{
			if (player != null)
			{
				player.properties.takeDamage(this.properties.baseDamage);
				attackTimer += GameProperties.Enemy_AttackTimer;
			}
		}
	}
}