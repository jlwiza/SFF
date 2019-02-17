package com.jonLwiza.engine.actors
{
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.baseConstructs.GeneralAnimation;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	//okay this is important so im going to try to type this clearly
	// the plan was i will change it back and set its body to off
	// or whatever it wont be that bad, then on the release
	// if i need to squeeze out every little bit i put them to real
	//animated scenaries so they have smaller overheads, i dont think
	// itll change much but there it is
	public class AnimatedScenary extends Scenary
	{

		public var movie:MovieClip;
		public var texts:Vector.<Texture>;
		
		public function AnimatedScenary()
		{
			super();
		}
		
		override protected function createArtAsset():void
		{
			// since were dealing with some sort of actor we know it has behaviours and probably animation so we default on its creation by puting a default animation on to the thing which is "blink"
			// its possible to pu this in the animation handler then when you actually have the resource overide the art asset creation, but if I put this here it forces something made using scenary archetect to be put in after and not 
			// im not sure but i think this is a dynamic atlas loader 
			//34072  61081
			movie =  new MovieClip(texts, 24);
			movie.x = 0;
			movie.y = 0;
			Starling.juggler.add(movie);
			addChild(movie);
			movie.play()
			movie.alignPivot()
		}
		
		public function switchMovie(newMov:String, atlas:String = "testing", loop:Boolean = true):void
		{
			
			movie.stop()
			removeChild(movie,true);
			starling.core.Starling.juggler.remove(movie);
			movie = new MovieClip(Assets.getAtlas(atlas).getTextures(newMov+"0"), 24);
			addChild(movie);
			movie.play()
			movie.loop = loop
				
		}
		
		
	}
}