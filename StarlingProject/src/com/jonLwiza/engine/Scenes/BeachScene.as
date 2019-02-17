package 
	com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Path;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Baddie;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Anim;
	import com.jonLwiza.engine.helperTypes.Status;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.geom.Point;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class BeachScene extends Cut
	{
		private var midbeg:Number = 18710 ;
		private var midend:Number = 22112;

		private var _begsonicJogging:String;
		private var _begsonicJumpFalling:String;
		private var _begsonicJumpRising:String;
		private var _begsonicRunning:String;
		private var _begsonicSprinting:String;
		private var _begsonicwaiting:String;
		private var _begsonicWalking:String;
		private var _midsonicJogging:String;
		private var _midsonicJumpFalling:String;
		private var _midsonicRunning:String;
		private var _midsonicSprinting:String;
		private var _midsonicwaiting:String;
		private var _midsonicWalking:String;
		private var _endsonicJogging:String;
		
		private var _endsonicRunning:String;
		private var _endsonicSprinting:String;
		private var _endsonicwaiting:String;
		private var _endsonicWalking:String;
		
		private var intobeach:AnimatedScenary;
		private var teaseBaddie:AnimatedScenary = new AnimatedScenary();
		private var outobeach:Scenary;
		private var midbeach:Scenary;
		private var _midsonicJumpRising:String;
		private var _endsonicJumpFalling:String;
		private var _endsonicJumpRising:String;
		private var _sonicWalkLookUp:String ="sonicWalkLookUp" ,_sonicwaitingLookUp:String = "sonicwaitingLookUp",_sonicLookUpjogging:String = "sonicLookUpjogging";
		private static var hnt2:Hornet;
		private static var box:Body;
		private var removed:Boolean;
		private var netscnry:AnimatedScenary = new AnimatedScenary();

		private static var brknHrnt:BrokenHornet;
		private var pressed:Boolean = false;
		private var next:Boolean = false;
		private var delta:Number = 0;
		private var enteredMid:Boolean;
		private var beg:Number = 11304;
		private var splash:Scenary;
		private var rotPath:Path = new Path();
		private var explosionmc:AnimatedScenary = new AnimatedScenary();
		private var isfirstTaunt:Boolean = true;
		private var killet:uint =0;

		private var angle:Number;
		private var checked:Boolean;

		
		public function BeachScene()
		{
			super();
			 basicAnims = ["_begsonicJogging","_begsonicJumpFalling","_begsonicJumpRising","_begsonicRunning","_begsonicSprinting","_begsonicwaiting","_begsonicWalking","_midsonicJogging","_midsonicJumpFalling","_midsonicRunning","_midsonicSprinting","_midsonicwaiting","_midsonicWalking","_endsonicJogging","_endsonicJumpFalling","_endsonicJumpRising","_endsonicRunning","_endsonicSprinting","_endsonicwaiting","_endsonicWalking"]

			 atlas.push("BeachScntxtr1")
		}
		// i think we need to set the textures to null after finished using them to promote the garbage collection
		override public function EnterScene():void
		{
			
//			MainSceneMotor.autoVP = false;
//
//			
		box = new Body(BodyType.KINEMATIC);
		
		
		box.shapes.add(new Polygon(Polygon.box(60,600)));
		box.position.setxy(108251, +664);
		box.space = MainSceneMotor.space;
		
		brknHrnt = new BrokenHornet();
		var brknRbble:BrokenRubble = new BrokenRubble();
		
		// these are the two hornets that make up the rubble and the broken hornets and the netcaught thing
		var hnt:Hornet= Hornet(Main.liveCamera.addNewBaddie(108031, -600,0,[]));
		hnt.currScene[0] = brknHrnt
		
 		netscnry = Main.liveCamera.addNewAnimatedScenary(-51921,-664,-64344,Assets.getAtlas("testin").getTextures("netCaught"))
		teaseBaddie =  AnimatedScenary(Main.liveCamera.SmartLoadScenary(-4457,1148,-281,"teasingBaddie","teasingHornet",3))
			
		hnt2 = Hornet(Main.liveCamera.addNewBaddie(108331, -600,0,[]));
		hnt2.currScene[0] = brknRbble
		hnt2.blocking = true
		hnt.blocking = true;
		hero = Main.liveCamera.hero_mc
		
			// i dont know what the hell this is
		rotPath.ptsArray = [{X:90,Y:0,Z:0,D:0},{X:0,Y:0,Z:0,D:90}]
		rotPath.isDistanceChecked = false
		rotPath.lpair = [{val:29000,path:0},{val:31000,path:1}]

		// these are the after hornets
		
		Hornet(Main.liveCamera.addNewBaddie(108691, -400,0,[]));
		Hornet(Main.liveCamera.addNewBaddie(108731, -460,0,[]));
		Hornet(Main.liveCamera.addNewBaddie(108801, -450,0,[]));
		//hero.body.position.x = 11304
//		CamRotPath = true;
//		autoCamFollow = true
		}
		
		
//		override public function HeldOn(actor:GeneralActor):String
//		{
//			//throw Error
//			//trace(hero.body.position.x, "            yaseaba")
//			//an-=speed
//			
//			MainSceneMotor.mouseJoint.body2 = Main.liveCamera.hero_mc.body
//			MainSceneMotor.mouseJoint.anchor1.setxy(2000 + Math.cos(12)*100,600 + Math.sin(12)*100);
//			MainSceneMotor.mouseJoint.active = true;
//			MainSceneMotor.floor.ptsArray = [MainSceneMotor.floor.ptsArray[0],MainSceneMotor.floor.ptsArray[1]]
//			return Status.S_RUNNING
//			
//		}
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			
			if(hero.body.position.x <30000){
				hero.body.position.x =30000
			}
			
			if(hero.body.position.x <100331){
				hero.body.position.x =100331
			}
			//super.UpdateScene(actor)
			
			//net.X = (LevelEditor.awyCam.rotationX+90)*Math.PI/180
			
			//LevelEditor.awyCam.rotationX = linkedCamRot.X rotPath.pointOnLinkedPath(hero.body.position.x).X
			//trace(LevelEditor.awyCam.rotationX)
			
//			if(Main.liveCamera.hero_mc.body.position.x < 100000){
//				Main.liveCamera.hero_mc.body.position.x = 100000
//				Main.liveCamera.hero_mc.body.position.y = -664
//			}

			
			//netscnry.movie.play()
			if(hnt2.dead && !removed){
			MainSceneMotor.space.bodies.remove(box)
				removed = true
			}
			if(!hnt2.dead){
//				if(hero.body.position.x > 108251){
//					hero.body.position.x = 108231
//				}
			}
			//trace(hero.body.position.x, "bababa")

			if(false){
				//Main.autoCam = false
				if(allLoaded() && false){
					//here I assumed this was loaded from the initial load and I just wanted to grab it
					splash = getscenary ("BeachScenescenary001")//AnimatedScenary(getscenary("anim"))
						
					Main.liveCamera.pos.X = 2074.4
					Main.liveCamera.pos.Y = 1025.5438
					Main.liveCamera.pos.Z = 2423.36
						
					// this is a good of example of going full 2d with a texture
						
					splash.updateZdepth = false
					
					splash.x = -Main.liveCamera.x
					splash.y = -Main.liveCamera.y
					splash.scaleX = 1;
					splash.scaleY = 1;
					MainSceneMotor.vpX = Main.liveCamera.pos.X + 210
					MainSceneMotor.vpY = Main.liveCamera.pos.Y - 600
					
				}
				
			}else if(true){
				if(!allLoaded())
					return
				sonicJogging = begsonicJogging;
				
				if(splash != null)
				splash.alpha = 0;
				splash = null;
				sonicJumpFalling = begsonicJumpFalling;
				sonicJumpRising = begsonicJumpRising;
				sonicRunning = begsonicRunning;
				sonicSprinting = begsonicSprinting;
				sonicwaiting = begsonicwaiting;
				sonicWalking = begsonicWalking;
				
			MainSceneMotor.vpX = Main.liveCamera.pos.X - 50
				
			if(allLoaded() && false){
				
				intobeach =	AnimatedScenary(getscenary("anim"))
			
//					if(hero.body.position.x < 13735){
//						hero.body.position.x = 13735
//					}
				
					
			intobeach.updateZdepth = false
				
			intobeach.x = -Main.liveCamera.x
			intobeach.y = -Main.liveCamera.y
			intobeach.scaleX = 1;
			intobeach.scaleY = 	1;
			
			}
			}else if(hero.body.position.x > midbeg && hero.body.position.x <= midend){
				if(!enteredMid){
				sonicJogging = null
				sonicJumpFalling = null
				sonicJumpRising = null
				sonicRunning = null
				sonicSprinting = null
				sonicwaiting =null;
				sonicWalking = null;
				}
			MainSceneMotor.vpX = Main.liveCamera.pos.X	
//			midbeach = getscenary("BeachScenescenary002");
//			midbeach.scaleZ = 3;
//			midbeach.alpha = .5
			//net.X = brknHrnt.X
			//net.Y = brknHrnt.Y;
			//net.Z = brknHrnt.Z;
			if(hero.body.position.x >107031 && hero.body.position.x <109231){
		    stage_mc = Main.liveCamera
			sonicWalking = _sonicWalkLookUp;
			sonicwaiting = _sonicwaitingLookUp;
			sonicJogging = _sonicLookUpjogging;
//			stage_mc.speed.X = (stage_mc.pos.X-150 - stage_mc.hero_mc.X)/12;
//			stage_mc.speed.Y  = (stage_mc.pos.Y +delta - stage_mc.hero_mc.Y-150)/12
//
//			stage_mc.pos.Z += (Main.liveCamera.hero_mc.Z + 80 -stage_mc.pos.Z)/35
//			if(delta > -100){
//				
//			delta -=.5
//			}
			if(hero.key.Y < 0 && !pressed){
			switchMovie(netscnry, "netFree")
			
			netscnry.movie.loop = false
			pressed = true
			}
			}
			if( hero.body.position.x >109231 ){
				

				if(teaseBaddie.frms < teaseBaddie.movie.currentFrame){
				teaseBaddie.x = -Main.liveCamera.x//+intoSkyX
					teaseBaddie.y = -Main.liveCamera.y//+intoSkyY
					teaseBaddie.scaleX =1;
				}else{
					teaseBaddie.alpha = .3
				}
					//				intosky.scaleY =1;
			}else{
				// its a dumb solution but who cares
				Hornet.killcount == killet
			}
			
			}else{
			
			MainSceneMotor.vpX = Main.liveCamera.pos.X+50
			
			outobeach =	getscenary("BeachScenescenary003")
			outobeach.updateZdepth = false
			outobeach.x = -Main.liveCamera.x
			outobeach.y = -Main.liveCamera.y 
			outobeach.scaleX = .5;
			outobeach.scaleY = .5;
			sonicJogging = endsonicJogging;
			sonicJumpFalling = endsonicJumpFalling;
			sonicJumpRising = endsonicJumpRising;
			sonicRunning =endsonicRunning;
			sonicSprinting = endsonicSprinting;
			sonicwaiting = endsonicwaiting;
			sonicWalking = endsonicWalking;
			//outobeach.Z = Main.liveCamera.pos.Z
			}	
			if(hero.body.position.x > beg)
			MainSceneMotor.vpY = Main.liveCamera.pos.Y-200
			
//			if(hero.body.position.x > 23100 && !next){
//				director.nextScene();
//					next = true
//			}
			
		}
		override public function Attacking(actor:GeneralActor):String
		{
			if( hero.body.position.x >109231  && Hornet.killcount - killet > 1 &&  Hornet.killcount -killet < 3){
				if(!Baddie(actor).attackingState || Baddie(actor).dead)
				{
					// do the swooping in and what not
					return Status.S_FAILURE
				}else{
					if(Baddie(actor).canAttack)
						Baddie(actor).canAttack = false;
					
					if(Baddie(actor).waitTimeticker>0)
						Baddie(actor).waitTimeticker = 0
					
					
					if(checked){
					var dy:Number =  actor.target.Y- Baddie(actor).body.position.y;
					var dx:Number = actor.target.X - Baddie(actor).body.position.x;
					angle =Math.atan2(dy, dx);
					 checked = false
					}
					
					Baddie(actor).body.position.x +=Math.cos(angle)*6
					Baddie(actor).body.position.y +=Math.sin(angle)*6

						
					if(Baddie(actor).body.position.y < -664){
						Baddie(actor).body.position.y == -664
						explosionmc.X = Baddie(actor).X
						explosionmc.Y = Baddie(actor).Y
						explosionmc.Z = Baddie(actor).Z
						explosionmc.movie.play()
						Baddie(actor).Destroy()
						
					}
						
					return Status.S_RUNNING
				}
				
			}else{
				
			return Baddie(actor).Attacking();
			}
		}
		override public function reactToTaunt(baddie:Baddie):void
		{
			if(hero.body.position.x >109231 && isfirstTaunt){
				teaseBaddie.movie.play()
					teaseBaddie.alpha = 1
						isfirstTaunt = false
			}
			baddie.attackingState = true;
			baddie.justAttacked = false;
			
		}
		
		
		public function get begsonicJogging():String
		{
			return _begsonicJogging;
		}

		public function set begsonicJogging(value:String):void
		{
			_begsonicJogging = value;
		}

		public function get begsonicJumpFalling():String
		{
			return _begsonicJumpFalling;
		}

		public function set begsonicJumpFalling(value:String):void
		{
			_begsonicJumpFalling = value;
		}

		public function get begsonicJumpRising():String
		{
			return _begsonicJumpRising;
		}

		public function set begsonicJumpRising(value:String):void
		{
			_begsonicJumpRising = value;
		}

		public function get begsonicRunning():String
		{
			return _begsonicRunning;
		}

		public function set begsonicRunning(value:String):void
		{
			_begsonicRunning = value;
		}

		public function get begsonicSprinting():String
		{
			return _begsonicSprinting;
		}

		public function set begsonicSprinting(value:String):void
		{
			_begsonicSprinting = value;
		}

		public function get begsonicwaiting():String
		{
			return _begsonicwaiting;
		}

		public function set begsonicwaiting(value:String):void
		{
			_begsonicwaiting = value;
		}

		public function get begsonicWalking():String
		{
			return _begsonicWalking;
		}

		public function set begsonicWalking(value:String):void
		{
			_begsonicWalking = value;
		}

		public function get midsonicJogging():String
		{
			return _midsonicJogging;
		}

		public function set midsonicJogging(value:String):void
		{
			_midsonicJogging = value;
		}

		public function get midsonicJumpFalling():String
		{
			return _midsonicJumpFalling;
		}

		public function set midsonicJumpFalling(value:String):void
		{
			_midsonicJumpFalling = value;
		}

		public function get midsonicRunning():String
		{
			return _midsonicRunning;
		}

		public function set midsonicRunning(value:String):void
		{
			_midsonicRunning = value;
		}

		public function get midsonicSprinting():String
		{
			return _midsonicSprinting;
		}

		public function set midsonicSprinting(value:String):void
		{
			_midsonicSprinting = value;
		}

		public function get midsonicwaiting():String
		{
			return _midsonicwaiting;
		}

		public function set midsonicwaiting(value:String):void
		{
			_midsonicwaiting = value;
		}

		public function get midsonicWalking():String
		{
			return _midsonicWalking;
		}

		public function set midsonicWalking(value:String):void
		{
			_midsonicWalking = value;
		}

		public function get endsonicJogging():String
		{
			return _endsonicJogging;
		}

		public function set endsonicJogging(value:String):void
		{
			_endsonicJogging = value;
		}


		public function get endsonicRunning():String
		{
			return _endsonicRunning;
		}

		public function set endsonicRunning(value:String):void
		{
			_endsonicRunning = value;
		}

		public function get endsonicSprinting():String
		{
			return _endsonicSprinting;
		}

		public function set endsonicSprinting(value:String):void
		{
			_endsonicSprinting = value;
		}

		public function get endsonicwaiting():String
		{
			return _endsonicwaiting;
		}

		public function set endsonicwaiting(value:String):void
		{
			_endsonicwaiting = value;
		}

		public function get endsonicWalking():String
		{
			return _endsonicWalking;
		}

		public function set endsonicWalking(value:String):void
		{
			_endsonicWalking = value;
		}

		public function get midsonicJumpRising():String
		{
			return _midsonicJumpRising;
		}

		public function set midsonicJumpRising(value:String):void
		{
			_midsonicJumpRising = value;
		}

		public function get endsonicJumpFalling():String
		{
			return _endsonicJumpFalling;
		}

		public function set endsonicJumpFalling(value:String):void
		{
			_endsonicJumpFalling = value;
		}

		public function get endsonicJumpRising():String
		{
			return _endsonicJumpRising;
		}

		public function set endsonicJumpRising(value:String):void
		{
			_endsonicJumpRising = value;
		}

		public function get sonicwaitingLookUp():String
		{
			return _sonicwaitingLookUp;
		}

		public function set sonicwaitingLookUp(value:String):void
		{
			_sonicwaitingLookUp = value;
		}

		public function get sonicWalkLookUp():String
		{
			return _sonicWalkLookUp;
		}

		public function set sonicWalkLookUp(value:String):void
		{
			_sonicWalkLookUp = value;
		}

		public function get sonicLookUpjogging():String
		{
			return _sonicLookUpjogging;
		}

		public function set sonicLookUpjogging(value:String):void
		{
			_sonicLookUpjogging = value;
		}

		
	}
}