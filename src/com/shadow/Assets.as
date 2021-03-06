package com.shadow 
{
	/**
	 * 
	 * @author Eric Bernier <http://www.ericbernier.com>
	 */
	public class Assets
	{	
		// Embed the levels
		[Embed(source = '../assets/levels/Level1.oel',  mimeType = "application/octet-stream")] public static const LEVEL1:Class;
		[Embed(source = '../assets/levels/Level2.oel',  mimeType = "application/octet-stream")] public static const LEVEL2:Class;
		[Embed(source = '../assets/levels/Level3.oel',  mimeType = "application/octet-stream")] public static const LEVEL3:Class;
		[Embed(source = '../assets/levels/Level4.oel',  mimeType = "application/octet-stream")] public static const LEVEL4:Class;
		[Embed(source = '../assets/levels/Level5.oel',  mimeType = "application/octet-stream")] public static const LEVEL5:Class;
		[Embed(source = '../assets/levels/Level6.oel',  mimeType = "application/octet-stream")] public static const LEVEL6:Class;
		[Embed(source = '../assets/levels/Level7.oel',  mimeType = "application/octet-stream")] public static const LEVEL7:Class;
		[Embed(source = '../assets/levels/Level8.oel',  mimeType = "application/octet-stream")] public static const LEVEL8:Class;
		[Embed(source = '../assets/levels/Level9.oel',  mimeType = "application/octet-stream")] public static const LEVEL9:Class;
		
		public static const LEVELS:Array = new Array(LEVEL1, LEVEL2, LEVEL3, LEVEL4, LEVEL5,
				LEVEL6, LEVEL7, LEVEL8, LEVEL9);
		
		// TitleWorld art and logos
		[Embed(source = '../assets/graphics/ebLogo.png')] public static const EB_LOGO:Class;
		[Embed(source = '../assets/graphics/titleBg.png')] public static const TITLE_BG:Class;
		[Embed(source = '../assets/graphics/titleLogo.png')] public static const TITLE_LOGO:Class;
		[Embed(source = '../assets/graphics/credits.png')] public static const TITLE_CREDITS_BG:Class;
		[Embed(source = '../assets/graphics/buffer.png')] public static const TITLE_BUFFER:Class;
		[Embed(source = '../assets/graphics/titleGroundhog.png')] public static const TITLE_GROUNDHOG:Class;
		
		// Ending
		[Embed(source = '../assets/graphics/endingScreen.png')] public static const END_SCREEN:Class;
		
		// Tilesets
		[Embed(source = '../assets/graphics/tileset.png')] public static const TILESET:Class;
		[Embed(source = '../assets/graphics/slope1.png')] public static const TILESET_SLOPE_1:Class;
		[Embed(source = '../assets/graphics/slope2.png')] public static const TILESET_SLOPE_2:Class;
		[Embed(source = '../assets/graphics/slope3.png')] public static const TILESET_SLOPE_3:Class;
		[Embed(source = '../assets/graphics/slope4.png')] public static const TILESET_SLOPE_4:Class;	
		
		// Gameworld graphics
		[Embed(source = '../assets/graphics/mute.png')] public static const MUTE_BTN:Class;
		[Embed(source = '../assets/graphics/unmute.png')] public static const UNMUTE_BTN:Class;
		[Embed(source = '../assets/graphics/skyGrad.png')] public static const SKY_BG:Class;
		[Embed(source = '../assets/graphics/tvScan.png')] public static const TV_SCAN:Class;
		[Embed(source = '../assets/graphics/sign.png')] public static const DIR_SIGN:Class;
		[Embed(source = '../assets/graphics/dirBg.png')] public static const DIR_BG:Class;
		[Embed(source = '../assets/graphics/tree.png')] public static const TREE:Class;
		
		// Platforms and Objects     
		[Embed(source = '../assets/graphics/crate.png')] public static const OBJECT_CRATE:Class;
		[Embed(source = '../assets/graphics/door.png')] public static const OBJECT_DOOR:Class;
		
		// Collectables
		[Embed(source = '../assets/graphics/flower.png')] public static const FLOWER:Class;
		
		// Player
		[Embed(source = '../assets/graphics/groundhogSprite.png')] public static const GROUNDHOG:Class;
		
		// Music
		[Embed(source = '../assets/music/HappyWalk.mp3')] public static const MUS_MENU:Class;
		[Embed(source = '../assets/music/CrocoRocket.mp3')] public static const MUS_GAME:Class;
		[Embed(source = '../assets/music/ChoroBavario.mp3')] public static const MUS_ENDING:Class;
		
		// Sound
		[Embed(source = '../assets/sound/buttonSelect.mp3')] public static const SND_BUTTON_BACK:Class;
		[Embed(source = '../assets/sound/buttonHover.mp3')] public static const SND_BUTTON_HOVER:Class;
		[Embed(source = '../assets/sound/buttonSelect.mp3')] public static const SND_BUTTON_SELECT:Class;
		[Embed(source = '../assets/sound/death.mp3')] public static const SND_DEATH:Class;
		[Embed(source = '../assets/sound/door.mp3')] public static const SND_DOOR:Class;
		[Embed(source = '../assets/sound/flower.mp3')] public static const SND_FLOWER:Class;
		[Embed(source = '../assets/sound/buttonHover.mp3')] public static const SND_JUMP:Class;
		[Embed(source = '../assets/sound/buttonSelect.mp3')] public static const SND_SHADOW:Class;
	}
}