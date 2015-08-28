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
	
	private var shadowSprite : FlxSprite;

	public function new(X:Int=0, Y:Int=0, t: TileType) 
	{
		super(X * GameProperties.TileSize, Y * GameProperties.TileSize);
		
		tx = X;
		ty = Y;
		
		passable = true;
		immovable = true;
		
		type = t;
		
		shadowSprite = null;
		
		if (t == TileType.Wall)	// Wall Tile
		{
			loadGraphic(AssetPaths.Background_Wall__png, false, 32, 32);
			passable = false;
		}
		else if (t == TileType.Floor)	// Floor
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(1,78, 96, 81));
		}
		else if (t == TileType.Exit)	// exit
		{
			loadGraphic(AssetPaths.Staircase__png, false , 32, 32);
		}
		else if (t == TileType.Ceiling)	// ceiling
		{
			makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(1.0, 14, 16, 16));
		}
		this.updateHitbox();
	}
	
	public function setShadow() : Void 
	{
		shadowSprite = new FlxSprite();
		shadowSprite.makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(0.5, 20, 20, 20));
		shadowSprite.offset.set(0, GameProperties.TileSize);
		shadowSprite.setPosition(x, y);
	}
	
	public function drawShadow() : Void 
	{
		if (shadowSprite != null)
		{
			shadowSprite.draw();
		}
	}
	
}