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
		
		
		if (t == 0)
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.WHITE);
			passable = false;
			immovable = true;
		}
		else if (t == 3)
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.BLACK);
			passable = true;
			immovable = true;
		}
		
	}
	
}