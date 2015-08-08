package;

import flixel.FlxSprite;

/**
 * ...
 * @author 
 */
class Player extends FlxSprite
{
	
	var properties : PlayerProperties;
	
	public function new() 
	{
		super();
		
		properties = new PlayerProperties();
		
		this.makeGraphic(GameProperties.TileSize, GameProperties.TileSize);
	}
	
}