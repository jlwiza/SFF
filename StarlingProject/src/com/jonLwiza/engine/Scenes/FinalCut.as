package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Path;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.BaddieBoss;
	import com.jonLwiza.engine.actors.BigBaddie;
	import com.jonLwiza.engine.actors.Cars;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.baseConstructs.NPC;
	import com.jonLwiza.engine.helperTypes.Vector3;
	import com.jonLwiza.engine.state.sonicBehavior.Ground;
	
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	
	public class FinalCut extends Cut
	{
		private var groundheight:Number = 1707
		private var entered:Boolean;
		private var floorpts:Array;
		private var pdist:Number;
		
		private var bigB:BigBaddie;
		private var tick:int = 0;
		private var nulBot:Cars;
		private var launchTime:int = 200;
		
		//private var trgtpt:Object;
		private var launch:Boolean;
		private var speed:int = 21;
		private var radius:Number = 950;
		private var ang:Number;
		private var neg:int;
		private var bkgrnd:Scenary;
		private var bkgrnd2:Scenary;
		private var startX:Object;
		private var bgPos:Number;
		private var oldAngle:Number = Math.PI/2;
		private var delta:Number = 0;
		private var right:Boolean;
		private var completeAnims:Array = ["sonicwaiting"]
		private var anglebtwn:Number;
		private var segs:Number;
		private var parts:int = 8;
		private var start:Number;
		private var playit:Boolean;
		private var chip:Number = 0;
		private var lineCirclePlaying:Boolean = false;
		private var course:int = -1;
		
		private var smallWave:AnimatedScenary;
		private var splashWave:AnimatedScenary;
		private var bigsElbow:AnimatedScenary;
		private var bigsShoulder:AnimatedScenary;
		private var somedist:Number;
		private var onEm:Boolean =false;
		private var distToTail:Number;
		private var maAngle:Number;
		private var strngLnth:int;
		private var dis:int;
		private var joe:Boolean = false;
		private var outdn:int = 1;
		private var firstCheckpt:int;
		private var turningAngle:Number;
		private var Zanchor:Number = 9999999999999999999999999999999999999;
		private var waveHeight:Number;
		private var varb:Number;
		private var entrSplash:Boolean = true;
		private var keyCount:int;
		private var exitSplash:Boolean;
		private var timeTillBig:int;
		private var splashX:Number;

		private var barnicle:Number = 0;
		private var notcalled:Boolean = true;
		private var enteredFWave:Boolean = true;
		private var angle:Number = 0;
		private var vector:Vector3 = new Vector3();
		private var spd:Number = 20;
		private var bigBaddieAnchr:Vector3 = new Vector3();
		private var waveAnchor:Number;
		private var midY:Number;
		private var Ftick:int = 0
		private var tickStart:Boolean = false;

		private var finalBg:AnimatedScenary;
		private var finalBigB:AnimatedScenary;
		
		public function FinalCut()
		{
			super();
			frameRate = 30
		}
		
		override public function EnterScene():void
		{
			
			skyboxTextures.push("cliffScneScenary001","cliffScneScenary020","cliffScneScenary018","cliffScneScenary015","cliffScneScenary016","cliffScneScenary014")
			//			var appndge:Appendage= Appendage(Main.liveCamera.addNewBaddie(6282.914564796065, 1079.250048828125,0,[],"Appendage"));
			//			var appndge2:Appendage= Appendage(Main.liveCamera.addNewBaddie(6282.914564796065, 1079.250048828125,0,[],"Appendage"));
			//pi/2 
			
			Main.liveCamera.rotationY =  Math.PI/2
			//startX = Director.scenary[0].X
			//Main.autoCam = false;
			MainSceneMotor.autoVP = false
			hero = Main.liveCamera.hero_mc
			midY =hero.Z + 12; 
				// ill have to change the X but it should do well enough , just find the x y z for sonic and add some z to it
//			smallWave = Main.liveCamera.addNewAnimatedScenary(13413.837937516404,1218.1001159051607,-20,Assets.getAtlas("testin").getTextures("netCaught"))
//			Director.scenary.push({name:"smallWave"})
//			splashWave = Main.liveCamera.addNewAnimatedScenary(13413.837937516404,1218.1001159051607,-20,Assets.getAtlas("testin").getTextures("netCaught"))
//			Director.scenary.push({name:"splashWave"})
//			nulBot = Cars(Main.liveCamera.addNewBaddie(hero.body.position.x + 1500,hero.body.position.y,0,[],"Cars"))
//			Director.scenary.push({name:"word"})
//			smallWave.Y = hero.Y
			
			//var p:Vector3D =new Vector3D//Main.liveCamera.hero_mc.Unproject(vx,vy,vz)
			
			
			
			
			
			finalBg = AnimatedScenary(getscenary("splashBG"))//Main.liveCamera.addNewAnimatedScenary(p.x,p.y,p.z,Assets.getAtlas("FinalCutAtlas").getTextures("bgFinal"))//(p.x,p.y,p.z,"bgFinal","bgFinal",1,false,1))
			 finalBg.updateZdepth = false
			finalBg.x =438.10
			finalBg.y =276.35
			finalBg.scaleX = 1
			finalBg.scaleY = 1
			finalBg.movie.pause()
			finalBg.movie.currentFrame =0
				
			finalBigB = Main.liveCamera.addNewAnimatedScenary(13,30,42,Assets.getAtlas("FinalCutAtlas").getTextures("bigBFly"))//(p.x,p.y,p.z,"bgFinal","bgFinal",1,false,1))
			finalBigB.updateZdepth = false
			finalBigB.index = finalBigB.index+1
			finalBigB.x =0
			finalBigB.y =0
			finalBigB.scaleX = 1
			finalBigB.scaleY = 1
			finalBigB.movie.pause()
				//,finalBg.
			finalBigB.movie.currentFrame =0
				
			course = -1;
		}
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			hero.isGrounded = true;
			hero.body.angularVel= 200
			
			// its actually stupidly simple 
			vector.X = Math.cos(angle*Math.PI/180)*spd; 
			vector.Z = Math.sin(angle*Math.PI/180)*spd; 
			
//			if(angle < 0){
//				angle+=360
//			}
			bigBaddieAnchr.X = hero.X
			bigBaddieAnchr.Z = hero.Z + 300
				
			hero.X += vector.X 
			hero.Z += vector.Z 
			
			if(hero.key.Y == -1)
			{
				angle+=1
//			if(Math.abs(90 - angle) < 5){ 
//				angle +=(90 - angle)/5
//			}else{
//				
//				if(90 - angle >0)
//				angle +=1
//				else
//				angle -=1    
//				}
			}
			
			var tg:Number = 0
//			if(hero.key.X == 1)
//			{
//				if(Math.abs(tg - angle) < 5){ 
//					
//					angle +=(tg - angle)/5
//				}else{
//					
//					if(tg - angle >0)
//						angle +=1
//					else
//						angle -=1    
//				}
//			}
//			if(angle > 0)
//			tg = 180
//			else
//			tg = -180
//			if(hero.key.X == -1)
//			{
//				if(Math.abs(tg - angle) < 5){ 
//					
//					angle +=(tg - angle)/5
//				}else{
//					
//					if(tg - angle >0)
//						angle +=1
//					else
//						angle -=1    
//				}
//			}

			tg = -90
			if(hero.key.Y == 1)
			{
				angle -=1
//				if(Math.abs(tg - angle) < 5){ 
//					
//					angle +=1(tg - angle)/5
//				}else{
//					
//					if(tg - angle > 0)
//						angle +=1
//					else
//						angle -=1    
//				}
			}
				
			
			if(angle > 85 && !tickStart){
				tickStart = true
					
					course = 0
			}
			
			if(tickStart){
				tick++
			}
			
	
			switch(course){
				case 0:
				{
					
					if(entrSplash)
					{
						finalBg.movie.currentFrame = 1
						entrSplash = false
						
							// this could be all made a lot slicker and cooler.. but I dont really feel like it
							flashAnims["Bigb fly in test"] = {ticker:0,p:new Path()}
							flashAnims["Bigb fly in test"].p.lpair = [{val:0,path:0},{val:1,path:1},{val:2,path:2},{val:3,path:3},{val:4,path:4},{val:5,path:5},{val:6,path:6},{val:7,path:7},{val:8,path:8},{val:9,path:9}]
							flashAnims["Bigb fly in test"].p.ptsArray = [{X:-222.9,Y:220.75,Z:0},{X:312.95,Y:206.35,Z:0},{X:312.95,Y:206.35,Z:0},{X:312.95,Y:206.35,Z:0},{X:312.95,Y:206.35,Z:0},{X:352.65,Y:125.05,Z:0},{X:352.65,Y:125.05,Z:0},{X:352.65,Y:125.05,Z:0},{X:352.65,Y:125.05,Z:0},{X:370.1,Y:280.1,Z:0}] 
						
					}
					
					if(tick>200)
						course = 1
					trace(tick)
					
						flashAnims["Bigb fly in test"].ticker++ 
						//trace(flashAnims["Bigb fly in test"].ticker);
					
					
					
					
					//this was a hack so InAlter will only work on hero_mc for it to work create an altered list and check if anyofthem are alter
					pos = flashAnims["Bigb fly in test"].p.pointOnLinkedPath(flashAnims["Bigb fly in test"].ticker/20)
					finalBigB.x = pos.x
					finalBigB.y = pos.y
					
					// we'll turn first wave to umm incorporate the first segment 
					// we do our animation it comes in turns to fly away and waits for you to give chase
					//firstWave()
					//Splash()
					break;
				}
				case 1:
				{
					if(enteredFWave)
					{
						// just use enterdFWAve again for the next case its uber messy but who cares right?!?!?!?!?!?!?
						finalBg.movie.currentFrame = 2
						enteredFWave = false
					}
					// then after we get them working in tandem we get their graphics and then we get the 
					// are basically umm almost there except we need to infuse the scene with energy strategically
					//Splash();
					break;
				}
				case 2:
				{
					
					rideTail();
					break;
				}
					
				default:
				{
					break;
				}
					
			}
			
		}
			
		
		private function firstWave():void
		{
			smallWave.X = hero.X
			
//			// okay since we'll make sonic drown if he doesnt move this could start after a certain time
			//we'll play the wave animation and
			
			if(tick > 200){
				Zanchor  = smallWave.Z - 200;
				if(enteredFWave){
					smallWave.Z -= 10;
					if(smallWave.Z < hero.Z)
						waveAnchor = smallWave.Z 
						hero.Z = (waveAnchor - hero.Z)/7
							y = 2*(hero.Z - waveAnchor)+midY
				}
				
				if(smallWave.Z - hero.Z < 300){
					enteredFWave = true
					turningAngle += (-70 - turningAngle)/14
				}
			}
		}
		
		private function Splash():void
		{
			// with splash just work on the animation and yeah
			// make it choose between paths more than actively moving between ones
			// this isnt the wave its the V splash
			splashWave.Y = hero.Y
			splashWave.Z = hero.Z
				
				// yeah and this should work
			if(Math.abs(hero.X - splashWave.X) < 500){
			}else{
				
				splashWave.X = (hero.X - splashWave.X)/12
			}
			if(!entrSplash)
			{
				splashWave.X = hero.X
				tick = 0
					entrSplash = true
					// basically start the movie and go from there
					// i think i should be able to move the movie to the right
					// while sonic is in front of it, or behind it depending on your reference
					// either way this isnt much to worry about
					// i really feel like im cheating the players with this lack of interactivity thoug... hmm
					
			}
			
		}

		
		private function rideTail():void
		{
			
			if(!entered){
				entered = true;
				pdist = hero.body.position.x
				floorpts = [{X:0,Y:groundheight,Z:hero.Z,D:0},{X:hero.X,Y:groundheight,Z:hero.Z,D:pdist}]
			}
			//floorpts.push({X:bigsHead.X,Y:hero.Y,Z:bigsHead.Z,D:0});
			
			
			for (var i:int = 1; i < floorpts.length; i++) 
			{
				
				pdist+=Math.sqrt((floorpts[i].X - floorpts[i-1].X)*(floorpts[i].X - floorpts[i-1].X)+(floorpts[i].Z - floorpts[i-1].Z)*(floorpts[i].Z - floorpts[i-1].Z))
				floorpts[i].D = pdist
			}
			
		}
		
		private function lazyJunk(cos:Number, sin:Number):void
		{
			var pt:BigBaddie  = bigB
			var x1:Number = bigB.X - Main.liveCamera.pos.X;
			var z1:Number = bigB.Z - Main.liveCamera.pos.Z;
			var x2:Number = cos*x1 - sin*z1;
			var z2:Number = cos*z1 + sin*x1;
			bigB.X = Main.liveCamera.pos.X + x2;
			bigB.Z = Main.liveCamera.pos.Z + z2;
			
			
			//			var her:Object = bkgrnd
			//			x1 = her.X - Main.liveCamera.pos.X;
			//			z1 = her.Z - Main.liveCamera.pos.Z;
			//			x2 = cos*x1 - sin*z1;
			//			z2 = cos*z1 + sin*x1;
			//			her.X = Main.liveCamera.pos.X + x2;
			//			her.Z = Main.liveCamera.pos.Z + z2;
			
			z2 = 300
			bkgrnd.Z = Main.liveCamera.pos.Z + z2;
			
			
			//			x1 = nulBot.X - Main.liveCamera.pos.X;
			//			z1 = nulBot.Z - Main.liveCamera.pos.Z;
			//			x2 = cos*x1 - sin*z1;
			//			z2 = cos*z1 + sin*x1;
			//			nulBot.X = Main.liveCamera.pos.X + x2;
			//			nulBot.Z = Main.liveCamera.pos.Z + z2;
		}
		override public function ground(hero:Vector3, actor:GeneralActor):void
		{
			
		}
		override public function UpdatePhysicsActor(hero:Vector3, actor:GeneralActor):void
		{
			
		}
		private function lineCircle():void
		{
			// okay I think i just kinda hacked this a bit but were gonna take the physics out entirely
			// they are completely unessary for this scene, maybe some falling, but i think clear all of this 
			// create a scenary in the background and just get moving around to work, most all the physics i make should be on this scene
			// maybe even just boat controls
			// dont wory about how speed is handled at this point just get it going 
			// its actually stupidly simple hero.X += Vector.X hero.Z += Vector.Z Vector.X = Math.cos(angle*Math.Pi/180)*speed; Vector.Z = Math.sin(angle*Math.Pi/180)*speed if(hero.key.y == 1){if(MAth.abs(90 - angle) < 5) angle +=(90 - angle)/5}else{if(90 - angle >0)angle +=1}else{angle -=1    
			if(!entered){
				entered = true;
				tick = 0
					
				pdist = hero.body.position.x
				floorpts = [{X:0,Y:groundheight,Z:hero.Z,D:0},{X:hero.X,Y:groundheight,Z:hero.Z,D:pdist}]
				// big B is a bit um big, so we need to rotate around his center mass hence, the plus 200 
				ang = Math.atan2(hero.Z - bigB.Z, hero.X - (bigB.X+200))
				//trace(ang*180/Math.PI)
				
				if(true)
				{
					neg = 1
					ang += Math.PI/2
				}else{
					neg = -1
					ang -= Math.PI/2
				}
				
				floorpts.push({X:hero.X+900 ,Y:groundheight,Z:hero.Z, D:pdist})
				// we wanna do this on the update prob too but one step at a time
				strngLnth =  pdist + 5000
				//				for (var j:int = 0; j <= 16; j++) 
				//				{
				//					ang += Math.PI/8*neg
				//					floorpts.push({X:bigB.X+600 +Math.cos(ang)*radius,Y:groundheight,Z:bigB.Z-900 +Math.sin(ang)*radius, D:pdist})	
				//					// the problem doing this straightforward like is that, sonic would end up sliding backwards, because as we move the point we move it further back, we need it to act like a string so that its distance to the point remains consistant, and regular
				//				
				//				}
				
				// this is the code that should do it 
				//trace(" BIGs dist to somnic\n\n\n\n", bigB.distToSonic)
				//trace(" BIGs dist to somnic\n\n\n", bigB.distToSonic)
				
				//				
				
				for (var i:int = 1; i < floorpts.length; i++) 
				{
					floorpts[i].D
					pdist+=Math.sqrt((floorpts[i].X - floorpts[i-1].X)*(floorpts[i].X - floorpts[i-1].X)+(floorpts[i].Z - floorpts[i-1].Z)*(floorpts[i].Z - floorpts[i-1].Z))
					floorpts[i].D = pdist
				}
				
				
				MainSceneMotor.floor.ptsArray =floorpts
				// i need a retarget ground thing
				//trace(floorpts)
				
				MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x,MainSceneMotor.floorBody,false)
				//maAngle = deg2rad(90)//Math.atan2(bigB.Z - hero.Z,bigB.X - hero.X)- Math.PI/2	

					turningAngle = 0
			}
			if(hero.key.Y > 0)
			{
				//trace("bigbie");
			}
			// should be moved to speed but you know
			turningAngle = turningAngle  -hero.key.Y*.5
			
			tick++
			maAngle = deg2rad(turningAngle)
			//			for (j = 1; j <= 8; j++) 
			//			{
			//				ang += Math.PI/8*neg
			//				floorpts[i] = {X:bigB.X +Math.cos(ang)+radius,Y:groundheight,Z:bigB.Z +Math.sin(ang)+radius, D:0}
			//			}
			//barnicle -=7
			//trace("BIGs dist to somnic\n\n\n\n", bigB.distToSonic)
			//trace("BIGs dist to somnic\n\n\n", bigB.distToSonic)
			//trace("BIGs dist to somnic", bigB.distToSonic)
			outdn --
			if( outdn< 1){
				// these values of outdn 11 and step 12 work, just limit the speed if you have problems and that should do it
				outdn= 3
				joe = true
						MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x,MainSceneMotor.floorBody,false)

			}
					varb+=.02
				// to change the height of the wave change the distance z anchor is from hero.Z
					//Zanchor= hero.Z + Math.cos(varb)*8
						if(hero.Z  > Zanchor)
				waveHeight = -(hero.Z - Zanchor)*.5 + groundheight	
						else
				waveHeight = groundheight	
					
					
				//				var lastPoint:Object = {X:hero.X,Y:groundheight,Z:hero.Z, D:hero.body.position.x}// = floorpts[floorpts.length - 1]
				//				floorpts[floorpts.length - 2] = {X:hero.X,Y:groundheight,Z:hero.Z, D:hero.body.position.x}
				//				dis = strngLnth -hero.body.position.x
				//				lastPoint.X = hero.X +Math.cos(maAngle)*4000
				//				lastPoint.Z = hero.Z +Math.sin(maAngle)*4000
				//				lastPoint.D = dis
				//				floorpts[floorpts.length - 1] = lastPoint
				//					
				//					
					var step:uint =12
				//				MainSceneMotor.floor.ptsArray =floorpts
				//	MainSceneMotor.floor.ptsArray.push({X:16,Y:groundheight,Z:45, D:MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].D+50},{X:16,Y:groundheight,Z:234, D:pdist})
				
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].X +=((hero.X  + Math.cos(maAngle)*400) -MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].X)/step;
				// i might wanna change this 
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].Z +=((hero.Z  + Math.sin(maAngle)*400) -MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].Z)/step ;
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].D +=((hero.body.position.x+400) - MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].D)/step
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].Y += (waveHeight -MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].Y)/step


				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 2].X = hero.X;
				// i might wanna change this 
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 2].Y += (waveHeight -MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].Y)/step
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 2].Z = hero.Z;
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 2].D =hero.body.position.x
				// i need a retarget ground thing
				//trace(floorpts)
				
			//	MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x,MainSceneMotor.floorBody,false)
				if(MainSceneMotor.floor.ptsArray.length > 4){
					MainSceneMotor.floor.ptsArray[2]= MainSceneMotor.floor.ptsArray[0]
					MainSceneMotor.floor.ptsArray.shift()
					MainSceneMotor.floor.ptsArray.shift()
				}
				//trace(MainSceneMotor.floor.ptsArray.length)
				//trace(MainSceneMotor.floor.ptsArray)
			//}
			//				
			
		}
		
		private function catchase():void
		{
			// TODO Auto Generated method stub
			if(!entered){
				entered = true;
				pdist = hero.body.position.x
				floorpts = [{X:0,Y:groundheight,Z:hero.Z,D:0},{X:hero.X,Y:groundheight,Z:hero.Z,D:pdist}]
				if(true)
				{
					right = true// 45 for the first 135 for the next
					floorpts.push({X:bigB.X + Math.cos(.785)*4000,Y:groundheight,Z:bigB.Z+ Math.sin(.785)*4000,D:pdist})
				}else{
					right = false
					floorpts.push({X:bigB.X + Math.cos(2.356)*4000,Y:groundheight,Z:bigB.Z + Math.sin(2.356)*4000,D:pdist})
				}
				for (var i:int = 1; i < floorpts.length; i++) 
				{
					floorpts[i].D
					pdist+=Math.sqrt((floorpts[i].X - floorpts[i-1].X)*(floorpts[i].X - floorpts[i-1].X)+(floorpts[i].Z - floorpts[i-1].Z)*(floorpts[i].Z - floorpts[i-1].Z))
					floorpts[i].D = pdist
				}
				
				
				
				MainSceneMotor.floor.ptsArray =floorpts
				// i need a retarget ground thing
				//trace(floorpts)
				MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x,MainSceneMotor.floorBody,false)
				
				Main.liveCamera.hero_mc.body.position.x = floorpts[1].D+50
				Main.liveCamera.hero_mc.body.position.y = floorpts[1].Y-50
			}
			
			
			nulBot.body.position.x = hero.body.position.x + 200
			nulBot.body.position.y = groundheight
			tick++
			if(tick == launchTime)
			{
				//	trgtpt = {X:nulBot.X,Y:groundheight,Z:nulBot.Z}
				launch = true
			}
			if(true){
				if(hero.body.velocity.x <  -0.4)
				{
					MainSceneMotor.floor.ptsArray[1].X = hero.X  + Math.cos(2.356)*4000;
					// i might wanna change this 
					MainSceneMotor.floor.ptsArray[1].Z = hero.Z + Math.sin(2.356)*4000;
					MainSceneMotor.floor.ptsArray[2].X = hero.X;
					// i might wanna change this 
					MainSceneMotor.floor.ptsArray[2].Z = hero.Z;
					hero.body.position.x = MainSceneMotor.floor.ptsArray[2].D 
					right = false
				}
				//}else{
				if(hero.body.velocity.x > 0.02)
				{
					MainSceneMotor.floor.ptsArray[2].X =hero.X  + Math.cos(.785)*4000;
					// i might wanna change this 
					MainSceneMotor.floor.ptsArray[2].Z =hero.Z  + Math.sin(.785)*4000;
					MainSceneMotor.floor.ptsArray[1].X = hero.X;
					// i might wanna change this 
					MainSceneMotor.floor.ptsArray[1].Z = hero.Z;
					hero.body.position.x = MainSceneMotor.floor.ptsArray[1].D 
					right = true;
				}
			}
			if(launch&& false){
				
				// i might make him run at sonic, but him jumping 
				// make some kind of sheering launching sound that goes with the music
				//				bigB.Y -= speed;
				//				if(bigB.Y > groundheight)
				//				{
				//					bigB.Y = groundheight 
				//					speed = 0
				//				}else{
				//				speed --
				//				}
				
				bigB.Z += ((hero.Z+2200) -bigB.Z)/(30 - chip)
				bigB.X += (hero.X -bigB.X)/(30 - chip)
				if(((hero.X -bigB.X)*(hero.X -bigB.X)+(hero.Z -bigB.Z)*(hero.Z -bigB.Z)) < radius+80){
					onEm = true
				}
				
				if(((hero.X -bigB.X)*(hero.X -bigB.X)+(hero.Z -bigB.Z)*(hero.Z -bigB.Z)) > radius && onEm){
					course = 0
				}
				
				if(chip == 10){
					attack()
					
				}
				
				//			bigB.Z += (trgtpt.Z -bigB.Z)/10
				//			bigB.X += (trgtpt.X -bigB.X)/10
				
				
			}
		}
		
		private function attack():void
		{
			
			bigB.attacking = true;
			
		}		
		
		
	}
}


