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

	public function new(X:Float=0, Y:Float=0, tx : Float, ty : Float,  type : Bool, level) 
	{
		super(X, Y);
		this.makeGraphic(16, 16, FlxColor.CRIMSON);
		
		var dir : FlxVector = new FlxVector(tx - X, ty - Y);
		dir = dir.normalize();
		dir = dir.scale(GameProperties.Skills_PowerShootSpeed * Math.sqrt(level*2));
		
		//acceleration.set(dir.x*10, dir.y*10);
		//maxVelocity.set (dir.x, dir.y);
		velocity.set(dir.x, dir.y);
		
		if (type)
		{
			damage = Std.int(1 + GameProperties.SkillsPowerShootDamagePerLevel * level);
		}
		else 
		{
			damage = 10;		
		}
	}
	
	public function hit()
	{
		alive = false;
		if (_type)
		{
			
		}
		else
		{
			
		}
	}
	
}