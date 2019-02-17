package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class CatchScene extends Cut
	{
		private var intosky:Scenary;
		public function CatchScene()
		{
			super();
			
		}
		
		override public function EnterScene():void
		{
			//hntGrp = Main.liveCamera.addNewAnimatedScenary(13413.837937516404,1218.1001159051607,-20,Assets.getAtlas("testing").getTextures("hornetsreceedingtutScene"))
			//Director.scenary.push({name:"hornetsreceedingtutScene"})
			MainSceneMotor.autoVP = true;
			//hntGrp = Main.liveCamera.addNewAnimatedScenary(13413.837937516404,1218.1001159051607,-20,Assets.getAtlas("testing").getTextures("hornetReceeding"))
			
			
			
			hero = Main.liveCamera.hero_mc
		}
		
		// i dont know why this is called catch scene
		override protected function UpdateScene(actor:GeneralActor=null):void{
			
			if(allLoaded()){
				intosky = getscenary("sky1");
				Main.liveCamera.scenary[0].scaleZ = 13
				intosky.x = -Main.liveCamera.x//+intoSkyX
				intosky.y = -Main.liveCamera.y//+intoSkyY
				intosky.scaleX =5;
				intosky.scaleY =5;
				
				if(hero.Z > 5806 && hero.key.Y !=0){
					director.nextScene()
				}
				Main.liveCamera.scenary[0].Y -= 20
			}
			//hero.key.X = 1;
			hero.body.velocity.x+=6
				
		}
	}
}
/*
so I had this thought, being good or having a strong sense of moral duty, is probably the most selfish thing you can do. and here's my thinking, so first
this gets pretty messy really quickly If Im not clear, so when I say good, I'll say its putting the needs of the group that your a part of, ahead 
of your own self interest, and when I say selfish its what benefits you the most, so first I have to address the the distinction of why being good only applies
yo your own group, its difficult to distinguish groups because our framing cah naturally changes when we discuss other groups 
say the is intellectaul freedom, the two parts of Kants ideas are two halfs of 
the same puzzle, the smaller bit the moral Imperative speaking about, they both talk about what will benefit you as a human being the most, and as such being
morality theres this Idea, well I was thinking about morality, kant, and thinking about an Idea

and very abrievated two of Kants driving ideas where driven by the decline of religion, while they 
were in an age of enlightment, which Kant would say actually we are in an age of becoming enlightened, well Kant was like well the rise of reason in the face of religion
is all well and good and all but we shouldnt lose the lessons of morality that religion 
*/