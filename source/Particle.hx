package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Particle extends FlxSprite
{
	var _type : Bool;

	public function new(X:Float=0, Y:Float=0, type : Bool) 
	{
		super(X, Y);
		this.makeGraphic(16, 16, FlxColor.CRIMSON);
		if (type)
		{
			
		}
		else 
		{
			
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