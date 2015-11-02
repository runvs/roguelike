package;

/**
 * ...
 * @author 
 */
class EnemyPropeties
{

	public function new(l : Int) 
	{
		level = l;
		currentHP = baseHP = GameProperties.Enemy_HP_Base + GameProperties.Enemy_HP_PerLevel * Math.round(Math.pow(level, GameProperties.Enemy_HP_PerLevel_Exponent));
		
		baseDamage = 2 + level * 0.85;
	}
	
	public var level : Int;
	
	public var currentHP : Int;
	public var baseHP : Int;
	
	public var baseDamage : Float;
	
}