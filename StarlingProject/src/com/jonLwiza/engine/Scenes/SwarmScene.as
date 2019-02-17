package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.BigBaddie;
	import com.jonLwiza.engine.actors.Cars;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;

	public class SwarmScene extends Cut
	{
		private var tick:uint;
		private var count:uint;
		private var circleStart:Number;
		private var circleFinish:Number;
		private var falling:Boolean = false;
		private var intoSkyX:Number = 0;
		private var intoSkyY:Number = 0;
		private var hornetBG:Scenary;
		private var intosky:Scenary;
		private var hornetBGX:Number = 0;
		private var hornetBGY:Number = 0;
		private var hornetSpn:AnimatedScenary;
		private var oldswarmpart:int;
		private var swarmpart:int;
		private var entered:Boolean;
		private var oldAngle:Number = Math.PI/2;

		private var skybg:Scenary;
		private var cntdwn:int;
		private var loopcnt:int = 0;
		private var kills:uint;

		
		public function SwarmScene()
		{
			
		}
		
		override public function EnterCut():void
		{// just track the camera for now
			hero = Main.liveCamera.hero_mc
			///MainSceneMotor.autoVP = false;
			//Main.autoCam = false
			
			LevelEditor.isFollowPath = false;
			circleStart = 41922;
			
			circleFinish = circleStart +3000
			swarmpart = 0
			var FinalHornet:Cars = Cars(Main.liveCamera.addNewBaddie(43305,1100,0,[],"Cars"))

			kills = Hornet.killcount
				
		}
		
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			
			if(kills != Hornet.killcount)
				count--
					
			tick++
			if(hero.body.position.x > circleFinish)
			{
				loopcnt++
				// for now we can make my life easy and kill the easing for this scene, to see if this illusion is possible
				hero.body.position.x = circleStart - 400
				for (var i:int = 0; i < Main.liveCamera.baddies.length; i++) 
				{
					Main.liveCamera.baddies[i].body.position.x -=  circleFinish - circleStart
						
				}
			}
//			if(allLoaded() && false){
//				
//				intosky = getscenary("sky");
//				skybg = getscenary("skybg");
//				hornetBG = getscenary("hornetBG");
//				intosky.updateZdepth = false
//				
//				intosky.x = -Main.liveCamera.x//+intoSkyX
//				intosky.y = -Main.liveCamera.y//+intoSkyY
//				intosky.scaleX =1;
//				intosky.scaleY =1;
//				
//				skybg.x = -Main.liveCamera.x//+intoSkyX
//				skybg.y = -Main.liveCamera.y//+intoSkyY
//				skybg.scaleX =5;
//				skybg.scaleY =5;
//				
//				hornetBG.x = -Main.liveCamera.x+hornetBGX
//				hornetBG.y = -Main.liveCamera.y+hornetBGY
//				hornetBG.scaleX =1;
//				hornetBG.scaleY =1;
//				
//				
//				var cos:Number = Math.cos(Main.liveCamera.rotationY - oldAngle)
//				////trace("joiuy ",Main.liveCamera.rotationY - oldAngle)
//				var sin:Number = Math.sin(Main.liveCamera.rotationY - oldAngle)
//				for (var i:int = 0; i < MainSceneMotor.floor.ptsArray.length; i++) 
//				{
//					
//					var x1:Number = MainSceneMotor.floor.ptsArray[i].X - Main.liveCamera.pos.X;
//					var z1:Number = MainSceneMotor.floor.ptsArray[i].Z - Main.liveCamera.pos.Z;
//					var x2:Number = cos*x1 - sin*z1;
//					var z2:Number = cos*z1 + sin*x1;
//					MainSceneMotor.floor.ptsArray[i].X = Main.liveCamera.pos.X + x2;
//					MainSceneMotor.floor.ptsArray[i].Z = Main.liveCamera.pos.Z + z2;
//					
//				}
//				
//				
//				oldAngle = Main.liveCamera.rotationY 
//				//hornetSpn = AnimatedScenary(getscenary("hornetBG"));
//			}
			// this might be wrong if nape has diffent coordinate thing then i do but i doubt it
			//hero.body.velocity.x = 210
			
			if(hero.body.velocity.y > 210)
			{
				hero.body.velocity.y = 210
				falling = true;
			}else{
				falling = false
			}
			for (i = 0; i < Main.liveCamera.baddies.length; i++) 
			{
				var sdr:Number = Main.liveCamera.hero_mc.Y+ 300
				var hrnt:Hornet = Main.liveCamera.baddies[i]
					
					//hrnt.scaleX =    ((hrnt.Y - (Main.liveCamera.hero_mc.Y - 200))/600)*5 //% traveled from (Main.liveCamera.hero_mc.Y - 200) to (Main.liveCamera.hero_mc.Y + 300) * 5
					//hrnt.scaleZ =    ((hrnt.Y - (Main.liveCamera.hero_mc.Y - 200))/600)*5 //% traveled from (Main.liveCamera.hero_mc.Y - 200) to (Main.liveCamera.hero_mc.Y + 300) * 5
			}
			if(!falling){
			for (i=0; i < Main.liveCamera.baddies.length; i++) 
			{
				hrnt = Main.liveCamera.baddies[i]
				
				if(hrnt.body.position.x < hero.body.position.x - 1900 || hrnt.body.position.x > hero.body.position.x + 2400 || hrnt.body.position.y > hero.body.position.y + 200){
					hrnt.body.position.setxy(hero.body.position.x + randomRange(-1300,2400), hero.body.position.y  + randomRange(-200,10))
				}
			}
			}else{
				
				for (i = 0; i < Main.liveCamera.baddies.length; i++) 
				{
					 hrnt = Main.liveCamera.baddies[i]
					
					if(hrnt.body.position.x < hero.body.position.x - 100 || hrnt.body.position.y > hero.body.position.y + 100){
						hrnt.body.position.setxy(hero.body.position.x + randomRange(-300,300), hero.body.position.y  + randomRange(-10,-450))
					}
				}
			}
			
			if(hero.body.position.x > circleStart+ 800)
			{
				if(tick % 20 == 0 && count < 15){
					count++
				Main.liveCamera.addNewBaddie(hero.body.position.x + randomRange(-1300,600), hero.body.position.y  + randomRange(-200,20),0,[]);
//					hornetSpn.x = hero.x;
//					hornetSpn.y = hero.y
					//hornetSpn.movie.play()
				}
				
			}
			//if()hornet killed youknow then subtract count
		}
		
	
		
		private function fighting():void
		{
			// TODO Auto Generated method stub
			
		}		

		
	}
}