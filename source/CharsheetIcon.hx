package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColorUtil;

/**
 * ...
 * @author 
 */
class CharsheetIcon extends FlxSprite
{
	
	public var text : FlxText;
	
	public var skillName : String;
	public var maxLevel : Int;
	public var currentLevel : Int;
	
	public var hitbox : FlxSprite;
	
	public var tooltip : FlxText;
	
	
	public function new(X:Float=0, Y:Float=0, graphic:Dynamic, skillname :String = "", tip : String = "") 
	{
		super(X, Y);
		this.loadGraphic(graphic, false, 16, 16);
		this.scale.set(2, 2);
		this.setSize(32, 32);
		this.updateHitbox();
		this.scrollFactor.set();
		
		hitbox = new FlxSprite(X, Y);
		hitbox.makeGraphic(32, 32, FlxColorUtil.makeFromARGB(0.1, 255, 255, 255));
		hitbox.scrollFactor.set();
		
		text = new FlxText(x, y + 32, 150, "" );
		text.scrollFactor.set();
		
		maxLevel = 5;
		currentLevel = 0;
		skillName = skillname;
		
		tooltip = new FlxText(x, y, 150, tip);
		tooltip.scrollFactor.set();
	}
	
	
	public override function update () : Void 
	{
		hitbox.update();
		super.update();
		text.update();
		if (maxLevel > 0)
		{
			text.text = skillName + "\n" + Std.string(currentLevel) + " / " + Std.string(maxLevel);
		}
		else
		{
			text.text = skillName  + " " + Std.string(currentLevel);
		}
		
		text.color = this.color;
		
		
		
		if (hitbox.overlapsPoint(FlxG.mouse, true))
		{
			tooltip.alpha = 1.0;
			tooltip.x = FlxG.mouse.screenX + 16;
			tooltip.y = FlxG.mouse.screenY + 16; 
			
			var ovx : Float = tooltip.x + tooltip.width - FlxG.width;
			var ovy : Float = tooltip.y + tooltip.height- FlxG.height;
			
			if (ovx  > 0)
			{
				tooltip.x -= ovx;
			}
			if (ovy > 0 )
			{
				tooltip.y -= ovy;
			}
			
		}
		else
		{
			tooltip.alpha = 0.0;
		}
		
	}
	
	public override function draw () : Void 
	{
		hitbox.draw();
		super.draw();
		text.draw();
		
	}
	
	public function drawToolTip() : Void 
	{
		tooltip.draw();
	}
	
	
	
}