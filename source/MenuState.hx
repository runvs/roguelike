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
	
	private var ring : RingMenu;
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
		
		ring = new RingMenu();
		ring.setTitleText("Roguelike");
		ring.setCreditText("A Game by\n  Lisa Malvareth Zumblick \nand\n  Simon @Laguna_999 Weis\n\nVisit us at https://runvs.io\n\nCreated August / November 2015");
		
		ring.addItem("Play Game", StartGame);
		ring.addItem("Exit", QuitGame);
		
		add(ring);
	}
	
	public function QuitGame() : Void 
	{
		
	}
	
	public function StartGame() : Void
	{
		FlxG.switchState(new PlayState());
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
			StartGame();
		}
	}	
}