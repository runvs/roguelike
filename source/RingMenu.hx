package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
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
	
	private var itemOffsetX : Float;
	
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
		selector.alpha = 0;
		FlxTween.tween(selector, { alpha: 1.0 }, 0.25, {startDelay: 1.75 } );
		add(selector);
		
		selectedItem = 0;
		
		itemOffsetX = FlxG.width/2 + 32;

		FlxTween.tween(this, { itemOffsetX: 0 }, 0.75, { ease:FlxEase.bounceOut, startDelay: 1.0 } );
	}
	
	public function setTitleText (t : String)
	{
		Title.text = t;
		Title.screenCenter();
		Title.setFormat(40, FlxColor.WHITE, "center");
		Title.borderStyle = FlxTextBorderStyle.OUTLINE;
		Title.borderColor = GameProperties.Color_Yellow;
		Title.borderSize = 2;
		var finalTitlePosition : Float = Title.y -FlxG.height / 3;
		Title.y = - 50;
	
		FlxTween.tween(Title, { y: finalTitlePosition }, 0.6, { ease:FlxEase.bounceOut, startDelay: 0 } );
	}
	public function setCreditText (t : String)
	{
		CreditsText.text = t;
		var finalCreditsPosition : Int = 0;
		CreditsText.x = -FlxG.width / 2 - 64;
		CreditsText.y = FlxG.height - 80 - 4;

		FlxTween.tween(CreditsText, { x: finalCreditsPosition }, 1, { ease:FlxEase.bounceOut, startDelay:0.35 } );
	}
	
	public function addItem(name:String, notifyCallback:Void -> Bool)
	{
		var i : Int = itemGroup.length;
		var t : RingItem = new RingItem(0, 0, 100, name, 12);
		t.callback = notifyCallback;
		t.screenCenter();
		t.y += 32 * i;
		t.x = leftXPos;
		itemGroup.add(t);
		if (itemGroup.length == 1 )
		{
			itemGroup.members[0].x = leftXPos + 10;
		}
		
	
	}
	
	public override function update(elapsed : Float)
	{
		super.update(elapsed);
		itemGroup.update(elapsed);
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
				r.offset.x = -itemOffsetX;	// tween at the beginning
				if (i == selectedItem)
				{
					if (r.result)
					{
						r.borderStyle = FlxTextBorderStyle.OUTLINE;
						r.borderSize = 2;
						r.borderColor = GameProperties.Color_Green;
					}
					else
					{
						r.borderStyle = FlxTextBorderStyle.OUTLINE;
						r.borderSize = 2;
						r.borderColor = GameProperties.Color_Red;
					}
				}
				else
				{
					r.borderStyle = FlxTextBorderStyle.NONE;
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
			var c : Bool = itemGroup.members[selectedItem].callback();
			itemGroup.members[selectedItem].result = c;
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