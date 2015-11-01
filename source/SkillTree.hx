package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class SkillTree extends FlxSpriteGroup
{
	
	public var showMe : Bool = false;
	
	private var btn_PowerShoot: CharsheetIcon;
	private var btn_PowerShield: CharsheetIcon;
	private var btn_PowerHit: CharsheetIcon;
	private var btn_PowerBall: CharsheetIcon;
	private var btn_PowerArmor: CharsheetIcon;
	
	private var btn_NaniteArmor : CharsheetIcon;
	private var btn_NaniteHealth : CharsheetIcon;
	private var btn_NaniteWeapon : CharsheetIcon;
	
	private var btn_BoostRegen : CharsheetIcon;
	private var btn_BoostAgi : CharsheetIcon;
	private var btn_BoostExp : CharsheetIcon;
	
	
	
	private var btn_St : FlxButton;
	private var btn_Ag : FlxButton;
	private var btn_En : FlxButton;
	private var btn_Wi : FlxButton;
	private var btn_Lk : FlxButton;
	
	
	private var InfoString : FlxText;
	
	private var backgroundSprite : FlxSprite;
	
	private var playerThumb : FlxSprite;
	
	public function new( properties : PlayerProperties) 
	{
		super();
		_properties = properties;
		
		backgroundSprite = new FlxSprite();
		backgroundSprite.loadGraphic(AssetPaths.background_charsheet__png, false, 512, 384);
		backgroundSprite.origin.set();
		backgroundSprite.offset.set();
		backgroundSprite.scrollFactor.set();
		backgroundSprite.setPosition();
		
		playerThumb = new FlxSprite(200, 30);
		playerThumb.scale.set(-2, 2);
		playerThumb.scrollFactor.set();
		playerThumb.loadGraphic(AssetPaths.Player__png, true, 32, 32);
		playerThumb.animation.add("idle", [0, 1, 2, 3], 3, true);
		playerThumb.animation.play("idle");
		
		add(backgroundSprite);
		add(playerThumb); 
		
		PowerHit = 0;
		PowerShoot = 0;
		PowerShield = 0;
		PowerBall  = 0;
		PowerArmor = 0;
		
		NaniteArmor = 0;
		NaniteHealth = 0;
		NaniteWeapon = 0;
		
		BoostRegen = 0;
		BoostAgi = 0;
		BoostExp = 0;
		
		b_PowerHit = false;
		b_PowerShoot = false;
		b_PowerShield = false;
		b_PowerBall = false;
		b_PowerArmor = false;
		
		b_NaniteArmor = false;
		b_NaniteHealth = false;
		b_NaniteWeapon = false;
		
		b_BoostRegen = false;
		b_BoostAgi = false;
		b_BoostExp = false;
		
		cooldown_PowerShoot= 0;
		cooldown_PowerShield= 0;
		cooldown_PowerHit= 0;
		cooldown_PowerBall= 0;
		cooldown_PowerArmor= 0;
		cooldown_BoostRegen= 0;
		cooldown_BoostExp= 0;
		cooldown_BoostAgi= 0;
		
		
		active_PowerHit = false;
		active_PowerShoot= false;
		active_PowerShield= false;
		active_PowerBall= false;
		active_PowerArmor= false;
		
		active_BoostRegen= false;
		active_BoostAgi= false;
		active_BoostExp = false;
		
		var skillOffsetX : Float = 20 + 256;
		var skillOffsetXRow2 : Float = 75;
		var skillOffsetXRow3 : Float = 150;
		
		var skillOffsetY : Float = 100;
		var skillOffsetHalfColumn : Float = 30;
		var skillOffsetYColumn2 : Float = 115;
		var skillOffsetYColumn3 : Float = 190;
		
		btn_PowerHit = new CharsheetIcon(skillOffsetX, skillOffsetY, AssetPaths.skill_1__png, "Power Hit");
		btn_PowerShoot = new CharsheetIcon(skillOffsetX + skillOffsetXRow2 , skillOffsetY - skillOffsetHalfColumn, AssetPaths.skill_2__png, "Power Shoot");	
		btn_PowerShield = new CharsheetIcon( skillOffsetX + skillOffsetXRow2, skillOffsetY + skillOffsetHalfColumn, AssetPaths.skill_3__png, "Power Shield");
		btn_PowerBall = new CharsheetIcon(skillOffsetX + skillOffsetXRow3, skillOffsetY - skillOffsetHalfColumn, AssetPaths.skill_4__png, "Power Ball");
		btn_PowerArmor = new CharsheetIcon(skillOffsetX + skillOffsetXRow3, skillOffsetY + skillOffsetHalfColumn, AssetPaths.skill_5__png, "Power Armor");
			
		btn_BoostRegen = new CharsheetIcon(skillOffsetX , skillOffsetY + skillOffsetYColumn2, AssetPaths.skill_6__png, "Boost Regen");	
		btn_BoostAgi = new CharsheetIcon(skillOffsetX + skillOffsetXRow2, skillOffsetY + skillOffsetYColumn2,AssetPaths.skill_7__png, "Boost Agi");	
		btn_BoostExp = new CharsheetIcon(skillOffsetX + skillOffsetXRow3, skillOffsetY + skillOffsetYColumn2,AssetPaths.skill_8__png, "Boost Exp");
		
		btn_NaniteArmor = new CharsheetIcon(skillOffsetX, skillOffsetY + skillOffsetYColumn3, AssetPaths.skill_9__png, "Nanite Armor");
		btn_NaniteHealth = new CharsheetIcon(skillOffsetX + skillOffsetXRow2, skillOffsetY + skillOffsetYColumn3,AssetPaths.skill_10__png, "Nanite Health");
		btn_NaniteWeapon = new CharsheetIcon(skillOffsetX + skillOffsetXRow3 , skillOffsetY + skillOffsetYColumn3,AssetPaths.skill_11__png, "Nanite Weapon");
		
		btn_St = new FlxButton(-60, 85, "Str", upgradeSt);
		btn_St.scale.set(1, 0.9);
		btn_St.updateHitbox();
		btn_Ag = new FlxButton(-60, 100, "Agi", upgradeAg);
		btn_Ag.scale.set(1, 0.9);
		btn_Ag.updateHitbox();
		btn_En = new FlxButton(-60, 115, "End", upgradeEn);
		btn_En.scale.set(1, 0.9);
		btn_En.updateHitbox();
		btn_Wi = new FlxButton(-60, 130, "Wil", upgradeWi);
		btn_Wi.scale.set(1, 0.9);
		btn_Wi.updateHitbox();
		btn_Lk = new FlxButton(-60, 145, "Luk", upgradeLk);
		btn_Lk.scale.set(1, 0.9);
		btn_Lk.updateHitbox();
		
		add(btn_St);
		add(btn_Ag);
		add(btn_En);
		add(btn_Wi);
		add(btn_Lk);
		
		InfoString = new FlxText();
		InfoString.setPosition(50,50);
		InfoString.origin.set();
		InfoString.offset.set();
		InfoString.scale.set(1.5, 1.5);
		InfoString.scrollFactor.set();
		//add(InfoString);
		
		this.scrollFactor.set();
	}
	
	
	public function upgradeSt ( )
	{
		if (_properties.attributePoints >= 1)
		{
			_properties.St += 1;
			_properties.attributePoints -= 1;
			_properties.ReCalculateDerivedValues();
		}
	}
	
	public function upgradeAg()
	{
		if (_properties.attributePoints >= 1)
		{
			_properties.Ag += 1;
			_properties.attributePoints -= 1;
			_properties.ReCalculateDerivedValues();
		}
	}
	public function upgradeEn()
	{
		if (_properties.attributePoints >= 1)
		{
			_properties.increaseEN();
			_properties.attributePoints -= 1;
			_properties.ReCalculateDerivedValues();
			
		}
	}
	public function upgradeWi()
	{
		if (_properties.attributePoints >= 1)
		{
			//_properties.Wi += 1;
			_properties.increaseWI();
			_properties.attributePoints -= 1;
			_properties.ReCalculateDerivedValues();
		}
	}
	
	public function upgradeLk()
	{
		if (_properties.attributePoints >= 1)
		{
			_properties.Lk += 1;
			_properties.attributePoints -= 1;
			_properties.ReCalculateDerivedValues();
		}
	}
	
	
	public function upgrade_PowerShoot(o :FlxObject = null) : Void 
	{		
		if (_properties.skillPoints >= 1 && b_PowerShoot)
		{
			_properties.skillPoints -= 1;
			PowerShoot += 1;
			btn_PowerShoot.currentLevel = PowerShoot;
		}
	}
	public function upgrade_PowerShield(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerShield)
		{
			_properties.skillPoints -= 1;
			PowerShield += 1;
			btn_PowerShield.currentLevel = PowerShield;
		}
	}
	public function upgrade_PowerHit(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerHit)
		{
			_properties.skillPoints -= 1;
			PowerHit += 1;
			btn_PowerHit.currentLevel = PowerHit;
		}
	}
	public function upgrade_PowerBall(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerBall)
		{
			_properties.skillPoints -= 1;
			PowerBall += 1;
			btn_PowerBall.currentLevel = PowerBall;
		}
	}
	public function upgrade_PowerArmor(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerArmor)
		{
			_properties.skillPoints -= 1;
			PowerArmor += 1;
			btn_PowerArmor.currentLevel = PowerArmor;
		}
	}
	
	public function upgrade_NaniteArmor(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_NaniteArmor)
		{
			_properties.skillPoints -= 1;
			NaniteArmor += 1;
			btn_NaniteArmor.currentLevel = NaniteArmor;
		}
	}
	public function upgrade_NaniteHealth(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_NaniteHealth)
		{
			_properties.skillPoints -= 1;
			NaniteHealth += 1;
			btn_NaniteHealth.currentLevel = NaniteHealth;
		}
	}
	public function upgrade_NaniteWeapon(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_NaniteWeapon)
		{
			_properties.skillPoints -= 1;
			NaniteWeapon += 1;
			btn_NaniteWeapon.currentLevel = NaniteWeapon;
		}
	}
	
	
	public function upgrade_BoostRegen(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_BoostRegen)
		{
			_properties.skillPoints -= 1;
			BoostRegen += 1;
			btn_BoostRegen.currentLevel = BoostRegen;
		}
	}
	public function upgrade_BoostAgi(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_BoostAgi)
		{
			_properties.skillPoints -= 1;
			BoostAgi += 1;
			btn_BoostAgi.currentLevel = BoostAgi;
		}
	}
	public function upgrade_BoostExp(o :FlxObject) : Void 
	{
		if (_properties.skillPoints >= 1 && b_BoostExp)
		{
			_properties.skillPoints -= 1;
			BoostExp += 1;
			btn_BoostExp.currentLevel = BoostExp;
		}
	}
	
	
	var _properties : PlayerProperties;
	
	public var PowerHit : Int;
	public var PowerShoot : Int;
	public var PowerShield : Int;
	public var PowerBall : Int;
	public var PowerArmor : Int;
	
	public var NaniteArmor : Int;
	public var NaniteHealth : Int;
	public var NaniteWeapon : Int;
	
	public var BoostRegen : Int;
	public var BoostAgi : Int;
	public var BoostExp : Int;
	
	
	public var active_PowerHit : Bool;
	public var active_PowerShoot: Bool;
	public var active_PowerShield: Bool;
	public var active_PowerBall: Bool;
	public var active_PowerArmor: Bool;
	
	public var active_BoostRegen: Bool;
	public var active_BoostAgi: Bool;
	public var active_BoostExp: Bool;
	
	
	public var cooldown_PowerHit: Float;
	public var cooldown_PowerShoot: Float;
	public var cooldown_PowerShield: Float;
	public var cooldown_PowerBall: Float;
	public var cooldown_PowerArmor: Float;
	
	public var cooldown_BoostRegen: Float;
	public var cooldown_BoostAgi: Float;
	public var cooldown_BoostExp: Float;
	
	public var lifeTime_PowerArmor : Float; 
	
	public var lifeTime_BoostRegen : Float;
	public var lifeTime_BoostAgi : Float;
	public var lifeTime_BoostExp : Float;
	
	private var b_PowerHit : Bool;
	private var b_PowerShoot : Bool;
	private var b_PowerShield : Bool;
	private var b_PowerBall : Bool;
	private var b_PowerArmor : Bool;
	
	private var b_NaniteArmor : Bool;
	private var b_NaniteHealth : Bool;
	private var b_NaniteWeapon : Bool;
	
	private var b_BoostRegen : Bool;
	private var b_BoostAgi : Bool;
	private var b_BoostExp : Bool;
	
	private function ActivateDeactivateLevelUpSkills ( ) : Void 
	{
		b_PowerHit = false;
		b_PowerShoot = false;
		b_PowerShield = false;
		b_PowerBall = false;
		b_PowerArmor = false;
		
		b_NaniteArmor = false;
		b_NaniteHealth = false;
		b_NaniteWeapon = false;
		
		b_BoostRegen = false;
		b_BoostAgi = false;
		b_BoostExp = false;
		
		if ( _properties.skillPoints > 0)
		{
			if ( _properties.level >= GameProperties.Skills_Level1)
			{
				b_PowerHit = true;
				b_NaniteArmor = true;
				b_BoostRegen = true;
			}
			if (_properties.level >= GameProperties.Skills_Level2)
			{
				if (PowerHit >= 1)
				{
					b_PowerShoot = true;
					b_PowerShield = true;
				}
				
				if (NaniteArmor >= 1)
				{
					b_NaniteHealth = true;
				}
				
				if (BoostRegen >= 1)
				{
					b_BoostAgi = true;
				}

			}
			if (_properties.level >= GameProperties.Skills_Level3)
			{
				if (PowerShoot >= 1)
				{
					b_PowerBall = true;
				}
				if (PowerShield >= 1)
				{
					b_PowerArmor = true;
				}
				
				if (NaniteHealth >= 1)
				{
					b_NaniteWeapon = true;
				}
				
				if (BoostAgi >= 1)
				{
					b_BoostExp = true;
				}
			}
			

		}
		
		
		// check if max level reached
		if ( PowerHit >= 5) 
		{
			b_PowerHit = false;
		}
		if ( PowerShoot >= 5) 
		{ 
			b_PowerShoot = false;
		}
		if ( PowerShield >= 5) 
		{
			b_PowerShield = false;
		}
		if ( PowerBall >= 5)
		{ 
			b_PowerBall = false;
		}
		if ( PowerArmor >= 5) 
		{
			b_PowerArmor = false;
		}
		
		if ( NaniteArmor >= 5)
		{
			b_NaniteArmor = false;
		}
		if ( NaniteHealth >= 5)
		{
			b_NaniteHealth = false;
		}
		if ( NaniteWeapon >= 5) 
		{
			b_NaniteWeapon = false;
		}
		
		if ( BoostRegen >= 5)
		{
			b_BoostRegen = false;
		}
		if ( BoostAgi >= 5) 
		{
			b_BoostAgi = false;
		}
		if ( BoostExp >= 5) 
		{
			b_BoostExp = false;
		}
		
		CheckButtons();
	}
	
	public function CheckButtons() : Void 
	{
		
		if (_properties.attributePoints >= 1)
		{
			btn_Ag.color = btn_St.color = btn_En.color = btn_Wi.color = btn_Lk.color = FlxColor.WHITE;
		}
		else
		{
			btn_Ag.color = btn_St.color = btn_En.color = btn_Wi.color = btn_Lk.color = FlxColor.GRAY;
		}
		
		
		if (b_PowerArmor)
		{
			btn_PowerArmor.color = FlxColor.WHITE;
		}
		else
		{
			btn_PowerArmor.color = FlxColor.GRAY;
		}
		
		if (b_PowerBall)
		{
			btn_PowerBall.color = FlxColor.WHITE;
		}
		else
		{
			btn_PowerBall.color = FlxColor.GRAY;
		}
		
		if (b_PowerHit)
		{
			btn_PowerHit.color = FlxColor.WHITE;
		}
		else
		{
			btn_PowerHit.color = FlxColor.GRAY;
		}
		
		if (b_PowerShield)
		{
			btn_PowerShield.color = FlxColor.WHITE;
		}
		else
		{
			btn_PowerShield.color = FlxColor.GRAY;
		}
		
		if (b_PowerShoot)
		{
			btn_PowerShoot.color = FlxColor.WHITE;
		}
		else
		{
			btn_PowerShoot.color = FlxColor.GRAY;
		}
		
		
		if (b_NaniteArmor)
		{
			btn_NaniteArmor.color = FlxColor.WHITE;
		}
		else
		{
			btn_NaniteArmor.color = FlxColor.GRAY;
		}
		
		if (b_NaniteHealth)
		{
			btn_NaniteHealth.color = FlxColor.WHITE;
		}
		else
		{
			btn_NaniteHealth.color = FlxColor.GRAY;
		}
		
		if (b_NaniteWeapon)
		{
			btn_NaniteWeapon.color = FlxColor.WHITE;
		}
		else
		{
			btn_NaniteWeapon.color = FlxColor.GRAY;
		}
		
		if (b_BoostRegen)
		{
			btn_BoostRegen.color = FlxColor.WHITE;
		}
		else
		{
			btn_BoostRegen.color = FlxColor.GRAY;
		}
		
		if (b_BoostAgi)
		{
			btn_BoostAgi.color = FlxColor.WHITE;
		}
		else
		{
			btn_BoostAgi.color = FlxColor.GRAY;
		}
		
		if (b_BoostExp)
		{
			btn_BoostExp.color = FlxColor.WHITE;
		}
		else
		{
			btn_BoostExp.color = FlxColor.GRAY;
		}
	}
	
	override public function draw () : Void 
	{
		if (showMe)
		{
			super.draw();
			
			btn_PowerHit.draw();		
			btn_PowerShoot.draw();
			btn_PowerShield.draw();
			btn_PowerBall.draw();
			btn_PowerArmor.draw();
			btn_NaniteWeapon.draw();
			btn_NaniteHealth.draw();
			btn_NaniteArmor.draw();
			btn_BoostAgi.draw();
			btn_BoostExp.draw();
			btn_BoostRegen.draw();
			InfoString.draw();
		}
		
	}
	
	public function Show () : Void 
	{
		showMe = ! showMe;
		if (showMe)
		{
			Open();
		}
		else
		{
			Close();
		}
	}
	
	private function Open() : Void 
	{
		MouseEventManager.add(btn_PowerShoot, upgrade_PowerShoot);
		MouseEventManager.add(btn_PowerShield, upgrade_PowerShield);
		MouseEventManager.add(btn_PowerHit, upgrade_PowerHit);
		MouseEventManager.add(btn_PowerBall, upgrade_PowerBall);
		MouseEventManager.add(btn_PowerArmor, upgrade_PowerArmor);
		MouseEventManager.add(btn_NaniteWeapon, upgrade_NaniteWeapon);
		MouseEventManager.add(btn_NaniteHealth, upgrade_NaniteHealth);
		MouseEventManager.add(btn_NaniteArmor, upgrade_NaniteArmor);
		MouseEventManager.add(btn_BoostAgi, upgrade_BoostAgi);
		MouseEventManager.add(btn_BoostExp, upgrade_BoostExp);
		MouseEventManager.add(btn_BoostRegen, upgrade_BoostRegen);
	}
	private function Close() : Void 
	{
		MouseEventManager.remove(btn_PowerShoot);
		MouseEventManager.remove(btn_PowerShield);
		MouseEventManager.remove(btn_PowerHit);
		MouseEventManager.remove(btn_PowerBall);
		MouseEventManager.remove(btn_PowerArmor);
		MouseEventManager.remove(btn_NaniteWeapon);
		MouseEventManager.remove(btn_NaniteHealth);
		MouseEventManager.remove(btn_NaniteArmor);
		MouseEventManager.remove(btn_BoostAgi);
		MouseEventManager.remove(btn_BoostExp);
		MouseEventManager.remove(btn_BoostRegen);
	}
	
	override public function update () : Void 
	{
		if (showMe)
		{
			super.update();
			InfoString.text = "Level:\t\t" + Std.string(_properties.level) + 
			"\nExp:\t\t" + Std.string(_properties.experience) + "/" + Std.string(_properties.experienceLevelUp)  +  "\nSkillpoints: " + Std.string(_properties.skillPoints) + "\n\n";
			
			InfoString.text = InfoString.text + "HP:\t\t\t" + Std.string(_properties.currentHP) + " / " + Std.string(_properties.getHP()) + "\n";
			InfoString.text = InfoString.text + "HP Max:\t" + Std.string(_properties.getHP()) + " = " + Std.string(_properties.baseHP) + " + "  + Std.string(_properties.skillHP) + "\n";
			InfoString.text = InfoString.text + "MP:\t\t\t" + Std.string(_properties.currentMP) + " / " + Std.string(_properties.baseMP) + "\n\n";
			
			InfoString.text = InfoString.text + "Movespeed:\t\t" + GameProperties.floatToStringPrecision(_properties.getMoveSpeedFactor(),2) + "\n\n";
			
			InfoString.text = InfoString.text + "Damage:\t" + Std.string(_properties.getDamage()) + 
			" = " + Std.string(_properties.baseDamage) + " + " + Std.string(_properties.skillDamage + _properties.skillPowerHitDamage) + "\n" ;
			
			InfoString.text = InfoString.text + "Defence:\t" + GameProperties.floatToStringPrecision(_properties.getDefense(), 2) + 
			" = " + GameProperties.floatToStringPrecision(_properties.baseDefense , 2) + " + " + GameProperties.floatToStringPrecision((_properties.skillPowerArmorDefense + _properties.skillDefense), 2) + "\n\n" ;			
		}
		ActivateDeactivateLevelUpSkills();
		calculateSkillBoni();
		
		cooldown_PowerShoot -= FlxG.elapsed;
		cooldown_PowerShield -= FlxG.elapsed;
		cooldown_PowerHit -= FlxG.elapsed;
		cooldown_PowerBall -= FlxG.elapsed;
		cooldown_PowerArmor -= FlxG.elapsed;
		cooldown_BoostRegen -= FlxG.elapsed;
		cooldown_BoostExp -= FlxG.elapsed;
		cooldown_BoostAgi -= FlxG.elapsed;
		
		CheckSkillLifeTime();
		
		btn_PowerHit.update();		
		btn_PowerShoot.update();
		btn_PowerShield.update();
		btn_PowerBall.update();
		btn_PowerArmor.update();
		btn_NaniteWeapon.update();
		btn_NaniteHealth.update();
		btn_NaniteArmor.update();
		btn_BoostAgi.update();
		btn_BoostExp.update();
		btn_BoostRegen.update();

		InfoString.update();
	}
	
	
	public function activateSkillPowerHit(): Void 
	{
		active_PowerHit = true;
		cooldown_PowerHit = GameProperties.Skills_PowerHit_CoolDown;
	}
	
	public function useSkillPowerHit(): Void 
	{
		active_PowerHit = false;
	}

	public function useSkillPowerShoot() : Void 
	{
		cooldown_PowerShoot = GameProperties.Skills_PowerShoot_CoolDown;
	}
	
	public function useSkillPowerShield() : Void 
	{
		cooldown_PowerShield = GameProperties.Skills_PowerShield_CoolDown;
	}
	
	public function useSkillPowerBall() : Void 
	{
		cooldown_PowerBall = GameProperties.Skills_PowerBall_CoolDown;
	}
	
	public function useSkillPowerArmor() : Void 
	{
		if ( cooldown_PowerArmor  <= 0)
		{
			cooldown_PowerArmor = GameProperties.Skills_PowerArmor_CoolDown;
			active_PowerArmor = true;
			lifeTime_PowerArmor = GameProperties.Skills_PowerArmor_LifeTime;
		}
	}
	
	public function activateSkillBoostRegen() : Void 
	{
		active_BoostRegen = true;
		cooldown_BoostRegen = GameProperties.Skills_BoostRegen_CoolDown;
		lifeTime_BoostRegen = GameProperties.Skills_BoostRegen_LifeTime;
	}
	
	public function activateSkillBoostAgi() : Void 
	{
		active_BoostAgi = true;
		cooldown_BoostAgi = GameProperties.Skills_BoostAgi_Cooldown;
		lifeTime_BoostAgi = GameProperties.Skills_BoostAgi_LifeTime;
	}
	
	public function activateSkillBoostExp() : Void 
	{
		active_BoostExp = true;
		cooldown_BoostExp = GameProperties.Skills_BoostExp_Cooldown;
		lifeTime_BoostExp= GameProperties.Skills_BoostExp_LifeTime;
	}
	

	
	
	private function calculateSkillBoni() : Void 
	{
		calculateSkillNaniteHealth();
		calculateSkillNaniteArmor();
		calculateSkillNaniteDamage();
	
		calculateSkillPowerHit();
		calculateSkillPowerArmor();
		
		calculateSkillBoostRegen();
		calculateSkillBoostAgi();
		calculateSkillBoostExp();
	}
	
	function calculateSkillNaniteHealth():Void 
	{
		var incfactor : Float = NaniteHealth * GameProperties.Skills_NaniteHealth_FactorPerLevel;
		var incHP :Float = _properties.baseHP * incfactor;
		var offs : Int = NaniteHealth * GameProperties.Skills_NaniteHealth_OffsetPerLevel;
		_properties.skillHP = Std.int(incHP) + offs;
	}
	
	function calculateSkillNaniteArmor():Void 
	{
		var incFactor : Float = NaniteArmor * GameProperties.Skills_NaniteArmor_FactorPerLevel;
		_properties.skillDefense = incFactor;
	}
	
	function calculateSkillNaniteDamage():Void 
	{
		var incD : Int = NaniteWeapon * GameProperties.Skills_NaniteWeapon_DamagePerLevel;
		var incF : Float = NaniteWeapon * GameProperties.Skills_NaniteWeapon_FactorPerLevel;
		incD += Std.int(incF * (_properties.baseDamage));
		_properties.skillDamage = incD;
	}
	
	function calculateSkillPowerHit():Void 
	{
		if (active_PowerHit)
		{
			_properties.skillPowerHitDamage = PowerHit * GameProperties.Skills_PowerHit_DamagePerLevel;
		}
		else 
		{
			_properties.skillPowerHitDamage = 0;
		}
	}
	
	function calculateSkillPowerArmor():Void 
	{
		
		if (active_PowerArmor && lifeTime_PowerArmor >= 0)
		{
			_properties.skillPowerArmorDefense = PowerArmor * GameProperties.Skills_PowerArmor_DefensePerLevel;
		}
		else 
		{
			_properties.skillPowerArmorDefense = 0;
		}
	}
	
	function calculateSkillBoostRegen () : Void 
	{
		if (active_BoostRegen && lifeTime_BoostRegen >= 0)
		{
			_properties.skillRegenGain = BoostRegen * GameProperties.Skills_BoostRegen_GainPerTickPerLevel;
			//_properties.skillRegenTimer = 0;	// instant heal
		}
		else
		{
			_properties.skillRegenGain = 0;
		}
	}
	
	function calculateSkillBoostExp() : Void 
	{
		if (active_BoostExp && lifeTime_BoostExp >= 0)
		{
			_properties.experienceFactor = BoostExp *  GameProperties.Skills_BoostExp_FactorPerLevel;
		}
		else
		{
			_properties.experienceFactor =  0;
		}
	}
	function calculateSkillBoostAgi(): Void 
	{
		if (active_BoostAgi && lifeTime_BoostAgi >= 0)
		{
			_properties.skillAg = BoostAgi * GameProperties.Skills_BoostAgi_OffsetPerLevel;
		}
		else
		{
			_properties.skillAg = 0;
		}
	}
	
	
	
	function CheckSkillLifeTime():Void 
	{
		if (lifeTime_PowerArmor >= 0 && active_PowerArmor )
		{
			lifeTime_PowerArmor -= FlxG.elapsed;
			if (lifeTime_PowerArmor <= 0)
			{	
				active_PowerArmor = false;
			}
		}
		
		if (lifeTime_BoostRegen >= 0 && active_BoostRegen)
		{
			lifeTime_BoostRegen -= FlxG.elapsed;
			if (lifeTime_BoostRegen <= 0)
			{
				active_BoostRegen = false;
			}
		}
		
		if (lifeTime_BoostAgi >= 0 && active_BoostAgi)
		{
			lifeTime_BoostAgi -= FlxG.elapsed;
			if (lifeTime_BoostAgi <= 0)
			{
				active_BoostAgi = false;
			}
		}
		
		if (lifeTime_BoostExp >= 0 && active_BoostExp)
		{
			lifeTime_BoostExp -= FlxG.elapsed;
			if (lifeTime_BoostExp <= 0)
			{
				active_BoostExp = false;
			}
		}
	}
	
	public function payMP(p:Int):Void
	{
		_properties.payMP(p);
	}
	
}