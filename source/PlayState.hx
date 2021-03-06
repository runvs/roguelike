package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxRect;
import flixel.math.FlxVector;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	public var level : Level;
	var levelNumber : Int;
	public var player : Player;
	
	var skillz : SkillTree;
	private var _ending : Bool;
	
	private var _vignette : FlxSprite;
	private var _overlay : FlxSprite;
	
	private var switching : Bool;
	private var pathfinder :Pathfinder;
	
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
		FlxG.camera.follow(player, FlxCameraFollowStyle.NO_DEAD_ZONE);
		//FlxG.camera.setScrollBounds(0, 0, level.sizeX*GameProperties.Tile_Size, level.sizeY*GameProperties.Tile_Size);
		
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
		
		pathfinder = new Pathfinder();
		
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
				var t : FlxTimer = new FlxTimer();
				t.start(1, function (t:FlxTimer) 
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
		while (!
		FloodfillTester.Test(level,
		level.Exit.tx, level.Exit.ty,
		 Std.int(level.getStartingPositionInTiles().x), Std.int(level.getStartingPositionInTiles().y)
		))
		{
			level = new Level(GameProperties.World_SizeInTilesX, GameProperties.World_SizeInTilesY, playerLevel, levelNumber);
		}
		
		//trace("end new level");
	}
		
	function updateEnemies(elapsed:Float):Void 
	{
		level._grpEnemies.forEach(function(e:BasicEnemy) 
		{
			if (e.alive == false)
			{
				player.properties.gainXP(GameProperties.Enemy_BaseXP);
			}
			else 
			{
				e.setState(this);
			}
		});
	}
	
	function updateCollisions():Void 
	{
		FlxG.collide(level.map.walls, level._grpParticles, function(t:Tile, p:Projectile)
		{
			p.hit();
		});
		FlxG.collide(level._grpEnemies, level._grpParticles, function(e:BasicEnemy , p:Projectile)
		{
			e.TakeDamage(p.damage);
			p.hit();
		});
		
		FlxG.collide(level.map.walls, player);
		FlxG.collide(level._grpShields, level._grpEnemies);
		FlxG.collide(level._grpShields, level._grpParticles);
		FlxG.collide(level._grpShields, player);
		
		FlxG.collide(level._grpEnemyParticles, player, function(p:Projectile, pla:Player)
		{
			trace ("take damage");
			pla.properties.takeDamage(p.damage);
			p.hit();
		});
		FlxG.collide(level.map.walls, level._grpEnemyParticles, function(t:Tile, p:Projectile)
		{
			p.hit();
		});
	
		FlxG.collide(level._grpEnemies, level.map.walls, BasicEnemy.handleWallCollision);
		//FlxG.collide(player, level._grpEnemies);
	}
	
	function updateLevel(elapsed:Float):Void 
	{
		var px : Int = Std.int(player.x / GameProperties.Tile_Size+0.5);
		var py : Int = Std.int(player.y / GameProperties.Tile_Size+0.5);
		
		level.update(elapsed);
		level.map.setVisibility(px, py, 4);
		pathfinder.setLevel (level);
		pathfinder.setPlayerPos(px, py);
		pathfinder.update();
	}
	
	function updatePlayer(elapsed:Float):Void 
	{
		player.update(elapsed);
		player.updateHud(elapsed);
		
		if (player.attack)
		{
			var r : FlxRect = player.getAttackRect();
			level._grpEnemies.forEach(function (e:BasicEnemy) 
			{
				var enemyRect : FlxRect = new FlxRect (e.x, e.y, e.width, e.height);
				if (r.overlaps(enemyRect))
				{
					e.TakeDamage(player.properties.getDamage());
				
					var f : EFacing = player.getLastFacing();
					var tx : Float = 0;
					var ty : Float = 0;
					
					if (f == EFacing.Down)
					{
						ty += 1;
					}
					else if (f == EFacing.Up)
					{
						ty -= 1;
					}
					else if (f == EFacing.Left)
					{
						tx -= 1;
					}
					else if (f == EFacing.Right)
					{
						tx += 1;
					}
				
					e.velocity.set(tx * GameProperties.Player_AttackPushBackVelocity, ty * GameProperties.Player_AttackPushBackVelocity);
				}
			});
		}
		if (player.attackPowerShoot)
		{

			var f : EFacing = player.getLastFacing();
			var tx : Float = 0;
			var ty : Float = 0;
			
			if (f == EFacing.Down)
			{
				ty += 1;
			}
			else if (f == EFacing.Up)
			{
				ty -= 1;
			}
			else if (f == EFacing.Left)
			{
				tx -= 1;
			}
			else if (f == EFacing.Right)
			{
				tx += 1;
			}
			var p : Projectile = new Projectile(player.x + GameProperties.Tile_Size/2 , player.y  + GameProperties.Tile_Size/2 , tx, ty, ProjectileType.Shot, skillz.PowerShoot, this);
			level._grpParticles.add(p);
		}
		if (player.attackPowerBall)
		{
			var tx : Float = 0;
			var ty : Float = 0;
			var f : EFacing = player.getLastFacing();
			if (f == EFacing.Down)
			{
				ty += 1;
			}
			else if (f == EFacing.Up)
			{
				ty -= 1;
			}
			else if (f == EFacing.Left)
			{
				tx -= 1;
			}
			else if (f == EFacing.Right)
			{
				tx += 1;
			}
			var p : Projectile = new Projectile(player.x + GameProperties.Tile_Size/2, player.y + GameProperties.Tile_Size/2, tx, ty, ProjectileType.Ball, skillz.PowerShoot, this);
			level._grpParticles.add(p);
		}
		if (player.attackShield)
		{
			var tx : Float = player.x;
			var ty : Float = player.y;
			var f : EFacing = player.getLastFacing();
			if (f == EFacing.Down)
			{
				ty += GameProperties.Tile_Size * 3;
			}
			else if (f == EFacing.Up)
			{
				ty -= GameProperties.Tile_Size * 3;
			}
			else if (f == EFacing.Left)
			{
				tx -= GameProperties.Tile_Size * 3;
			}
			else if (f == EFacing.Right)
			{
				tx += GameProperties.Tile_Size * 3;
			}
			
			var s : Shield = new Shield(tx + GameProperties.Tile_Size/2, ty + GameProperties.Tile_Size/2, skillz.PowerShield);
			level._grpShields.add(s);
		}
		
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		_overlay.update(elapsed);
		skillz.update(elapsed);
		player.getInputMenu();
		if (!_ending && !switching )
		{
		
			if (!player.alive)
			{
				endGame();
			}
			
			
			
			if (!skillz.showMe)
			{
				super.update(elapsed);
				
				updateEnemies(elapsed);
				
				cleanUp();
				
				updateLevel(elapsed);

				updatePlayer(elapsed);
				
				updateCollisions();
				
				ChangeLevel();
			}
			
			
			
		}
		
		
		
	}
	
	public function spawnPowerBallExplosion(p : Projectile)
	{
		//trace ("PBE");
		FlxG.camera.shake(0.0125, 0.25);
		var l : Int = p._level + 3;
		var d : Float = 360.0 / l;
		var dir : FlxVector = new FlxVector(1, 1);
		for (i in 0...l)
		{
			
			dir.rotateByDegrees(d);
			var p2 : Projectile = new Projectile(p.x, p.y, p.x + dir.x, p.y + dir.y, ProjectileType.Shot, p._level, this);
			level._grpParticles.add(p2);
		}
	}
	
	override public function draw(): Void
	{
		level.draw();
		player.draw();
		
		level.drawShadows();
		

		level.drawVisited();
		
		
		if (!skillz.showMe)
		{
			player.drawHud();
		}
		else
		{
			skillz.draw();
		}
		//_vignette.draw();
		//_overlay.draw();
		
		//super.draw();
	}
}