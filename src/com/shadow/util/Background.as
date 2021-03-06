package com.shadow.util
{
	import com.greensock.TweenMax;
	
	import com.shadow.Assets;
	import com.shadow.Global;
	
	import net.flashpunk.graphics.Backdrop;

	
	public class Background extends Backdrop
	{
		public function Background(type:uint = 0)
		{	
			var bg:Class = Assets.SKY_BG;
			
			if (type == Global.TV_SCAN)
			{
				bg = Assets.TV_SCAN;
			}
			
			super(bg, true, true);
		}
		
		
		override public function update():void
		{	
			super.update();
		}
	}
}