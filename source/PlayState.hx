package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.addons.effects.FlxTrail;
import flixel.addons.ui.FlxButtonPlus;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil.LineStyle;
import haxe.Log;
import openfl.display.SpreadMethod;

class PlayState extends FlxState
{
	var box:FlxShapeBox;
	var circles:FlxGroup = new FlxGroup();

	// we'll need individual ones to get the same look as the example.
	final globalGravity:Float = 600;

	override public function create()
	{
		super.create();

		box = new FlxShapeBox(0, 0, FlxG.width - 25, 10, {color: FlxColor.WHITE, thickness: 1}, FlxColor.WHITE);
		box.screenCenter();
		box.y += FlxG.height / 3;
		box.immovable = true;

		var b1 = new BouncyBall(0, 0, 16, 0.70, FlxColor.GREEN);
		b1.screenCenter(X);

		var trail = new FlxTrail(b1, AssetPaths.ball_one_trial__png);

		circles.add(b1);

		add(trail);
		add(circles);
		add(box);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.G) {}

		FlxG.collide(circles, box);

		super.update(elapsed);
	}

	public function createBouncyBall(?x:Float = 0, ?y:Float = 0, radius:Float, ?elasticity:Float = 0.25, color:FlxColor):FlxShapeCircle
	{
		var ball = new FlxShapeCircle(x, y, radius, {color: color, thickness: 2}, color);
		ball.acceleration.y = globalGravity;
		ball.elasticity = elasticity;

		return ball;
	}
}

class BouncyBall extends FlxShapeCircle
{
	/**
	 * [Description]
	 * @param x 
	 * @param y 
	 * @param radius 
	 * @param elasticity 
	 * @param color 
	 */
	override public function new(?x:Float = 0, ?y:Float = 0, radius:Float, ?elasticity:Float = 0.25, color:FlxColor)
	{
		super(x, y, radius, {color: color, thickness: 2}, color);
		acceleration.y = 600;
		this.elasticity = elasticity;
	}

	override function update(elapsed:Float)
	{
		// adds a stretch affect based on velocity; while ensuring at least a 1.0scale
		scale.y = Math.max(1, 1 + velocity.y / 1000);

		// this is an attempt at stopping the jumping effect
		if (scale.y > 1.05 || scale.y < 0.95 || scale.y == 1)
			updateHitbox();

		super.update(elapsed);
	}
}
/**
 * Ball 1:
 *  - Falls fast has a failling trail with lines to show speed.
 *  - Bounces several times but also changes shape with the bounce, causingit to go oblong
 * 
 * Ball 2:
 *  - has impact effect
 *  - falls slower but gives the impression of more force
 *  - higher bounce/elasticity
 * 
 * Ball 3:
 *  - has a dot trail falls like a heavy rock bounces once with another small bounce
 *  - has X axis movement and rolls along the surface
 * 
 * Ball 4:
 *  - Bounces several times as it moves along the X axis and then falls off
 *  - has impact effect but not a forceful one, 
 *  - almost tops at the top of its bounce 
 *  - last to stop moving
 * 
 * Platform: 
 *  - thin, immovable
 *  - Retains hitbox/collison during spin <---- (annyoing to do, requires manually collision detection and calculations) 
 * 
 * source link: https://dribbble.com/shots/2327065-Bouncing-Balls/attachments/9246107?mode=media
 * 
 * Extras:
 *  - Create a box of bouncing balls that interact with eachother, maybe allow the cursor to interact with them? 
 *  - a "worm" moving across the screen which is made up of several bouncing bowls giving the apperance of a worm
 */
