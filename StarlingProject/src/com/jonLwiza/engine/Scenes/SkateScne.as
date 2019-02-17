package com.jonLwiza.engine.Scenes 
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Path;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	import starling.display.Image;
	
	public class SkateScne extends Cut
	{
		private var chairBody:Body;
		private var swtch:Boolean = true;
		private var pos:Vector3 = new Vector3();
		private var camPath:Path
		private var chip:Number = .25;
		private var foreground:Scenary;
		private var forSwap:Boolean = false;
		private var passed:Boolean = false;
		private var something:Boolean;
		private var pased:Boolean;
		private var grndInd:int;
		private var heroInd:int;
		protected var hornetsFlyAway:AnimatedScenary = new AnimatedScenary()
		private var hrnetPath:Path = new Path();
		private var ticker:int;
		private var checkSet:Boolean  = false;
		private var loopStart:Number = 2300;
		private var inAlter:Boolean;
		public function SkateScne()
		{
			super();
		}
		
		override public function LeaveCut():void
		{
			
		}
		override public function EnterScene():void
		{
			
		//isConstantSort = false	
//			camPath = new Path(Director.paths[0])
//			
//			
//			var hnt:Hornet= Hornet(Main.liveCamera.addNewBaddie(7469.457386983606, 5034.250048828125,0,[]));
			
			hornetsFlyAway = Main.liveCamera.addNewAnimatedScenary(-4457,1148,-281,Assets.getAtlas("BeachScntxtr1").getTextures("brknMess"),"wood")

//			
			
		}
		override protected function UpdateScene(actor:GeneralActor=null):void{
			//inAlter = false
			
				
				return;
			//trace(linkedCamPos.X)
			
//			if(!LevelEditor.isFollow){
//				LevelEditor.awyCam.z = linkedCamPos.Z
//				LevelEditor.awyCam.y = linkedCamPos.Y
//				LevelEditor.awyCam.x = linkedCamPos.X
//			}
				// okay I put in Alter again this is terrible but its fine and body position
			if(Main.liveCamera.hero_mc.body.position.x >=2347.033496685604&& Main.liveCamera.hero_mc.body.position.x <=3085.021470830767 && false){
				//ok this is great because this is how you move character based on the camera, rather than the world, great for flash stuff
				if(beg != 2347.033496685604&& end !=3085.021470830767){ 
					p.ptsArray = [{X:255.7,Y:243.4,Z:0},{X:274.8,Y:6.9,Z:0},{X:539.05,Y:72.05,Z:0},{X:539.05,Y:72.1,Z:0},{X:539.05,Y:72.15,Z:0},{X:539.05,Y:72.2,Z:0},{X:539.05,Y:72.25,Z:0},{X:539.05,Y:72.3,Z:0},{X:539.05,Y:72.35,Z:0},{X:539.05,Y:72.4,Z:0},{X:539.05,Y:72.45,Z:0},{X:539.05,Y:72.5,Z:0},{X:539.05,Y:72.55,Z:0},{X:539.05,Y:72.6,Z:0},{X:539.05,Y:72.65,Z:0},{X:539.05,Y:72.7,Z:0},{X:539.05,Y:72.75,Z:0},{X:539.05,Y:72.8,Z:0},{X:539.4,Y:72.75,Z:0},{X:539.4,Y:72.8,Z:0},{X:539.4,Y:72.85,Z:0},{X:539.4,Y:72.9,Z:0},{X:539.4,Y:72.95,Z:0},{X:539.4,Y:73,Z:0},{X:539.4,Y:73.1,Z:0},{X:539.4,Y:73.8,Z:0},{X:539.4,Y:73.05,Z:0},{X:62.45,Y:166,Z:0},{X:61.75,Y:166.1,Z:0},{X:61.05,Y:166.15,Z:0},{X:60.4,Y:166.3,Z:0},{X:59.65,Y:166.3,Z:0},{X:58.85,Y:166.45,Z:0},{X:58.1,Y:166.45,Z:0},{X:57.35,Y:166.55,Z:0},{X:56.55,Y:166.65,Z:0},{X:55.85,Y:166.7,Z:0},{X:55.2,Y:166.8,Z:0},{X:54.5,Y:166.85,Z:0},{X:53.85,Y:166.95,Z:0},{X:53.15,Y:167,Z:0},{X:393.45,Y:251.1,Z:0}] 
					
					Main.liveCamera.hero_mc.prxy = new Vector3()
					p.lpair = [{val:2347.033496685604,path:0},{val:2365.0332033720715,path:1},{val:2383.0329100585386,path:2},{val:2401.032616745006,path:3},{val:2419.0323234314737,path:4},{val:2437.032030117941,path:5},{val:2455.0317368044084,path:6},{val:2473.0314434908755,path:7},{val:2491.031150177343,path:8},{val:2509.0308568638106,path:9},{val:2527.0305635502777,path:10},{val:2545.0302702367453,path:11},{val:2563.029976923213,path:12},{val:2581.02968360968,path:13},{val:2599.0293902961475,path:14},{val:2617.0290969826146,path:15},{val:2635.028803669082,path:16},{val:2653.0285103555498,path:17},{val:2671.028217042017,path:18},{val:2689.0279237284844,path:19},{val:2707.027630414952,path:20},{val:2725.027337101419,path:21},{val:2743.0270437878867,path:22},{val:2761.0267504743542,path:23},{val:2779.0264571608213,path:24},{val:2797.026163847289,path:25},{val:2815.0258705337565,path:26},{val:2833.0255772202236,path:27},{val:2851.025283906691,path:28},{val:2869.0249905931582,path:29},{val:2887.024697279626,path:30},{val:2905.024403966093,path:31},{val:2923.0241106525605,path:32},{val:2941.023817339028,path:33},{val:2959.023524025495,path:34},{val:2977.0232307119627,path:35},{val:2995.0229373984303,path:36},{val:3013.0226440848974,path:37},{val:3031.022350771365,path:38},{val:3049.0220574578325,path:39},{val:3067.0217641442996,path:40},{val:3085.021470830767,path:41}]
					
					
					beg =2347.033496685604
					end =3085.021470830767
				}
				inAlter = true
				pos = p.pointOnLinkedPath(Main.liveCamera.hero_mc.body.position.x)
				Main.liveCamera.hero_mc.updateZdepth = false
				Main.liveCamera.hero_mc.x = pos.X
				Main.liveCamera.hero_mc.y = pos.Y
			}











			
				
				
				
				
				
				
				
				
				
				
			if(!inAlter){
				//Main.liveCamera.hero_mc.prxy = null
				beg =0
				end =0
			}
			
			if(checkSet){
//			ticker+=10
//				var plmt:Vector3 = hrnetPath.placement(ticker)
//					hornetsFlyAway.X = plmt.X
//					hornetsFlyAway.Y = plmt.Y
//					hornetsFlyAway.Z = plmt.Z
//			}
			}
		if(Main.liveCamera.hero_mc.body.position.x >= loopStart){
//			if(!checkSet){
//				hornetsFlyAway.movie.play()
//				ticker = 0
//				checkSet = true
//				}
//			
//			// this is how you pass by value and not just a reference to ther original
//			// I dunno how smart it is to do but uh yeah
//			hrnetPath.ptsArray  =	Assets.clone([{X:0,Y:0,Z:0,D:0},{X:hero.X,Y:hero.Y-100,Z:hero.Z,D:0 },{X:hero.X,Y:hero.Y-300,Z:hero.Z + 5000,D:0}])
		}
			// this is sad because it may not work here but will work when I change the system over if so Ill just do a simple hack like += 10
			
			
			return
			var sncPce:Number = (Main.liveCamera.hero_mc.body.position.x - Director.floorpts[1].D)/(Director.floorpts[Director.floorpts.length -1].D - Director.floorpts[1].D)
			pos = camPath.placement(sncPce)
				
			if(allLoaded() && false){
				
//			foreground =getscenary("foreground");
//			foreground.scaleZ = .5
//			if(foreground.Z < hero.Z && !forSwap){
//				Main.liveCamera.setChildIndex(foreground,Main.liveCamera.getChildIndex(hero)-1)
//				forSwap = true
//			}else if(foreground.Z > hero.Z && forSwap){
//					
//					Main.liveCamera.setChildIndex(foreground,Main.liveCamera.getChildIndex(hero)+1)
//					forSwap = false
//				}
				
				
			}else{
//				if(!something){
//				hero.body.position.x = 5290	
//				hero.body.position.y = 4734
//				something = true;
//				
//				}
				Main.liveCamera.pos.X = Main.liveCamera.hero_mc.X 
				Main.liveCamera.pos.Y = Main.liveCamera.hero_mc.Y - 80 
				Main.liveCamera.pos.Z =Main.liveCamera.hero_mc.Z-150
			}
				
				if(Main.testing == 2){
					
					stage_mc =Main.liveCamera
					if(Main.liveCamera.hero_mc.body.position.x <2580){
						
						stage_mc.speed.X = (stage_mc.pos.X - stage_mc.hero_mc.X)/6;
						stage_mc.speed.Y  = (stage_mc.pos.Y - stage_mc.hero_mc.Y)/6
						stage_mc.pos.Z = stage_mc.hero_mc.Z 
					}else if(Main.liveCamera.hero_mc.body.position.x <23783){
						//trace("first");
						stage_mc.pos.X += ((Main.liveCamera.hero_mc.X +(Main.liveCamera.hero_mc.X - pos.X)/3 - 1300)- stage_mc.pos.X)/15;
						stage_mc.pos.Y += (pos.Y+700 - stage_mc.pos.Y)/15;
						stage_mc.pos.Z += (Main.liveCamera.hero_mc.Z+760 -stage_mc.pos.Z)/15;
					
//					}else if(Main.liveCamera.hero_mc.body.position.x <42001){
//					//	throw Error("jhg")
//						stage_mc.pos.X += ((Main.liveCamera.hero_mc.X +(Main.liveCamera.hero_mc.X - pos.X)/3)- stage_mc.pos.X)/15;
//						stage_mc.pos.Y += (pos.Y+700 - stage_mc.pos.Y)/15;
//						stage_mc.pos.Z += (Main.liveCamera.hero_mc.Z+940 -stage_mc.pos.Z)/15;
//					}else if(Main.liveCamera.hero_mc.body.position.x <70050){
//						stage_mc.pos.X += ((Main.liveCamera.hero_mc.X +(Main.liveCamera.hero_mc.X - pos.X)/3)+100- stage_mc.pos.X)/15;
//						stage_mc.pos.Y += (pos.Y+270 - stage_mc.pos.Y)/15;
//						stage_mc.pos.Z += (Main.liveCamera.hero_mc.Z+900 -stage_mc.pos.Z)/(15 - chip);
//					}
//					if(Main.liveCamera.hero_mc.Z < -5346.){
//						stage_mc.pos.X += (Main.liveCamera.hero_mc.X - stage_mc.pos.X)/15
//						stage_mc.pos.Y += (Main.liveCamera.hero_mc.Y - stage_mc.pos.Y)/5
//						stage_mc.pos.Z += (Main.liveCamera.hero_mc.Z-200 -stage_mc.pos.Z)/3
//
//						//	stage_mc.speed.Y  = (stage_mc.pos.Y - stage_mc.hero_mc.Y)/12
//						//	stage_mc.pos.Z = stage_mc.hero_mc.Z 
//					}if(Main.liveCamera.hero_mc.Z < 6043){
//						stage_mc.pos.X += (Main.liveCamera.hero_mc.X - stage_mc.pos.X)/15
//						stage_mc.pos.Y += (Main.liveCamera.hero_mc.Y - stage_mc.pos.Y)/5
//						stage_mc.pos.Z +=(Main.liveCamera.hero_mc.Z-200 -stage_mc.pos.Z)/13
//						stage_mc.speed.Y  = (stage_mc.pos.Y - stage_mc.hero_mc.Y)/12
//						stage_mc.pos.Z = stage_mc.hero_mc.Z 
//					if(Main.liveCamera.hero_mc.body.position.x < 7400){
//						stage_mc.pos.X += (Main.liveCamera.hero_mc.X - stage_mc.pos.X)/15
//						stage_mc.pos.Y += (Main.liveCamera.hero_mc.Y - stage_mc.pos.Y)/5
//						stage_mc.pos.Z +=(Main.liveCamera.hero_mc.Z-200 -stage_mc.pos.Z)/3
//
//				
//					}else if(Main.liveCamera.hero_mc.body.position.x < 8590){
//						stage_mc.pos.X += (Main.liveCamera.hero_mc.X - stage_mc.pos.X)/15
//						stage_mc.pos.Y += (Main.liveCamera.hero_mc.Y - stage_mc.pos.Y)/5
//						stage_mc.pos.Z +=(Main.liveCamera.hero_mc.Z-200 -stage_mc.pos.Z)/3
//
//
//					}else{
//					stage_mc.pos.X += ((Main.liveCamera.hero_mc.X +(Main.liveCamera.hero_mc.X - pos.X)/2)- stage_mc.pos.X)/15
//					stage_mc.pos.Y = pos.Y
//					stage_mc.pos.Z +=(Main.liveCamera.hero_mc.Z+100 -stage_mc.pos.Z)/3
//					}					
						
					if(Main.liveCamera.hero_mc.body.position.x > 67555 && !passed){
						director.nextScene()
						passed = true;
					}
				}
				//
				//trace(Main.liveCamera.hero_mc.body.position.x, " nte other ", sncPce)
			if(allLoaded()){
				
				foreground =getscenary("foreground")//AnimatedScenary(getscenary("anim"))

				if(hero.Z > foreground.Z && !pased){
					pased = true
				grndInd =	Main.liveCamera.getChildIndex(foreground)
				heroInd =	Main.liveCamera.getChildIndex(hero)
					Main.liveCamera.swapChildrenAt(heroInd, grndInd)
				}
				
				for (var i:int = 0; i < Main.liveCamera.scenary.length; i++) 
				{
					Main.liveCamera.scenary[i].scaleZ = 8*10
					if(i ==0)
						Main.liveCamera.scenary[i].scaleZ = 2*10
				if(i ==Main.liveCamera.scenary.length-1)
				Main.liveCamera.scenary[i].scaleZ = i*8*10/2
				}
			}
			
		}
	}
	
}
}