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
		currentHP = baseHP = 5 * (level +1);
	}
	
	public var level : Int;
	
	public var currentHP : Int;
	public var baseHP : Int;
	
}