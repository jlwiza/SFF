package com.jonLwiza.engine.Scenes
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Path;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.Cars;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import starling.display.Image;
	
	public class CliffScene extends Cut
	{

		private var car1:Cars;

		private var tl:TimelineMax;
		private var car2:Cars;
		private var driveIn:AnimatedScenary;
		private var flagged:Boolean = false;
		private static var t2pos:Object 
		private static var t3pos:Object 
		private static var t4pos:Object 
		private static var t5pos:Object 
		private var drivepart:int;
		private var cntdwn:int;
		private var oldrivepart:int;
		private var entered:Boolean;
		private var driveInCar:AnimatedScenary;
		private var end1:int;
		private var check2:Boolean = false;
		private var check3:Boolean = false
		private var floorPath:Path = new Path();
		private var enteredswitch:uint = 0;
		
		public function CliffScene()
		{
			super();
			
		}
		
		
		
		override public function LeaveCut():void
		{
			MainSceneMotor.autoVP = true;
		}
		override public function EnterScene():void
		{
			CamRotPath = true
			autoCamFollow = true
			hero = Main.liveCamera.hero_mc 
			car1 = Cars(Main.liveCamera.addNewBaddie(hero.body.position.x + 1000,hero.body.position.y,0,[],"Cars"))
			car2 = Cars(Main.liveCamera.addNewBaddie(hero.body.position.x + 1500,hero.body.position.y,0,[],"Cars"))
			floorPath.ptsArray = MainSceneMotor.floor.ptsArray
			// this probably isnt true since it defaults to yes but for reference purposes
			floorPath.isDistanceChecked = true
				
			//driveIn = Main.liveCamera.addNewAnimatedScenary(13413.837937516404,1218.1001159051607,-20,Assets.getAtlas("backgrnds").getTextures("driving"))
//			driveInCar = Main.liveCamera.addNewAnimatedScenary(13413.837937516404,1218.1001159051607,-20,Assets.getAtlas("backgrounds").getTextures("driveingCar"),"",true)
//			
//			Director.scenary.push({name:"drivein"})
//			Director.scenary.push({name:"drivecar"})
				sonicwaiting ="CliffSonicwaiting"
				sonicWalking ="CliffSonicWalking"
				sonicJogging ="cliffSonicJogging"
//
				drivepart = 1;
			t2pos = MainSceneMotor.floor.ptsArray[2]
			t3pos = MainSceneMotor.floor.ptsArray[3]
			t4pos = MainSceneMotor.floor.ptsArray[4]
			t5pos = MainSceneMotor.floor.ptsArray[5]
			
		}
		
		
		override protected function UpdateScene(actor:GeneralActor=null):void{
			super.UpdateScene(actor)
			trace(LevelEditor.awyCam.rotationX,"rotation")
			//MainSceneMotor.fl -=.5
			
			
			
			
			if(hero.body.position.x < 195700){
				
			}else if(hero.body.position.x < 527580&& !check2){
				car1.body.position.x = 195700 + 1000
					// ill later just set its path on the y that is the ground points
				car1.body.position.y = floorPath.placement(car1.body.position.x).Y
				//check2 = true
			}else if(hero.body.position.x > 671000&&hero.body.position.x < 671000 && !check3){
				car1.body.position.x = 527580 + 1000
				// ill later just set its path on the y that is the ground points
				car1.body.position.y =floorPath.placement(car1.body.position.x).Y
				check3 = true
			}
			return
			if(hero.body.position.x > 311580 && false ){
					if(enteredswitch == 0){
						enteredswitch ++
						
						
						deleteOldies()
						Director.scenary = [{X: -126321.65,Y: 2200.00,Z: -200042.20,ScaleX: 8.01,ScaleY: 8.01,name: "cliffScneScenary010",frms: 1},{X: -142460.00,Y: 8134.00,Z: -201588.60,ScaleX: 2.15,ScaleY: 2.15,name: "cliffScneScenary011",frms: 1},{X: -167105.80,Y: 12932.95,Z: -201588.60,ScaleX: 10.44,ScaleY: 10.44,name: "cliffScneScenary012",frms: 1},{X: -230819.05,Y: 21566.31,Z: -201588.60,ScaleX: 11.97,ScaleY: 11.97,name: "cliffScneScenary013",frms: 1},{X: -251645.30,Y: 45560.94,Z: -202928.16,ScaleX: 1.85,ScaleY: 1.85,name: "cliffScneScenary014",frms: 1},{X: -272027.82,Y: 36412.27,Z: -229565.92,ScaleX: 19.01,ScaleY: 19.01,name: "cliffScneScenary015",frms: 1},{X: -282568.00,Y: 59227.60,Z: -148379.10,ScaleX: 4.95,ScaleY: 4.95,name: "cliffScneScenary016",frms: 1},{X: -322937.81,Y: 16715.72,Z: -319545.00,ScaleX: 14.75,ScaleY: 14.75,name: "cliffScneScenary017",frms: 1},{X: -284043.84,Y: 40744.00,Z: -258056.48,ScaleX: 15.09,ScaleY: 15.09,name: "cliffScneScenary018",frms: 1},{X: -278782.80,Y: 33317.50,Z: -301106.80,ScaleX: 23.82,ScaleY: 23.82,name: "cliffScneScenary019",frms: 1},{X: -283388.34,Y: 19840.25,Z: -309887.55,ScaleX: 8.16,ScaleY: 8.16,name: "cliffScneScenary020",frms: 1},{X: -388604.00,Y: 53780.95,Z: -301667.53,ScaleX: 14.06,ScaleY: 14.06,name: "cliffScneScenary021",frms: 1},{X: -363950.64,Y: 23199.12,Z: -323883.64,ScaleX: 19.15,ScaleY: 19.15,name: "cliffScneScenary022",frms: 1},{X: -402289.50,Y: 50079.08,Z: -238237.81,ScaleX: 10.51,ScaleY: 10.51,name: "cliffScneScenary023",frms: 1},{X: -403967.90,Y: 51157.00,Z: -277481.90,ScaleX: 0.62,ScaleY: 0.62,name: "cliffScneScenary024",frms: 1},{X: -406630.89,Y: 51057.40,Z: -279505.97,ScaleX: 10.08,ScaleY: 10.08,name: "cliffScneScenary025",frms: 1},{X: -398745.49,Y: 48602.86,Z: -197872.95,ScaleX: 5.36,ScaleY: 5.36,name: "cliffScneScenary026",frms: 1}]
							for (var i:int = 0; i < Director.scenary.length; i++) 
							{
								Assets.LoadQue.push(Director.scenary[i].name)
							}
					}
			}
			
			if(enteredswitch == 1 && Assets.LoadQue.length == 0){
				for (var scIter:int = 0; scIter < Director.scenary.length; scIter++) 
				{
					Main.liveCamera.addNewScenary(Director.scenary[scIter].X,Director.scenary[scIter].Y,Director.scenary[scIter].Z,new Image(Assets.getTexture(Director.scenary[scIter].name)),Director.scenary[scIter].name, null,false,Director.scenary[scIter].ScaleX)

				}
				enteredswitch ++
			}
//			car1.body.position.x  = hero.body.position.x+ 80
//			car1.body.position.y  = hero.body.position.y
//			car2.body.position.x -= 10;
			// i think I'm gonna use the depricated function to get the x, and y Im pretty sure it should just work, im not sure why but i know other things just worked so Im not to worried
			
			//if(car2.body.position.x < hero.body.position.x)
			cntdwn --;
			//trace(cntdwn)
//			if(cntdwn == 0){
//				drivepart ++
//					if(drivepart == 2 || drivepart == 3)
//			car2.body.position.x  = hero.body.position.x+3600
//			}
//			whatup()
			if(drivepart>4 && ! flagged){
				flagged = true
				//Director.nextScene()
			}
			MainSceneMotor.vpX = Main.liveCamera.pos.X
			MainSceneMotor.vpY = Main.liveCamera.pos.Y-60
			//actor.body.position.x = 42218	
			if(allLoaded() && false){
				
				
				driveIn.updateZdepth = false
				driveIn.alpha = 0.5
				driveIn.x = -Main.liveCamera.x
				driveIn.y = -Main.liveCamera.y
				driveIn.scaleX = 1.0;
				driveIn.scaleY = 1.0;
//				driveInCar.updateZdepth = false
//				
//				driveInCar.x = -Main.liveCamera.x
//				driveInCar.y = -Main.liveCamera.y
//				driveInCar.scaleX = 1.0;
//				driveInCar.scaleY = 1.0;
			}
			if(actor.body.angularVel > 70)
			actor.body.angularVel = 70
		}
		
		public function whatup():void{
			if(oldrivepart != drivepart){
				entered = false
				oldrivepart = drivepart
			}else{
				entered = true
			}
			switch(drivepart)
			{
				case 1:
				{
					if(!entered){
						cntdwn = 600
						driveIn.alpha = 0
						//end1 = MainSceneMotor.floor.ptsArray[i].Y + 10
					}
					tl = new TimelineMax()
					
					var time:Number = 2.0
					//add a tween
					for (var i:int =0; i < MainSceneMotor.floor.ptsArray.length; i++) 
					{
						if(MainSceneMotor.floor.ptsArray[i].D > hero.body.position.x)
							break;
						//tl.insert(TweenLite.to(MainSceneMotor.floor.ptsArray[i], time, {Y:end1,  ease:Linear.easeNone}));
					}
					MainSceneMotor.floor.ptsArray[2].Y += .005
					
					//					MainSceneMotor.floor.ptsArray[2].Y += (t2pos.Y - 8 -MainSceneMotor.floor.ptsArray[2].Y )/300
					//					MainSceneMotor.floor.ptsArray[3].Y += (t3pos.Y - 10-MainSceneMotor.floor.ptsArray[3].Y )/300
					//					MainSceneMotor.floor.ptsArray[4].Y += (t4pos.Y - 20-MainSceneMotor.floor.ptsArray[4].Y )/300
					//					MainSceneMotor.floor.ptsArray[5].Y += (t5pos.Y - 40-MainSceneMotor.floor.ptsArray[5].Y )/300
					break;
				}
				case 2:
				{
					if(!entered){
						driveIn.switchMovie("drivin2","backgrounds")
						driveInCar.switchMovie("drivin2Car", "backgrounds")
						cntdwn = 500
						//end
						
						
						
						//tl.insert(TweenLite.to(this.body.position, time, {y:targetBaddie.body.position.y}));
						//tl.insert(TweenLite.to(this, time, {Z:targetBaddie.Z}));
						
					}
					
					for (var i:int =0; i < MainSceneMotor.floor.ptsArray.length; i++) 
					{
						if(cntdwn > 150){
							MainSceneMotor.floor.ptsArray[i].D-=1
						}
						//tl.insert(TweenLite.to(MainSceneMotor.floor.ptsArray[i], time, {Y:end1,  ease:Linear.easeNone}));
					}
					//					if(cntdwn > 450){
					//					MainSceneMotor.floor.ptsArray[2].Y ++
					//					MainSceneMotor.floor.ptsArray[3].Y ++
					//					MainSceneMotor.floor.ptsArray[4].Y ++
					//					MainSceneMotor.floor.ptsArray[5].Y ++
					//					}
					break;
				}
				case 3:
				{
					if(!entered){
						driveIn.switchMovie("drivin3","backgrounds")
						driveInCar.switchMovie("drivin3Car","backgrounds")
						cntdwn = 500
					}
					
					
					//add a tween
					for (var i:int =0; i < MainSceneMotor.floor.ptsArray.length; i++) 
					{
						
						if(cntdwn > 300){
							MainSceneMotor.floor.ptsArray[i].D-=1
							MainSceneMotor.floor.ptsArray[i].Y+=.5
							MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x, MainSceneMotor.floorBody,false);
						}
						//tl.insert(TweenLite.to(MainSceneMotor.floor.ptsArray[i], time, {Y:end1,  ease:Linear.easeNone}));
					}
					//					MainSceneMotor.floor.ptsArray[2].Y += (t2pos.Y - 8 -MainSceneMotor.floor.ptsArray[2].Y )/30
					//					MainSceneMotor.floor.ptsArray[3].Y += (t3pos.Y - 10-MainSceneMotor.floor.ptsArray[3].Y )/30
					//					MainSceneMotor.floor.ptsArray[4].Y += (t4pos.Y - 20-MainSceneMotor.floor.ptsArray[4].Y )/30
					//					MainSceneMotor.floor.ptsArray[5].Y += (t5pos.Y - 40-MainSceneMotor.floor.ptsArray[5].Y )/30
					
					//					MainSceneMotor.floor.ptsArray[2].X += (t2pos.X - 80 -MainSceneMotor.floor.ptsArray[2].X )/30
					//					MainSceneMotor.floor.ptsArray[3].X += (t3pos.X - 10-MainSceneMotor.floor.ptsArray[3].X )/30
					//					MainSceneMotor.floor.ptsArray[4].X += (t4pos.X - 20-MainSceneMotor.floor.ptsArray[4].X )/30
					//					MainSceneMotor.floor.ptsArray[5].X += (t5pos.X - 40-MainSceneMotor.floor.ptsArray[5].X )/30
					break;
				}
				case 4:
				{
					if(!entered){
						driveIn.switchMovie("drivin4","backgrounds")
						
						cntdwn = 600
					}
					
					//					for (var i:int =0; i < MainSceneMotor.floor.ptsArray.length; i++) 
					//					{
					//						if(cntdwn > 300){
					//							MainSceneMotor.floor.ptsArray[i].D-=.5
					//						}
					//					}
					
					
					//					MainSceneMotor.floor.ptsArray[2].Y += (t2pos.Y - 10 -MainSceneMotor.floor.ptsArray[2].Y )/30
					//					MainSceneMotor.floor.ptsArray[3].Y += (t3pos.Y - 10-MainSceneMotor.floor.ptsArray[3].Y )/30
					//					MainSceneMotor.floor.ptsArray[4].Y += (t4pos.Y -MainSceneMotor.floor.ptsArray[4].Y )/30
					//					MainSceneMotor.floor.ptsArray[5].Y += (t5pos.Y -MainSceneMotor.floor.ptsArray[5].Y )/30
					//					
					//					MainSceneMotor.floor.ptsArray[2].X += (t2pos.X - 80 -MainSceneMotor.floor.ptsArray[2].X )/30
					//					MainSceneMotor.floor.ptsArray[3].X += (t3pos.X - 10-MainSceneMotor.floor.ptsArray[3].X )/30
					//					MainSceneMotor.floor.ptsArray[4].X += (t4pos.X - 20-MainSceneMotor.floor.ptsArray[4].X )/30
					//					MainSceneMotor.floor.ptsArray[5].X += (t5pos.X - 40-MainSceneMotor.floor.ptsArray[5].X )/30
					break;
				}
					
				default:
				{
					break;
				}
					
			}
			//	MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x, MainSceneMotor.floorBody,false);
			
		}
	}
}