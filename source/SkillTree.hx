package;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
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
	
	private var btn_PowerShoot: FlxButton;
	private var btn_PowerShield: FlxButton;
	private var btn_PowerHit: FlxButton;
	private var btn_PowerBall: FlxButton;
	private var btn_PowerArmor: FlxButton;
	
	
	private var btn_NaniteArmor : FlxButton;
	private var btn_NaniteHealth : FlxButton;
	private var btn_NaniteWeapon : FlxButton;
	
	private var btn_BoostRegen : FlxButton;
	private var btn_BoostAgi : FlxButton;
	private var btn_BoostExp : FlxButton;
	
	
	
	private var btn_St : FlxButton;
	private var btn_Ag : FlxButton;
	private var btn_En : FlxButton;
	private var btn_Wi : FlxButton;
	private var btn_Lk : FlxButton;
	
	
	private var text_Skillpoints : FlxText;
	
	public function new( properties : PlayerProperties) 
	{
		super();
		_properties = properties;
		
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
		
		
		btn_PowerHit   = new FlxButton(200, 40, "Power Hit 0/5", upgrade_PowerHit);
		btn_PowerHit.scale.set(1, 1.5);
		btn_PowerHit.updateHitbox();
		btn_PowerShoot = new FlxButton(150, 100, "Power Shoot 0/5", upgrade_PowerShoot);
		btn_PowerShoot.scale.set(1, 1.5);
		btn_PowerShoot.updateHitbox();
		btn_PowerShield = new FlxButton(250, 100, "Power Shield 0/5", upgrade_PowerShield);
		btn_PowerShield.scale.set(1, 1.5);
		btn_PowerShield.updateHitbox();
		btn_PowerBall  = new FlxButton(150, 160, "Power Ball 0/5", upgrade_PowerBall);
		btn_PowerBall.scale.set(1, 1.5);
		btn_PowerBall.updateHitbox();
		btn_PowerArmor = new FlxButton(250, 160, "Power Armor 0/5", upgrade_PowerArmor);
		btn_PowerArmor.scale.set(1, 1.5);
		btn_PowerArmor.updateHitbox();
		
		
		btn_NaniteArmor = new FlxButton(400, 40, "Nanite Armor 0/5", upgrade_NaniteArmor);
		btn_NaniteArmor.scale.set(1, 1.5);
		btn_NaniteArmor.updateHitbox();

		btn_NaniteHealth = new FlxButton(400, 100, "Nanite Health 0/5", upgrade_NaniteHealth);
		btn_NaniteHealth.scale.set(1, 1.5);
		btn_NaniteHealth.updateHitbox();
		btn_NaniteWeapon = new FlxButton(400, 160, "Nanite Weapon 0/5", upgrade_NaniteWeapon);
		btn_NaniteWeapon.scale.set(1, 1.5);
		btn_NaniteWeapon.updateHitbox();
		
		btn_BoostRegen = new FlxButton(600, 40, "Boost Regen 0/5", upgrade_BoostRegen);
		btn_BoostRegen.scale.set(1, 1.5);
		btn_BoostRegen.updateHitbox();
		btn_BoostAgi = new FlxButton(600, 100, "Boost Agi 0/5", upgrade_BoostAgi);
		btn_BoostAgi.scale.set(1, 1.5);
		btn_BoostAgi.updateHitbox();
		btn_BoostExp = new FlxButton(600, 160, "Boost Exp 0/5", upgrade_BoostExp);
		btn_BoostExp.scale.set(1, 1.5);
		btn_BoostExp.updateHitbox();
		
		btn_St = new FlxButton(-60, 85, "St", upgradeSt);
		btn_St.scale.set(1, 0.9);
		btn_St.updateHitbox();
		btn_Ag = new FlxButton(-60, 100, "Ag", upgradeAg);
		btn_Ag.scale.set(1, 0.9);
		btn_Ag.updateHitbox();
		btn_En = new FlxButton(-60, 115, "En", upgradeEn);
		btn_En.scale.set(1, 0.9);
		btn_En.updateHitbox();
		btn_Wi = new FlxButton(-60, 130, "Wi", upgradeWi);
		btn_Wi.scale.set(1, 0.9);
		btn_Wi.updateHitbox();
		btn_Lk = new FlxButton(-60, 145, "Lk", upgradeLk);
		btn_Lk.scale.set(1, 0.9);
		btn_Lk.updateHitbox();
		
		add(btn_St);
		add(btn_Ag);
		add(btn_En);
		add(btn_Wi);
		add(btn_Lk);
		
		
		add(btn_PowerShoot);
		add(btn_PowerShield);
		add(btn_PowerHit);
		add(btn_PowerBall);
		add(btn_PowerArmor);
		
		add(btn_NaniteArmor);
		add(btn_NaniteHealth);
		add(btn_NaniteWeapon);
		
		add(btn_BoostRegen);
		add(btn_BoostAgi);
		add(btn_BoostExp);
		
		text_Skillpoints = new FlxText(40, 50, 400, "");
		text_Skillpoints.scale.set(1.5, 1.5);
		add(text_Skillpoints);
		
		this.scrollFactor.set();
		x = 100;
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
			_properties.En += 1;
			_properties.attributePoints -= 1;
			_properties.ReCalculateDerivedValues();
		}
	}
	public function upgradeWi()
	{
		if (_properties.attributePoints >= 1)
		{
			_properties.Wi += 1;
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
	
	
	public function upgrade_PowerShoot() : Void 
	{		
		if (_properties.skillPoints >= 1 && b_PowerShoot)
		{
			_properties.skillPoints -= 1;
			PowerShoot += 1;
			btn_PowerShoot.text = "Power Shot " + Std.string(PowerShoot) + "/5";
		}
	}
	public function upgrade_PowerShield() : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerShield)
		{
			_properties.skillPoints -= 1;
			PowerShield += 1;
			btn_PowerShield.text = "Power Shield " + Std.string(PowerShield) + "/5";
		}
	}
	public function upgrade_PowerHit() : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerHit)
		{
			_properties.skillPoints -= 1;
			PowerHit += 1;
			btn_PowerHit.text = "Power Hit " + Std.string(PowerHit) + "/5";
		}
	}
	public function upgrade_PowerBall() : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerBall)
		{
			_properties.skillPoints -= 1;
			PowerBall += 1;
			btn_PowerBall.text = "Power Ball " + Std.string(PowerBall) + "/5";
		}
	}
	public function upgrade_PowerArmor() : Void 
	{
		if (_properties.skillPoints >= 1 && b_PowerArmor)
		{
			_properties.skillPoints -= 1;
			PowerArmor += 1;
			btn_PowerArmor.text = "Power Armor " + Std.string(PowerArmor) + "/5";
		}
	}
	
	public function upgrade_NaniteArmor() : Void 
	{
		if (_properties.skillPoints >= 1 && b_NaniteArmor)
		{
			_properties.skillPoints -= 1;
			NaniteArmor += 1;
			btn_NaniteArmor.text = "Nanite Armor " + Std.string(NaniteArmor) + "/5";
		}
	}
	public function upgrade_NaniteHealth() : Void 
	{
		if (_properties.skillPoints >= 1 && b_NaniteHealth)
		{
			_properties.skillPoints -= 1;
			NaniteHealth += 1;
			btn_NaniteHealth.text = "Nanite Health " + Std.string(NaniteHealth) + "/5";
		}
	}
	public function upgrade_NaniteWeapon() : Void 
	{
		if (_properties.skillPoints >= 1 && b_NaniteWeapon)
		{
			_properties.skillPoints -= 1;
			NaniteWeapon += 1;
			btn_NaniteWeapon.text = "Nanite Weapon " + Std.string(NaniteWeapon) + "/5";
		}
	}
	
	
	public function upgrade_BoostRegen() : Void 
	{
		if (_properties.skillPoints >= 1 && b_BoostRegen)
		{
			_properties.skillPoints -= 1;
			BoostRegen += 1;
			btn_BoostRegen.text = "Boost Regen " + Std.string(BoostRegen) + "/5";
		}
	}
	public function upgrade_BoostAgi() : Void 
	{
		if (_properties.skillPoints >= 1 && b_BoostAgi)
		{
			_properties.skillPoints -= 1;
			BoostAgi += 1;
			btn_BoostAgi.text = "Boost Agi " + Std.string(BoostAgi) + "/5";
		}
	}
	public function upgrade_BoostExp() : Void 
	{
		if (_properties.skillPoints >= 1 && b_BoostExp)
		{
			_properties.skillPoints -= 1;
			BoostExp += 1;
			btn_BoostExp.text = "Boost Exp " + Std.string(BoostExp) + "/5";
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
			btn_PowerArmor.set_color(FlxColor.RED);
		}
		else
		{
			btn_PowerArmor.set_color(FlxColor.GRAY);
		}
		
		if (b_PowerBall)
		{
			btn_PowerBall.set_color(FlxColor.RED);
		}
		else
		{
			btn_PowerBall.set_color(FlxColor.GRAY);
		}
		
		if (b_PowerHit)
		{
			btn_PowerHit.set_color(FlxColor.RED);
		}
		else
		{
			btn_PowerHit.set_color(FlxColor.GRAY);
		}
		
		if (b_PowerShield)
		{
			btn_PowerShield.set_color(FlxColor.RED);
		}
		else
		{
			btn_PowerShield.set_color(FlxColor.GRAY);
		}
		
		if (b_PowerShoot)
		{
			btn_PowerShoot.set_color(FlxColor.RED);
		}
		else
		{
			btn_PowerShoot.set_color(FlxColor.GRAY);
		}
		
		
		if (b_NaniteArmor)
		{
			btn_NaniteArmor.set_color(FlxColor.RED);
		}
		else
		{
			btn_NaniteArmor.set_color(FlxColor.GRAY);
		}
		
		if (b_NaniteHealth)
		{
			btn_NaniteHealth.set_color(FlxColor.RED);
		}
		else
		{
			btn_NaniteHealth.set_color(FlxColor.GRAY);
		}
		
		if (b_NaniteWeapon)
		{
			btn_NaniteWeapon.set_color(FlxColor.RED);
		}
		else
		{
			btn_NaniteWeapon.set_color(FlxColor.GRAY);
		}
		
		if (b_BoostRegen)
		{
			btn_BoostRegen.set_color(FlxColor.RED);
		}
		else
		{
			btn_BoostRegen.set_color(FlxColor.GRAY);
		}
		
		if (b_BoostAgi)
		{
			btn_BoostAgi.set_color(FlxColor.RED);
		}
		else
		{
			btn_BoostAgi.set_color(FlxColor.GRAY);
		}
		
		if (b_BoostExp)
		{
			btn_BoostExp.set_color(FlxColor.RED);
		}
		else
		{
			btn_BoostExp.set_color(FlxColor.GRAY);
		}
	}
	
	override public function draw () : Void 
	{
		if (showMe)
		{
			super.draw();
		}
		
		
		
	}
	
	override public function update () : Void 
	{
		if (showMe)
		{
			super.update();
			text_Skillpoints.text = "Level:\t\t" + Std.string(_properties.level) + 
			"\nExp:\t\t" + Std.string(_properties.experience) + "/" + Std.string(_properties.experienceLevelUp)  +  "\nSkillpoints: " + Std.string(_properties.skillPoints) + "\n\n";
		
			text_Skillpoints.text = text_Skillpoints.text + "Attribute Points: \t" + Std.string(_properties.attributePoints) + "\n";
			text_Skillpoints.text = text_Skillpoints.text + "        \t\t" + Std.string(_properties.St) + "\n" ;
			text_Skillpoints.text = text_Skillpoints.text + "        \t\t" + Std.string(_properties.getAg()) + " = " + Std.string(_properties.Ag) + " + " + Std.string(_properties.skillAg) + "\n" ;
			text_Skillpoints.text = text_Skillpoints.text + "        \t\t" + Std.string(_properties.En) + "\n" ;
			text_Skillpoints.text = text_Skillpoints.text + "        \t\t" + Std.string(_properties.Wi) + "\n" ;
			text_Skillpoints.text = text_Skillpoints.text + "        \t\t" + Std.string(_properties.Lk) + "\n\n" ;
			
			text_Skillpoints.text = text_Skillpoints.text + "HP:\t\t\t" + Std.string(_properties.currentHP) + " / " + Std.string(_properties.getHP()) + "\n";
			text_Skillpoints.text = text_Skillpoints.text + "HP Max:\t" + Std.string(_properties.getHP()) + " = " + Std.string(_properties.baseHP) + " + "  + Std.string(_properties.skillHP) + "\n";
			text_Skillpoints.text = text_Skillpoints.text + "MP:\t\t\t" + Std.string(_properties.currentMP) + " / " + Std.string(_properties.baseMP) + "\n\n";
			
			text_Skillpoints.text = text_Skillpoints.text + "Damage:\t" + Std.string(_properties.getDamage()) + 
			" = " + Std.string(_properties.baseDamage) + " + " + Std.string(_properties.skillDamage + _properties.skillPowerHitDamage) + "\n" ;
			
			text_Skillpoints.text = text_Skillpoints.text + "Defence:\t" + GameProperties.floatToStringPrecision(_properties.getDefense(), 2) + 
			" = " + GameProperties.floatToStringPrecision(_properties.baseDefense ,2)+ " + " + GameProperties.floatToStringPrecision((_properties.skillPowerArmorDefense + _properties.skillDefense),2) + "\n" ;
		}
		ActivateDeactivateLevelUpSkills();
		calculateSkillBoni();
		
		if (FlxG.keys.justPressed.C)
		{
			showMe = ! showMe;
		}
		
		cooldown_PowerShoot -= FlxG.elapsed;
		cooldown_PowerShield -= FlxG.elapsed;
		cooldown_PowerHit -= FlxG.elapsed;
		cooldown_PowerBall -= FlxG.elapsed;
		cooldown_PowerArmor -= FlxG.elapsed;
		cooldown_BoostRegen -= FlxG.elapsed;
		cooldown_BoostExp -= FlxG.elapsed;
		cooldown_BoostAgi -= FlxG.elapsed;
		
		CheckSkillLifeTime();
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
		cooldown_PowerShield = GameProperties.Skills_PowerBall_CoolDown;
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
			_properties.skillRegenTimer = 0;	// instant heal
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
	
	
}