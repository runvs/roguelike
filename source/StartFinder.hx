import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
class StartFinder 
{
	public static function findPosition(tree:flixel.group.FlxTypedGroup<Leaf>): FlxPoint
	{
		var p  : FlxPoint;

		//so dirty...
		var listOfRooms:Array<Leaf> = new Array<Leaf>();
		
		//iterate over all leafes
		for(currentLeaf in tree)
		{
			//get current room
			var room:Leaf = currentLeaf;
			if(room.room != null)
			{
				//put the roomtype value into the "map"
				listOfRooms.push(room);
			}
		}
			
		
		var index : Int = FlxRandom.intRanged(0, listOfRooms.length);
		var tmpRoom:flixel.util.FlxRect = listOfRooms[index].room;
		
		//spawn
		//find coordinate
		var x:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.TileSize;
		var y:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.TileSize;
		
		return new FlxPoint(x,y);
	}
}