package;


class MapGenerator
{
	public static function generateMapFromTree(tree:flixel.group.FlxTypedGroup<Leaf>): MyTileMap
	{
		//we need to give every room a roomType and every hall a hallType
		//for now, we do it random
		var currentLeaf:Leaf;

		//so dirty...
		var listOfHalls:Array<flixel.util.FlxRect> = new Array<flixel.util.FlxRect>();
		var listOfRooms:Array<flixel.util.FlxRect> = new Array<flixel.util.FlxRect>();
		var listOfTypes:Array<Int> = new Array<Int>();
		
		//iterate over all leafes
		for(currentLeaf in tree)
		{
			//get current room
			var room:flixel.util.FlxRect = currentLeaf.room;
			if(room != null)
			{
				//roll type for room
				var roomType:Int = 3; //always type one - we will manually add a canteen (2) later
				//put the roomtype value into the "map"
				listOfRooms.push(room);
				listOfTypes.push(roomType);
			}
			
			var hall:flixel.util.FlxRect;
			if(currentLeaf.halls != null)
			{
				for(hall in currentLeaf.halls)
				{
					listOfHalls.push(hall);
				}				
			}
		}

		// set a random room as a cantine
		var canteenAdded:Bool = false;
		while(canteenAdded == false)
		{
			for(i in 0...listOfRooms.length)
			{
				var spawnCanteen:Bool = flixel.util.FlxRandom.chanceRoll(10);
				if(spawnCanteen)
				{
					listOfTypes[i] = 2;
					canteenAdded = true;
					break;
				}
			}
		}

		
		
		
		//generate the map string
		//var mapString:StringBuf = new StringBuf();
		var finalMap : MyTileMap = new MyTileMap();
//
		//really bad but hey i studied computer science twice!
		for(y in 0 ... tree.members[0].height)
		{
			for(x in 0 ... tree.members[0].width)
			{
				//check every room :(
				var type:Int = 0;
				//trace(x + ","+y);
				for(roomIndex in 0 ... listOfRooms.length)
				{
					var tmpRoom:flixel.util.FlxRect = listOfRooms[roomIndex];
					//trace(x + "," + y + " in: " + tmpRoom.x + ", " + tmpRoom.y + " - (" + tmpRoom.width + ", " + tmpRoom.height +")");
					if(isInRoom(x, y, tmpRoom))
					{
						type = listOfTypes[roomIndex];
						//trace("yay");
						break;
					}
				}

				var tmpHall:flixel.util.FlxRect;
				for(tmpHall in listOfHalls)
				{
					if(isInHall(x, y, tmpHall))
					{
						if(type == 0)
						{
							type = 3;
						}
						break;
					}
				}

				//mapString.add(Std.string(type));
				var t : Tile = new Tile(x*GameProperties.TileSize, y*GameProperties.TileSize, type);
				if (t.passable == true)
				{
					finalMap.floor.add(t);
				}
				else
				{
					finalMap.walls.add(t);
				}
			}
		}

		////trace(mapString);
		return finalMap;
	}

	public static function isInHall(x:Int, y:Int, room:flixel.util.FlxRect):Bool
	{
		if(x >= room.x && x < room.x + room.width)
		{
			if(y >= room.y && y < room.y + room.height)
			{
				return true;
			}
		}

		return false;
	}

	public static function isInRoom(x:Int, y:Int, room:flixel.util.FlxRect):Bool
	{
		if(x > room.x && x <= room.x + room.width)
		{
			if(y > room.y && y <= room.y + room.height)
			{
				return true;
			}
		}

		return false;
	}


	//this function simply generates a list of rooms and connecting floors
	//you can add this with a list of desired rooms in a funtion im going to write right away
	public static function generateTree(mapSizeX:Int, mapSizeY:Int):flixel.group.FlxTypedGroup<Leaf>
	{
		var tree:flixel.group.FlxTypedGroup<Leaf> = new flixel.group.FlxTypedGroup<Leaf>();
		var root:Leaf = new Leaf(0, 0, mapSizeX, mapSizeY);

		tree.add(root);

  		var treeSplitted:Bool;
  		//these parameters will become changeable
		var splitChance:Float = 0.75;
		var MAX_LEAF_SIZE:Int = 12;

		do
		{
			var currentLeaf:Leaf;
			treeSplitted = false;
			for(currentLeaf in tree)
			{
		        if (currentLeaf.leftChild == null && currentLeaf.rightChild == null) // if this Leaf is not already split...
		        {
		            // if this Leaf is too big, or splitChance percent chance...
		            if (currentLeaf.width > MAX_LEAF_SIZE || currentLeaf.height > MAX_LEAF_SIZE || flixel.util.FlxRandom.chanceRoll(splitChance))
		            {
		                if (currentLeaf.split()) // split the Leaf!
		                {
		                    // if we did split, push the child leafs to the Vector so we can loop into them next
		                    tree.add(currentLeaf.leftChild);
		                    tree.add(currentLeaf.rightChild);
		                    treeSplitted = true;
		                }
		            }
		        }				
			}
		}
		while(treeSplitted);		

		root.createRooms();

		return tree;
	}

	//returns the number of rooms in the tree with this leaf 
    //as root
    public static function numberOfRooms(tree:flixel.group.FlxTypedGroup<Leaf>):Int
    {
    	var currentLeaf:Leaf;
		var roomCount:Int = 0;

		for(currentLeaf in tree)
    	{
    		if(currentLeaf.room != null)
    		{
    			roomCount++;
    		}

    	}
    	return roomCount;
    }
}