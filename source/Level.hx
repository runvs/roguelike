import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxVersion;
import flixel.tile.FlxTile;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;

class Level extends FlxObject
{
	
	public var _grpEnemies:flixel.group.FlxTypedGroup<Enemy>;
	public var _grpDeadEnemies:flixel.group.FlxTypedGroup<Enemy>;

	public var map : MyTileMap;
	//public var _state:PlayState;
	private var _level : Int;
	private var _worldLevel : Int;
	public var sizeX: Int;
	public var sizeY: Int;
	
	public var StartPos : FlxPoint;
	public var Exit : Tile;
	
	public var _grpParticles : FlxTypedGroup<Particle>;
	public var _grpShields : FlxTypedGroup<Shield>;
	

	public function new(state:PlayState, sX:Int, sY:Int, level:Int, worldLevel : Int)
	{
		super();
		_level = level;
		_worldLevel = worldLevel;
		//_state = state;
		sizeX = sX;
		sizeY = sY;
		initializeLevel(sizeX, sizeY);
		
		scrollFactor.set();
		
		_grpParticles = new FlxTypedGroup<Particle>();
		_grpShields = new FlxTypedGroup<Shield>();
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
		RemoveSingleWallTiles();
		createBoundaries();
		

		
		_grpEnemies = MobGenerator.generateMobsFromTree(mapAsTree, _level - 1, _worldLevel);
		_grpDeadEnemies = new FlxTypedGroup<Enemy>();
		
		
		var ne : FlxTypedGroup<Enemy>= new FlxTypedGroup<Enemy>();
		_grpEnemies.forEach(function(e:Enemy) 
		{
			var dir : FlxVector = new FlxVector(e.x - StartPos.x, e.y - StartPos.y);
			if (dir.length <= 1.5 * GameProperties.Enemy_AggroRadius)
			{
			}
			else
			{
				ne.add(e);
			}
		});
		_grpEnemies = ne;
		

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
			if (getFloor(i, 1) != null)
			{
				var t : Tile = new Tile( i, 0 , 0);
				map.walls.add(t);
			}
			else
			{
				var t : Tile = new Tile( i, 0 , 8);
				map.walls.add(t);
			}
			var t = new Tile(i, (sizeY) , 8);
			map.walls.add(t);
		}
	}
	
	function RemoveSingleWallTiles() : Void
	{
		var newWalls : FlxTypedGroup<Tile> = new FlxTypedGroup<Tile>();
		
		map.walls.forEach(function (t:Tile) : Void 
		{
			if ( t.type == 0)	// tile is a "wall"
			{
				var posX : Int = t.tx;
				var posY : Int = t.ty;
				
				if (getWall(posX, posY-1) == null)
				{
					var newTile : Tile = new Tile(posX, posY, 3);
					map.floor.add(newTile);
					t.destroy();
				}
				else
				{
					newWalls.add(t);
				}
				
			}
			else
			{
				newWalls.add(t);
			}
		});
		
		map.walls = newWalls;
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

		_grpDeadEnemies.update();
		_grpEnemies.update();
		_grpShields.update();
		_grpParticles.update();
		
		//_grpEnemies.forEachAlive(checkEnemyVision);
	}

	public override function draw():Void
	{
		super.draw();
		map.draw();
		_grpDeadEnemies.draw();
		_grpEnemies.draw();
		
		_grpShields.draw();
		_grpParticles.draw();
	}
	
	public function cleanUp () : Void 
	{
		var newEnemies : FlxTypedGroup<Enemy> = new FlxTypedGroup<Enemy>();
		
		_grpEnemies.forEach(function (e: Enemy ) : Void 
		{
			if (e.alive) { newEnemies.add(e); } else { _grpDeadEnemies.add(e); }
		});
		_grpEnemies = newEnemies;
		
		var newPart : FlxTypedGroup<Particle> = new FlxTypedGroup<Particle>();
		_grpParticles.forEach(function(p:Particle) : Void
		{
			if (p.alive) { newPart.add(p); } else { p.destroy(); }
		});
		_grpParticles = newPart;
		
		var newShields : FlxTypedGroup<Shield> = new FlxTypedGroup<Shield>();
		_grpShields.forEach(function(s:Shield) : Void
		{
			if (s.alive) { newShields.add(s); } else { s.destroy(); }
		});
		_grpShields = newShields;
	}
	
}
