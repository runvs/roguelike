import flixel.util.FlxRandom;
class ExitGenerator
{

	public static function generateExitsForMap(map: MyTileMap): MyTileMap
	{
		trace ("generate exits");
		var EXIT_DOWN_ID = 7;
		
		var exitDownPosition:flixel.util.FlxPoint = new flixel.util.FlxPoint();
		var told : Tile = map.floor.getRandom(0, map.floor.length-1 );
		var tnew : Tile = new Tile(told.x, told.y, EXIT_DOWN_ID);
		
		map.floor.replace(told, tnew);

		return map;
	}
}