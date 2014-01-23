package com.shadow.entities 
{
	import com.shadow.Assets;
	import com.shadow.Global;
	import com.shadow.worlds.GameWorld;
	
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;


	public class Door extends Entity
	{
		private var sprite_:Image = new Image(Assets.OBJECT_DOOR, new Rectangle(0, 0, 32, 64));
		private var spriteHover_:Image = new Image(Assets.OBJECT_DOOR, new Rectangle(32, 0, 32, 64));
		
		private var locked_:Boolean = false;
		
		private var doorSnd_:Sfx = new Sfx(Assets.SND_DOOR);
		
		
		public function Door(x:int, y:int, locked:Boolean) 
		{
			super(x, y - 30);
			
			locked_ = locked;
			
			if (locked_)
			{
				sprite_ =  new Image(Assets.OBJECT_DOOR, new Rectangle(64, 0, 32, 64));
			    spriteHover_= new Image(Assets.OBJECT_DOOR, new Rectangle(96, 0, 32, 64));	
			}
			
			graphic = sprite_;
			setHitbox(32, 32, 0, -32);
		}
		
		
		override public function update():void
		{
			graphic = sprite_;
			
			if (collideWith(Global.player, x, y)) 
			{
				graphic = spriteHover_;
				
				// Note the use of collideWith (above). This is faster than using collde("type")
				if (!locked_)
				{					
					if (Input.pressed(Global.keyDown) || Input.pressed(Global.keyS))
					{
						doorSnd_.play(Global.soundVolume);
						
						Global.finished = true;
					}
				}
			}
		}
		
		
		public function unlockDoor():void
		{
			locked_ = false;
			
			sprite_ = new Image(Assets.OBJECT_DOOR, new Rectangle(0, 0, 32, 64));
			spriteHover_ = new Image(Assets.OBJECT_DOOR, new Rectangle(32, 0, 32, 64));
		}
	}
}
