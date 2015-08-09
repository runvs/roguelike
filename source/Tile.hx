package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;

/**
 * ...
 * @author 
 */
class Tile extends FlxSprite
{
	
	public var passable : Bool;
	public var tx : Int;
	public var ty : Int;
	
	public var type : Int;

	public function new(X:Int=0, Y:Int=0, t: Int) 
	{
		tx = X;
		ty = Y;
		
		super(X*GameProperties.TileSize, Y * GameProperties.TileSize);
		passable = true;
		immovable = true;
		
		type = t;
		
		if (t == 0)	// Wall Tile
		{
			//makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.GRAY);
			loadGraphic(AssetPaths.Background_Wall__png, false, 32, 32);
			passable = false;
		}
		else if (t == 3)	// Floor
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(1,78, 96, 81));
		}
		else if (t == 7)	// exit
		{
			trace("exit created");
			//makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.GREEN);
			loadGraphic(AssetPaths.Staircase__png, false , 32, 32);
		}
		else if (t == 8)	// ceiling
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(1.0, 14, 16, 16));
		}
		this.updateHitbox();
	}
	
}