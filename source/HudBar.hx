package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class HudBar extends FlxSprite
{

	var _vertical : Bool;
	
	public function new(X:Float=0, Y:Float=0, w : Float, h : Float, vertical: Bool =true) 
	{
		super();
		x = X;
		y = Y;
		_vertical = vertical;
		
		makeGraphic(Std.int(w), Std.int(h), FlxColor.WHITE);
		this.origin.set(0, 0);
		this.scrollFactor.set();
	}
	
	override public function update():Void
	{
		super.update();
		var val : Float = health ;
		if (val < 0 ) val = 0;
		if (val > 1) val = 1;
			
		if (_vertical)
		{
			scale.set(1, val);
		}
		else
		{
			scale.set(val, 1);
		}
	}
	
}