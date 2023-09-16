package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.addons.ui.FlxButtonPlus;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil.LineStyle;
import openfl.display.SpreadMethod;

class PlayState extends FlxState
{
	var box:FlxShapeBox;
	var circles:FlxGroup = new FlxGroup();

	final globalGravity:Float = 300;

	override public function create()
	{
		super.create();

		box = new FlxShapeBox(0, 0, FlxG.width - 25, 10, {color: FlxColor.GRAY, thickness: 2}, FlxColor.GRAY);
		box.screenCenter();
		box.y += FlxG.height / 3;
		box.immovable = true;

		for (i in 0...10)
		{
			var ball = createBouncyBall(FlxG.random.int(0, FlxG.width - 10), FlxG.random.int(0, 25), FlxG.random.int(5, 50), FlxG.random.float(0.1, 0.8),
				FlxG.random.color());
			circles.add(ball);
		}

		// elasticity defines how much movement we retain on collision ranging from 0 -> 1 (%!)
		// 0 being no movement and 1 being all movement!

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
