package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author 
 */
class BasicEnemy extends Creature
{
	
	private var randomwalkTimer : Float;
	private var randomWalkDirection : Int;
	
	private var walkTarget : FlxObject;
	
	private var attackTimer : Float;
	
	public var properties : EnemyPropeties;
	public var doRandomWalk:Bool;

	public var playerX : Float;
	public var playerY : Float;

	public function new(l:Int) 
	{
		super();
		
		properties = new EnemyPropeties( l );
		accelFactor = 0.75;
		playerX = 0;
		playerY = 0;
		
		//makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.RED);
		loadGraphic(AssetPaths.Enemy__png, true, 32, 32);
		this.animation.add("idle", [0, 1, 2, 3, 4],FlxRandom.intRanged(4,6));
		this.animation.add("walk", [5, 6, 7, 8], 5);
		this.animation.play("idle", false, FlxRandom.intRanged(0, 3));
		this.animation.add("dead", [9], 30, true);
		
		attackTimer = GameProperties.Enemy_AttackTimer;
		
		doRandomWalk = true;
		randomwalkTimer = 1.5;
		randomWalkDirection = FlxRandom.intRanged(0, 3);
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed * 0.5,  GameProperties.Player_MaxSpeed * 0.5);
	}
	
	public function setPlayerPosition (px : Float, py :Float) : Void 
	{
		playerX = px;
		playerY = py;
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
	
	public  function doKIStuff()
	{
		// dont do anything, override in child classes
	}
	
	public function walkTowards() : Void
	{
		walkTarget = new FlxObject(playerX, playerY, 0 , 0);
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
			this.color = FlxColorUtil.makeFromARGB(1.0, 100, 100, 100);
		}
	}
	
	public static function handleWallCollision(enemy:BasicEnemy, wall:FlxObject):Void
	{
		enemy.randomWalkDirection = (enemy.randomWalkDirection + 2) % 4;
	}
	
	public static function handlePlayerCollision(player:Player, enemy:BasicEnemy):Void
	{
		if (enemy.attackTimer <= 0.0)
		{
			player.properties.takeDamage(enemy.properties.baseDamage);
			enemy.attackTimer += GameProperties.Enemy_AttackTimer;
		}
	}
}