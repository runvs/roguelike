package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author 
 */
class RingMenu extends FlxSpriteGroup
{

	private var Title : FlxText;
	private var itemGroup : FlxTypedGroup<RingItem>;
	
	private var selector : FlxSprite;
	private var selectedItem : Int;
	
	public function new() 
	{
		super();
		this.scrollFactor.set();
		Title = new FlxText(0, 0, FlxG.width, "", 16);
		add(Title);
		
		itemGroup = new FlxTypedGroup<RingItem>();
		//itemGroup.scrollFactor.set();
		
		//add(itemGroup);
		
		selector = new FlxSprite();
		selector.makeGraphic(16, 4);
		selector.offset.set(32, 0);
		add(selector);
		
		
		selectedItem = 0;
		
	}
	
	public function setTitleText (t : String)
	{
		Title.text = t;
		Title.screenCenter();
		Title.setFormat(40, FlxColor.WHITE, "center");
		Title.y -= FlxG.height/4;
	}
	
	public function addItem(name:String, notifyCallback:Void -> Void)
	{
		var i : Int = itemGroup.length;
		var t : RingItem = new RingItem(0, 0, 100, name, 12);
		t.callback = notifyCallback;
		t.screenCenter();
		t.y += 32 * i;
		itemGroup.add(t);
	}
	
	public override function update()
	{
		super.update();
		itemGroup.update();
		if (itemGroup.length >= 1)
		{
			selector.x = itemGroup.members[selectedItem].x;
			selector.y = itemGroup.members[selectedItem].y;
		}
		
		getInput();
		
	}
	
	function getInput() 
	{
		if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S)
		{
			MoveSelectorDown();
		}
		else if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W)
		{
			MoveSelectorUp();
		}
		else if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
		{
			Proceed();
		}
	}
	
	function Proceed() 
	{
		if (itemGroup.length > 0)
		{
			itemGroup.members[selectedItem].callback();
		}
	}
	
	function MoveSelectorUp() 
	{
		selectedItem--;
		if (selectedItem < 0)
		{
			selectedItem = itemGroup.length - 1;
		}
	}
	
	function MoveSelectorDown() 
	{
		selectedItem++;
		if (selectedItem > itemGroup.length - 1)
		{
			selectedItem = 0;
		}
	}
	
	public override function draw()
	{
		super.draw();
		itemGroup.draw();
	}
	
	
	
	
	
	
	
}