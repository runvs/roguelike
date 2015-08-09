package;

import flixel.FlxSprite;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Tile extends FlxSprite
{
	
	public var passable : Bool;

	public function new(X:Float=0, Y:Float=0, t: Int) 
	{
		super(X, Y);
		passable = true;
		immovable = true;
		
		
		if (t == 0)
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.GRAY);
			passable = false;
		}
		else if (t == 3)
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.BLACK);
		}
		else if (t == 7)
		{
			trace("exit created");
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.GREEN);
		}
		this.updateHitbox();
	}
	
}