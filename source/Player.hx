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
	
	public function new() 
	{
		super();
		
		properties = new PlayerProperties();
		
		//this.makeGraphic(GameProperties.TileSize, GameProperties.TileSize);
		this.loadGraphic(AssetPaths.Player__png, true, 32, 32);
		this.animation.add("idle", [0, 1], 5, true);
		this.animation.add("walk", [4, 5, 6, 7],5, true);
		this.animation.add("attack", [12, 13], 5, false);
		this.animation.add("taunt", [12, 13], 5, false);
		this.animation.play("idle");
		
		//this.scale.set(2,2
		this.width = 25;
		this.updateHitbox();
		
		this.updateHitbox();
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed,  GameProperties.Player_MaxSpeed);
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
		
	}
	
	public function setSkills (sk : SkillTree)
	{
		skillz = sk;
	}
	
	override public function draw()
	{
		super.draw();
		targetbox.draw();
	}
	
	public function drawHud() : Void 
	{
		// TODO health and mana bar
		
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
		if (properties.currentHP <= 0)
		{
			alive = false;
		}
		
		HPBar.health = properties.currentHP / properties.getHP();
		HPBar.update();
		MPBar.health = properties.currentMP / properties.baseMP;
		MPBar.update();
		var f : Float = (properties.experience - properties.experienceLevelUpLast) / (properties.experienceLevelUp - properties.experienceLevelUpLast) ;
		ExpBar.health = f;
		ExpBar.update();
		
		attack = false;
		attackPowerShoot = false;
		
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
		if (FlxG.mouse.justPressed)
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
		if (FlxG.keys.justPressed.ONE)
		{
			trace("One");
			if (FlxColorUtil.getRed(skill_PowerHit.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				trace("active");
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
				// TODO spawn Particle and so on
			}
		}
		if (FlxG.keys.justPressed.THREE)
		{
			if (FlxColorUtil.getRed(skill_PowerShield.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.useSkillPowerShield();
				// TODO spawn Shield and so on
				skillz.payMP(GameProperties.Skills_PowerShieldMPCost);
			}
		}
		if (FlxG.keys.justPressed.FOUR)
		{
			if (FlxColorUtil.getRed(skill_PowerBall.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.useSkillPowerBall();
				// TODO spawn Ball and so on
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
			}
		}
		if (FlxG.keys.justPressed.SEVEN)
		{
			if (FlxColorUtil.getRed(skill_BoostAgi.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.activateSkillBoostAgi();
				skillz.payMP(GameProperties.Skills_BoostAgiMPCost);
			}
		}
		if (FlxG.keys.justPressed.EIGHT)
		{
			if (FlxColorUtil.getRed(skill_BoostExp.color) == FlxColorUtil.getRed(FlxColor.RED))
			{
				skillz.activateSkillBoostExp();
				skillz.payMP(GameProperties.Skills_BoostExpMPCost);
			}
		}
	}
	
	public function getAttackRect() : FlxRect
	{
		return targetboxRect;
	}
	

}
