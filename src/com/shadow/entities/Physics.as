package com.shadow.entities
{
	import com.shadow.Global;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	
	/**
	 * 
	 * @author Eric Bernier
	 */
	public class Physics extends Entity
	{      
		public var speed_:Point = new Point(0, 0);			
		public var acceleration_:Point = new Point(0, 0);	
		
		public var gravity_:Number = 0.2;
		public var friction_:Point = new Point(0.5, 0.5);
		public var slopeHeight_:int = 1;
		public var maxSpeed_:Point = new Point(3, 8);
		public var enemy_:Boolean = false;
		
		public function Physics(x:int = 0, y:int = 0) 
		{
			super(x, y);
			type = Global.SOLID_TYPE;
		}
		
		
		override public function update():void 
		{
			motion();
			gravity();
		}
		
		
		/**
		 * Moves this entity at it's current speed_(speed_.x, speed_.y) and increases speed_based on 
		 * acceleration (acceleration.x, acceleration.y)
		 * @param	mx		Include horizontal movement
		 * @param	my		Include vertical movement
		 * @return	void
		 */
		public function motion(mx:Boolean = true, my:Boolean = true):void 
		{	
			if (mx)
			{
				if (!motionx(this, speed_.x)) 
				{ 
					speed_.x = 0; 
				}
				
				speed_.x += acceleration_.x;
			}
			
			if (my)
			{
				if (!motiony(this, speed_.y)) 
				{ 
					speed_.y = 0; 
				}
				
				speed_.y += acceleration_.y;
			}			
		}
		
		
		/**
		 * Increases this entities speed, based on its gravity (mGravity)
		 * @return	Void
		 */
		public function gravity():void 
		{
			speed_.y += gravity_;
		}
		
		
		/**
		 * Slows this entity down, according to its friction (mFriction.x, mFriction.y)
		 * @param	mx		Include horizontal movement
		 * @param	my		Include vertical movement
		 * @return	void
		 */
		public function friction(x:Boolean = true, y:Boolean = true):void 
		{
			if (x)
			{
				if (speed_.x > 0)
				{
					speed_.x -= friction_.x;
					if (speed_.x < 0) 
					{ 
						speed_.x = 0; 
					}
				}
				
				if (speed_.x < 0)
				{
					speed_.x += friction_.x;
					
					if (speed_.x > 0) 
					{ 
						speed_.x = 0; 
					}
				}
			}
		}
		
		
		/**
		 * Stops entity from moving to fast, according to maxspeed_(mMaxspeed_.x, mMaxspeed_.y)
		 * @param	mx		Include horizontal movement
		 * @param	my		Include vertical movement
		 * @return	void
		 */
		public function maxspeed(x:Boolean = true, y:Boolean = true):void
		{
			if (x) 
			{
				if (Math.abs(speed_.x) > maxSpeed_.x)
				{
					speed_.x = maxSpeed_.x * FP.sign(speed_.x);
				}
			}
			
			if (y) 
			{
				if (Math.abs(speed_.y) > maxSpeed_.y)
				{
					speed_.y = maxSpeed_.y * FP.sign(speed_.y);
				}
			}
		}
		
		
		/**
		 * Moves the set entity horizontal at a given speed, checking for collisions and slopes
		 * @param	e		The entity you want to move
		 * @param	spdx	The speed_at which the entity should move
		 * @return	True (didn't hit a solid) or false (hit a solid)
		 */
		public function motionx(e:Entity, spdx:Number):Boolean
		{
			for (var i:int = 0; i < Math.abs(spdx); i ++) 
			{
				var moved:Boolean = false;
				var below:Boolean = true;
				
				if (!e.collide(Global.SOLID_TYPE, e.x, e.y + 1)) 
				{ 
					below = false; 
				}
				
				for (var s:int = 0; s <= slopeHeight_; s ++)
				{
					if (!e.collide(Global.SOLID_TYPE, e.x + FP.sign(spdx), e.y - s)) 
					{
						if (!e.collide(Global.PLAYER_TYPE, e.x + FP.sign(spdx), e.y - s) || enemy_) 
						{ 
							e.x += FP.sign(spdx);
						}
						
						e.y -= s;
						moved = true;
						
						break;
					}
				}
				
				if (below && !e.collide(Global.SOLID_TYPE,e.x, e.y + 1)) 
				{ 
					e.y += 1; 
				}
				
				if (!moved) 
				{ 
					return false; 
				}
			}
			
			return true;
		}
		
		
		/**
		 * Moves the set entity vertical at a given speed, checking for collisions
		 * @param	e		The entity you want to move
		 * @param	spdy	The speed at which the entity should move
		 * @return	True (didn't hit a solid) or false (hit a solid)
		 */
		public function motiony(e:Entity, spdy:Number):Boolean
		{
			for (var i:int = 0; i < Math.abs(spdy); i ++)
			{
				if (!e.collide(Global.SOLID_TYPE, e.x, e.y + FP.sign(spdy))) 
				{ 
					if (!e.collide(Global.PLAYER_TYPE, e.x, e.y + FP.sign(spdy))) 
					{ 
						e.y += FP.sign(spdy); 
					}
				} 
				else 
				{ 
					return false; 
				}
			}
			
			return true;
		}
		
		
		/**
		 * Moves an entity of the given type that is on top of this entity (if any). 
		 * Also moves player if it's on top of the entity on top of this one.
		 * Mostly used for moving platforms
		 * @param	type	Entity type to check for
		 * @param	speed	The speep at which to move the thing above you
		 * @return	void
		 */
		public function moveontop(type:String, speed:Number):void
		{
			var e:Entity = collide(type, x, y - 1) as Entity;
			if (e) 
			{
				motionx(e, speed);
				
				var p:Physics = e as Physics;
				if(p != null) 
				{ 
					p.moveontop(Global.PLAYER_TYPE, speed); 
				}
			}
		}
		
		
		/**
		 * Moves an entity of the given type that is on top of this entity (if any). 
		 * Also moves player if it's on top of the entity on top of this one.
		 * Mostly used for moving platforms
		 * @param	type	Entity type to check for
		 * @param	speed	The speep at which to move the thing above you
		 * @return	void
		 */
		public function moveUpOnTop(type:String, speed:Number):void
		{
			var e:Entity = collide(type, x, y - 1) as Entity;
			if (e) 
			{
				motiony(e, speed);
				
				var p:Physics = e as Physics;
				if(p != null) 
				{ 
					p.moveUpOnTop(Global.PLAYER_TYPE, speed); 
				}
			}
		}
	}
}
