package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

/**
 * ...
 * @author 
 */
class Shield extends FlxSprite
{

	private var lifeTime : Float;
	
	public function new(X:Float=0, Y:Float=0, level : Int) 
	{
		super(X, Y);
		//this.makeGraphic(32, 32);
		this.loadGraphic(AssetPaths.Shield__png, true, 22, 28);
		this.animation.add("start", [0, 1, 2], 9, false);
		this.animation.add("idle", [3,4,5,6], 5, true);
		this.animation.play("start");
		
		var f : Float = 1 + (level) / 5.0;
		this.scale.set(f, f);
		this.updateHitbox();
		
		var t : FlxTimer = new FlxTimer();
		t.start(3.0 / 9.0, function(t: FlxTimer) { this.animation.play("idle", true); } );
		
		lifeTime = (1.5 +  level* 0.85);
		immovable = true;
	}
	
	override public function update (elapsed:Float) : Void
	{
		super.update(elapsed);
		lifeTime -= FlxG.elapsed;
		if (lifeTime <= 0)
		{
			alive = false;
		}
	}
	
	
}