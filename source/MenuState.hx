package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

using flixel.util.FlxSpriteUtil;
/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	var t: FlxText;
	var t2: FlxText;
	var t3 : FlxText;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		//FloodfillTester.SelfTest();
		
		#if flash
		FlxG.sound.playMusic(AssetPaths.roguelike_ost__mp3, 1.0, true);
		#else
		FlxG.sound.playMusic(AssetPaths.roguelike_ost__ogg, 1.0, true);
		#end
		
		t = new FlxText(0, 0, 1024, "Roguelike");
		t.screenCenter();
		t.setFormat(40, FlxColor.WHITE,"center");
		add(t);
		
		t2 = new FlxText(0, 0, 1024, "Press Space or Return to start");
		t2.screenCenter();
		t2.setFormat(20, FlxColor.WHITE,"center");
		t2.y += 100;
		add(t2);
		
		t3 = new FlxText(0, 0, 1024, "A Game by\n  Lisa Malvareth Zumblick \nand\n  Simon Laguna Weis\n\nVisit us at https://runvs.io\n\nCreated August 2015");
		t3.screenCenter();
		t3.setFormat(10, FlxColor.WHITE,"left");
		t3.y = FlxG.height - t3.height - 20;
		add(t3);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		if (FlxG.keys.anyJustPressed(["Space", "Return"]))
		{
			FlxG.switchState(new PlayState());
		}
	}	
}