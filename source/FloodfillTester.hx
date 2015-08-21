package;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class FloodfillTester
{
	public static function Test(level : Level, startX : Int, startY : Int, endX : Int, endY : Int) : Bool 
	{		
		if (level.getFloor(endX, endY) == null || level.getFloor(startX, startY) == null)
		{
			return false;
		}
		
		var visited: Array<Tile> = new Array<Tile>();
		var active: Array<Tile> = new Array<Tile>();
		
		var s : Tile = level.getFloor(startX, startY);
		active.push(s);
		
		var found : Bool = false;
		while (!found)
		{
			// check if we have found the exit in one of the active tiles
			for (i in 0...active.length)
			{
				var t : Tile = active[i];
				if (t.tx == endX && t.ty == endY)
				{
					return true;
				}
			}
			
			// add all active tiles to the visited list.
			visited = visited.concat(active);

			active = new Array<Tile>();
			for (i in 0...visited.length)
			{
				var t : Tile = visited[i];
			
				trace (t.tx + " "  + t.ty);
				
				var tl : Tile = level.getFloor(t.tx - 1, t.ty);
				var tu : Tile = level.getFloor(t.tx, t.ty-1);
				var td : Tile = level.getFloor(t.tx, t.ty+1);
				var tr : Tile = level.getFloor(t.tx + 1, t.ty);
				
				if (tl != null && !isIn(tl, visited)) active.push(tl);
				if (tr != null && !isIn(tr, visited)) active.push(tr);
				if (tu != null && !isIn(tu, visited)) active.push(tu);
				if (td != null && !isIn(td, visited)) active.push(td);
			}
			if ( active.length == 0)
			{
				return false;
			}
		}
		
		return false;
	}
	
	private static function isIn (t:Tile, a:Array<Tile>) : Bool
	{
		for (i in 0...a.length)
		{
			var f : Tile = a[i];
			if (f.tx == t.tx && f.ty == t.ty)
			{
				return true;
			}
		}
		return false;
	}
	
	
	public static function SelfTest() : Bool
	{
		{
			var level = new Level(null, 6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(2, 1, TileType.Floor);
			var t3 : Tile  = new Tile(2, 2, TileType.Floor);
			var t4 : Tile  = new Tile(3, 2, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			level.map.floor.add(t3);
			level.map.floor.add(t4);
			var res : Bool = Test(level, 3, 2, 1, 1);
			trace (res);
		}
		
		
		{
			var level = new Level(null, 6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(2, 1, TileType.Floor);
			var t3 : Tile  = new Tile(3, 1, TileType.Floor);
			var t4 : Tile  = new Tile(4, 1, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			level.map.floor.add(t3);
			level.map.floor.add(t4);
			var res : Bool = Test(level, 1, 1, 4, 1);
			trace (res);
		}
		
		
		{
			var level = new Level(null, 6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(2, 1, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 1, 1, 2, 1);
			trace (res);
		}
		
		{
			var level = new Level(null, 6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(1, 2, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 1, 1, 1, 2);
			trace (res);
		}
		
		{
			var level = new Level(null, 6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(1, 2, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 1, 2, 1, 1);
			trace (res);
		}
		
		{
			var level = new Level(null, 6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(2, 1, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 2, 1, 1, 1);
			trace (res);
		}
		
		
		return true;
	}
	
}