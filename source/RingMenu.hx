package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedGroup;
import flixel.input.gamepad.LogitechButtonID;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author 
 */
class RingMenu extends FlxSpriteGroup
{

	private var Title : FlxText;
	private var CreditsText : FlxText;
	private var itemGroup : FlxTypedGroup<RingItem>;
	
	private var selector : FlxSprite;
	private var selectedItem : Int;
	
	private var leftXPos : Float = FlxG.width / 2 - 25;
	
	public function new() 
	{
		super();
		this.scrollFactor.set();
		
		Title = new FlxText(0, 0, FlxG.width, "", 16);
		add(Title);
		CreditsText = new FlxText(0, 0, FlxG.width / 2, "", 8);
		add(CreditsText);
		
		itemGroup = new FlxTypedGroup<RingItem>();		
		selector = new FlxSprite();
		selector.makeGraphic(16, 4);
		selector.offset.set(32, -8);
		selector.color = GameProperties.Color_Red;
		add(selector);
		
		selectedItem = 0;
		
	}
	
	public function setTitleText (t : String)
	{
		Title.text = t;
		Title.screenCenter();
		Title.setFormat(40, FlxColor.WHITE, "center");
		Title.setBorderStyle(FlxText.BORDER_OUTLINE, GameProperties.Color_Red, 2);
		Title.y -= FlxG.height/3;
	}
	public function setCreditText (t : String)
	{
		CreditsText.text = t;
		CreditsText.x = 0;
		CreditsText.y = FlxG.height - 80 - 4;
	}
	
	public function addItem(name:String, notifyCallback:Void -> Void)
	{
		var i : Int = itemGroup.length;
		var t : RingItem = new RingItem(0, 0, 100, name, 12);
		t.callback = notifyCallback;
		t.screenCenter();
		t.y += 32 * i;
		t.x = leftXPos;
		itemGroup.add(t);
	}
	
	public override function update()
	{
		super.update();
		itemGroup.update();
		if (itemGroup.length >= 1)
		{
			selector.x = FlxG.width / 2 - 25;
			selector.y = itemGroup.members[selectedItem].y;
			if (itemGroup.length > 1)
			{
				getInput();
			}
			for (i in 0...itemGroup.length)
			{
				var r : RingItem = itemGroup.members[i];
				if (i == selectedItem)
				{
					r.setBorderStyle(FlxText.BORDER_OUTLINE, GameProperties.Color_Red, 2);
				}
				else
				{
					r.setBorderStyle(FlxText.BORDER_NONE, GameProperties.Color_Red, 2);
				}
			}
		}
		
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
		
		var rold : RingItem = itemGroup.members[selectedItem];
		selectedItem--;
		if (selectedItem < 0)
		{
			selectedItem = itemGroup.length - 1;
		}
		var rnew : RingItem = itemGroup.members[selectedItem];
		
		FlxTween.tween(rnew, { x:leftXPos + 10}, 0.1);
		FlxTween.tween(rold, { x:leftXPos }, 0.1);
	}
	
	function MoveSelectorDown() 
	{
		var rold : RingItem = itemGroup.members[selectedItem];
		selectedItem++;
		if (selectedItem > itemGroup.length - 1)
		{
			selectedItem = 0;
		}
		var rnew : RingItem = itemGroup.members[selectedItem];
		
		FlxTween.tween(rnew, { x:leftXPos + 10 }, 0.1);
		FlxTween.tween(rold, { x:leftXPos}, 0.1);
	}
	
	public override function draw()
	{
		super.draw();
		itemGroup.draw();
	}
	
	
	
	
	
	
	
}