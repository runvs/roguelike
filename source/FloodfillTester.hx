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
		var runIdx : Int = 0;
		while (!found)
		{
			runIdx += 1;
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
			
			var active2 : Array<Tile> = new Array<Tile>();
			//active = new Array<Tile>();
			for (i in 0...active.length)
			{
				var t : Tile = active[i];
			
				//trace (t.tx + " "  + t.ty);
				
				var tl : Tile = level.getFloor(t.tx - 1, t.ty);
				var tu : Tile = level.getFloor(t.tx, t.ty-1);
				var td : Tile = level.getFloor(t.tx, t.ty+1);
				var tr : Tile = level.getFloor(t.tx + 1, t.ty);
				
				// only add existing tiles
				// don't add if tile has already been visited
				// don't add if tile is already marked for check on this step
				if (tl != null && !isIn(tl, visited) && !isIn(tl, active2)) active2.push(tl);
				if (tr != null && !isIn(tr, visited) && !isIn(tr, active2)) active2.push(tr);
				if (tu != null && !isIn(tu, visited) && !isIn(tu, active2)) active2.push(tu);
				if (td != null && !isIn(td, visited) && !isIn(td, active2)) active2.push(td);
			}
			if ( active2.length == 0)
			{
				return false;
			}
			active = active2;
			trace (runIdx + " " + active2.length);
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
		trace ("----------------------------");
		trace ("BEGIN Flood Fill Tester Selftest");
		trace ("----------------------------");
		
		
		// test 1,1 -> 2,1 ==>> true
		{
			var level = new Level(6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(2, 1, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 1, 1, 2, 1);
			trace (true + " " + res);
		}
		
		// test 1,1 -> 1,2 ==>> true
		{
			var level = new Level( 6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(1, 2, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 1, 1, 1, 2);
			trace (true + " " + res);
		}
		
		// test 1,2 -> 1,1 ==>> true
		{
			var level = new Level(6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(1, 2, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 1, 2, 1, 1);
			trace (true + " " + res);
		}
		
		
		// test 1,1 -> 2,1 -> 2,2 ->3,2 ==>> true
		{
			var level = new Level(6, 6, 1, 1);
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
			trace (true + " " + res);
		}
		
		// test 1,1 -> 2,1 -> 3,1 ->4,1 ==>> true
		{
			var level = new Level(6, 6, 1, 1);
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
			trace (true + " " + res);
		}
		
		
		
		
		
		// test 1,1 -> ... -> 79,1 ==>> true
		{
			var level = new Level(81, 3, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			for (i in 0...80)
			{
				var t : Tile = new Tile(i, 1, TileType.Floor);
				level.map.floor.add(t);
			}

			var res : Bool = Test(level, 79, 1, 1, 1);
			trace (true + " " + res);
		}

		
		// test 1,1 -> ... -> 29,1 with adjactant Tile line ==>> true
		{
			var level = new Level(31, 5, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			for (i in 1...30)
			{
				var t1 : Tile = new Tile(i, 1, TileType.Floor);
				level.map.floor.add(t1);
				var t2 : Tile = new Tile(i, 2, TileType.Floor);
				level.map.floor.add(t2);
				var t3 : Tile = new Tile(i, 3, TileType.Floor);
				level.map.floor.add(t3);
				var t4 : Tile = new Tile(i, 4, TileType.Floor);
				level.map.floor.add(t4);
				
			}

			var res : Bool = Test(level, 29, 1, 1, 4);
			trace (true + " " + res);
		}
		
		
		
		
		// test when not connected ==>> false
		{
			var level = new Level(6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(3, 1, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 3, 1, 1, 1);
			trace (false + " " + res);
		}
		
		// test when start tile not in floors ==>> false
		{
			var level = new Level(6, 6, 1, 1);
			level.map.floor = new FlxTypedGroup<Tile>();
			var t1 : Tile  = new Tile(1, 1, TileType.Floor);
			var t2 : Tile  = new Tile(2, 1, TileType.Floor);
			level.map.floor.add(t1);
			level.map.floor.add(t2);
			var res : Bool = Test(level, 3, 1, 1, 1);
			trace (false + " " + res);
		}
		
		
		trace ("----------------------------");
		trace ("END Flood Fill Tester Selftest");
		trace ("----------------------------");
		
		
		return true;
	}
	
}