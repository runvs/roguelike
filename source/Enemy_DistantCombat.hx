package;
import flixel.FlxG;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Enemy_DistantCombat extends BasicEnemy
{

	public function new(l:Int) 
	{
		super(l);
		
		loadGraphic(AssetPaths.Enemy2__png, true, 32, 32);
		this.animation.add("idle", [0, 1, 2, 3, 4],FlxG.random.int(4,6));
		this.animation.add("walk", [5, 6, 7, 8], 5);
		this.animation.play("idle", false, FlxG.random.int(0, 3));
		this.animation.add("dead", [9], 30, true);
		
		type = 1;
	}

	
	public override function doKIStuff () : Void 
	{
		var xx:Float = playerX - x;
		var yy:Float = playerY - y;
		var distance:Float = xx * xx + yy * yy;
		
		
		if (distance < 0.25 * GameProperties.Enemy_AggroRadius * GameProperties.Enemy_AggroRadius) 
		{
			// walk away

			xx = - xx;
			yy = - yy;
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
		else if (distance <= 2 *  GameProperties.Enemy_AggroRadius * GameProperties.Enemy_AggroRadius)
		{
			// stand & shoot
			// dont move
			attack();
		}
		else if ( distance <= 6 *  GameProperties.Enemy_AggroRadius * GameProperties.Enemy_AggroRadius)
		{

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
		FlxG.collide(this, player);
	}
	
	public override function attack () : Void 
	{
		if (attackTimer <= 0.0)
		{
			if (player != null)
			{
				var xx = player.x - x;
				var yy = player.y -y ;
				var p : Projectile = new Projectile(x + GameProperties.Tile_Size / 2.0 , y + GameProperties.Tile_Size / 2.0, xx, yy, ProjectileType.EnemyProj, Std.int(0.75*properties.baseDamage), state);
				state.level.spawnEnemyShot(p);
				attackTimer += GameProperties.Enemy_AttackTimer;
			}
		}
	}
}