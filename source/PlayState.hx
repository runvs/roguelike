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
		FlxG.camera.setBounds(0, 0, level.sizeX*GameProperties.Tile_Size, level.sizeY*GameProperties.Tile_Size);
		
		// overlay and vignette stuff
		
		 _vignette = new FlxSprite(); 
		_vignette.loadGraphic(AssetPaths.vignette__png, false, 800, 600);
		_vignette.origin.set();
		_vignette.offset.set();
		_vignette.scale.set(FlxG.width/_vignette.width, FlxG.height/_vignette.height);
		_vignette.alpha = 0.75;
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
					CreateNewLevel(player.properties.level);
					switching = false;
					player.setPosition(level.getPlayerStartingPosition().x, level.getPlayerStartingPosition().y);
					FlxTween.tween(_overlay, { alpha:0 } );
				});
			}
		}
	}
	
	// This Method will create a new Level and do a floodfill check.
	// if the check fails, a new level will be created
	function CreateNewLevel(playerLevel:Int):Void 
	{
		FlxG.worldBounds.set(GameProperties.World_SizeInTilesX*GameProperties.Tile_Size, GameProperties.World_SizeInTilesY * GameProperties.Tile_Size);
		
		trace("create new Level");
		level = new Level(GameProperties.World_SizeInTilesX, GameProperties.World_SizeInTilesY, playerLevel, levelNumber);
		while (!FloodfillTester.Test(level, Std.int(level.getStartingPositionInTiles().x), Std.int(level.getStartingPositionInTiles().y), level.Exit.tx, level.Exit.ty))
		{
			level = new Level(GameProperties.World_SizeInTilesX, GameProperties.World_SizeInTilesY, playerLevel, levelNumber);
		}
	}
		
	function updateEnemies():Void 
	{
		level._grpEnemies.forEach(function(e:Enemy) 
		{
			if (e.alive == false)
			{
				player.properties.gainXP(GameProperties.Enemy_BaseXP);
			}
			else 
			{
				var xx:Float = e.x - player.x;
				var yy:Float = e.y - player.y;
				var distance:Float = xx * xx + yy * yy;
				
				if (distance <= GameProperties.Enemy_AggroRadius*GameProperties.Enemy_AggroRadius) {
					e.doRandomWalk = false;
					e.walkTowards(player);
				}
				else
				{
					e.doRandomWalk = true;
				}
			}
		});
	}
	
	function updateCollisions():Void 
	{
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
		FlxG.collide(player, level._grpEnemies, Enemy.handlePlayerCollision);
	}
	
	function updateLevel():Void 
	{
		level.update();
		level.map.setVisibility(Std.int(player.x / GameProperties.Tile_Size+0.5), 
			Std.int(player.y / GameProperties.Tile_Size+0.5), 
			4);
	}
	
	function updatePlayer():Void 
	{
		player.update();
		player.updateHud();
		
		if (player.attack)
		{
			var r : FlxRect = player.getAttackRect();
			level._grpEnemies.forEach(function (e:Enemy) 
			{
				var enemyRect : FlxRect = new FlxRect (e.x, e.y, e.width, e.height);
				if (r.overlaps(enemyRect))
				{
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
				
				updateEnemies();
				
				cleanUp();
				
				updateLevel();
				
				updatePlayer();
				
				updateCollisions();
				
				ChangeLevel();
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
		
		level.drawShadows();
		

		level.drawVisited();
		
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