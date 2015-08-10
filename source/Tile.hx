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
	
	public var type : TileType;

	public function new(X:Int=0, Y:Int=0, t: TileType) 
	{
		tx = X;
		ty = Y;
		
		super(X*GameProperties.TileSize, Y * GameProperties.TileSize);
		passable = true;
		immovable = true;
		
		type = t;
		
		if (t == TileType.Wall)	// Wall Tile
		{
			//makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.GRAY);
			loadGraphic(AssetPaths.Background_Wall__png, false, 32, 32);
			passable = false;
		}
		else if (t == TileType.Floor)	// Floor
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(1,78, 96, 81));
		}
		else if (t == TileType.Exit)	// exit
		{
			//trace("exit created");
			//makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.GREEN);
			loadGraphic(AssetPaths.Staircase__png, false , 32, 32);
		}
		else if (t == TileType.Ceiling)	// ceiling
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(1.0, 14, 16, 16));
		}
		this.updateHitbox();
	}
	
}