package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author 
 */
class Enemy extends Creature
{
	
	private var randomwalkTimer : Float;
	private var randomWalkDirection : Int;


	public function new() 
	{
		super();
		
		makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColor.RED);
		
		randomwalkTimer = 1.5;
		randomWalkDirection = FlxRandom.intRanged(0, 3);
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed * 0.5,  GameProperties.Player_MaxSpeed * 0.5);
	}
	
	override  public function update ()
	{
		acceleration.set(0, 0);
		doKIStuff();
		
		super.update();
	}
	
	private function doKIStuff()
	{
		randomwalkTimer -= FlxG.elapsed;
		if (randomwalkTimer <= 0)
		{
			randomwalkTimer = 4;
			randomWalkDirection = FlxRandom.intRanged(0, 3);
		}
		
		if (randomWalkDirection == 0)
		{
			moveDown();
		}
		else if (randomWalkDirection == 1)
		{
			moveLeft();
		}
		else if (randomWalkDirection == 2)
		{
			moveUp();
		}
		else 
		{
			moveRight();
		}
		
	}
	
}