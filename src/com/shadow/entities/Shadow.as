package com.shadow.entities 
{
	import Playtomic.*;
	
	import com.shadow.Assets;
	import com.shadow.Global;
	import com.shadow.worlds.EndWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import punk.transition.Transition;
	import punk.transition.effects.*;
	
	
	/**
	 * 
	 * @author Eric Bernier
	 * This is quite the hack of a class due to laziness and just wanting to finish the game
	 */
	public class Shadow extends Physics
	{	
		private const WIDTH:int = 30;
		private const HEIGHT:int = 30;
		private const APPLE_JUMP:int = 25;
		private const JUMP:int = 8;
		private const ENDING_X:int = 498;
		
		private var sprite:Spritemap = new Spritemap(Assets.GROUNDHOG, WIDTH, HEIGHT, null);
		private var movement:Number = 1;
		private var direction_:Boolean = true;
		public var onGround_:Boolean = false;
		public var ending_:Boolean = false;
		private var dead:Boolean = false;
		private var start:Point;
		private var apples_:Boolean = false;
		private var jumpSnd_:Sfx = new Sfx(Assets.SND_JUMP);
		private var deathSnd_:Sfx = new Sfx(Assets.SND_BUTTON_SELECT);
		
		
		public function Shadow(xCoord:int, yCoord:int) 
		{
			yCoord -= HEIGHT;
			super(xCoord, yCoord);
			start = new Point(xCoord, yCoord);
			type = Global.SOLID_TYPE;
			
			gravity_ = 0.4;
			speed_.y = -JUMP * 2;
			maxSpeed_ = new Point(4, 8);
			friction_ = new Point(0.5, 0.5);
			
			sprite.add("stand", [0, 1], 6, true);
			sprite.add("idle", [0, 1], 6, true);
			sprite.add("walk", [4, 5, 6, 7], 10, true);
			sprite.add("jump", [1], 0, false);
			sprite.play("stand");
			sprite.color = 0x707070;
			
			this.setHitbox(25, 25, 0, -4);
			graphic = sprite;
		}
		
		
		override public function update():void 
		{
			// Check if the player either wants to spawn or destroy a shadow
			if (Input.pressed(Global.keySpace))
			{
				this.removeShadow();	
			}
			
			if (ending_)
			{
				direction_ = false;
			}
			else if (sprite.alpha < 1) 
			{ 
				sprite.alpha += 0.1 
			}
			
			onGround_ = false;
			if (collide(Global.SOLID_TYPE, x, y + 1) || Global.onMovingPlatform || collide(Global.PLAYER_TYPE, x, y + 1)) 
			{ 
				onGround_ = true;
			}
			
			if (onGround_ && ending_)
			{	
				Global.gameMusic.stop();
				var question:Text = new Text("?", Global.player.x + 9, Global.player.y - 32, {size:22, color:0xFFFFFF, 
					font:"Rumpel", outlineColor:0x000000, outlineStrength:2});
				FP.world.addGraphic(question);
				
				Transition.to(EndWorld, 
					new StarIn({duration:2, track:Global.PLAYER_TYPE}), 
					new StarOut());
			}
			
			acceleration_.x = 0;
			if (Input.check(Global.keyA) && speed_.x > -maxSpeed_.x) 
			{ 
				acceleration_.x = -movement; 
				direction_ = false; 
			}
			
			if (Input.check(Global.keyD) && speed_.x < maxSpeed_.x) 
			{ 
				acceleration_.x = movement; 
				direction_ = true; 
			}
			
			if ( (!Input.check(Global.keyA) && !Input.check(Global.keyD)) || Math.abs(speed_.x) > maxSpeed_.x) 
			{ 
				friction(true, false); 
			}
			
			if (Input.pressed(Global.keyW)) 
			{
				var jumped:Boolean = false;
				
				if (onGround_ && Global.level < Global.NUM_LEVELS) 
				{ 
					speed_.y = -JUMP; 
					jumped = true;
					
					world.add(new Particle(x, y + 30, .5, .5, .1, 0xFFFFFF));
					world.add(new Particle(x + 5, y + 28 + 5, .5, .5, .1, 0xFFFFFF));
					world.add(new Particle(x - 5, y + 25 - 5, .5, .5, .1, 0xFFFFFF));
					
					jumpSnd_.play(Global.soundVolume, 0);
				}
			}
			
			gravity();
			maxspeed(false, true);
			
			if (speed_.y < 0 && !Input.check(Global.keyW))
			{ 
				gravity(); 
				gravity(); 
			}        
			
			if (onGround_)
			{
				if (speed_.x < 0 || speed_.x > 0) 
				{ 
					sprite.play("walk"); 
				}
				
				if (speed_.x == 0) 
				{
					sprite.play("stand"); 
				}
			}
			else 
			{ 
				sprite.play("jump"); 
			}
			
			motion();
			if (this.y >= Global.levelHeight)
			{
				FP.world.remove(this);
			}
			
			if (!direction_)
			{
				sprite.flipped = true;
			}
			else
			{
				sprite.flipped = false;
			}
			
			if (Global.level == Global.NUM_LEVELS)
			{
				if (this.x >= ENDING_X)
				{
					ending_ = true;
				}
			}
		}	
		
		
		public function removeShadow():void
		{	
			world.add(new Particle(x, y + 30, .5, .5, .1, 0x707070));
			world.add(new Particle(x + 5, y + 28 + 5, .5, .5, .1, 0x707070));
			world.add(new Particle(x - 5, y + 25 - 5, .5, .5, .1, 0x707070));
			
			Global.haveShadow = false;
			FP.world.remove(this);
		}
	}
}
