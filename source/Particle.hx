package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxVector;

/**
 * ...
 * @author 
 */
class Particle extends FlxSprite
{
	var _type : Bool;
	public var damage : Int;
	private var _state : PlayState;
	public var _level : Int;

	public function new(X:Float=0, Y:Float=0, tx : Float, ty : Float,  type : Bool, level: Int, state : PlayState) 
	{
		super(X, Y);
		_state = state;
		_level = level;
		_type  = type;
		this.loadGraphic(AssetPaths.Projectile__png, true, 16, 16);
		this.animation.add("normal", [0, 1, 2], 4);
		this.animation.play("normal");
		
		this.origin.set(8, 8);
		
		
		var dir : FlxVector = new FlxVector(tx - X, ty - Y);
		dir = dir.normalize();
		dir = dir.scale(GameProperties.Skills_PowerShootSpeed * Math.sqrt(level*2));
		
		this.angle = dir.degrees;
		
		//acceleration.set(dir.x*10, dir.y*10);
		//maxVelocity.set (dir.x, dir.y);
		velocity.set(dir.x, dir.y);
		
		if (type)
		{
			damage = Std.int(1 + GameProperties.Skills_PowerShootDamagePerLevel * level);
		}
		else 
		{
			damage = 10;		
		}
	}
	
	public function hit()
	{
		trace("hit");
		if (_type)
		{
			_state.spawnPowerBallExplosion(this);
		}
		else
		{
			
		}
		alive = false;
	}
	
}