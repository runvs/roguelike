class MobGenerator 
{
	public static function generateMobsFromTree(tree:flixel.group.FlxTypedGroup<Leaf>, level : Int):flixel.group.FlxTypedGroup<Enemy>
	{
		var listOfEmenies:flixel.group.FlxTypedGroup<Enemy> = new flixel.group.FlxTypedGroup<Enemy>();

		//so dirty...
		var listOfRooms:Array<flixel.util.FlxRect> = new Array<flixel.util.FlxRect>();
		
		//iterate over all leafes
		for(currentLeaf in tree)
		{
			//get current room
			var room:flixel.util.FlxRect = currentLeaf.room;
			if(room != null)
			{
				//put the roomtype value into the "map"
				listOfRooms.push(room);
			}
		}
			
		for(roomIndex in 0 ... listOfRooms.length)
		{
			var tmpRoom:flixel.util.FlxRect = listOfRooms[roomIndex];
			var chance:Float = (level +3) * 8;
			if (chance > 100)
			{
				chance = 100;
			}

			//we have a room, do we even spawn an enemy?
			if(flixel.util.FlxRandom.chanceRoll(chance))
			{
				//spawn
				//find coordinate
				var x:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.TileSize;
				var y:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.TileSize;
				//trace(x + "; " + y);
				var e:Enemy = new Enemy();
				e.setPosition(x, y);
				listOfEmenies.add(e);
				//increase chance for next spawn
				//chance += chance * (chance/100);
			}
		}	

		return listOfEmenies;
	}
}