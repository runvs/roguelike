package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

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
	
	private var shadow_topSprite : FlxSprite;
	private var shadow_rightSprite : FlxSprite;
	
	private var visited : Bool;
	private var visitedSprite : FlxSprite;

	private var distanceMap : Map<String, Float>; 
	public function new(X:Int=0, Y:Int=0, t: TileType) 
	{
		super(X * GameProperties.Tile_Size, Y * GameProperties.Tile_Size);
		tx = X;
		ty = Y;
		type = t;
		
		passable = true;
		immovable = true;
		
		visited = false;
		visitedSprite = new FlxSprite();
		visitedSprite.makeGraphic(GameProperties.Tile_Size, GameProperties.Tile_Size, FlxColor.fromRGB(50,50,50));
		visitedSprite.setPosition(x, y);
		
		shadow_rightSprite = null;
		shadow_topSprite = null;
		
		LoadImageByTileType();
		distanceMap = new Map<String, Float>();
	}
	
	
	
	public function setShadow(what:ShadowType) : Void 
	{
		if (what == ShadowType.Not)	// none
		{
			shadow_topSprite = null;
			shadow_rightSprite = null;
		}
		else if (what == ShadowType.North)	// top only
		{
			shadow_topSprite = new FlxSprite();
			shadow_topSprite.loadGraphic(AssetPaths.shadow_top__png, false, 48, 16);
			shadow_topSprite.offset.set(0, 16);
			shadow_topSprite.setPosition(x, y);
			shadow_topSprite.alpha = GameProperties.Tiles_ShadowAlpha;
		}
		else if (what == ShadowType.East)	// right only
		{
			shadow_rightSprite = new FlxSprite();
			shadow_rightSprite.loadGraphic(AssetPaths.shadow_right__png, false, 16, 48);
			shadow_rightSprite.offset.set(-GameProperties.Tile_Size, 16);
			shadow_rightSprite.setPosition(x, y);
			shadow_rightSprite.alpha = GameProperties.Tiles_ShadowAlpha;
		}
		else if (what == ShadowType.NorthEast)	// top and right
		{
			shadow_topSprite = new FlxSprite();
			shadow_topSprite.loadGraphic(AssetPaths.shadow_top__png, false, 48, 16);
			shadow_topSprite.offset.set(0, 16);
			shadow_topSprite.setPosition(x, y);
			shadow_topSprite.alpha = GameProperties.Tiles_ShadowAlpha;
			
			shadow_rightSprite = new FlxSprite();
			shadow_rightSprite.loadGraphic(AssetPaths.shadow_right__png, false, 16, 48);
			shadow_rightSprite.offset.set(-GameProperties.Tile_Size, 16);
			shadow_rightSprite.setPosition(x, y);
			shadow_rightSprite.alpha = GameProperties.Tiles_ShadowAlpha;
		}
		else if (what == ShadowType.NorthCroppedEastCropped) // top and right but both cropped
		{
			shadow_topSprite = new FlxSprite();
			shadow_topSprite.loadGraphic(AssetPaths.shadow_top_cropped__png, false, 32, 16);
			shadow_topSprite.offset.set(0, 16);
			shadow_topSprite.setPosition(x, y);
			shadow_topSprite.alpha = GameProperties.Tiles_ShadowAlpha;
			
			shadow_rightSprite = new FlxSprite();
			shadow_rightSprite.loadGraphic(AssetPaths.shadow_right_cropped__png, false, 16, 32);
			shadow_rightSprite.offset.set(-GameProperties.Tile_Size, 0);
			shadow_rightSprite.setPosition(x, y);
			shadow_rightSprite.alpha = GameProperties.Tiles_ShadowAlpha;
		}
		else if (what == ShadowType.EastCropped)
		{
			shadow_rightSprite = new FlxSprite();
			shadow_rightSprite.loadGraphic(AssetPaths.shadow_right_cropped__png, false, 16, 32);
			shadow_rightSprite.offset.set(-GameProperties.Tile_Size, 0);
			shadow_rightSprite.setPosition(x, y);
			shadow_rightSprite.alpha = GameProperties.Tiles_ShadowAlpha;
		}
		else if (what == ShadowType.NorthCropped) // top and right but both cropped
		{
			shadow_topSprite = new FlxSprite();
			shadow_topSprite.loadGraphic(AssetPaths.shadow_top_cropped__png, false, 32, 16);
			shadow_topSprite.offset.set(0, 16);
			shadow_topSprite.setPosition(x, y);
			shadow_topSprite.alpha = GameProperties.Tiles_ShadowAlpha;
		}
		
	}
	
	public function visitMe() : Void 
	{
		var delay : Float = FlxG.random.float(0.0, 0.4);
		var t : FlxTimer = new FlxTimer();
		t.start(delay, function ( t: FlxTimer)
		{
			FlxTween.tween(visitedSprite, { alpha : 0 }, 0.5 - delay);
		});
	}
	
	public function drawVisited() : Void 
	{
		if (!visited)
		{
			//trace("draw Tile");
			visitedSprite.draw();
		}
		else
		{
			//trace("noDraw");
		}
	}
	
	public function drawShadow() : Void 
	{
		if (shadow_topSprite != null)
		{
			shadow_topSprite.draw();
			
		}
		if (shadow_rightSprite != null)
		{
			shadow_rightSprite.draw();
		}
	}
	
	function LoadImageByTileType():Void 
	{
		if (type == TileType.Wall)	// Wall Tile
		{
			loadGraphic(AssetPaths.Background_Wall__png, false, 32, 32);
			passable = false;
		}
		else if (type == TileType.Floor)	// Floor
		{
			makeGraphic(GameProperties.Tile_Size, GameProperties.Tile_Size, FlxColor.fromRGB(78, 96, 81));
		}
		else if (type == TileType.Exit)	// exit
		{
			loadGraphic(AssetPaths.Staircase__png, false , 32, 32);
		}
		else if (type == TileType.Ceiling)	// ceiling
		{
			makeGraphic(GameProperties.Tile_Size, GameProperties.Tile_Size, FlxColor.fromRGB(14, 16, 16));
		}
		this.updateHitbox();
	}
	
	public function setDistance (tag:String, value : Float) :Void 
	{
		distanceMap[tag] = value;
	}
	
}