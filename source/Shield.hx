package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author 
 */
class Shield extends FlxSprite
{

	private var lifeTime : Float;
	
	public function new(X:Float=0, Y:Float=0, level : Int) 
	{
		super(X, Y);
		this.makeGraphic(32, 32);
		
		lifeTime = (1.0 +  level* 0.5);
		immovable = true;
	}
	
	override public function update () : Void
	{
		lifeTime -= FlxG.elapsed;
		if (lifeTime <= 0)
		{
			alive = false;
		}
	}
	
	
}