package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import flixel.util.FlxTimer;
import flixel.util.FlxVector;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	var level : Level;
	var levelNumber : Int;
	var player : Player;
	
	var skillz : SkillTree;
	private var _ending : Bool;
	
	private var _vignette : FlxSprite;
	private var _overlay : FlxSprite;
	
	private var switching : Bool;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		_ending = false;
		switching = false;
		levelNumber = 1;
		
		
		
		CreateNewLevel(1);
		player = new Player();
		player.setPosition(level.getPlayerStartingPosition() .x, level.getPlayerStartingPosition().y);
		
		skillz = new SkillTree(player.properties);
		player.setSkills(skillz);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
		FlxG.camera.setBounds(0, 0, level.sizeX*GameProperties.TileSize, level.sizeY*GameProperties.TileSize);
		
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
		
		#if FLX_NO_DEBUG
		FlxTween.tween(_overlay, { alpha:0 }, 0.5);
		#else
		_overlay.alpha = 0;
		#end
		
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
	
	function ChangeLevel():Void 
	{
		if ( !switching)
		{
			if (FlxG.overlap(player, level.Exit)) 
			{
				switching = true;
				FlxTween.tween(_overlay, { alpha:1 } );
				var t : FlxTimer = new FlxTimer(1, function (t:FlxTimer) 
				{
					levelNumber++;
					//level = new Level(this, GameProperties.WorldSizeInTilesx, GameProperties.WorldSizeInTilesy, player.properties.level, levelNumber);
					CreateNewLevel(player.properties.level);
					switching = false;
					player.setPosition(level.getPlayerStartingPosition().x, level.getPlayerStartingPosition().y);
					FlxTween.tween(_overlay, { alpha:0 } );
				});
			}
		}
	}
	
	function CreateNewLevel(playerLevel:Int):Void 
	{
		trace("create new Level");
		level = new Level(this, GameProperties.WorldSizeInTilesx, GameProperties.WorldSizeInTilesy, playerLevel, levelNumber);
		//while (!FloodfillTester.Test(level, Std.int(level.getStartingPositionInTiles().x), Std.int(level.getStartingPositionInTiles().y), level.Exit.tx, level.Exit.ty))
		//{
		//	level = new Level(this, GameProperties.WorldSizeInTilesx, GameProperties.WorldSizeInTilesy, playerLevel, levelNumber);
		//}
		trace ("testing floodfill");
		var result : Bool = FloodfillTester.Test(level, Std.int(level.getStartingPositionInTiles().x), Std.int(level.getStartingPositionInTiles().y), level.Exit.tx, level.Exit.ty);
		trace (result);
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		_overlay.update();
		skillz.update();
		
		
		
		if (!_ending && !switching )
		{
			if (!player.alive)
			{
				endGame();
			}
			
			if (!skillz.showMe)
			{
				super.update();
				
				level._grpEnemies.forEach(function(e:Enemy) 
				{
					if (e.alive == false)
					{
						player.properties.gainXP(GameProperties.Enemy_BaseXP);
					}
				});
				cleanUp();
				level.update();
				player.update();
				player.updateHud();
				FlxG.collide(level.map.walls, level._grpParticles, function(t:Tile, p:Particle)
				{
					p.hit();
				});
				FlxG.collide(level._grpEnemies, level._grpParticles, function(e:Enemy , p:Particle)
				{
					e.TakeDamage(p.damage);
					p.hit();
				});
				
				FlxG.collide(level.map.walls, player);
				FlxG.collide(level._grpShields, level._grpEnemies);
				FlxG.collide(level._grpShields, level._grpParticles);
				FlxG.collide(level._grpShields, player);
			
				FlxG.collide(level._grpEnemies, level.map.walls, Enemy.handleWallCollision);
				for (enemy in level._grpEnemies)
				{
					var xx:Float = enemy.x - player.x;
					var yy:Float = enemy.y - player.y;
					var distance:Float = xx * xx + yy * yy;
					
					if (distance <= GameProperties.Enemy_AggroRadius*GameProperties.Enemy_AggroRadius) {
						enemy.doRandomWalk = false;
						enemy.walkTowards(player);
					}
					else
					{
						enemy.doRandomWalk = true;
					}
				}
				
				FlxG.collide(player, level._grpEnemies, Enemy.handlePlayerCollision);
				
				ChangeLevel();
				
				if (player.attack)
				{
					//trace("attack");
					var r : FlxRect = player.getAttackRect();
					
					level._grpEnemies.forEach(function (e:Enemy) 
					{
						var enemyRect : FlxRect = new FlxRect (e.x, e.y, e.width, e.height);
						if (r.overlaps(enemyRect))
						{
							//trace("hit");
							e.TakeDamage(player.properties.getDamage());
						
						}
					});
				}
				if (player.attackPowerShoot)
				{
					var mx : Float = FlxG.mouse.x;
					var my : Float = FlxG.mouse.y;
					var p : Particle  = new Particle(player.x, player.y, mx, my, false, skillz.PowerShoot, this);
					level._grpParticles.add(p);
				}
				if (player.attackPowerBall)
				{
					var mx : Float = FlxG.mouse.x;
					var my : Float = FlxG.mouse.y;
					var p : Particle  = new Particle(player.x, player.y, mx, my, true, skillz.PowerBall, this);
					level._grpParticles.add(p);
				}
				if (player.attackShield)
				{
					var mx : Float = FlxG.mouse.x;
					var my : Float = FlxG.mouse.y;
					var s : Shield = new Shield(mx, my, skillz.PowerShield);
					level._grpShields.add(s);
				}
			}
		
		}
	}
	
	public function spawnPowerBallExplosion(p : Particle)
	{
		//trace ("PBE");
		var l : Int = p._level + 3;
		var d : Float = 360.0 / l;
		var dir : FlxVector = new FlxVector(1, 1);
		for (i in 0...l)
		{
			
			dir.rotateByDegrees(d);
			var p2 : Particle = new Particle(p.x, p.y, p.x + dir.x, p.y + dir.y, false, p._level, this);
			level._grpParticles.add(p2);
		}
	}
	
	override public function draw(): Void
	{
		level.draw();
		player.draw();
		
		
		_vignette.draw();
		if (!skillz.showMe)
		{
			player.drawHud();
		}
		else
		{
			skillz.draw();
		}
		_overlay.draw();
		
		super.draw();
	}
}