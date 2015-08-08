package;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class SkillTree extends FlxSpriteGroup
{
	
	public var showMe : Bool = false;
	
	private var btn_NaniteArmor : FlxButton;
	private var btn_NaniteHealth : FlxButton;
	private var btn_NaniteWeapon : FlxButton;
	
	
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
		active_BoostExp= false;
		
		
		btn_NaniteArmor = new FlxButton(200, 40, "Nanite Armor", upgrade_NaniteArmor);
		btn_NaniteArmor.scrollFactor.set();
		btn_NaniteHealth = new FlxButton(200, 120, "Nanite Health", upgrade_NaniteHealth);
		btn_NaniteHealth.scrollFactor.set();
		btn_NaniteWeapon = new FlxButton(200, 200, "Nanite Weapon", upgrade_NaniteWeapon);
		btn_NaniteWeapon.scrollFactor.set();
		
		add(btn_NaniteArmor);
		add(btn_NaniteHealth);
		add(btn_NaniteWeapon);
		this.scrollFactor.set();
	}
	
	public function upgrade_NaniteArmor() : Void 
	{
		
	}
	public function upgrade_NaniteHealth() : Void 
	{
		
	}
	public function upgrade_NaniteWeapon() : Void 
	{
		
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

	
	private function calculateSkillBoni() : Void 
	{
		calculateSkillNaniteHealth();
		calculateSkillNaniteArmor();
		calculateSkillNaniteDamage();
	
		
		calculateSkillPowerArmor();
	}
	
	function calculateSkillNaniteHealth():Void 
	{
		var incfactor : Float = NaniteHealth * GameProperties.Skills_NaniteHealth_FactorPerLevel;
		var incHP :Float = _properties.baseHP * incfactor;
		_properties.skillHP = Std.int(incHP);
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
		incD += Std.int(incF * (_properties.baseDamage + 0.25 * _properties.itemDamage));
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
		calculateSkillPowerHit();
		if (active_PowerArmor && lifeTime_PowerArmor >= 0)
		{
			_properties.skillPowerArmorDefense = PowerArmor * GameProperties.Skills_PowerArmor_DefensePerLevel;
		}
		else 
		{
			_properties.skillPowerArmorDefense = 0;
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
	}
	
	
}