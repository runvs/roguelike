import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRect;

class MobGenerator 
{
	public static function generateMobsFromTree(tree:flixel.group.FlxTypedGroup<Leaf>, PlayerLlevel : Int, WorldLevel : Int):flixel.group.FlxTypedGroup<BasicEnemy>
	{
		var listOfEmenies:flixel.group.FlxTypedGroup<BasicEnemy> = new FlxTypedGroup<BasicEnemy>();

		var level : Int = PlayerLlevel + WorldLevel;
		
		
		//so dirty...
		var listOfRooms:Array<FlxRect> = new Array<FlxRect>();
		
		//iterate over all leafes
		for(currentLeaf in tree)
		{
			//get current room
			var room:FlxRect = currentLeaf.room;
			if(room != null)
			{
				//put the roomtype value into the "map"
				listOfRooms.push(room);
			}
		}
			
		for(roomIndex in 0 ... listOfRooms.length)
		{
			var tmpRoom:FlxRect = listOfRooms[roomIndex];
			
			var distant : Bool = FlxG.random.bool();
			//distant = false;
			if (FlxG.random.bool(30))
			{
				//spawn
				//find coordinate
				var x:Int = FlxG.random.int(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.Tile_Size;
				var y:Int = FlxG.random.int(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.Tile_Size;
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
			if(FlxG.random.bool(chance))
			{
				//spawn
				//find coordinate
				var x:Int = FlxG.random.int(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.Tile_Size;
				var y:Int = FlxG.random.int(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.Tile_Size;
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
			
				
				if(FlxG.random.bool(chance))
				{
					//spawn
					//find coordinate
					var x:Int = FlxG.random.int(cast tmpRoom.left + 1, cast tmpRoom.right - 1) * GameProperties.Tile_Size;
					var y:Int = FlxG.random.int(cast tmpRoom.top + 1, cast tmpRoom.bottom - 1) * GameProperties.Tile_Size;
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
				
			}
		}	

		return listOfEmenies;
	}
}