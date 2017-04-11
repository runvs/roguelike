package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class GameProperties
{	
	public static var Tile_Size : Int = 32;
	public static var Tiles_ShadowAlpha : Float = 0.25;
	
	public static var World_SizeInTilesX : Int = 45;
	public static var World_SizeInTilesY : Int = 30;
	
	public static var World_PathfinderTimerMax : Float = 1;
	
	public static var Skills_Level1 : Int = 1;	// obviously
	public static var Skills_Level2 : Int = 8;
	public static var Skills_Level3 : Int = 17;
	
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
	public static var Skills_PowerHit_DamagePerLevel : Int = 7;
	public static var Skills_PowerHitMPCost : Int = 5; 
	
	// Tier 2
	public static var Skills_PowerShoot_CoolDown : Float = 3.5;
	public static var Skills_PowerShootMPCost : Int = 5; 
	public static var Skills_PowerShootSpeed : Float = 250;
	public static var Skills_PowerShootDamagePerLevel : Int = 7;
	
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
	public static var Skills_BoostRegen_CoolDown : Float = 5;
	public static var Skills_BoostRegen_LifeTime : Float = 3;
	public static var Skills_BoostRegen_GainPerTickPerLevel : Int = 1;
	public static var Skills_BoostRegenMPCost : Int = 7; 
	
	// Tier 2
	public static var Skills_BoostAgi_Cooldown : Float = 20;
	public static var Skills_BoostAgi_LifeTime : Float = 10;
	public static var Skills_BoostAgi_OffsetPerLevel : Int = 9;
	public static var Skills_BoostAgiMPCost : Int = 5; 
	
	// Tier 3
	public static var Skills_BoostExp_Cooldown : Float = 40;
	public static var Skills_BoostExp_LifeTime : Float = 20;
	public static var Skills_BoostExp_FactorPerLevel : Float = 0.075;
	public static var Skills_BoostExpMPCost : Int = 5; 
	
	public static var Player_MaxSpeed : Float = 100;
	public static var Player_VelocityDecay : Float = 800;
	public static var Player_Speed : Float = 1000;
	public static var Player_AttackTimer : Float = 1.15;
	public static var Player_experienceLevelUpBase : Int = 45;
	public static var Player_experienceLevelUpFactor : Float = 1.3;
	
	public static var Player_AttackPushBackVelocity : Float = 1500;
	
	public static var Player_AttributePointsPerLevelUp : Int = 3;
	
	public static var Enemy_AggroRadius : Int = Tile_Size * 3;
	public static var Enemy_AttackTimer : Float = 0.75;
	public static var Enemy_BaseXP : Int = 9;
	public static var Enemy_HP_Base : Int = 8;
	public static var Enemy_HP_PerLevel : Int = 4 ;
	public static var Enemy_HP_PerLevel_Exponent : Float = 1.3;
	
	public static var Color_Red : FlxColor  = FlxColor.fromRGB( 203, 65, 58);
	public static var Color_Green : FlxColor  = FlxColor.fromRGB(70, 148, 80);
	public static var Color_Yellow : FlxColor  = FlxColor.fromRGB(203, 122, 58);
	
	
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
