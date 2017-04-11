
class ExitGenerator
{

	public static function generateExitsForMap(map: MyTileMap): MyTileMap
	{
		var told : Tile = map.floor.getRandom(0, map.floor.length-1 );
		var tnew : Tile = new Tile(told.tx, told.ty, TileType.Exit);
		
		map.floor.replace(told, tnew);

		return map;
	}
}