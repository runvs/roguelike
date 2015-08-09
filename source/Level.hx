import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTile;

class Level extends FlxObject
{
	
	public var _grpEnemies:flixel.group.FlxTypedGroup<Enemy>;

	public var map : MyTileMap;
	public var _state:PlayState;
	private var _level : Int;
	private var sizeX: Int;
	private var sizeY: Int;

	public function new(state:PlayState, sX:Int, sY:Int, level:Int)
	{
		super();
		_level = level;
		_state = state;
		sizeX = sX;
		sizeY = sY;
		initializeLevel(sizeX, sizeY);
	}
	
	private function initializeLevel(sizeX:Int, sizeY:Int):Void
	{
		var mapAsTree:flixel.group.FlxTypedGroup<Leaf> = MapGenerator.generateTree(sizeX, sizeY);

		map = new MyTileMap();
		map = MapGenerator.generateMapFromTree(mapAsTree);
		
		// create boundaries
		createBoundaries();

		_grpEnemies = MobGenerator.generateMobsFromTree(mapAsTree, (_level == 0) ? 0 : 50, _level-1);

		//var forbiddenList:Array<Int> = new Array<Int>();
		//forbiddenList.push(0);
		//map = ExitGenerator.generateExitsForMap(map, forbiddenList);
	}
	
	function createBoundaries():Void 
	{
		for (j in 0...sizeY )
		{
			var t : Tile = new Tile( 0 * GameProperties.TileSize, j * GameProperties.TileSize, 0);
			map.walls.add(t);
			t = new Tile((sizeX ) * GameProperties.TileSize, j * GameProperties.TileSize, 0);
			map.walls.add(t);
		}
		for (i in 0...sizeX )
		{
			var t : Tile = new Tile( i * GameProperties.TileSize, 0 * GameProperties.TileSize, 0);
			map.walls.add(t);
			t = new Tile(i * GameProperties.TileSize, (sizeY) * GameProperties.TileSize, 0);
			map.walls.add(t);
		}
	}

	public override function update():Void
	{	
		super.update();
		map.update();

		_grpEnemies.update();
		//_grpEnemies.forEachAlive(checkEnemyVision);
	}

	public override function draw():Void
	{
		super.draw();
		map.draw();
		_grpEnemies.draw();
	}
	
	public function cleanUp () : Void 
	{
		var newEnemies : FlxTypedGroup<Enemy> = new FlxTypedGroup<Enemy>();
		
		_grpEnemies.forEach(function (e: Enemy ) : Void 
		{
			if (e.alive) { newEnemies.add(e); } else { e.destroy(); }
		});
		_grpEnemies = newEnemies;
	}
	
}