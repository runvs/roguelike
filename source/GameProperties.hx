package;

/**
 * ...
 * @author 
 */
class GameProperties
{	
	public static var TileSize : Int = 32;
	public static var WorldSizeInTilesx : Int = 32;
	public static var WorldSizeInTilesy : Int = 24;
	public static var Skills_Level1 : Int = 1;
	
	public static var Skills_Level2 : Int = 5;
	public static var Skills_Level3 : Int = 10;
	
	// Tier 1
	public static var Skills_NaniteArmor_FactorPerLevel : Float = 0.05;
	
	// Tier 2
	public static var Skills_NaniteHealth_FactorPerLevel : Float = 0.09;
	public static var Skills_NaniteHealth_OffsetPerLevel : Int = 6;
	
	// Tier 3
	public static var Skills_NaniteWeapon_FactorPerLevel : Float = 0.05;
	public static var Skills_NaniteWeapon_DamagePerLevel : Int = 5;
	
	// Tier 1
	public static var Skills_PowerHit_CoolDown : Float = 5;
	public static var Skills_PowerHit_DamagePerLevel : Int = 5;
	public static var Skills_PowerHitMPCost : Int = 5; 
	
	// Tier 2
	public static var Skills_PowerShoot_CoolDown : Float = 5;
	public static var Skills_PowerShootMPCost : Int = 5; 
	public static var Skills_PowerShootSpeed : Float = 200;
	public static var Skills_PowerShootDamagePerLevel : Int = 3;
	
	public static var Skills_PowerShield_CoolDown : Float = 5;
	public static var Skills_PowerShieldMPCost : Int = 5; 
	
	// Tier 3
	public static var Skills_PowerBall_CoolDown : Float = 5;
	public static var Skills_PowerBallMPCost : Int = 5; 
	
	public static var Skills_PowerArmor_CoolDown : Float = 5;
	public static var Skills_PowerArmor_LifeTime : Float = 5;
	public static var Skills_PowerArmor_DefensePerLevel : Float = 0.10;
	public static var Skills_PowerArmorMPCost : Int = 5; 
	
	// Tier 1
	public static var Skills_BoostRegen_CoolDown : Float = 3;
	public static var Skills_BoostRegen_LifeTime : Float = 2;
	public static var Skills_BoostRegen_GainPerTickPerLevel : Int = 1;
	public static var Skills_BoostRegenMPCost : Int = 5; 
	
	// Tier 2
	public static var Skills_BoostAgi_Cooldown : Float = 30;
	public static var Skills_BoostAgi_LifeTime : Float = 10;
	public static var Skills_BoostAgi_OffsetPerLevel : Int = 5;
	public static var Skills_BoostAgiMPCost : Int = 5; 
	
	// Tier 3
	public static var Skills_BoostExp_Cooldown : Float = 40;
	public static var Skills_BoostExp_LifeTime : Float = 20;
	public static var Skills_BoostExp_FactorPerLevel : Float = 0.075;
	public static var Skills_BoostExpMPCost : Int = 5; 
	
	public static var Player_MaxSpeed : Float = 100;
	public static var Player_VelocityDecay : Float = 800;
	public static var Player_Speed : Float = 1000;
	public static var Player_AttackSpeed : Float = 0.25;
	public static var Player_experienceLevelUpBase : Int = 40;
	public static var Player_experienceLevelUpFactor : Float = 1.2;
	
	public static var Enemy_AggroRadius : Int = TileSize * 4;
	public static var Enemy_AttackTimer : Float = 0.75;
	public static var Enemy_BaseXP : Int = 14;
	
	public static function floatToStringPrecision(n:Float, prec:Int)
	{
		n = Math.round(n * Math.pow(10, prec));
		var str = ''+n;
		var len = str.length;
		if (len <= prec)
		{
			while (len < prec)
			{
				str = '0'+str;
				len++;
			}
			return '0.'+str;
		}
		else
		{
			return str.substr(0, str.length-prec) + '.'+str.substr(str.length-prec);
		}
	}
}
