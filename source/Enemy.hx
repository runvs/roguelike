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
	
	public var properties : EnemyPropeties;


	public function new() 
	{
		super();
		
		properties = new EnemyPropeties( 1 );
		
		//makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.RED);
		loadGraphic(AssetPaths.Enemy__png, true, 32, 32);
		this.animation.add("idle", [0, 1, 2, 3, 4],FlxRandom.intRanged(4,6));
		this.animation.add("walk", [5, 6, 7, 8]);
		this.animation.play("idle", false, FlxRandom.intRanged(0,3));
		
		//this.offset.set();
		//this.origin.set();
		//this.scale.set(2, 2);
		//this.updateHitbox();
		
		randomwalkTimer = 1.5;
		randomWalkDirection = FlxRandom.intRanged(0, 3);
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed * 0.5,  GameProperties.Player_MaxSpeed * 0.5);
	}
	
	override  public function update ()
	{
		acceleration.set(0, 0);
		doKIStuff();
		
		super.update();
	}
	
	private function doKIStuff()
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
	
	
	public function TakeDamage ( d : Int ) : Void 
	{
		properties.currentHP -= d;
		trace ("take damage " + Std.string(d) + " newHP " + Std.string(properties.currentHP));
		if (properties.currentHP <= 0)
		{
			alive = false;
		}
	}
	
	public static function handleWallCollision(enemy:Enemy, wall:FlxObject)
	{
		enemy.randomWalkDirection = (enemy.randomWalkDirection + 2) % 4;
	}
}