package;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Pathfinder
{
	private var pathfinderTimer : Float;
	private var check : Bool;
	private var level : Level;
	
	private var px : Int;
	private var py : Int;
	
	public function new() 
	{
		pathfinderTimer = 0.0;
		check = false;
	}
	
	public function setCheck (val:Bool ) : Void
	{
		check = val;
	}
	
	public function setLevel ( l : Level) : Void 
	{
		level = l;
	}
	
	public function setPlayerPos ( playerx:Int, playery:Int):Void
	{
		
	}
	
	public function update () : Void 
	{
		if (pathfinderTimer > 0)
		{
			pathfinderTimer -= FlxG.elapsed;
		}
		if (check && pathfinderTimer <= 0)
		{
			pathfinderTimer = GameProperties.World_PathfinderTimerMax;
			DoPathfinding();
		}
	}
	
	private function DoPathfinding() : Void 
	{
		if (level == null)
		{
			return;
		}
		FloodfillTester.Test(level, px, py, 0, 0, "player");
	}
	
	public static function biLinterp(l : Level, obj : FlxObject)
	{
		var ox : Float = obj.x;
		var oy : Float = obj.y;
		
		var otx : Int = Std.int(ox / GameProperties.Tile_Size);
		var oty : Int = Std.int(oy / GameProperties.Tile_Size);
		
		var t: Tile = l.getFloor(otx, oty);
		
	}
}