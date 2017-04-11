package;

import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;

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
	
	override public function update(elapsed:Float)
	{
		//super.update(elapsed);
		floor.update(elapsed);
		walls.update(elapsed);
	}
	
	override public function draw()
	{
		super.draw();
		floor.draw();
		walls.draw();
	}
	
	public function drawVisited() : Void 
	{
		walls.forEach(function (t:Tile):Void { t.drawVisited(); } );
		floor.forEach(function (t:Tile):Void { t.drawVisited(); } );
	}
	
	public function drawShadows() : Void 
	{
		walls.forEach(function (t:Tile):Void { t.drawShadow(); } );
	}
	
	public function setVisibility(playerX : Int, playerY : Int, range : Float ) : Void 
	{
		walls.forEach(function (t:Tile):Void { 
			var dx = t.tx - playerX;
			var dy = t.ty - playerY;
			var distSquared : Float = dx * dx + dy * dy;
			if (distSquared < range * range)
			{
				t.visitMe();
			}
		} );
		floor.forEach(function (t:Tile):Void { 
			var dx = t.tx - playerX;
			var dy = t.ty - playerY;
			var distSquared : Float = dx * dx + dy * dy;
			if (distSquared < range * range)
			{
				t.visitMe();
			}
		} );
	}
}
