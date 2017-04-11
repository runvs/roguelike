package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class BasicEnemy extends Creature
{
	
	private var randomwalkTimer : Float;
	private var randomWalkDirection : Int;
	
	private var attackTimer : Float;
	private var doAttack : Bool;
	
	public var properties : EnemyPropeties;

	public var playerX : Float;
	public var playerY : Float;

	private var player : Player;
	private var state : PlayState;
	
	public var type : Int ;
	
	private var hitSound : FlxSound;
	public function new(l:Int) 
	{
		super();
		
		properties = new EnemyPropeties( l );
		accelFactor = 0.75;
		playerX = 0;
		playerY = 0;
		player = null;
		
		makeGraphic(GameProperties.Tile_Size, GameProperties.Tile_Size, FlxColor.RED);
		
		attackTimer = GameProperties.Enemy_AttackTimer;
		
		randomwalkTimer = 1.5;
		randomWalkDirection = FlxG.random.int(0, 3);
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed * 0.5,  GameProperties.Player_MaxSpeed * 0.5);
		
		hitSound = new FlxSound();
	
		#if flash
		hitSound = FlxG.sound.load(AssetPaths.hit_enemy__mp3);
		#else
		hitSound = FlxG.sound.load(AssetPaths.hit_enemy__ogg);
		#end
		
	}
	
	public function setState (s : PlayState) : Void 
	{
		state = s;
		player  = s.player;
		playerX = s.player.x;
		playerY = s.player.y;
	}
	
	override  public function update (elapsed:Float)
	{
		doAttack = false;
		if (alive)
		{
			acceleration.set(0, 0);
			if (attackTimer > 0)
			{
				attackTimer -= FlxG.elapsed;
			}
			doKIStuff();
		}
		else
		{
			animation.play("dead", true);
		}
		super.update(elapsed);
	}
	
	public  function doKIStuff()
	{
		// dont do anything, override in child classes
	}
	
	public function TakeDamage ( d : Int ) : Void 
	{
		
		properties.currentHP -= d;
		hitSound.play();
		//trace ("take damage " + Std.string(d) + " newHP " + Std.string(properties.currentHP));
		if (properties.currentHP <= 0)
		{
			alive = false;
			active = false;
			animation.play("dead", true);
			this.velocity.set();
			acceleration.set();
			this.color = FlxColor.fromRGB(100, 100, 100);
		}
	}
	
	public static function handleWallCollision(enemy:BasicEnemy, wall:FlxObject):Void
	{
		enemy.randomWalkDirection = (enemy.randomWalkDirection + 2) % 4;
	}
	
	
	public function attack () : Void 
	{
		//do nothing. has to be overwritten by child classes
	}
	
	
}