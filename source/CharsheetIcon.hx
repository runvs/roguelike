package;

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
	
	
	public function new(X:Float=0, Y:Float=0, graphic:Dynamic, skillname :String = "") 
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
		
	}
	
	public override function draw () : Void 
	{
		hitbox.draw();
		super.draw();
		text.draw();
	}
	
	
	
}