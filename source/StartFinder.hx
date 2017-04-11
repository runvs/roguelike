import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

class StartFinder 
{
	public static function findPosition(tree:FlxTypedGroup<Leaf>): FlxPoint
	{
		var p  : FlxPoint = null;

		//so dirty...
		var listOfRooms:Array<Leaf> = new Array<Leaf>();
		
		//iterate over all leafes
		for(currentLeaf in tree)
		{
			//get current room
			var room:Leaf = currentLeaf;
			if(room != null && room.room != null)
			{
				//put the roomtype value into the "map"
				listOfRooms.push(room);
			}
		}
			
		
		var index : Int = FlxG.random.int(0, listOfRooms.length-1);
		var tmpRoom: FlxRect = listOfRooms[index].room;
		
		//spawn
		//find coordinate
		var x:Int = FlxG.random.int(cast tmpRoom.left + 1, cast tmpRoom.right - 1) ;
		var y:Int = FlxG.random.int(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) ;
		
		return new FlxPoint(x,y);
	}
}