package ;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flixel.util.FlxRandom;

/**
 * ...
 * @author 
 */
class MapCreator extends FlxSpriteGroup
{

	public function new() 
	{
		super();
		map = new Array <Int>();
	}
	
	var map : Array<Int>;
	var sizex : Int;
	var sizey : Int;
	
	public function get(x:Int, y:Int) : Int
	{
		var index : Int = x + y * sizex;
		return map[index];
	}	
	
	public function create (sx : Int, sy : Int)
	{		
		sizex = sx;
		sizey = sy;
		for (i in 0...sizex)
		{
			for (j in 0...sizey)
			{
				var r : Bool =  FlxRandom.chanceRoll(60);
				map.push((r? 0 : 1));
			}
		}
		
		DoGoLStep();
		//DoGoLStep();
		
		
		for (i in 0...sizex)
		{
			for (j in 0...sizey)
			{				
				var t : Int = get(i, j);
				var s :FlxSprite = new FlxSprite(i*GameProperties.Tile_Size, j*GameProperties.Tile_Size);
				s.makeGraphic(GameProperties.Tile_Size, GameProperties.Tile_Size, ((t != 0)? FlxColor.BLACK : FlxColor.WHITE));
				
				add(s);
			}
		}
	}
	
	function DoGoLStep():Void 
	{
		var map2 : Array<Int> = new Array<Int>();	
		
		for (i in 0...sizex)
		{
			for (j in 0...sizey)
			{
				
				if (i == 0 || j == 0 || i == sizex-1 || j == sizey-1)
				{
					map2.push(0);
				}
				else
				{
					var l : Int = get(i - 1, j);
					var r : Int = get(i + 1, j);
					
					var u : Int = get(i, j-1);
					var d : Int = get(i, j + 1);
					
					var lu : Int = get(i - 1, j-1);
					var ru : Int = get(i + 1, j-1);
					
					var ld : Int = get(i - 1, j+1);
					var rd : Int = get(i + 1, j+1);
					
					var sum : Int = l + r + u +d + lu + ru + ld +rd;
					
					var deathLimit : Int = 2;
					var birthLimit : Int = 3;
					
					if (get(i, j) == 1)	// cell alive
					{
						if (sum < deathLimit)
						{
							map2.push(0);
						}
						else 
						{
							map2.push(1);
						}
					}
					else
					{
						if (sum > birthLimit)
						{
							map2.push(1);
						}
						else
						{
							map2.push(0);
						}
					}
				}
			}
		}
		map = map2;
	}
	
	
	
}