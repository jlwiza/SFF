package com.jonLwiza.engine.baseConstructs
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Ground;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import nape.phys.Body;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	/**
	 * What this does is that it takes over main scene to default to whatever the animations are within a cut
	 * I think it should be the other way round it should be cut first then main scene but I may of thought I didnt want to be
	 * beholdant to the Director.
	 */
	public class Cut extends MainScene
	{
		
		// the way this seems to be set up makes it so that cuts are the only thing that can change their state animations dynamically while 
		// i need to hardcode the changes for scenes its kinda cool though since im guessing that the cut should lie higher than the scene, since we dont actually
		// "enter" the scene per se the cut becomes the mainscene and we could just as change it to initCut
		
		//protected var cutAnimations:Dictionary = new Dictionary();
		// i wonder why i put this in cut instead of main scene.. what was my thinking, I get it this is very clever by seperating the cuts we make a base system that we change out
		// it gives unpresidented flexibility and makes each scene very rigid yet reusable in its implementation in other words the paradigm designs it so if you want to make 
		// changes to core animation things do it in the cut rather than scenes so i can reuse the scenes more over without much change to the code while cuts are things that are used
		// only once and theyre changes flow down through the loop but can be overwritten if i force a scene to 
		// though it seems if i just subclass the this instead of main scene it should handle the same

		public var frameRate:uint = 60
		private var _isMouseJointActve:Boolean = false
		// If Im not mistaken to get the spritesheet working it should be just load the texuresheet, then put the 
		// I think just call it TA'd or something and then as soon as it gets to it, it pops the frIter to the end
		// I hope this doesnt fuck you over jon but it should be not that hard, Im a little fried and other line 513 or the else clause in frameLoaded I added || textAtlas I set that to be false it should be that if you can set textAtlas true I think it should just work no programming required, if not it should be an oftly good jumping off point
		public  var basicAnims:Array = [{name:"sonicwaiting",frms:1},{name:"sonicJogging",frms:1},{name:"sonicWalking",frms:1},{name:"sonicFalling",frms:5},{name:"sonicJumpRising",frms:1},{name:"sonicRising",frms:4},{name:"sonicJumpFalling",frms:1},{name:"sonicRunning",frms:1},{name:"sonicSprinting",frms:1}];
		
		public function Cut()
		{
			var scene:String = getQualifiedClassName(this);
			var dname:String = scene.slice(scene.search("::")+2)
			
			var sceneName:String = dname
			// umm alot of notes here but this one is important ****** we should optimize this by not doing silly updates to the scene to see if its collided with sonic
			// since it has no physical body that should be handled by entered scene and leave scene
			
			// if this doesn't work just make sure to name scenes with animations
			super();
			this.hero = MainScene.hero
			 //umm a lot of these features become overkill since i have the live edit so im gonna
			// comment these all out and use cut more like a type to differentiate it from a scene than anything else
		}
		
		// we might wanna change this to init cut or something i dunno since the cut isnt a real thing 
//		override protected function HeroEntered():void
//		{
//			// I don't care what this is doing its wrong 
//			// change all the nulls in main scene then all the states but yeah thatd take some time which does need to be done though
//			cutAnimations["sonicRising"] = null;
//			cutAnimations["sonicwaiting"] = null;
//			cutAnimations["sonicdying"] = null;
//			cutAnimations["sonicDead"] = null;
//			cutAnimations["sonicFalling"] = null;
//			cutAnimations["sonicHanging"] = null
//			cutAnimations["sonicJumpRising"] = null;
//			cutAnimations["sonicJumpFalling"] = null;
//			cutAnimations["sonicJogging"] = null;
//			cutAnimations["sonicRunning"] = null;
//			cutAnimations["sonicSprinting"] = null;
//			cutAnimations["sonicRolling"] = null;
//			cutAnimations["sonicIdle"] = null;
//			cutAnimations["sonicPissed"] = null;
//			cutAnimations["sonicWalking"] = null;
//			cutAnimations["sonicCharging"] = null;
//			cutAnimations["sonicDucking"] = null;
//			cutAnimations["sonicSkid"] = null;
//			cutAnimations["jumpCharging"] = null;
//			// theyre both usable i need to put them in different places though, and i want everything to do this, not just
//			// the cuts we'll say that all of the cuts
//			
//			// what i was saying before is if i changed undefined to be the trigger instead of null id just have to type this without that stuff above me
//			// but this should work
//			 sonicRising= cutAnimations["sonicRising"];
//			sonicwaiting= cutAnimations["sonicwaiting"];
//			sonicdying=  cutAnimations["sonicdying"];
//			sonicDead= cutAnimations["sonicDead"];
//			sonicFalling= cutAnimations["sonicFalling"];
//			sonicHanging= cutAnimations["sonicHanging"]
//			sonicJumpRising= cutAnimations["sonicJumpRising"];
//			sonicJumpFalling= cutAnimations["sonicJumpFalling"];
//			sonicJogging= cutAnimations["sonicJogging"];
//			sonicRunning= cutAnimations["sonicRunning"];
//			sonicSprinting= cutAnimations["sonicSprinting"];
//			sonicRolling= cutAnimations["sonicRolling"];
//			sonicIdle = cutAnimations["sonicIdle"];
//			sonicPissed= cutAnimations["sonicPissed"];
//			sonicWalking= cutAnimations["sonicWalking"];
//			sonicCharging  = cutAnimations["sonicCharging"];
//			sonicDucking = cutAnimations["sonicDucking"];
//			sonicSkid  = cutAnimations["sonicSkid"];
//			jumpCharging= cutAnimations["jumpCharging"];
//		}
		
		public function heroEntryPoint():void{
			Main.liveCamera.hero_mc.body.position.x = Director.floorpts[1].D
			Main.liveCamera.hero_mc.body.position.y = Director.floorpts[1].Y+173
			//	trace(Director.floorpts[2].X,Director.floorpts[2].D, getQualifiedClassName(this), Main.liveCamera.hero_mc.body.position.x)
		}
		/**just an accessor method starts off the things that need to be called for cuts in general
		 * which is where the hero starts and calling the enterScene method so dont override enterCut to start a level
		 * **/
		public function EnterCut():void
		{
			heroEntryPoint()
			EnterScene()
				
		}
		
		/**
		 * the custom lpair object looks like  {val:flashAnims[name].p.ptsArray.length - 1,path:flashAnims[name].p.ptsArray.length - 1}
		 */
//		public function setFlashAnim(name:String, customlPair:Object = null):void
//		{
//			
//			flashAnims[name] = {ticker:0}
//			flashAnims[name].p.ptsArray = [{X:456.25,Y:-262.25,Z:0},{X:518.25,Y:254.95,Z:0},{X:598.2,Y:336.85,Z:0},{X:691.5,Y:416,Z:0},{X:797.5,Y:492.3,Z:0},{X:915.45,Y:565.55,Z:0},{X:1044.45,Y:635.65,Z:0},{X:1183.5,Y:702.45,Z:0},{X:1331.5,Y:765.85,Z:0},{X:1487.4,Y:825.8,Z:0},{X:1649.9,Y:882.3,Z:0},{X:1817.85,Y:935.25,Z:0},{X:1989.95,Y:984.7,Z:0},{X:2165.1,Y:1030.65,Z:0},{X:2342,Y:1073.2,Z:0},{X:2519.55,Y:1112.4,Z:0},{X:2696.8,Y:1148.3,Z:0},{X:2872.65,Y:1181.1,Z:0},{X:3046.3,Y:1210.85,Z:0},{X:3216.9,Y:1237.7,Z:0},{X:3383.75,Y:1261.8,Z:0},{X:3546.2,Y:1283.25,Z:0},{X:3703.8,Y:1302.2,Z:0},{X:3856,Y:1318.8,Z:0},{X:3998.75,Y:1329.3,Z:0},{X:4129.1,Y:1346.1,Z:0},{X:4248.25,Y:1368.85,Z:0},{X:4357.2,Y:1397.3,Z:0},{X:4456.95,Y:1431.25,Z:0},{X:4548.2,Y:1470.55,Z:0},{X:4631.7,Y:1515.15,Z:0},{X:4708.2,Y:1564.95,Z:0},{X:4778.2,Y:1619.95,Z:0},{X:4842.35,Y:1680.2,Z:0},{X:4901.15,Y:1745.7,Z:0},{X:4955.1,Y:1816.65,Z:0},{X:5004.7,Y:1893.2,Z:0},{X:5050.5,Y:1975.5,Z:0},{X:5093,Y:2063.85,Z:0},{X:5132.7,Y:2158.7,Z:0},{X:5170.15,Y:2260.45,Z:0},{X:5206.1,Y:2369.7,Z:0},{X:5241.15,Y:2487.25,Z:0},{X:5276.2,Y:2614.1,Z:0}] 
//			if(customlPair != null)
//			flashAnims[name].p.lpair = customlPair
//			else
//			flashAnims[name].p.lpair = {val:flashAnims[name].p.ptsArray.length - 1,path:flashAnims[name].p.ptsArray.length - 1}
//
//		}
		/**
		 * Plays the animation through keepsPlaying says as soon as soon as the start conditions are met it will play to the end
		 * if you want break conditions just do it in the main or pass in the start condition as a variable, this way then i can alter it, it seems smarter then the auto shit that i did
		 * don't put too much into this function 
		 * also just making it active be true just plays it auto magically the extra ticker value at the end is dumb but im lazy and 
		 * just keeps all the code that i was writing in tact incrment wont work if you put any value aside from 0 I split it up since a direct animation has a little bit 
		 * more customization so playFlashAnim may be useful for something a bit more dynamic */
		public function playHeroFlashAnim(name:String, part:GeneralMotor, startCond:Boolean, keepsPlaying:Boolean = true, incrment:Number = 1, directTicker:Number= 0):Boolean{
			
			if((startCond||flashAnims[name].active) && flashAnims[name].ticker < flashAnims[name].p.endVal){
				if(keepsPlaying){flashAnims[name].active =true}
				var pos:Vector3 = flashAnims[name].p.pointOnLinkedPath(flashAnims[name].ticker)
				// we might want to do .isonpath but for now
				if(part is Hero){
					
				part.bdy.x = pos.X
				part.bdy.y = pos.Y
					
				}else{
					var vc3:Object = pos
					// in this instance we're actually just taking its 2d coordinate since we project it on to the path... buuut when were actually later not dealing with the path i wont even have to deal with this translation
					if(flashAnims[name].is2D){
					//var npos:Point = Main.liveCamera.globalToLocal(new Point(500,500))
					
						part.x =Main.liveCamera.hero_mc.x
						part.y = Main.liveCamera.hero_mc.y
							
						//part.z = vc3.Z
					}else{
					if(part == getscenary("opningScnefarbackground"))
					{
						part.X = Main.liveCamera.hero_mc.X
						part.Y = Main.liveCamera.hero_mc.Y
						part.Z = Main.liveCamera.hero_mc.Z
					}else{	
					part.X = vc3.X
					part.Y = vc3.Y 
					part.Z = vc3.Z
					}
					}

				}
					trace(" in Anim ",name)
				part.vel.x = 0
				part.vel.y = 0
				if(directTicker== 0){
					flashAnims[name].ticker+=incrment*MainSceneMotor.worldSpeed
				}else{
					flashAnims[name].ticker = directTicker
				}
				
				return true
				
			}
			
			// i think all i need to do is tesst that it works by inputing points
			// i just got bogged down on how i should best tackle the problem of how it outputs data, i realized that it would be easy enough to just leave it as is for now
			// where it outputs just from the screens position, the problem with that is that its very camera centric, and if i decide to move the camera later im banged
			// there are two solutions to this, actually kinda like three but the third one is really involved so Im not super excited to use that but the two are well i could just get the local position in Main.liveCamera and use that by placing an object at 0 , 0 and  just subtract from the position of things to find out where it is, and that works actually pretty great so long as im moving side to side, which technically i am, but then breaks down during any type of rotation and would do something pretty weird, Im not actually even sure what to be perfectly honest
			// so thats out the second is just get its X,Y,Z like originally planned but thats annoying because its a bit hard to get on the path, but thats not an actual real concern to be perfectly honest, so just change to that , but we should make sure it works and fix it before doing anything else
			return false
		}
			/**
			 * more barebones than the playHero, it just
			 *  wants to know if your playCondition is true and it will 
			 * be true regardles, no keeps playing flag,
			 *  and you directly influence the ticker
			 */
			public function playFlashAnim(name:String, part:GeneralMotor, playCond:Boolean,ticker:Number):Boolean{
				
				if(playCond){
					
					var pos:Vector3 = flashAnims[name].p.pointOnLinkedPath(flashAnims[name].ticker)
					// we might want to do .isonpath but for now
				{
						var vc3:Object = pos
						// in this instance we're actually just taking its 2d coordinate since we project it on to the path... buuut when were actually later not dealing with the path i wont even have to deal with this translation
						if(flashAnims[name].is2D){
							//var npos:Point = Main.liveCamera.globalToLocal(new Point(500,500))
							trace(vc3.X, "is What i am")
							part.x = vc3.X
							part.y = vc3.Y
							
							//part.z = vc3.Z
						}else{
							
								part.X = vc3.X
								part.Y = vc3.Y 
								part.Z = vc3.Z
							
						}
						
					}
					trace(" in Anim ",name)
					part.vel.x = 0
					part.vel.y = 0
					
						flashAnims[name].ticker = ticker
					
					
					return true
					
				}
				
				// i think all i need to do is tesst that it works by inputing points
				// i just got bogged down on how i should best tackle the problem of how it outputs data, i realized that it would be easy enough to just leave it as is for now
				// where it outputs just from the screens position, the problem with that is that its very camera centric, and if i decide to move the camera later im banged
				// there are two solutions to this, actually kinda like three but the third one is really involved so Im not super excited to use that but the two are well i could just get the local position in Main.liveCamera and use that by placing an object at 0 , 0 and  just subtract from the position of things to find out where it is, and that works actually pretty great so long as im moving side to side, which technically i am, but then breaks down during any type of rotation and would do something pretty weird, Im not actually even sure what to be perfectly honest
				// so thats out the second is just get its X,Y,Z like originally planned but thats annoying because its a bit hard to get on the path, but thats not an actual real concern to be perfectly honest, so just change to that , but we should make sure it works and fix it before doing anything else
				return false
			}
			
			
		
		public function EnterScene():void{
			
		}
		
		public function LeaveCut():void
		{
			
		}
		
		protected function switchMovie(anim:AnimatedScenary, newMov:String,atlas:String = "testin"):void
		{
			anim.movie.stop()
			anim.removeChild(anim.movie,true);
			starling.core.Starling.juggler.remove(anim.movie);
			anim.movie = new MovieClip(Assets.getAtlas(atlas).getTextures(newMov+"0"), 24);
			anim.addChild(anim.movie);
			anim.movie.play()
			
		}
		
		public function deleteOldies():void
		{
			
			for (var i:int = 0; i < Main.liveCamera.scenary.length-2; i++) 
			{
				if(Main.liveCamera.scenary.length ==1)
					break;
				
				//trace("\n\n\nDisposing of SCENE NAMED "+Main.liveCamera.scenary[i].name+"\n\n\n");
				//trace("\nDisposing of SCENE NAMED "+Director.scenary.length+"\n");
				
				if(Director.scenary[i].frms == 1){
					if(Assets.isTextureLoaded(Main.liveCamera.scenary[i].name))
					{
						//trace("disposing of this scene "+Assets.gameTextures[Main.liveCamera.scenary[i].name])
						Assets.gameTextures[Main.liveCamera.scenary[i].name].dispose()
					}	
				}
				
				Main.liveCamera.scenary[i].dispose()
				Main.liveCamera.scenary[i].removeFromParent();
				Director.scenary[i] = null;
				
			}
			Main.liveCamera.scenary = []
			//		Main.liveCamera.swapChildrenAt(Main.liveCamera.getChildIndex(Main.liveCamera.scenary[1]),Main.liveCamera.getChildIndex(Main.liveCamera.scenary[8]));
			//Main.liveCamera.scenary[1].scaleZ=6*2.5*4
			//				var scaleW:Number = 2
			//				picWidth = scaleW*2048
			//				for (var j2:int = 1; j2 < Main.liveCamera.scenary.length; j2++) 
			//				{
			//					//							
			//					Main.liveCamera.scenary[j2].scaleZ = scaleW
			//				}
			//				for (var j:int = 11; j < Main.liveCamera.scenary.length; j++) 
			//				{
			//					
			//					Main.liveCamera.scenary[j].scaleZ = scaleW
			//					Main.liveCamera.scenary[j].Z = 0
			//					Main.liveCamera.scenary[j].X =(j-1)*picWidth
			//					newY = MainSceneMotor.floor.Groundforce((j-1)*picWidth)
			//					Main.liveCamera.scenary[j].Y = (newY+lastY)/2-scaleW/2
			//					lastY = newY
			//				}
			
		}
		
		/** this is a convienence method that mirrors the getscenary that can be also found in the liveCamera**/
		public function getscenary(name:String):Scenary{
			
//			if(!allLoaded())
//			throw Error("not completed loading")
			
			for (var i:int = 0; i < Main.liveCamera.scenary.length; i++) 
			{
				//trace("the name of el scenary ", Main.liveCamera.scenary[i].name)
				if(Main.liveCamera.scenary[i].name == name)
					return Main.liveCamera.scenary[i]
			}
			// i love how i said shit got weird instead of what this is actually doing Im dumb
			throw Error("the Scenary you requested has not been loaded into the scene")
			return null
		}

		
		public function get isMouseJointActve():Boolean
		{
			
			return MainSceneMotor.mouseJoint.active;
		}

		/** this is the safe convienence method to make sure when im editing animation it dont fucks with shits **/
		public function set isMouseJointActve(value:Boolean):void
		{
			if(!Main.Release){
			if(EditKeyHandler.State == EditKeyHandler.Animation)
				return
			}
			
			MainSceneMotor.mouseJoint.active = value;
		}

		
	}
	
	
}