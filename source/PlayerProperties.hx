package;
import flixel.FlxG;
import flixel.system.FlxSound;

/**
 * ...
 * @author 
 */
class PlayerProperties
{

	private var hitSound : FlxSound;
	
	public function new() 
	{
		level = 0;
		experience = 0;
		experienceLevelUpLast = 0;
		experienceLevelUp = GameProperties.Player_experienceLevelUpBase;
		experienceFactor = 0;
		skillPoints = 0;
		
		St = 7;
		Ag = 7;
		En = 7;
		Wi = 7;
		Lk = 7;
		baseHP = 30;
		skillHP = 0;
		currentHP = baseHP;
		
		skillRegenTimerMax = skillRegenTimer = 0.25;
		
		MPRegenTimer = MPRegenTimerMax = 5;
		
		baseMP = 30;
		currentMP = baseMP;
		
	
		baseDamage = 3;

		skillDamage = 0;
		skillPowerHitDamage = 0;
		
		baseDefense= 0;
		skillDefense= 0;
		skillPowerArmorDefense= 0;
		baseHitChance = 0;
		
		hitSound = new FlxSound();
		#if flash
		hitSound = FlxG.sound.load(AssetPaths.hit__mp3);
		#else
		hitSound = FlxG.sound.load(AssetPaths.hit__ogg);
		#end
		
		
		//gainXP(50000);
	}
	
	public function update():Void 
	{
		CheckLevelUp();
		ReCalculateDerivedValues();
		
		updateHPRegen();
		updateMPRegen();
		
		if (currentHP > getHP())
		{
			currentHP = getHP();
		}
		if (currentMP > baseMP)
		{
			currentMP = baseMP;
		}
	}

	public var experience : Int;
	public var experienceLevelUp : Int;
	public var experienceLevelUpLast : Int;
	public var level: Int;
	public var skillPoints : Int;
	public var attributePoints : Int;
	
	public var St : Int;
	public var Ag : Int;
	public var En : Int;
	public var Wi : Int;
	public var Lk : Int;
	
	public function increaseEN() : Void 
	{
		var h : Float = currentHP;
		var hm : Float = getHP();
		
		En += 1;
		ReCalculateDerivedValues();
		var f : Float = getHP() / hm;
		currentHP = Math.round(f * h);
	}
	
	public function increaseWI() : Void 
	{
		var h : Float = currentMP;
		var hm : Float = baseMP;
		
		Wi += 1;
		ReCalculateDerivedValues();
		var f : Float = baseMP / hm;
		currentMP = Math.round(f * h);
	}
	
	public var skillAg : Int;
	public function getAg () : Int
	{
		return Ag + skillAg;
	}
	
	public var currentHP : Int;
	public var baseHP : Int;
	public var skillHP : Int;
	public function getHP () : Int
	{
		return baseHP + skillHP;
	}
	
	public var skillRegenTimerMax : Float;
	public var skillRegenTimer : Float;
	public var skillRegenGain : Int;
	
	
	public var baseMP : Int;
	public var currentMP : Int;
	
	public var MPRegenTimer :Float ;
	public var MPRegenTimerMax : Float;
	
	public function payMP (p:Int) : Void 
	{
		currentMP -= p;
		if (currentMP < 0 )
		{
			currentMP = 0;
		}
	}
	
	
	public var baseDamage : Int;
	public var skillDamage : Int;
	public var skillPowerHitDamage :Int ;
	public function getDamage () : Int 
	{
		var val : Int = Math.round(baseDamage  + skillDamage + skillPowerHitDamage);
		return  val;
	}
	
	public var baseDefense : Float;
	public var skillDefense : Float;
	public var skillPowerArmorDefense : Float;
	public function getDefense () : Float 
	{
		var val : Float = baseDefense  + skillDefense + skillPowerArmorDefense;
		if (val > 0.9)
		{
			val = 0.9 + (val - 0.9 * 0.05); 
		}
		if (val >= 1)
		{
			val = 0.99;
		}
		return  val;
	}
	
	public var experienceFactor : Float;
	public function gainXP(xp:Int)
	{
		var f = 1.0 + experienceFactor;
		experience += Std.int(xp * f);
		CheckLevelUp();
	}
	
	public function CheckLevelUp():Void 
	{
		if (experience >= experienceLevelUp)
		{
			level += 1;
			skillPoints += 1;
			attributePoints += GameProperties.Player_AttributePointsPerLevelUp;
			experienceLevelUpLast = experienceLevelUp;
			experienceLevelUp = Std.int(experienceLevelUp * GameProperties.Player_experienceLevelUpFactor);
		}
	}
	
	public function ReCalculateDerivedValues() : Void 
	{
		baseHP = 20 + En * 2;
		baseMP = 5 + Wi * 3;
		baseDamage = 1 + (St + 1);
		baseDefense = 0 + (0.006 * Ag + 0.0025* Lk);
	}
	
	
	function Heal(inc: Int):Void 
	{
		currentHP += inc;
		if (currentHP >= getHP())
		{
			currentHP = getHP();
		}
	}
	
	function updateHPRegen():Void 
	{
		//trace (skillRegenTimer);
		//trace ("g "  + skillRegenGain);
		if (skillRegenTimer < 0)
		{
			skillRegenTimer = skillRegenTimerMax;
			Heal(skillRegenGain);
		}
		else
		{
			skillRegenTimer -= FlxG.elapsed;
		}
	}
	
	function updateMPRegen() : Void 
	{
		MPRegenTimer -= FlxG.elapsed;
		if (MPRegenTimer <= 0)
		{
			MPRegenTimer = MPRegenTimerMax * (9/(1+Wi));
			currentMP += 1;
		}
	}
	
	public function takeDamage(damage:Float) : Void
	{
		var reducedDamage = Math.round(damage * (1 - getDefense()));
		
		FlxG.camera.shake(0.0075, 0.2);
	
		currentHP -= reducedDamage;
		hitSound.play();
	}
	
	public var baseHitChance : Float;
	
	public function getMoveSpeedFactor () : Float 
	{
		return 1.0 + (Ag-5) / 40.0;
	}
	
	public function getAttackTimer () : Float
	{
		return (0.50 + 0.5/((Ag)/5)  )* GameProperties.Player_AttackTimer;
	}
	

	
	

	

	
	
}