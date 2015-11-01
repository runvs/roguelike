package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;

/**
 * ...
 * @author 
 */
class SkillIcon extends FlxSprite
{

	public var overlay : FlxSprite;
	
	public var avail : Bool;
	public var ready : Bool;
	
	public var text : FlxText;
	
	public var coolDownTime : Float;
	public var currentTime : Float;
	
	public function new( n : Int ) 
	{
		super();	
		//this.makeGraphic(32, 32);
		avail = false;
		ready = false;
		
		coolDownTime = 1;
		currentTime = 0;
		
		overlay  = new FlxSprite();
		overlay.loadGraphic(AssetPaths.skillicon_overlay__png, true, 32, 32);
		overlay.scrollFactor.set();
		overlay.animation.add("1", [0], 100, true);
		overlay.animation.add("2", [1], 100, true);
		overlay.animation.add("3", [2], 100, true);
		overlay.animation.add("4", [3], 100, true);
		overlay.animation.add("5", [4], 100, true);
		overlay.animation.add("6", [5], 100, true);
		overlay.animation.add("7", [6], 100, true);
		overlay.animation.add("8", [7], 100, true);
		overlay.animation.add("0", [8], 100, true);
		overlay.alpha = 0.75;
		
		if (n == 1 )
		{
			this.loadGraphic(AssetPaths.skill_1__png, false, 16, 16);
		}
		else if (n == 2 )
		{
			this.loadGraphic(AssetPaths.skill_2__png, false, 16, 16);
		}
		else if (n == 3 )
		{
			this.loadGraphic(AssetPaths.skill_3__png, false, 16, 16);
		}
		else if (n == 4 )
		{
			this.loadGraphic(AssetPaths.skill_4__png, false, 16, 16);
		}
		else if (n == 5 )
		{
			this.loadGraphic(AssetPaths.skill_5__png, false, 16, 16);
		}
		else if (n == 6 )
		{
			this.loadGraphic(AssetPaths.skill_6__png, false, 16, 16);
		}
		else if (n == 7 )
		{
			this.loadGraphic(AssetPaths.skill_7__png, false, 16, 16);
		}
		else if (n == 8 )
		{
			this.loadGraphic(AssetPaths.skill_8__png, false, 16, 16);
		}
		this.scrollFactor.set();
		this.scale.set(2, 2);
		this.updateHitbox();
		this.setPosition( 10 + (n - 1) * (32 + 16), FlxG.height - 24 - 34 );
		
		text = new FlxText(x, y, 32, Std.string(n));
		text.scrollFactor.set();
		
		overlay.setPosition(x, y);
	}
	
	
	public override function draw () : Void 
	{
		super.draw();
		overlay.draw();
		text.draw();
	}
	
	public override function update () : Void 
	{
		super.update();
		overlay.update();
		text.update();
		
		if (FlxColorUtil.getRed(text.color) == FlxColorUtil.getRed(FlxColor.BLACK))
		{
			avail = false;
		} 
		else if (FlxColorUtil.getRed(text.color) == FlxColorUtil.getRed(FlxColor.GRAY))
		{
			avail = true;
			ready = false;
		}
		else
		{
			avail = true;
			ready = true;
		}
		
		if ( !avail)
		{
			this.color = FlxColorUtil.makeFromARGB(1.0, 50, 50, 50);
		}
		else
		{
			this.color = FlxColorUtil.makeFromARGB(1.0, 150, 150, 150);
			if (ready)
			{
				this.color = FlxColorUtil.makeFromARGB(1.0, 255, 255, 255);
			}
		}
		
		if ( avail && !ready)
		{
			var x : Int = 8 - Std.int(currentTime / ( coolDownTime / 8));
			var s : String = Std.string(x);
			overlay.animation.play(s, true);
		}
		else
		{
			overlay.animation.play("0");
		}
		
	}
	
	
}