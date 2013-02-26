package com.shadow
{	
	import Playtomic.*;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Quad;
	import com.greensock.plugins.TransformMatrixPlugin;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	
	[SWF(width='640', height='480', scale='exactfit')]
	
	
	/**
	 *
	 * @author Eric Bernier <http://www.ericbernier.com>
	 * Based on the preloader by Draknet on the flashpunk.net forums
	 */
	public class SawMyShadow extends Sprite
	{
		private static const mainClassName: String = "com.shadow.Main";
		
		private static const WIDTH:uint = 640;
		private static const HEIGHT:uint = 480;
		
		private static const BG_COLOR:uint = 0x000000;
		private static const PB_COLOR:uint = 0xF7EAE8;
		private static const FG_COLOR:uint = 0xFFFFFF;
		private static const TXT_COLOR:uint = 0xCCCCCC;
		
		private static const PROGRESS_BAR_WIDTH:uint = 367;
		private static const PROGRESS_BAR_HEIGHT:uint = 17;
		private static const PROG_BAR_X:uint = 134;
		
		[Embed(source = 'assets/fonts/Rumpelstiltskin.ttf', embedAsCFF="false", fontFamily = 'Rumpel')]
		private static const FONT:Class;
		
		[Embed("assets/graphics/preloaderBg.png")] private var bgPattern:Class;
		private var bgImg_:Bitmap = new bgPattern;
		[Embed("assets/graphics/titleLogo.png")] private var logo:Class;
		private var logo_:Bitmap = new logo;	
		
		[Embed("assets/graphics/ebLogo.png")] private var ebLogo:Class;
		private var ebLogo_:Bitmap = new ebLogo;
		private var ebClip_:MovieClip = new MovieClip();
		
		[Embed("assets/graphics/oneGame.png")] private var oneGameLogo:Class;
		private var oneGameLogo_:Bitmap = new oneGameLogo;
		private var oneGameClip_:MovieClip = new MovieClip();
		
		[Embed("assets/graphics/playButton.png")] private var playBtn:Class;
		private var playBtn_:Bitmap = new playBtn;
		[Embed("assets/graphics/playButtonHover.png")] private var playBtnHover:Class;
		private var playBtnHover_:Bitmap = new playBtnHover;
		private var playBtnClip_:MovieClip = new MovieClip();
		
		private var progressBar:Shape;
		private var progressBarBg:Shape;
		private var px:int;
		private var py:int;
		private var w:int
		private var h:int;
		private var sw:int;
		private var sh:int;
		private var loadingCounter:int;
		private var adsFinished_:Boolean = false;
		
		// Set this to true to enable Playtomic logging
		private var playtomic_:Boolean = true;
		
		private var SWFID:int = 982743;
		private var GUID:String = "9e28bc4a82fc4c90";
		private var API_Key:String = "907b2132c3ca454e84f3168214d875";
		
		private var mustClick_:Boolean = true;
		private var loadPreloader_:Boolean = true;
		private var linkAdded_:Boolean = false;
		private var playBtnLoaded_:Boolean = false;

				
		public function SawMyShadow()
		{	
			// Log the entry to PlayTomic
			// Log.View(PT_SWF_ID:int, PT_GUID:string, PT_API:string, root.loaderInfo.loaderURL);
			Log.View(SWFID, GUID, API_Key, root.loaderInfo.loaderURL);
			this.init();
		}
		
		
		private function init():void
		{	
			this.addChild(bgImg_);
			
			sw = stage.stageWidth;
			sh = stage.stageHeight;
			
			w = stage.stageWidth * 0.8;
			h = PROGRESS_BAR_HEIGHT;
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			this.addChild(logo_);
			logo_.x = 160;
			logo_.y = 125;
			TweenMax.from(logo_, 0.85, {y: -200, ease:Bounce.easeOut, delay:0, onComplete:null});		

			oneGameLogo_.scaleX = 0.65;
			oneGameLogo_.scaleY = 0.65;
			oneGameLogo_.x = 75;
			oneGameLogo_.y = 5;
			TweenMax.from(oneGameLogo_, 1.1, {y: -200, ease:Cubic.easeOut, delay:0, onComplete:setupButtons});
			
			oneGameClip_.addChild(oneGameLogo_);
			oneGameClip_.buttonMode = true;
			this.addChild(oneGameClip_);
			
			ebLogo_.x = 215;
			ebLogo_.y = 325;
			TweenMax.from(ebLogo_, 1.1, {y: 490, ease:Cubic.easeOut, delay:0, onComplete:null});
			
			ebClip_.addChild(ebLogo_);
			ebClip_.buttonMode = true;
			this.addChild(ebClip_);
						
			px = (sw - w) * 0.5;
			py = (sh - h) * 0.5 + 50;
			
			progressBarBg = new Shape();
			progressBarBg.graphics.beginFill(BG_COLOR);
			progressBarBg.graphics.drawRect(135, py - 3, 375, h + 6);
			progressBarBg.graphics.endFill();
			progressBarBg.alpha = 0.6;
			this.addChild(progressBarBg);
			TweenMax.from(progressBarBg, 0.35, {x: -300, ease:Quad.easeIn, delay:0, onComplete:null});	
			
			graphics.beginFill(0xF7EAE8);
			graphics.drawRect(px - 20, py - 2, w + 4, h + 4);
			graphics.endFill();
			progressBar = new Shape();
			addChild(progressBar);
			TweenMax.from(progressBar, 0.35, {x: -300, ease:Quad.easeIn, delay:0, onComplete:null});
		}
		
		
		public function onEnterFrame (e:Event):void
		{ 
			if (loadPreloader_)
			{
				if (hasLoaded())
				{
					progressBar.graphics.clear();
					progressBar.graphics.beginFill(PB_COLOR);
					
					progressBar.graphics.drawRect(PROG_BAR_X + 5, py, PROGRESS_BAR_WIDTH, h);
					progressBar.graphics.endFill();
					
					if (!playBtnLoaded_)
					{
						var bgX:int = progressBarBg.x;
						progressBarBg.x = 800;
						TweenMax.from(progressBarBg, 0.75, {x:173, ease:null, delay:0, onComplete:null});
						
						progressBar.x = 800;
						TweenMax.from(progressBar, 0.75, {x:175, ease:null, delay:0, onComplete:null});
						
						playBtn_.x = 270;
						playBtn_.y = 205;
						playBtnHover_.x = 270;
						playBtnHover_.y = 205;
						TweenMax.from(playBtn_, 0.75, {x: -215, ease:Back.easeOut, delay:0, onComplete:null});
						
						playBtnClip_.addChild(playBtn_);
						playBtnClip_.buttonMode = true;
						playBtnClip_.addEventListener(MouseEvent.CLICK, onMouseClick);
						playBtnClip_.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
						playBtnClip_.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
						playBtnClip_.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
						playBtnClip_.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
						this.addChild(playBtnClip_);
						
						playBtnLoaded_ = true;
					}
				} 
				else 
				{					
					var p:Number = (loaderInfo.bytesLoaded / loaderInfo.bytesTotal);
					
					progressBar.graphics.clear();
					progressBar.graphics.beginFill(PB_COLOR);
					
					progressBar.graphics.drawRect(PROG_BAR_X + 5, py, p * PROGRESS_BAR_WIDTH, h);
					progressBar.graphics.endFill();
				}       
			}
		}
		
		
		private function hasLoaded ():Boolean 
		{
			return (loaderInfo.bytesLoaded >= loaderInfo.bytesTotal);
		}
		
		
		private function onMouseClick(e:MouseEvent):void 
		{			
			if (hasLoaded())
			{
				playGame();
			}
		}
		
		
		private function onMouseDown(e:MouseEvent):void
		{
			playBtnClip_.removeChildren(0);
			playBtnClip_.addChild(playBtn_);
		}
		
		
		private function onMouseUp(e:MouseEvent):void
		{
			playBtnClip_.removeChildren(0);
			playBtnClip_.addChild(playBtn_);
		}
		
		
		private function onMouseOver(e:MouseEvent):void
		{
			playBtnClip_.removeChildren(0);
			playBtnClip_.addChild(playBtnHover_);
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			playBtnClip_.removeChildren(0);
			playBtnClip_.addChild(playBtn_);
		}
		
		private function playGame (): void 
		{	
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			var mainClass:Class = getDefinitionByName(mainClassName) as Class;
			parent.addChild(new mainClass as DisplayObject);
			
			parent.removeChild(this);
		}
		

		private function goToOneGameAMonthSite(e:MouseEvent):void
		{
			var url:String = new String("http://www.onegameamonth.com");
			navigateToURL(new URLRequest(url));
		}
		
		
		private function goToMySite(e:MouseEvent):void
		{
			var url:String = new String("http://www.twitter.com/ericmbernier");
			navigateToURL(new URLRequest(url));
		}
		
		
		private function setupButtons():void
		{
			ebClip_.addChild(ebLogo_);
			oneGameClip_.addChild(oneGameLogo_);
			
			ebClip_.addEventListener(MouseEvent.CLICK, goToMySite);
			oneGameClip_.addEventListener(MouseEvent.CLICK, goToOneGameAMonthSite);
			
			this.addChild(ebClip_);
			this.addChild(oneGameClip_);
		}
	}
}
