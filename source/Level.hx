import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTile;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

class Level extends FlxObject
{
	
	public var _grpEnemies:flixel.group.FlxTypedGroup<Enemy>;

	public var map : MyTileMap;
	//public var _state:PlayState;
	private var _level : Int;
	public var sizeX: Int;
	public var sizeY: Int;
	
	public var StartPos : FlxPoint;
	public var Exit : Tile;
	

	public function new(state:PlayState, sX:Int, sY:Int, level:Int)
	{
		super();
		_level = level;
		//_state = state;
		sizeX = sX;
		sizeY = sY;
		initializeLevel(sizeX, sizeY);
		
		scrollFactor.set();
	}
	
	private function initializeLevel(sizeX:Int, sizeY:Int):Void
	{
		var mapAsTree:flixel.group.FlxTypedGroup<Leaf> = MapGenerator.generateTree(sizeX, sizeY);
		
		StartPos = StartFinder.findPosition(mapAsTree);
		
		map = MapGenerator.generateMapFromTree(mapAsTree);
		map = ExitGenerator.generateExitsForMap(map);
		
		map.floor.forEach(function (t:Tile) : Void
		{
			if (t.type == 7)
			{
				Exit = t;
			}
		});
		
		// create boundaries
		TileReplacement();
		createBoundaries();
		

		_grpEnemies = MobGenerator.generateMobsFromTree(mapAsTree, (_level == 0) ? 0 : 50, _level - 1);
		

		//var forbiddenList:Array<Int> = new Array<Int>();
		//forbiddenList.push(0);
		//map = ExitGenerator.generateExitsForMap(map, forbiddenList);
	}
	
	function createBoundaries():Void 
	{
		for (j in 0...sizeY )
		{
			var t : Tile = new Tile( 0 , j , 8);
			map.walls.add(t);
			t = new Tile((sizeX ) , j , 8);
			map.walls.add(t);
		}
		for (i in 0...sizeX )
		{
			var t : Tile = new Tile( i, 0 , 8);
			map.walls.add(t);
			t = new Tile(i, (sizeY) , 8);
			map.walls.add(t);
		}
	}
	
	function TileReplacement() : Void 
	{
		var newWalls : FlxTypedGroup<Tile> = new FlxTypedGroup<Tile>();
		
		map.walls.forEach(function (t:Tile) : Void 
		{
			// count neighbours
			var N : Int = 0;
			map.floor.forEach(function(ft:Tile) : Void
			{
				var dx : Int = ft.tx -t.tx;
				var dy : Int = ft.ty -t.ty;
				if (dx * dx <= 1 && dy * dy <= 1)
				{
					N += 1;
				}
				
			});
			
			// get position
			var posX : Int = t.tx;
			var posY : Int = t.ty;
			
			// if one or more neighbours
			if (N != 0)
			{
				if (getFloor(posX, posY+1) != null)
				{
					newWalls.add(t);
				}
				else
				{
					var tnew : Tile = new Tile(posX, posY, 8);
					newWalls.add(tnew);
					t.destroy();
				}
			}
			else //if zero neighbours
			{
				var tnew : Tile = new Tile(posX, posY, 8);
				newWalls.add(tnew);
				t.destroy();
			}
		});
		
		map.walls = newWalls;
	}
	
	
	function getFloor(x:Int, y:Int) : Tile
	{
		var tf : Tile = null;
		if (x > 0 && x  < sizeX && y > 0 && y < sizeY)
		{
			map.floor.forEach(function(t:Tile)
			{
				if (t.tx == x && t.ty == y)
				{
					tf = t;
				}
			});
		}
		return tf;
			
	}
	
	function getWall(x:Int, y:Int) : Tile
	{
		var tf : Tile = null;
		if (x > 0 && x  < sizeX && y > 0 && y < sizeY)
		{
			map.walls.forEach(function(t:Tile)
			{
				if (t.tx == x && t.ty == y)
				{
					tf = t;
				}
			});
		}
		return tf;
			
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