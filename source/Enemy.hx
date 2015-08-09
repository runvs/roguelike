package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author 
 */
class Enemy extends Creature
{
	
	private var randomwalkTimer : Float;
	private var randomWalkDirection : Int;
	
	private var walkTarget : FlxObject;
	
	private var attackTimer : Float;
	
	public var properties : EnemyPropeties;
	public var doRandomWalk:Bool;


	public function new(l:Int) 
	{
		super();
		
		properties = new EnemyPropeties( l );
		accelFactor = 0.9;
		
		//makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.RED);
		loadGraphic(AssetPaths.Enemy__png, true, 32, 32);
		this.animation.add("idle", [0, 1, 2, 3, 4],FlxRandom.intRanged(4,6));
		this.animation.add("walk", [5, 6, 7, 8], 7);
		this.animation.play("idle", false, FlxRandom.intRanged(0, 3));
		this.animation.add("dead", [9], 30, true);
		
		//this.offset.set();
		//this.origin.set();
		//this.scale.set(2, 2);
		//this.updateHitbox();
		
		attackTimer = GameProperties.Enemy_AttackTimer;
		
		doRandomWalk = true;
		randomwalkTimer = 1.5;
		randomWalkDirection = FlxRandom.intRanged(0, 3);
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed * 0.5,  GameProperties.Player_MaxSpeed * 0.5);
	}
	
	override  public function update ()
	{
		if (alive)
		{
			acceleration.set(0, 0);
			doKIStuff();

		}
		else
		{
			animation.play("dead", true);
		}
		super.update();
	}
	
	private function doKIStuff()
	{
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
	
	public function walkTowards(obj:FlxObject) : Void
	{
		walkTarget = obj;
	}
	
	public function TakeDamage ( d : Int ) : Void 
	{
		properties.currentHP -= d;
		//trace ("take damage " + Std.string(d) + " newHP " + Std.string(properties.currentHP));
		if (properties.currentHP <= 0)
		{
			alive = false;
			active = false;
			animation.play("dead", true);
			this.velocity.set();
			acceleration.set();
		}
	}
	
	public static function handleWallCollision(enemy:Enemy, wall:FlxObject):Void
	{
		enemy.randomWalkDirection = (enemy.randomWalkDirection + 2) % 4;
	}
	
	public static function handlePlayerCollision(player:Player, enemy:Enemy):Void
	{
		if (enemy.attackTimer <= 0.0)
		{
			player.properties.takeDamage(enemy.properties.baseDamage);
			
			enemy.attackTimer += GameProperties.Enemy_AttackTimer;
		}
	}
}