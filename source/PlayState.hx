package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	var level : Level;
	var player : Player;
	
	var skillz : SkillTree;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		level = new Level(this, 100, 30, 1);
		player = new Player();
		player.x = 100;
		player.y = 100;
		skillz = new SkillTree(player.properties);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
		//FlxG.camera.setBounds(0, 0, level.map.width, level.map.height);
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
		level.update();
		player.update();
		FlxG.collide(player, level.map.walls);
		FlxG.collide(level._grpEnemies, level.map.walls);
		FlxG.collide(player, level._grpEnemies);
		FlxG.collide(level._grpEnemies, level.map.walls);
		skillz.update();
	}
	
	override public function draw(): Void
	{
		level.draw();
		player.draw();
		skillz.draw();
		super.draw();
	}
}