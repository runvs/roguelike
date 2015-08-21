package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import lime.math.Rectangle;

/**
 * ...
 * @author 
 */
class Player extends Creature
{
	public var properties : PlayerProperties;
	
	private var attacTimer : Float;
	
	private var targetbox : FlxSprite;
	private var targetboxRect : FlxRect;
	
	public var attack : Bool;
	public var attackPowerShoot : Bool;
	public var attackPowerBall : Bool;
	public var attackShield : Bool;
	private var skill_PowerHit : FlxText;
	private var skill_PowerShoot : FlxText;
	private var skill_PowerShield : FlxText;
	private var skill_PowerBall : FlxText;
	private var skill_PowerArmor : FlxText;
	private var skill_BoostRegen : FlxText;
	private var skill_BoostAgi : FlxText;
	private var skill_BoostExp : FlxText;
	
	private var HPBar : HudBar;
	private var MPBar : HudBar;
	private var ExpBar : HudBar;
	
	var skillz : SkillTree;
	
	var effectFGRed : FlxSprite;
	var effectBGRed : FlxSprite;
	
	var effectFGGreen : FlxSprite;
	var effectBGGreen : FlxSprite;
	
	var effectFGYellow : FlxSprite;
	var effectBGYellow : FlxSprite;
	
	public function new() 
	{
		super();
		
		properties = new PlayerProperties();
		
		//this.makeGraphic(GameProperties.TileSize, GameProperties.TileSize);
		this.loadGraphic(AssetPaths.Player__png, true, 32, 32);
		this.animation.add("idle", [0, 1], 3, true);
		this.animation.add("walk", [4, 5, 6, 7],6, true);
		this.animation.add("attack", [12, 13], 5, false);
		this.animation.add("taunt", [12, 13], 5, false);
		this.animation.play("idle");
		
		//this.scale.set(2,2
		this.width = 25;
		this.updateHitbox();
		
		this.updateHitbox();
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		
		attacTimer = 0;
		targetbox = new FlxSprite();
		targetbox.makeGraphic(GameProperties.TileSize, GameProperties.TileSize, FlxColorUtil.makeFromARGB(0.5, 100, 200, 200));
		targetboxRect = new FlxRect(x, y, GameProperties.TileSize, GameProperties.TileSize);
		
		// hud stuff
		
		skill_PowerHit    = new FlxText(200, FlxG.height - 80, 200, "Power Hit [1]");
		skill_PowerHit.scrollFactor.set();
		skill_PowerShoot  = new FlxText(200, FlxG.height - 70, 200, "Power Shoot [2]" );
		skill_PowerShoot.scrollFactor.set();
		skill_PowerShield = new FlxText(200, FlxG.height - 60, 200, "Power Shield [3]");
		skill_PowerShield.scrollFactor.set();
		skill_PowerBall   = new FlxText(200, FlxG.height - 50, 200, "Power Ball [4]");
		skill_PowerBall.scrollFactor.set();
		skill_PowerArmor  = new FlxText(200, FlxG.height - 40, 200, "Power Armor [5]");
		skill_PowerArmor.scrollFactor.set();
		skill_BoostRegen  = new FlxText(200, FlxG.height - 30, 200, "Boost Regen [6]");
		skill_BoostRegen.scrollFactor.set();
		skill_BoostAgi    = new FlxText(200, FlxG.height - 20, 200, "Boost Agi [7]");
		skill_BoostAgi.scrollFactor.set();
		skill_BoostExp    = new FlxText(200, FlxG.height - 10, 200, "Boost Exp [8]");
		skill_BoostExp.scrollFactor.set();
		
		HPBar = new HudBar(100, FlxG.height - 100 -10, 30, 100);
		HPBar.color = FlxColor.RED;
		MPBar = new HudBar(FlxG.width - 100 , FlxG.height - 100 - 10, 30, 100);
		MPBar.color = FlxColor.BLUE; 
		ExpBar = new HudBar( 300, FlxG.height - 30 -10, FlxG.width - 600, 30, false);
		ExpBar.color = FlxColor.GOLDEN;
		
		
		effectFGRed = new FlxSprite();
		effectBGRed = new FlxSprite();
		effectBGRed.loadGraphic(AssetPaths.Spell_Agi__png, true, 32, 32);
		effectFGRed.loadGraphic(AssetPaths.Spell_Agi__png, true, 32, 32);
		
		effectBGRed.animation.add("idle", [9], 30, true);
		effectBGRed.animation.add("cast", [9, 0,1,2,3,9], 30, false);
		effectBGRed.animation.play("idle");
		effectFGRed.animation.add("idle", [9], 30, true);
		effectFGRed.animation.add("cast", [4,5,6,7,8], 10, true);
		
		
		
		effectFGGreen = new FlxSprite();
		effectBGGreen = new FlxSprite();
		effectBGGreen.loadGraphic(AssetPaths.Spell_Heal__png, true, 32, 32);
		effectFGGreen.loadGraphic(AssetPaths.Spell_Heal__png, true, 32, 32);
		
		effectBGGreen.animation.add("idle", [9], 30, true);
		effectBGGreen.animation.add("cast", [9, 0,1,2,3,9], 30, false);
		effectBGGreen.animation.play("idle");
		effectFGGreen.animation.add("idle", [9], 30, true);
		effectFGGreen.animation.add("cast", [4,5,6,7,8], 10, true);
		
		
		
		effectFGYellow = new FlxSprite();
		effectBGYellow = new FlxSprite();
		
		effectBGYellow.loadGraphic(AssetPaths.Spell_Exp__png, true, 32, 32);
		effectFGYellow.loadGraphic(AssetPaths.Spell_Exp__png, true, 32, 32);
		
		effectBGYellow.animation.add("idle", [9], 30, true);
		effectBGYellow.animation.add("cast", [9, 0,1,2,3,9], 30, false);
		effectBGYellow.animation.play("idle");
		effectFGYellow.animation.add("idle", [9], 30, true);
		effectFGYellow.animation.add("cast", [4,5,6,7,8], 10, true);
		
		
		
	}
	
	public function setSkills (sk : SkillTree)
	{
		skillz = sk;
	}
	
	override public function draw()
	{
		effectBGYellow.draw();
		effectBGGreen.draw();
		effectBGRed.draw();
		super.draw();
		targetbox.draw();
		effectFGYellow.draw();
		effectFGGreen.draw();
		effectFGRed.draw();
	}
	
	public function drawHud() : Void 
	{		
		// skill Buttons
		skill_PowerHit.draw();
		skill_PowerShoot.draw();
		skill_PowerShield.draw();
		skill_PowerBall.draw();
		skill_PowerArmor.draw();
		skill_BoostRegen.draw();
		skill_BoostAgi.draw();
		skill_BoostExp.draw();
		HPBar.draw();
		MPBar.draw();
		ExpBar.draw();
	}
	
	override public function update()
	{
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed * properties.getMoveSpeedFactor() ,  GameProperties.Player_MaxSpeed * properties.getMoveSpeedFactor());
		if (properties.currentHP <= 0)
		{
			alive = false;
		}
		
		
		effectFGRed.setPosition(x, y);
		effectFGRed.update();
		effectBGRed.setPosition(x, y);
		effectBGRed.update();
		
		effectFGGreen.setPosition(x, y);
		effectFGGreen.update();
		effectBGGreen.setPosition(x, y);
		effectBGGreen.update();
		
		effectFGYellow.setPosition(x, y);
		effectFGYellow.update();
		effectBGYellow.setPosition(x, y);
		effectBGYellow.update();
		
		HPBar.health = properties.currentHP / properties.getHP();
		HPBar.update();
		MPBar.health = properties.currentMP / properties.baseMP;
		MPBar.update();
		var f : Float = (properties.experience - properties.experienceLevelUpLast) / (properties.experienceLevelUp - properties.experienceLevelUpLast) ;
		ExpBar.health = f;
		ExpBar.update();
		
		attack = false;
		attackPowerShoot = false;
		attackPowerBall = false;
		attackShield = false;
		acceleration.set(0, 0);
		getInput();
		super.update();
		
		
		properties.update();
		var f : EFacing = getLastFacing();
			
		targetboxRect.x = x;
		targetboxRect.y = y;
		if (f == EFacing.Right)
		{
			targetboxRect.x += GameProperties.TileSize;
		}
		else if (f == EFacing.Left)
		{
			targetboxRect.x -= GameProperties.TileSize;
		}
		if (f == EFacing.Up)
		{
			targetboxRect.y -= GameProperties.TileSize;
		}
		else if (f == EFacing.Down)
		{
			targetboxRect.y += GameProperties.TileSize;
		}
		
		targetbox.setPosition(targetboxRect.x, targetboxRect.y);
		
	}
	
	public function updateHud() : Void 
	{
		if (skillz.PowerHit == 0)
		{
			skill_PowerHit.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerHit >= 0 || properties.currentMP < GameProperties.Skills_PowerHitMPCost)
		{
			skill_PowerHit.color = FlxColor.GRAY;
		}
		else
		{
			skill_PowerHit.color = FlxColor.RED;
		}
		
		if (skillz.PowerShoot == 0)
		{
			skill_PowerShoot.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerShoot >= 0 || properties.currentMP < GameProperties.Skills_PowerShootMPCost)
		{
			skill_PowerShoot.color = FlxColor.GRAY;
		}
		else
		{
			skill_PowerShoot.color = FlxColor.RED;
		}
		
		if (skillz.PowerShield == 0)
		{
			skill_PowerShield.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerShield >= 0 || properties.currentMP < GameProperties.Skills_PowerShieldMPCost)
		{
			skill_PowerShield.color = FlxColor.GRAY;
		}
		else
		{
			skill_PowerShield.color = FlxColor.RED;
		}
		
		if (skillz.PowerBall == 0)
		{
			skill_PowerBall.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerBall >= 0 || properties.currentMP < GameProperties.Skills_PowerBallMPCost)
		{
			skill_PowerBall.color = FlxColor.GRAY;
		}
		else
		{
			skill_PowerBall.color = FlxColor.RED;
		}
		
		if (skillz.PowerArmor == 0)
		{
			skill_PowerArmor.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerArmor >= 0 || properties.currentMP < GameProperties.Skills_PowerArmorMPCost)
		{
			skill_PowerArmor.color = FlxColor.GRAY;
		}
		else
		{
			skill_PowerArmor.color = FlxColor.RED;
		}
		
		if (skillz.BoostRegen == 0)
		{
			skill_BoostRegen.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_BoostRegen >= 0 || properties.currentMP < GameProperties.Skills_BoostRegenMPCost)
		{
			skill_BoostRegen.color = FlxColor.GRAY;
		}
		else
		{
			skill_BoostRegen.color = FlxColor.RED;
		}
		
		if (skillz.BoostAgi == 0)
		{
			skill_BoostAgi.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_BoostAgi >= 0 || properties.currentMP < GameProperties.Skills_BoostAgiMPCost)
		{
			skill_BoostAgi.color = FlxColor.GRAY;
		}
		else
		{
			skill_BoostAgi.color = FlxColor.RED;
		}
		
		if (skillz.BoostExp == 0)
		{
			skill_BoostExp.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_BoostExp >= 0 || properties.currentMP < GameProperties.Skills_BoostExpMPCost)
		{
			skill_BoostExp.color = FlxColor.GRAY;
		}
		else
		{
			skill_BoostExp.color = FlxColor.RED;
		}
		
		skill_PowerHit.update();
		skill_PowerShoot.update();
		skill_PowerShield.update();
		skill_PowerBall.update();
		skill_PowerArmor.update();
		skill_BoostRegen.update();
		skill_BoostAgi.update();
		skill_BoostExp.update();
		
	}
	
	private function getInput () : Void 
	{
		
		getInputMovement();
		getInputAttack();
		getInputSkills();
		
		EffectAnimations();
		
	}

	
	private function doAttack () : Void 
	{
		if (attacTimer  <= 0)
		{
			attacTimer = GameProperties.Player_AttackSpeed;
			
		}
	}
	
	function getInputMovement():Void 
	{
		var left : Bool = false;
		var right : Bool = false;
		
		if (FlxG.keys.anyPressed(["A", "LEFT"]))
			left = true;
		if (FlxG.keys.anyPressed(["D", "RIGHT"]))
			right = true;
			
		if (left && !right)
		{
			moveLeft();
		}
		else if (right != left)
		{
			moveRight();
		}
		else
		{
			// do nothing, since both or no key is pressed
		}
		
		
		var up : Bool = false;
		var down : Bool = false;
		
		if (FlxG.keys.anyPressed(["W", "UP"]))
			up = true;
		if (FlxG.keys.anyPressed(["S", "DOWN"]))
			down = true;
			
		if (up && !down)
		{
			moveUp();
		}
		else if (down != up)
		{
			moveDown();
		}
		else
		{
			// do nothing, since both or no key is pressed
		}
	}
	
	function getInputAttack():Void 
	{
		attack = false;
		if (FlxG.mouse.justPressed || FlxG.keys.anyJustPressed(["SPACE"]))
		{
			attack = true;
			if (skillz.active_PowerHit)
			{
				skillz.useSkillPowerHit();
			}
		}
		if (attack)
		{
			doAttack();
		}
	}
	
	function getInputSkills():Void 
	{
		attackPowerShoot = false;
		attackPowerBall = false;
		attackShield = false; 
		if (FlxG.keys.justPressed.ONE)
		{
			if (FlxColorUtil.getRed(skill_PowerHit.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.activateSkillPowerHit();
				skillz.payMP(GameProperties.Skills_PowerHitMPCost);
			}
		}
		if (FlxG.keys.justPressed.TWO)
		{
			if (FlxColorUtil.getRed(skill_PowerShoot.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				attackPowerShoot = true;
				skillz.useSkillPowerShoot();
				skillz.payMP(GameProperties.Skills_PowerShootMPCost);

			}
		}
		if (FlxG.keys.justPressed.THREE)
		{
			if (FlxColorUtil.getRed(skill_PowerShield.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.useSkillPowerShield();
				attackShield = true;
				skillz.payMP(GameProperties.Skills_PowerShieldMPCost);
			}
		}
		if (FlxG.keys.justPressed.FOUR)
		{
			if (FlxColorUtil.getRed(skill_PowerBall.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.useSkillPowerBall();
				attackPowerBall = true;
				skillz.payMP(GameProperties.Skills_PowerBallMPCost);
			}
		}
		if (FlxG.keys.justPressed.FIVE)
		{
			if (FlxColorUtil.getRed(skill_PowerArmor.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.useSkillPowerArmor();
				skillz.payMP(GameProperties.Skills_PowerArmorMPCost);
			}
		}
		if (FlxG.keys.justPressed.SIX)
		{
			if (FlxColorUtil.getRed(skill_BoostRegen.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.activateSkillBoostRegen();
				skillz.payMP(GameProperties.Skills_BoostRegenMPCost);
				effectBGGreen.animation.play("cast", true);
			}
		}
		if (FlxG.keys.justPressed.SEVEN)
		{
			if (FlxColorUtil.getRed(skill_BoostAgi.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.activateSkillBoostAgi();
				skillz.payMP(GameProperties.Skills_BoostAgiMPCost);
				effectBGRed.animation.play("cast", true);
			}
		}
		if (FlxG.keys.justPressed.EIGHT)
		{
			if (FlxColorUtil.getRed(skill_BoostExp.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.activateSkillBoostExp();
				skillz.payMP(GameProperties.Skills_BoostExpMPCost);
				effectBGYellow.animation.play("cast", true);
			}
		}
	}
	
	function EffectAnimations():Void 
	{
		if (skillz.active_BoostAgi)
		{
			effectFGRed.animation.play("cast", false);
			effectFGRed.alpha = 1;
		}
		else 
		{
			effectFGRed.animation.play("idle", false);
			effectFGRed.alpha = 0;
		}
		
		
		if (skillz.active_BoostExp)
		{
			effectFGYellow.animation.play("cast", false);
			effectFGYellow.alpha = 1;
		}
		else 
		{
			effectFGYellow.animation.play("idle", false);
			effectFGYellow.alpha = 0;
		}
		
		if (skillz.active_BoostRegen)
		{
			effectFGGreen.animation.play("cast", false);
			effectFGGreen.alpha = 1;
		}
		else 
		{
			effectFGGreen.animation.play("idle", false);
			effectFGGreen.alpha = 0;
		}
	}
	
	public function getAttackRect() : FlxRect
	{
		return targetboxRect;
	}
	

}
