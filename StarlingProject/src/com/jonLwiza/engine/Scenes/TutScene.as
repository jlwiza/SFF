package com.jonLwiza.engine.Scenes 
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Path;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	public class TutScene extends Cut
	{
		private static var hntGrp:AnimatedScenary;
		private var origPos:Number;
		private var someVal:Number;
		private var moveVal:Number;
		private var hrnetPath:Path;
		private var ticker:int;
		private var checkSet:Boolean;
		private var loopStart:Number;
		protected var hornetsFlyAway:AnimatedScenary = new AnimatedScenary()
		public function TutScene()
		{
			super();
		}
		
		override public function EnterCut():void
		{
		
			hornetsFlyAway = Main.liveCamera.addNewAnimatedScenary(-4457,1148,-281,Assets.getAtlas("BeachScntxtr1").getTextures("brknMess"),"wood")
			throw Error("sfdjh")
			
		}
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			trace(linkedCamPos.X)
			if(checkSet){
				ticker+=10
				hrnetPath.placement(ticker)
			}
			
			if(Main.liveCamera.hero_mc.body.position.x >= loopStart){
				if(!checkSet){
					hornetsFlyAway.movie.play()
					ticker = 0
					checkSet = true
				}
				
				// this is how you pass by value and not just a reference to ther original
				// I dunno how smart it is to do but uh yeah
				hrnetPath.ptsArray  =	Assets.clone([{X:0,Y:0,Z:0,D:0},{X:hero.X,Y:hero.Y-100,Z:hero.Z,D:0 },{X:hero.X,Y:hero.Y-300,Z:hero.Z,D:0}])
			}
			
		}
	//		MainSceneMotor.vpX = Main.liveCamera.pos.X
//			MainSceneMotor.vpY = Main.liveCamera.pos.Y-200
//				
//			
//			if(allLoaded()){
//				someVal = 5806
//				if(hero.Z > someVal){
//				moveVal = hero.Z - someVal
//				getscenary("scnetut1").X = origPos - moveVal*1.5
//				}
////			hntGrp.X = hero.X
////			hntGrp.Y = hero.Y
////			hntGrp.Z = hero.Z+500
//				for (var i:int = 0; i < Main.liveCamera.scenary.length-1; i++) 
//				{
//					Main.liveCamera.scenary[i].scaleZ = 13
//				}
//				Main.liveCamera.scenary[i].scaleZ = 13*3
//			}
//		}
	}
}