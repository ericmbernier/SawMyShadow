package com.shadow.entities
{
	import com.shadow.Assets;
	
	import flash.display.Graphics;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	
	public class Directions extends Entity
	{
		private const WIDTH:uint = 500;
		private var dirBg_:Image = new Image(Assets.DIR_BG);
		private var dirText_:Text;
		private var gfx_:Graphiclist;
		
		
		public function Directions(xCoord:int, yCoord:int, directions:String)
		{	
			x = xCoord;
			y = yCoord;
			
			dirText_ = new Text(directions, x - 35, y, {size:20, color:0x000000, font:"Rumpel", wordWrap:true, width:WIDTH});
			
			gfx_ = new Graphiclist(dirBg_, dirText_);
			
			this.graphic = gfx_;
			layer = -9999;
		}
	}
}