package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Enemy extends Creature
{

	public function new() 
	{
		super();
		
		makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.RED);
	}
	
}