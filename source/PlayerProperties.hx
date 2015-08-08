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
	public function getDamage () : Float 
	{
		var val : Int = baseDamage + itemDamage + skillDamage;
		return  val;
	}
	
	public var baseDefense : Float;
	public var itemDefense : Float;
	public var skillDefense : Float;
	public function getDefense () : Float 
	{
		var val : Float = baseDefense + itemDefense + skillDefense;
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
	
	public var baseHitChance : Int;
	

	
	

	

	
	
}