package com.shadow.entities
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	import com.shadow.Assets;
	
	import com.shadow.Global;
	import com.shadow.worlds.EndWorld;
	
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	import punk.transition.Transition;
	import punk.transition.effects.StarIn;
	import punk.transition.effects.StarOut;

		
	/**
	 *
	 * @author Eric Bernier <http://www.ericbernier.com>
	 */
	public class Flower extends Entity
	{			
        private const WIDTH:uint = 24;
        private const HEIGHT:uint = 24;
    
		private var image_:Image = new Image(Assets.FLOWER);			
		private var flowerSnd_:Sfx = new Sfx(Assets.SND_FLOWER);
	

		public function Flower(xCoord:int, yCoord:int)
		{	
			this.x = xCoord;
			this.y = yCoord;
			
			this.type = Global.FLOWER_TYPE;	

			this.graphic = image_;
			
			if (Global.level < Global.NUM_LEVELS)
			{
				TweenMax.to(image_, 0.3, {y: -5, repeat: -1, yoyo:true, ease:Quad.easeInOut});
			}
			
			this.setHitbox(WIDTH, HEIGHT);
		}
		

		public function collect():void
		{	
            Global.flowerVal += 1;
            
            world.add(new Particle(x, y, .5, .5, .1, 0xF3232D));
            world.add(new Particle(x + 5, y + 5, .5, .5, .1, 0xF3232D));
            world.add(new Particle(x - 5, y - 5, .5, .5, .1, 0xF3232D));
			
			flowerSnd_.play(Global.soundVolume);
			FP.world.remove(this);
		}
	}
}
