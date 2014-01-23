package com.shadow.worlds
{	
	import com.shadow.Global;
	
	import flash.display.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	
	import punk.transition.Transition;
	import punk.transition.effects.*;
	
	
	/**
	 * 
	 * @author Eric Bernier 
	 */
	public class TransitionWorld extends World
	{		
		private var screen_:Image;
		private var display_:Entity;
		
		// What world to transition to and the boolean that ensures we only make one transition call
		private var goto_:Class;
		private var transitioned_:Boolean = false;	
		
		private var transitionType_:uint;
		
		public function TransitionWorld(goto:Class, screen:Image=null, transitionType:uint = 0) 
		{
			// Set the screen to what was last being displayed
			screen_ = screen;
			
			display_ = new Entity(0, 0, screen_);
			this.add(display_);
			
			goto_ = goto;
			transitionType_ = transitionType;
		}
		
		
		override public function update():void
		{
			if (!transitioned_)
			{
				switch (transitionType_)
				{
					case Global.TRANSITION_FLIP_SCREEN:
					{
						Transition.to(goto_, 
							new FlipOut({duration:0.75}), 
							new FlipIn({duration:0.75}));
						break;
					}
					case Global.TRANSITION_CIRCLE:
					{
						Transition.to(goto_, 
							new CircleIn({duration:1}), 
							new CircleOut({duration:0.5}));
						break;
					}
					case Global.TRANSITION_STAR:
					{
						Transition.to(goto_, 
							new StarIn({duration:1}), 
							new StarOut({duration:0.5}));
						break;
					}
					case Global.TRANSITION_FADE:
					{
						Transition.to(goto_,
							new FadeIn({duration:1}),
							new FadeOut({duration:0.5}));
						break;
					}						
				}
				
				transitioned_ = true;
			}
			
			super.update();
		}
	}
}
