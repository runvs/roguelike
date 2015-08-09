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
		currentHP = baseHP = 6 * (level +1);
		
		baseDamage = 1 + level * 0.5;
	}
	
	public var level : Int;
	
	public var currentHP : Int;
	public var baseHP : Int;
	
	public var baseDamage : Float;
	
}