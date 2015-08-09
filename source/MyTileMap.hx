package;

import flixel.FlxObject;
import flixel.group.FlxTypedGroup;

/**
 * ...
 * @author 
 */
class MyTileMap extends FlxObject
{

	public var floor : FlxTypedGroup<Tile>;
	public var walls : FlxTypedGroup<Tile>;
	
	public function new() 
	{
		super();
		floor = new FlxTypedGroup<Tile>();
		walls = new FlxTypedGroup<Tile>();
		scrollFactor.set();
	}
	
	override public function update()
	{
		//super.update();
		floor.update();
		walls.update();
	}
	
	override public function draw()
	{
		super.draw();
		floor.draw();
		walls.draw();
	}
}