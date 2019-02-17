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
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.baseConstructs.NPC;
	import com.jonLwiza.engine.helperTypes.Vector3;
	import com.jonLwiza.engine.state.baddieBehavior.Jumping;
	import com.jonLwiza.engine.state.sonicBehavior.Ground;
	
	import flash.geom.Vector3D;
	
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.utils.Cast;
	
	import starling.utils.deg2rad;
	
	public class SpiritRuin extends Cut
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
		private var course:int = 0;

		private var bigsTail:AnimatedScenary;
		private var bigsHead:AnimatedScenary;
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
		private var Rentered:Boolean = false;

		private var tx:Number;

		private var tz:Number;
		private var leftTurn:Boolean;
		private var sonicVector:Vector3 = new Vector3();
		private var angle:Number = 0;
		private var spd:Number = 0;

		

		private var angToBig:Number;
		private var circle:Boolean =false;
		private var angleSkw:int;

		private var tailPath:Path = new Path();
		private var freeRoam:Boolean = true;
		private var flip:Boolean = true;
		private var sncPlcement:Number = 0;
		private var sonicJumped:Boolean = false ;
		private var gravity:Number =  -0.21875;
		private var jumpImpulse:Number = 6.5;

		private var homingPath:Path;
		private var biggiPath:Path = new Path();
		private var hominpathprg:Number;

		private var angToSonicJumpDash:Number;
		private var ticker:Number = 0;
		private var bX:Number;
		private var bZ:Number;

		private var bigBXVel:Number = 0;
		private var bigBZVel:Number = 0;
		private var presKey:int;
		private var oTangle:Number;
		private var otherKeyPressed:Boolean;

		private var plmt:Vector3;

		private var spiritBg:Scenary;
		private var origpts:Array;
		public function SpiritRuin()
		{
			super();
			
		}
		
		override public function EnterCut():void
		{
			
			bigB= BigBaddie(Main.liveCamera.addNewBaddie(Main.liveCamera.hero_mc.X - 3000 , 1707.250048828125,Main.liveCamera.hero_mc.Z +10050,[],"BigBaddie"));
//			var appndge:Appendage= Appendage(Main.liveCamera.addNewBaddie(6282.914564796065, 1079.250048828125,0,[],"Appendage"));
//			var appndge2:Appendage= Appendage(Main.liveCamera.addNewBaddie(6282.914564796065, 1079.250048828125,0,[],"Appendage"));
			//pi/2 
			//trace(sonicDead)
			Main.liveCamera.rotationY =  Math.PI/2
			//startX = Director.scenary[0].X
			//Main.autoCam = false;
			animAngles = [0,90,180,270]
			MainSceneMotor.autoVP = false
			hero = Main.liveCamera.hero_mc
			bigsTail = Main.liveCamera.addNewAnimatedScenary(13413.837937516404,1218.1001159051607,-20,Assets.getAtlas("testin").getTextures("netCaught"))
			Director.scenary.push({name:"net"})
			nulBot = Cars(Main.liveCamera.addNewBaddie(hero.body.position.x + 1500,hero.body.position.y,0,[],"Cars"))
			//var p:Vector3D = Main.liveCamera.hero_mc.Unproject(447.4 ,357.6,  200)
			spiritBg = getscenary("skateFlrbg")//Main.liveCamera.addNewAnimatedScenary(p.x,p.y,p.z,Assets.getAtlas("SpiritRuinAtlas").getTextures("skateFlrbg"))//(p.x,p.y,p.z,"bgFinal","bgFinal",1,false,1)
				
			spiritBg.updateZdepth = false
			spiritBg.x = 447.4
			spiritBg.scaleX =1
			spiritBg.scaleY = 1
			spiritBg.y = 357.6
			
				
		}
		override protected function HeroMotion(actor:Hero = null):void
		{
			// i left this for the animation but whatevs
			super.HeroMotion(actor)
				
			
			if(hero.key.X != 0 || hero.key.Y>0 ){
				spd = 23
			}else{
				if(spd>0)
				spd--
			}
			
//			if(actor.spacebar && actor.isGrounded && actor.canJump)
//			{
//				actor.triggerJumping = true;
//				actor.doublejumped = false;
//				actor.passed = false;
//				actor.tryAndGrab = false; 
//				actor.tryDodge = false; 
//				
//				////trace("Jumping fdsgfs  gfds aa f");
//				//stage_mc.hero_mc.playAnimation("test");
//				
//				//stage_mc.hero_mc.currScene[0].Jump(stage_mc.hero_mc);
//			}
			
			if(!actor.isJumping && actor.triggerJumping && sonicJumped)
			{
				jumping()
			}
			//angle = 45
			//trace(sonicwaiting)
			if(freeRoam){
				hero.currAngle = angle*Math.PI/180
				
				// I'll test += see if that works but it was just = before better test it while its fresh
			sonicVector.X = Math.cos(angle*Math.PI/180)*spd; 
			sonicVector.Z = Math.sin(angle*Math.PI/180)*spd; 
			
			hero.X += sonicVector.X 
			hero.Z += sonicVector.Z 
			
			hero.Y+= sonicVector.Y
			
			if(hero.Y <= groundheight){
				hero.Y = groundheight
				// this is risky but we gots to do it
				hero.isGrounded = true
				sonicVector.Y  = 0;
				sonicJumped = false
			}else{
				hero.isGrounded = false
				sonicVector.Y += gravity
			}
			
			}
		}
		override public function Jump(actor:GeneralActor):void
		{
			//super.Jump(actor)
				sonicJumped = true;
				sonicVector.Y += jumpImpulse*2
		}
		private function jumping():void
		{
			if(sonicVector.Y >4 && !hero.spacebar){
				sonicVector.Y = 4	
					// I think I'm just putting this here so when 
					// I change things later
				hero.releasedDuringJump = true
			}
			
			// id make a homing function but this will do
			if(homingPath && hero.doublejumped){
				hominpathprg +=1/4
					hero.X = homingPath.placement(hominpathprg).X
					hero.Y = homingPath.placement(hominpathprg).Y
					hero.Z = homingPath.placement(hominpathprg).Z
				if(hominpathprg == 1){
					// it shows we hit the target
					hero.doublejumped = true
						sonicVector.Y = 5
						sonicVector.X = Math.cos(angToSonicJumpDash*Math.PI/180)*spd; 
						sonicVector.Z = Math.sin(angToSonicJumpDash*Math.PI/180)*spd; 
				}
			}
			
		}
		override public function SonicDoubleJump(actor:GeneralActor):void
		{
			if(!Hero(actor).hanging){
				// this works here but put it up on top eventually
				
			
				if(Hero(actor).closestConcern.distToSonic > 400)
				{
					spd *=4
					sonicVector.X = Math.cos(angle*Math.PI/180)*spd; 
					sonicVector.Z = Math.sin(angle*Math.PI/180)*spd; 
					// shouldnt need to but it feels cleaner and safer
					actor.doublejumped = false
				}else{
				 homingPath = new Path(Assets.clone([{X:hero.X,Y:hero.Y,Z:hero.Z},{X:hero.closestConcern.X,Y:hero.closestConcern.Y,Z:hero.closestConcern.Z}]))
				 homingPath.lpair = [{val:0,path:0},{val:1,path:1}]
				 angToSonicJumpDash = Math.atan2(hero.Z - bigB.Z, hero.X - bigB.X)*180/Math.PI+randomRange(-20,20)

				}
			}
		}
		
		override public function ground(hero:Vector3, actor:GeneralActor):void
		{
			
		}
		override public function UpdatePhysicsActor(hero:Vector3, actor:GeneralActor):void
		{
			// temp fix and what not
			
		}
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			
			loadSkyBox()
		
		
			//yeah were not using an actual tail, maybe later but just an angle
			if(flip){
			bigsTail.X = bigB.X+600+ Math.cos(bigB.rotationY)*-radius
			bigsTail.Z = bigB.Z +Math.sin(bigB.rotationY)*-radius
			bigsTail.Y = bigB.Y + 200
			bigB.scaleZ = 2
			flip = false
			}
			bigsTail.Y ++
			
			
			//trace(" umm we can use this to check up and see where it is ",bigsTail.distToSonic)
			
			// it looks like the angle change will be fairly consistant its really only the angle that changes
			
			// in the first meet the angle is something like 45 and we dont take anything else into consideration
			// except the reverse which takes the angle to be something like 135 // unless you're too close then 
			
			// we change to the cat in mouse, though cat and mouse may just work without changing it to a pure angle thing
			// because he's chasing you as well, it also might make things harder, if its purely back and forth, but the camera
			
			// stays flat and up
			
			distToTail = hero.DistToPoint(new Vector3(bigsTail.X,bigsTail.Y,bigsTail.Z))
			if(hero.body.velocity.y > -1 ||true){
			if( distToTail < somedist|| true){
				if(hero.key.Y < 0){
					//throw Error
				course = 2;
				}
			}
			}
			
//			lineCircle();	
//			else
//			catchase();
			//trace(hero.movie.name, "  nzmd ov ghd thing")
			
			switch(course)
			{
				case 0:
				{
					
					lineCircle();
					break;
				}
				case 1:
				{
					
					catchase();
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
			if(allLoaded() && false){
				// i should hard code the the width since thats the distance we want it to fully move
				
				bkgrnd =getscenary("scnespirit")
					bkgrnd.alpha = 1.0
				//bkgrnd2 =	getscenary("scnespirit2")
				bgPos = (Main.liveCamera.rotationY%(2*Math.PI))*bkgrnd.width
				//delta = bgPos*bkgrnd.scaleX
				////trace("SpiritRuin.UpdateScene(actor)", delta);
				
				bkgrnd.updateZdepth = false
				
				bkgrnd.x = -Main.liveCamera.x+delta
				bkgrnd.y = -Main.liveCamera.y
				bkgrnd.scaleX = .5;
				bkgrnd.scaleY = .5;
				
				var cos:Number = Math.cos(Main.liveCamera.rotationY - oldAngle)
					////trace("joiuy ",Main.liveCamera.rotationY - oldAngle)
				var sin:Number = Math.sin(Main.liveCamera.rotationY - oldAngle)
				for (var i:int = 0; i < MainSceneMotor.floor.ptsArray.length; i++) 
				{
					
					var x1:Number = MainSceneMotor.floor.ptsArray[i].X - Main.liveCamera.pos.X;
					var z1:Number = MainSceneMotor.floor.ptsArray[i].Z - Main.liveCamera.pos.Z;
					var x2:Number = cos*x1 - sin*z1;
					var z2:Number = cos*z1 + sin*x1;
					MainSceneMotor.floor.ptsArray[i].X = Main.liveCamera.pos.X + x2;
					MainSceneMotor.floor.ptsArray[i].Z = Main.liveCamera.pos.Z + z2;
					
				}
				lazyJunk(cos,sin)
				
				oldAngle = Main.liveCamera.rotationY 
			
				
				for (var j:int = 0; j < completeAnims.length; j++) 
				{
					//trace(hero.movie.name, " ",hero.anim.indexOf(completeAnims[j]))
					if(hero.movie.name.indexOf(completeAnims[j]) != -1&&hero.movie.name.indexOf("TO") == -1){// &&hero.anim.indexOf(completeAnims[i]+"TO") == -1)
					
						// um this should be temp but i doubt itll actually just stay temp but thats fine
						if(this[completeAnims[j]] == null)
						this[completeAnims[j]] = completeAnims[j]
						
						playit= true
							break;
					}
							
				}
				
				
				if(playit){
					playit = false
					anglebtwn = ((hero.rotationY - Main.liveCamera.rotationY)*180)/Math.PI + 90
						anglebtwn = (hero.rotationY*180)/Math.PI
					segs = 360/parts
					start = 360 - segs/2
					if(anglebtwn < 0)
						anglebtwn +=360
							
					//trace((hero.rotationY*180)/Math.PI," ", Main.liveCamera.rotationY*180/Math.PI," since there is no rotation this should equal the first ",anglebtwn)
					for (var k:int = 0; k < parts; k++) 
					{
					//	//trace("the segs",start)
						if(k == 0){
						if(anglebtwn > start || anglebtwn < segs/2){
							//hornetIdle = hero.movie.name+start
							
						 hero.straightto(completeAnims[j]+"_"+start.toString(),false, hero.frame)
						 this[completeAnims[j]] = completeAnims[j]+"_"+start.toString() 
						}
							 start =segs/2
						}else{
							
							
						if(anglebtwn >start && anglebtwn < start+segs){
							//hornetIdle = hero.movie.name+(start+segs/2).toString()
						hero.straightto(completeAnims[j]+"_"+(start).toString(),false, hero.frame)
						this[completeAnims[j]] = completeAnims[j]+"_"+start.toString() 

							
						}
						start += segs
						}
					}
					
				}
				trace((hero.rotationY*180)/Math.PI," ", Main.liveCamera.rotationY*180/Math.PI," since there is no rotation this should equal the first ",(hero.rotationY-Main.liveCamera.rotationY)*180/Math.PI+90)

			hero.rotationY = Math.atan2(nulBot.Z - hero.Z, nulBot.X - hero.X)
				// the facing angle should be
				////trace ("the facing angle presumably is", ((hero.rotationY - Main.liveCamera.rotationY)*180)/Math.PI)
			
			}
		}
			
			
			
		private function rideTail():void
		{
			// TO GET this to work we have to //trace 0 to 100 percent, and make sure that works
			// then test it by connecting it to a movie that has images that say 
			// 0, 10, 20, 40, 50, 60, 70, 80, 90, 100%
			
			if(!Rentered){
				freeRoam = false
				
				Rentered = true;
				//hero.updateZdepth = false
				pdist = hero.body.position.x
					//floorpts = [{X:0,Y:0,Z:0,D:0},{X:500,Y:-80,Z:300,D:pdist-bigsTail.Y+80 },{X:590,Y:-80,Z:0,D:pdist}]
					origpts = [{X:-75.75,Y:-96.25,Z:0},{X:26.45,Y:-84.95,Z:0},{X:26.45,Y:-84.95,Z:0},{X:26.45,Y:-84.95,Z:0},{X:96.9,Y:-78.3,Z:0},{X:96.9,Y:-78.3,Z:0},{X:143.8,Y:-144.3,Z:0},{X:143.8,Y:-144.3,Z:0},{X:143.8,Y:-144.3,Z:0},{X:259.05,Y:-158.05,Z:0}] 
					
						
						// this is how you pass by value and not just a reference to ther original
						// I dunno how smart it is to do but uh yeah
				tailPath.ptsArray  = Assets.clone(origpts)//[{X:-75.75,Y:-96.25,Z:0},{X:26.45,Y:-84.95,Z:0},{X:26.45,Y:-84.95,Z:0},{X:26.45,Y:-84.95,Z:0},{X:96.9,Y:-78.3,Z:0},{X:96.9,Y:-78.3,Z:0},{X:143.8,Y:-144.3,Z:0},{X:143.8,Y:-144.3,Z:0},{X:143.8,Y:-144.3,Z:0},{X:259.05,Y:-158.05,Z:0}] 
					//
					var se:Object = {}//[{X:0,Y:0,Z:0,D:0},{X:500,Y:-80,Z:300,D:pdist-bigsTail.Y+80 },{X:590,Y:-80,Z:0,D:pdist}]
	
					
				
		//	floorpts.push({X:hero.X,Y:hero.Y+80,Z:bigB.Z,D:0});
					
			
//			for (var i:int = 2; i < floorpts.length; i++) 
//			{
////				floorpts[i-1].X += hero.X 
////				floorpts[i-1].Z += hero.Z 
//				pdist+=Math.sqrt((floorpts[i].X - floorpts[i-1].X)*(floorpts[i].X - floorpts[i-1].X)+(floorpts[i].Z - floorpts[i-1].Z)*(floorpts[i].Z - floorpts[i-1].Z))
//				floorpts[i].D = pdist
//			}
			
			//tailPath.ptsArray =floorpts
				tailPath.live = true
			// i need a retarget ground thing
			
			//MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x,MainSceneMotor.floorBody,false)
			}
			
			// all I have to do to make this animation ready is just have a function that has all the tails animation frames and call to change it when its up
			// setting it up in maya may be a bigger hurdle then setting it up here honestly, eh not really you just get the path everyframe and you just animate it as you would
			// and put that in an array, putting the name of the animation would be nice but honestly who cares, it would look something like this
			//  if (BigB.movie.currframe !=lastFrame || !tailPath.ptsArray){
			// tailPath.ptsArray = Assets.clone(tailpoints[BigB.movie.currframe][0]) then i just need to
			// lastFrame =BigB.movie.currframe
			// }
			
			//floorpts =  [{X:0,Y:0,Z:0,D:0},{X:500,Y:-80,Z:300,D:pdist-bigsTail.Y+80 },{X:590,Y:-80,Z:0,D:pdist}]
				// in the final since I probably wont need a tail persay I might it has a hit box and I can just attach it to the swinging whatever
			// this just says everything is relative to bigb right now its tail but you get the idea
//			for (var i:int = 0; i < tailPath.ptsArray.length; i++) 
//			{
//				tailPath.ptsArray[i].X = bigsTail.X + floorpts[i].X 
//				tailPath.ptsArray[i].Y = bigsTail.Y	+ floorpts[i].Y 
//				tailPath.ptsArray[i].Z = bigsTail.Z + floorpts[i].Z 
//			}
			
			
			//(TODO):origpts is the point your gonna keep updating on animation
			for (var i:int = 0; i < tailPath.ptsArray.length; i++) 
			{
				tailPath.ptsArray[i].X = bigB.X + origpts[i].X 
				tailPath.ptsArray[i].Y =bigB.Y+ origpts[i].Y*-(bigB.scaleZ) 
				//tailPath.ptsArray[i].Z = bigsTail.Z + floorpts[i].Z 
			}
			
			sncPlcement += spd*hero.key.X
				trace(sncPlcement, hero.width, bigB.width)
			hero.X = tailPath.placement(sncPlcement).X
			hero.Y = tailPath.placement(sncPlcement).Y
			hero.Z = bigB.Z//tailPath.placement(sncPlcement).Z
				var endOpath:Number  = 1100
				if(sncPlcement > endOpath){
					course = 0
					freeRoam = true
					Rentered = false;
					//hero.Unproject(hero.x,hero.y, hero.z);
					hero.updateZdepth = true
				}
			//var prc:Number = (hero.body.position.x - floorpts[1].D)/(floorpts[2].D - floorpts[1].D)*100/5
            //trace("the percentage should be .. drumroll "+prc+"%."+hero.body.position.x)
//			if(behindBig keep circle)
//			{
//				// its all actually the same thing so uh yeah
//			}
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
		
		private function lineCircle():void
		{
			// were gonna wanna check for a tight back and forth condition 
			if(!entered/*and havent pressed an angle for half a second*/){
				
				if(hero.key.X == 1){
					entered = true;
				oTangle = 135
				}else if(hero.key.X == -1){
					// we might want a little bit of a delay in the action
				oTangle = 45
				entered = true;
				}
				if(oTangle){
				if(oTangle == 135){
					presKey = 1
				biggiPath.ptsArray  =	Assets.clone([{X:bigB.X,Y:bigB.Y,Z:bigB.Z,D:0 },{X:bigB.X+6000,Y:bigB.Y,Z:bigB.Z,D:0}])
				}else if(oTangle == 45){
					presKey = -1
					biggiPath.ptsArray  =	Assets.clone([{X:bigB.X,Y:bigB.Y,Z:bigB.Z,D:0 },{X:bigB.X-2000,Y:bigB.Y,Z:bigB.Z,D:0}])
				}
				bX = biggiPath.ptsArray[biggiPath.ptsArray.length -1].X
				bZ = biggiPath.ptsArray[biggiPath.ptsArray.length -1].Z
				}
				// then on the distance too close we change it to catchase
				// or we move left which we need to make sure isnt in the enter
				// meanwhile the bigbadd just plays his scripted animation, 
				// just change t to ++ its really easy and that should work
				// start the animation as soon as sonic runs for about a second
				// on testing ofcourse i dont need to do that, but for other peops
				// its a must, and they can go left on startwhich is why we need to do it on enter
		}else{
			
			//this is the  is the first movement to clue the player on how the controls have changed slightly
			ticker+=10
				if(!circle && !otherKeyPressed){
					//trace("thid",ticker)
			plmt = biggiPath.placement(ticker)
			bigB.X = plmt.X
			bigB.Y = plmt.Y
			bigB.Z = plmt.Z
				}else if(otherKeyPressed){
					// this is a mock chase phase
					//bigB.X += (hero.X - bigB.X)/20
					bigB.vel.x  = (hero.X - bigB.X)/300
					
					bigB.vel.z = (hero.Z - bigB.Z)/300
				}
			var distToBig:Number = hero.DistToPoint(new Vector3(bigB.X,bigB.Y,bigB.Z))
			if(hero.DistToPoint(new Vector3(bigB.X,bigB.Y,bigB.Z))>2080 && !circle){
				//trace(hero.DistToPoint(new Vector3(bigB.X,bigB.Y,bigB.Z)))
			if(hero.key.X == presKey){
				angle = Math.atan2(bZ - hero.Z, bX - hero.X)*180/Math.PI //45
			}else if(hero.key.X == -presKey){
				// we might want a little bit of a delay in the action
				otherKeyPressed = true
				// it should be only if the baddie has finished moving into position
				
				// else  and we should start the chase chase is simple it just moves at the same angle
				// and speed sonic does only there is a bit of a delay and he attacks, but i can put the attacks latttter
				angle = oTangle
			}
			}else{
				circle = true
				angToBig = Math.atan2(-hero.Z + bigB.Z, -hero.X + bigB.X)*180/Math.PI
				var bigBwidt:Number = 700
				var bigBdMtr:Number =  bigBwidt + 100
				angleSkw  = 90*(1 -(distToBig - bigBdMtr)/(8000 - bigBdMtr)) 
				if(hero.key.X == 1){
					angle = angToBig -angleSkw;
				}else if(hero.key.X == -1){
					// we might want a little bit of a delay in the action
					angle = angToBig +angleSkw;
				}
				trace(" the angle during circle time is: ",hero.facingAngle, hero.currAngle*180/Math.PI)
				// itll eventually be a target point // but you get the jist
				
					// you should manually exit circle
				
				//bigB.X += bigBXVel
				//bigB.Z += bigBZVel
			}
		}
		}
		private function lineCircleOld():void
		{
			if(!entered){
				entered = true;
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
				
				var yx:Number = bigB.X+600 +Math.cos(ang)*radius
				var yz:Number = bigB.Z-900 +Math.sin(ang)*radius
					pdist = Math.sqrt((yx - hero.X)*(yx - hero.X)+(yz - hero.Z)*(yz - hero.Z))
				floorpts.push({X:bigB.X+600 +Math.cos(ang)*radius,Y:groundheight,Z:bigB.Z-900 +Math.sin(ang)*radius, D:pdist})
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
				if(true){
					hero.body.position.x = floorpts[1].D
				}	
			}
			
//			for (j = 1; j <= 8; j++) 
//			{
//				ang += Math.PI/8*neg
//				floorpts[i] = {X:bigB.X +Math.cos(ang)+radius,Y:groundheight,Z:bigB.Z +Math.sin(ang)+radius, D:0}
//			}
			
			//trace(" BIGs dist to somnic\n\n\n\n", bigB.distToSonic)
			//trace(" BIGs dist to somnic\n\n\n", bigB.distToSonic)
			//trace(" BIGs dist to somnic", bigB.distToSonic)
			outdn --
			if(bigB.distToSonic < 2080 && outdn <1 || (joe && outdn <1 )){
				outdn= 13
				joe = true
				
				maAngle = Math.atan2(bigB.Z - hero.Z,bigB.X - hero.X)- Math.PI/2	
//				var lastPoint:Object = {X:hero.X,Y:groundheight,Z:hero.Z, D:hero.body.position.x}// = floorpts[floorpts.length - 1]
//				floorpts[floorpts.length - 2] = {X:hero.X,Y:groundheight,Z:hero.Z, D:hero.body.position.x}
//				dis = strngLnth -hero.body.position.x
//				lastPoint.X = hero.X +Math.cos(maAngle)*4000
//				lastPoint.Z = hero.Z +Math.sin(maAngle)*4000
//				lastPoint.D = dis
//				floorpts[floorpts.length - 1] = lastPoint
//					
//					
//				MainSceneMotor.floor.ptsArray =floorpts
			//	MainSceneMotor.floor.ptsArray.push({X:16,Y:groundheight,Z:45, D:MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].D+50},{X:16,Y:groundheight,Z:234, D:pdist})
	
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].X =hero.X  + Math.cos(maAngle)*400;
				// i might wanna change this 
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].Z =hero.Z  + Math.sin(maAngle)*400;
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 1].D =hero.body.position.x+400
				
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 2].X = hero.X;
				// i might wanna change this 
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 2].Z = hero.Z;
				MainSceneMotor.floor.ptsArray[MainSceneMotor.floor.ptsArray.length - 2].D = hero.body.position.x
				// i need a retarget ground thing
				//trace(floorpts)
				
				MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x,MainSceneMotor.floorBody,false)
				if(MainSceneMotor.floor.ptsArray.length > 4){
					MainSceneMotor.floor.ptsArray[2]= MainSceneMotor.floor.ptsArray[0]
				MainSceneMotor.floor.ptsArray.shift()
				MainSceneMotor.floor.ptsArray.shift()
				}
				Main.liveCamera.hero_mc.body.position.x = floorpts[1].D+50
				Main.liveCamera.hero_mc.body.position.y = floorpts[1].Y+150

				//trace(MainSceneMotor.floor.ptsArray.length)
				//trace(MainSceneMotor.floor.ptsArray)
				// i think i may leave it might not be that big of a deal
				//if()
				
			}
			//				
			if( hero.Y <(bigsTail.Y +70)){
				course = 2;
				
			}
		}
		private function catChase():void{
			if(hero.key.X == 1)
			{
			angle = Math.atan2(hero.Z - bigB.Z, hero.X - bigB.X)+90
			}else if(hero.key.X == -1)
			{
				angle = Math.atan2(hero.Z - bigB.Z, hero.X - bigB.X)-90

			}
		}
		private function catchase():void
		{
			// TODO Auto Generated method stub
			if(!entered){
				entered = true;
				
				pdist = hero.body.position.x
				floorpts = [{X:0,Y:groundheight,Z:hero.Z,D:0},{X:6000,Y:groundheight,Z:hero.Z,D:6000}]
				
				// we'll probably have to fic these and put it to the key but i know that will be a trial	
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
				
				tx = hero.X+ (floorpts[2].X - hero.X)/2
				tz = hero.Z+(floorpts[2].Z - hero.Z)/2

				
				MainSceneMotor.floor.ptsArray =floorpts
				// i need a retarget ground thing
					//trace(floorpts)
				MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x,MainSceneMotor.floorBody,false)
			
				Main.liveCamera.hero_mc.body.position.x = floorpts[1].D+50
				Main.liveCamera.hero_mc.body.position.y = floorpts[1].Y+150
				if(false){
					hero.body.position.x = floorpts[1].D
				}	
			}
			
			
			nulBot.body.position.x = hero.body.position.x + 200
			nulBot.body.position.y = groundheight
			tick++
				MainSceneMotor.interupt = true
			if(tick == launchTime)
			{
			//	trgtpt = {X:nulBot.X,Y:groundheight,Z:nulBot.Z}
					launch = true
			}
			if(true){
			if(hero.key.X < 0)
			{
				MainSceneMotor.floor.ptsArray[2].X = hero.X  + Math.cos(2.356)*4000;
				// i might wanna change this 
				MainSceneMotor.floor.ptsArray[2].Z = hero.Z + Math.sin(2.356)*4000;
				MainSceneMotor.floor.ptsArray[1].X = hero.X;
				// i might wanna change this 
				MainSceneMotor.floor.ptsArray[1].Z = hero.Z;
				hero.body.position.x = MainSceneMotor.floor.ptsArray[1].D 
				right = false
					leftTurn = true
			}
			//}else{
				if(hero.key.X >= 0)
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
			if(launch){
				
				// i might make him run at sonic, but him jumping 
				// make some kind of sheering launching sound that goes with the music
//				bigB.Y -= speed;
				// maybe i should have this look up and down but for now its too much flare
//				if(bigB.Y > groundheight)
//				{
//					bigB.Y = groundheight 
//					speed = 0
//				}else{
//				speed --
//				}
				if(leftTurn){
				
				// it falls off the track because it hates me... oh well
				bigB.Z += ((hero.Z+2200) -bigB.Z)/(500 - chip)
				bigB.X += (hero.X -bigB.X)/(500 - chip)
				if(bigB.distToSonic < radius+1140){
					onEm = true
				}
				// so the majority of the fight stays in catchase until i shake em and can get behind the beast
					trace(bigB.distToSonic, radius+1145)
				if(bigB.distToSonic > radius+1145 && onEm){
						course = 0
						MainSceneMotor.interupt = false
				}
					// its less attack as more of hey move left now kind of thing
					if(chip == 10){
						attack()
						
					}
				}else{
					if((bigB.Z - tz)> 15 && hero.body.velocity.x > .2){
					bigB.Z += (tz -bigB.Z)/10
					bigB.X += (tx+1200 -bigB.X)/10
					}else{
						
					}
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