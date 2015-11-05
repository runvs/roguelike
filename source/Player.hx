package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.plugin.MouseEventManager;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
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
	
	private var skillIconList : FlxTypedGroup<SkillIcon>;
	
	
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
	
	public var levelUpSprite : FlxSprite;
	public var charsheetSprite : FlxSprite;
	
	private var attackSound : FlxSound;
	private var blipSound :FlxSound;
	
	public function new() 
	{
		super();
		
		
		properties = new PlayerProperties();
		
		levelUpSprite = new FlxSprite();
		levelUpSprite.loadGraphic(AssetPaths.levelup__png, false, 16, 16);
		levelUpSprite.setPosition(FlxG.width - 32 - 10, FlxG.height-24-34);
		levelUpSprite.scrollFactor.set();
		levelUpSprite.origin.set();
		levelUpSprite.offset.set();
		levelUpSprite.scale.set(2, 2);
		levelUpSprite.updateHitbox();
		FlxTween.tween(levelUpSprite, { alpha: 0.5 }, 0.75, { type:FlxTween.PINGPONG, ease : FlxEase.sineInOut } );
		
		charsheetSprite = new FlxSprite();
		charsheetSprite.loadGraphic(AssetPaths.opencharsheet__png, false, 32, 32);
		charsheetSprite.scrollFactor.set();
		charsheetSprite.setPosition(FlxG.width - 32 - 10, FlxG.height-24-34);
		
		
		skillIconList = new FlxTypedGroup<SkillIcon>();
		for (i in 1 ... 9 )
		{
			skillIconList.add(new SkillIcon (i));
		}
		
		skillIconList.members[0].coolDownTime = GameProperties.Skills_PowerHit_CoolDown;
		skillIconList.members[1].coolDownTime = GameProperties.Skills_PowerShoot_CoolDown;
		skillIconList.members[2].coolDownTime = GameProperties.Skills_PowerShield_CoolDown;
		skillIconList.members[3].coolDownTime = GameProperties.Skills_PowerBall_CoolDown;
		skillIconList.members[4].coolDownTime = GameProperties.Skills_PowerArmor_CoolDown;
		skillIconList.members[5].coolDownTime = GameProperties.Skills_BoostRegen_CoolDown;
		skillIconList.members[6].coolDownTime = GameProperties.Skills_BoostAgi_Cooldown;
		skillIconList.members[7].coolDownTime = GameProperties.Skills_BoostExp_Cooldown;
		
		
		
		this.loadGraphic(AssetPaths.Player__png, true, 32, 32);
		this.animation.add("idle", [0, 1], 3, true);
		this.animation.add("walk", [4, 5, 6, 7],6, true);
		this.animation.add("attack", [12, 13], 5, false);
		this.animation.add("taunt", [12, 13], 5, false);
		this.animation.play("idle");

	
		this.drag = new FlxPoint( GameProperties.Player_VelocityDecay, GameProperties.Player_VelocityDecay);
		
		attacTimer = 0;
		targetbox = new FlxSprite();
		targetbox.makeGraphic(GameProperties.Tile_Size, GameProperties.Tile_Size, FlxColorUtil.makeFromARGB(0.5, 100, 200, 200));
		targetboxRect = new FlxRect(x, y, GameProperties.Tile_Size, GameProperties.Tile_Size);
		
		// hud stuff
		
		
		var hudwidth : Float = FlxG.width - 10 - 10;
		
		HPBar = new HudBar(10, FlxG.height - 24, hudwidth/3.0 - 10 , 20, false);
		HPBar.color = GameProperties.Color_Red;
		
		MPBar = new HudBar(FlxG.width - 10 - hudwidth/3.0 + 10 , FlxG.height - 24 ,  hudwidth/3.0 - 10 , 20, false);
		MPBar.color = GameProperties.Color_Green;
		
		ExpBar = new HudBar( 10 + hudwidth/3.0 + 5 , FlxG.height - 24, hudwidth/3.0 - 10 , 20, false);
		ExpBar.color = GameProperties.Color_Yellow;
		
		
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
		
		
		MouseEventManager.add(charsheetSprite, OpenSkills);
		
		//properties.attributePoints = 5;
		
		attackSound = new FlxSound();
		blipSound = new FlxSound();
		#if flash
		attackSound = FlxG.sound.load(AssetPaths.attack__mp3);
		blipSound = FlxG.sound.load(AssetPaths.blib__mp3);
		#else
		attackSound = FlxG.sound.load(AssetPaths.attack__ogg);
		blipSound = FlxG.sound.load(AssetPaths.blib__ogg);
		#end
	}
	
	private function OpenSkills(o : FlxObject = null)
	{
		skillz.Show();
		blipSound.play();
		MouseEventManager.remove(charsheetSprite);
	}
	
	private function CloseSkills (o:FlxObject = null) : Void 
	{
		skillz.Show();
		blipSound.play();
		MouseEventManager.add(charsheetSprite, OpenSkills);
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
		// bars 
		HPBar.draw();
		MPBar.draw();
		ExpBar.draw();

		// level up sprite
		if ( !(properties.skillPoints > 0 || properties.attributePoints > 0))
		{
			charsheetSprite.draw();
		}
		else
		{
			levelUpSprite.draw();
		}
		
		// skillIcons
		skillIconList.draw();
	}
	
	override public function update()
	{
		this.maxVelocity = new FlxPoint(GameProperties.Player_MaxSpeed * properties.getMoveSpeedFactor() ,  GameProperties.Player_MaxSpeed * properties.getMoveSpeedFactor());
		if (properties.currentHP <= 0)
		{
			alive = false;
		}
		
		
		charsheetSprite.update();
		levelUpSprite.update();
		
		
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
		
		
		attacTimer -= FlxG.elapsed;
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
			targetboxRect.x += GameProperties.Tile_Size;
		}
		else if (f == EFacing.Left)
		{
			targetboxRect.x -= GameProperties.Tile_Size;
		}
		if (f == EFacing.Up)
		{
			targetboxRect.y -= GameProperties.Tile_Size;
		}
		else if (f == EFacing.Down)
		{
			targetboxRect.y += GameProperties.Tile_Size;
		}
		
		targetbox.setPosition(targetboxRect.x, targetboxRect.y);
		
	}
	
	public function updateHud() : Void 
	{

		skillIconList.update();
		skillIconList.members[0].currentTime = skillz.cooldown_PowerHit;
		skillIconList.members[1].currentTime = skillz.cooldown_PowerShoot;
		skillIconList.members[2].currentTime = skillz.cooldown_PowerShield;
		skillIconList.members[3].currentTime = skillz.cooldown_PowerBall;
		skillIconList.members[4].currentTime = skillz.cooldown_PowerArmor;
		skillIconList.members[5].currentTime = skillz.cooldown_BoostRegen;
		skillIconList.members[6].currentTime = skillz.cooldown_BoostAgi;
		skillIconList.members[7].currentTime = skillz.cooldown_BoostExp;
		
		
		if (skillz.PowerHit == 0)
		{
			skillIconList.members[0].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerHit >= 0 || properties.currentMP < GameProperties.Skills_PowerHitMPCost)
		{
			skillIconList.members[0].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[0].text.color = GameProperties.Color_Red;
		}
		
		
		if (skillz.PowerShoot == 0)
		{
			skillIconList.members[1].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerShoot >= 0 || properties.currentMP < GameProperties.Skills_PowerShootMPCost)
		{
			skillIconList.members[1].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[1].text.color = GameProperties.Color_Red;
		}
		
		if (skillz.PowerShield == 0)
		{
			skillIconList.members[2].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerShield >= 0 || properties.currentMP < GameProperties.Skills_PowerShieldMPCost)
		{
			skillIconList.members[2].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[2].text.color = GameProperties.Color_Red;
		}
		
		
		if (skillz.PowerBall == 0)
		{
			skillIconList.members[3].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerBall >= 0 || properties.currentMP < GameProperties.Skills_PowerBallMPCost)
		{
			skillIconList.members[3].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[3].text.color = GameProperties.Color_Red;
		}

		
		if (skillz.PowerArmor == 0)
		{
			skillIconList.members[4].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_PowerArmor >= 0 || properties.currentMP < GameProperties.Skills_PowerArmorMPCost)
		{
			skillIconList.members[4].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[4].text.color = GameProperties.Color_Red;
		}


		
		if (skillz.BoostRegen == 0)
		{
			skillIconList.members[5].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_BoostRegen >= 0 || properties.currentMP < GameProperties.Skills_BoostRegenMPCost)
		{
			skillIconList.members[5].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[5].text.color = GameProperties.Color_Red;
		}
		

		
		if (skillz.BoostAgi == 0)
		{
			skillIconList.members[6].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_BoostAgi >= 0 || properties.currentMP < GameProperties.Skills_BoostAgiMPCost)
		{
			skillIconList.members[6].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[6].text.color = GameProperties.Color_Red;
		}

		
		
		if (skillz.BoostExp == 0)
		{
			skillIconList.members[7].text.color = FlxColor.BLACK;
		}
		else if (skillz.cooldown_BoostExp >= 0 || properties.currentMP < GameProperties.Skills_BoostExpMPCost)
		{
			skillIconList.members[7].text.color = FlxColor.GRAY;
		}
		else
		{
			skillIconList.members[7].text.color = GameProperties.Color_Red;
		}

		
	}
	
	public function getInputMenu() : Void 
	{
			
		if (FlxG.keys.justPressed.C)
		{
			if (skillz.showMe)
			{
				CloseSkills();
			}
			else
			{
				OpenSkills();
			}
		}
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
			attacTimer = properties.getAttackTimer();
			attack = true;
			attackSound.play(true);
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
			doAttack();
			if (skillz.active_PowerHit)
			{
				skillz.useSkillPowerHit();
			}
		}
	}
	
	function getInputSkills():Void 
	{
		attackPowerShoot = false;
		attackPowerBall = false;
		attackShield = false; 
		if (FlxG.keys.justPressed.ONE)
		{
			if (FlxColorUtil.getRed(skillIconList.members[0].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
			{
				skillz.activateSkillPowerHit();
				skillz.payMP(GameProperties.Skills_PowerHitMPCost);
			}
		}
		if (FlxG.keys.justPressed.TWO)
		{
			if (FlxColorUtil.getRed(skillIconList.members[1].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
			{
				attackPowerShoot = true;
				skillz.useSkillPowerShoot();
				skillz.payMP(GameProperties.Skills_PowerShootMPCost);

			}
		}
		if (FlxG.keys.justPressed.THREE)
		{
			if (FlxColorUtil.getRed(skillIconList.members[2].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
			{
				skillz.useSkillPowerShield();
				attackShield = true;
				skillz.payMP(GameProperties.Skills_PowerShieldMPCost);
			}
		}
		if (FlxG.keys.justPressed.FOUR)
		{
			if (FlxColorUtil.getRed(skillIconList.members[3].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
			{
				skillz.useSkillPowerBall();
				attackPowerBall = true;
				skillz.payMP(GameProperties.Skills_PowerBallMPCost);
			}
		}
		if (FlxG.keys.justPressed.FIVE)
		{
			if (FlxColorUtil.getRed(skillIconList.members[4].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
			{
				skillz.useSkillPowerArmor();
				skillz.payMP(GameProperties.Skills_PowerArmorMPCost);
			}
		}
		if (FlxG.keys.justPressed.SIX)
		{
			if (FlxColorUtil.getRed(skillIconList.members[5].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
			{
				skillz.activateSkillBoostRegen();
				skillz.payMP(GameProperties.Skills_BoostRegenMPCost);
				effectBGGreen.animation.play("cast", true);
			}
		}
		if (FlxG.keys.justPressed.SEVEN)
		{
			if (FlxColorUtil.getRed(skillIconList.members[6].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
			{
				skillz.activateSkillBoostAgi();
				skillz.payMP(GameProperties.Skills_BoostAgiMPCost);
				effectBGRed.animation.play("cast", true);
			}
		}
		if (FlxG.keys.justPressed.EIGHT)
		{
			if (FlxColorUtil.getRed(skillIconList.members[7].text.color) == FlxColorUtil.getRed(GameProperties.Color_Red))
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
