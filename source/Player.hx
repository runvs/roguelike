package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColorUtil;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;

/**
 * ...
 * @author 
 */
class Player extends Creature
{
	public var properties : PlayerProperties;
	
	private var attacTimer : Float;
	
	private var targetbox : FlxSprite;
	
	public function new() 
	{
		super();
		
		properties = new PlayerProperties();
		
		this.makeGraphic(GameProperties.TileSize, GameProperties.TileSize);
		
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed,  GameProperties.Player_MaxSpeed);
		attacTimer = 0;
		targetbox = new FlxSprite();
		targetbox.makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(0.5, 100, 200, 200));
	}
	
	override public function draw()
	{
		super.draw();
		targetbox.draw();
	}
	
	override public function update()
	{
		acceleration.set(0, 0);
		getInput();
		super.update();
		
		var f : EFacing = getLastFacing();
			
		var r : FlxRect  = new FlxRect(x, y, GameProperties.TileSize, GameProperties.TileSize);
		if (f == EFacing.Right)
		{
			r.x += GameProperties.TileSize;
		}
		else if (f == EFacing.Left)
		{
			r.x -= GameProperties.TileSize;
		}
		if (f == EFacing.Up)
		{
			r.y -= GameProperties.TileSize;
		}
		else if (f == EFacing.Down)
		{
			r.y += GameProperties.TileSize;
		}
		targetbox.setPosition(r.x, r.y);
	}
	
	private function getInput () : Void 
	{
		
		var left : Bool = false;
		var right : Bool = false;
		
		if (FlxG.keys.anyPressed(["A", "LEFT"]))
			left = true;
		if (FlxG.keys.anyPressed(["D", "RIGHT"]))
			right = true;
			
		if (left && !right)
		{
			moveLeft();
		}
		else if (right != left)
		{
			moveRight();
		}
		else
		{
			// do nothing, since both or no key is pressed
		}
		
		
		var up : Bool = false;
		var down : Bool = false;
		
		if (FlxG.keys.anyPressed(["W", "UP"]))
			up = true;
		if (FlxG.keys.anyPressed(["S", "DOWN"]))
			down = true;
			
		if (up && !down)
		{
			moveUp();
		}
		else if (down != up)
		{
			moveDown();
		}
		else
		{
			// do nothing, since both or no key is pressed
		}
		
		var attack: Bool = false;
		if (FlxG.mouse.justPressed)
		{
			attack = true;
		}
		if (attack)
		{
			doAttack();
		}
	}

	
	private function doAttack () : Void 
	{
		if (attacTimer  <= 0)
		{
			attacTimer = GameProperties.Player_AttackSpeed;
			
			var f : EFacing = getLastFacing();
			
			var r : FlxRect  = new FlxRect(x, y, GameProperties.TileSize, GameProperties.TileSize);
			if (f == EFacing.Right)
			{
				r.x += GameProperties.TileSize;
			}
			else if (f == EFacing.Left)
			{
				r.x -= GameProperties.TileSize;
			}
			if (f == EFacing.Up)
			{
				r.y -= GameProperties.TileSize;
			}
			else if (f == EFacing.Down)
			{
				r.y += GameProperties.TileSize;
			}
		}
	}
	
	

}
