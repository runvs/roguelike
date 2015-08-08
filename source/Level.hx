import flixel.FlxObject;
import flixel.tile.FlxTile;

class Level extends FlxObject
{
	
	//public var _grpEnemies:flixel.group.FlxTypedGroup<Enemy>;

	public var map : flixel.tile.FlxTilemap;
	public var _state:PlayState;
	private var _level : Int;

	public function new(state:PlayState, sizeX:Int, sizeY:Int, level:Int)
	{
		super();
		_level = level;
		_state = state;
		initializeLevel(sizeX, sizeY);
	}
	
	private function initializeLevel(sizeX:Int, sizeY:Int):Void
	{
		var mapAsTree:flixel.group.FlxTypedGroup<Leaf> = MapGenerator.generateTree(sizeX, sizeY);

		map = new flixel.tile.FlxTilemap();
		map.loadMap(MapGenerator.generateMapFromTree(mapAsTree).toString(), AssetPaths.SpriteSheetA__png, GameProperties.TileSize, GameProperties.TileSize, 0, 0, 0);
		// collision map
		map.setTileProperties(0, FlxObject.ANY);
		map.setTileProperties(1, FlxObject.NONE);
		map.setTileProperties(2, FlxObject.NONE);
		map.setTileProperties(3, FlxObject.NONE);
		map.setTileProperties(4, FlxObject.NONE);
		map.setTileProperties(5, FlxObject.NONE);
		map.setTileProperties(6, FlxObject.NONE);
		map.setTileProperties(7, FlxObject.NONE);

		//_grpEnemies = MobGenerator.generateMobsFromTree(mapAsTree, (_level == 0) ? 0 : 50, _level-1);

		//var forbiddenList:Array<Int> = new Array<Int>();
		//forbiddenList.push(0);
		//map = ExitGenerator.generateExitsForMap(map, forbiddenList);
	}

	public override function update():Void
	{	
		super.update();
		map.update();
		
		//flixel.FlxG.collide(_grpEnemies, map);
		
		//_grpEnemies.forEachAlive(function(e:Enemy):Void{e.update();});
		//_grpEnemies.forEachAlive(checkEnemyVision);
	}

	public override function draw():Void
	{
		super.draw();
		map.draw();
		//_grpEnemies.forEachAlive(function(e:Enemy):Void{e.draw();});
	}
	
}