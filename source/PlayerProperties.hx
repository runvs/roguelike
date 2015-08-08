package;

/**
 * ...
 * @author 
 */
class PlayerProperties
{

	public function new() 
	{
		level = 0;
		experience = 0;
		skillPoints = 0;
		attributePoints = 0;
		
		St = 5;
		Ag = 5;
		En = 5;
		Wi = 5;
		Lk = 5;
		baseHP = 30;
		itemHP = 0;
		skillHP = 0;
		currentHP = baseHP;
		
		baseMP = 0;
	
		baseDamage = 3;
		itemDamage = 0;
		skillDamage = 0;
		skillPowerHitDamage = 0;
		
		baseDefense= 0;
		itemDefense= 0;
		skillDefense= 0;
		skillPowerArmorDefense= 0;
		baseHitChance= 0;
		
		
	}

	public var experience : Int;
	public var level: Int;
	public var skillPoints : Int;
	public var attributePoints : Int;
	
	public var St : Int;
	public var Ag : Int;
	public var En : Int;
	public var Wi : Int;
	public var Lk : Int;
	
	public var currentHP : Int;
	public var baseHP : Int;
	public var itemHP : Int;
	public var skillHP : Int;
	public function getHP () : Int
	{
		return baseHP + itemHP + skillHP;
	}
	
	public var baseMP : Int;
	
	public var baseDamage : Int;
	public var itemDamage : Int;
	public var skillDamage : Int;
	public var skillPowerHitDamage :Int ;
	public function getDamage () : Int 
	{
		var val : Int = Std.int(baseDamage + itemDamage + skillDamage + skillPowerHitDamage);
		return  val;
	}
	
	
	
	
	public var baseDefense : Float;
	public var itemDefense : Float;
	public var skillDefense : Float;
	public var skillPowerArmorDefense : Float;
	public function getDefense () : Float 
	{
		var val : Float = baseDefense + itemDefense + skillDefense + skillPowerArmorDefense;
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
	
	public var baseHitChance : Float;
	

	
	

	

	
	
}