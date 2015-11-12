import flixel.util.FlxRandom;
class MobGenerator 
{
	public static function generateMobsFromTree(tree:flixel.group.FlxTypedGroup<Leaf>, PlayerLlevel : Int, WorldLevel : Int):flixel.group.FlxTypedGroup<BasicEnemy>
	{
		var listOfEmenies:flixel.group.FlxTypedGroup<BasicEnemy> = new flixel.group.FlxTypedGroup<BasicEnemy>();

		var level : Int = PlayerLlevel + WorldLevel;
		
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
			
			var distant : Bool = FlxRandom.chanceRoll();
			//distant = false;
			if (FlxRandom.chanceRoll(30))
			{
				//spawn
				//find coordinate
				var x:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.Tile_Size;
				var y:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.Tile_Size;
				//trace(x + "; " + y);
				var e:BasicEnemy = null;
				if (distant)
				{	
					e = new Enemy_CloseCombat(level);
				}
				else 
				{
					e = new Enemy_DistantCombat(level);
				}
				
				e.setPosition(x, y);
				listOfEmenies.add(e);
			}
			
			var chance:Float = (level +5) * 8;
			if (chance > 100)
			{
				chance = 100;
			}

			//we have a room, do we even spawn an enemy?
			if(flixel.util.FlxRandom.chanceRoll(chance))
			{
				//spawn
				//find coordinate
				var x:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.Tile_Size;
				var y:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.Tile_Size;
				//trace(x + "; " + y);
				var e:BasicEnemy = null;
				if (distant)
				{	
					e = new Enemy_CloseCombat(level);
				}
				else 
				{
					e = new Enemy_DistantCombat(level);
				}
				e.setPosition(x, y);
				listOfEmenies.add(e);
				//increase chance for next spawn
				//chance += chance * (chance/100);
			
				
				if(flixel.util.FlxRandom.chanceRoll(chance))
				{
					//spawn
					//find coordinate
					var x:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.Tile_Size;
					var y:Int = flixel.util.FlxRandom.intRanged(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.Tile_Size;
					//trace(x + "; " + y);
					var e:BasicEnemy = null;
					if (distant)
					{	
						e = new Enemy_CloseCombat(level);
					}
					else 
					{
						e = new Enemy_DistantCombat(level);
					}
					e.setPosition(x, y);
					listOfEmenies.add(e);
					//increase chance for next spawn
					//chance += chance * (chance/100);
				
				}
				
			}
		}	

		return listOfEmenies;
	}
}