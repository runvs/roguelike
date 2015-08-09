package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxRect;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	var level : Level;
	var player : Player;
	
	var skillz : SkillTree;
	private var _ending : Bool;
	
	private var _vignette : FlxSprite;
	private var _overlay : FlxSprite;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		_ending = false;
		
		level = new Level(this, 100, 30, 1);
		player = new Player();
		player.x = 100;
		player.y = 100;
		skillz = new SkillTree(player.properties);
		player.setSkills(skillz);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
		//FlxG.camera.setBounds(0, 0, level.map.width, level.map.height);
		
		
		
		// overlay and vignette stuff
		
		 _vignette = new FlxSprite(); 
		_vignette.loadGraphic(AssetPaths.vignette__png, false, 800, 600);
		_vignette.origin.set();
		_vignette.offset.set();
		_vignette.scale.set(1.28, 1.28);
		_vignette.alpha = 0.5;
		_vignette.scrollFactor.set();
		
		_overlay  = new FlxSprite();
		_overlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		FlxTween.tween(_overlay, { alpha:0 }, 0.5);
		_overlay.scrollFactor.set();
	}
	
	public function cleanUp ()  : Void 
	{
		level.cleanUp();
	}
	
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	
	private function endGame() : Void 
	{
		if (!_ending)
		{
			_ending = true;
			FlxG.camera.fade(FlxColor.BLACK, 1.0, false, function () : Void { FlxG.switchState(new MenuState()); } );
			//FlxGameJolt.fetchScore(
		}	
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		_overlay.update();
		skillz.update();
		
		if (!_ending)
		{
			if (!player.alive)
			{
				endGame();
			}
			
			if (!skillz.showMe)
			{
				super.update();
				cleanUp();
				level.update();
				player.update();
				player.updateHud();
				FlxG.collide(player, level.map.walls);
				FlxG.collide(level._grpEnemies, level.map.walls);
				FlxG.collide(level._grpEnemies, level.map.walls);
				
				FlxG.collide(player, level._grpEnemies);
				
				if (player.attack)
				{
					trace("attack");
					var r : FlxRect = player.getAttackRect();
					
					level._grpEnemies.forEach(function (e:Enemy) 
					{
						var enemyRect : FlxRect = new FlxRect (e.x, e.y, e.width, e.height);
						if (r.overlaps(enemyRect))
						{
							trace("hit");
							e.TakeDamage(player.properties.getDamage());
							if (e.alive == false)
							{
								player.properties.gainXP(120);
							}
						}
					});
				}
			}
		
		}
	}
	
	override public function draw(): Void
	{
		level.draw();
		player.draw();
		if (!skillz.showMe)
		{
			player.drawHud();
		}
		else
		{
			skillz.draw();
		}
		
		_vignette.draw();
		_overlay.draw();
		
		super.draw();
	}
}