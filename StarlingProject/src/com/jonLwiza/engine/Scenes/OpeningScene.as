package com.jonLwiza.engine.Scenes 
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Ground;
	import com.jonLwiza.engine.GeneralElements.Path;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.AnimationHandler;
	import com.jonLwiza.engine.baseConstructs.Baddie;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.Status;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import dragonBones.Armature;
	
	import nape.phys.FluidProperties;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	public class OpeningScene extends Cut
	{
		private var overide:Boolean;
		private var speed:Number;
		private var an:Number;
		
		private var center:Point;
		private var called:Boolean = false;
		
		//private var hntArmtr:Armature;
		private var log1:Number = 8385;
		private var log2:Number = 8715;
		private var skidStart:Number = 6069;
		private var skidEnd:Number = 6775;
		private var something:Boolean = true;
		private var picWidth:int = 5*2048
		private var lastY:Number;
		private var newY:Number;
		private var somepoint:Number = 47203;
		private var scIter:int = 0;
		private var list:Array = [{X:45057,Y:16185,Z:0,name:"scneopening0012",frms:1},{X:49152,Y:16351.024235195155,Z:0,name:"scneopening0013",frms:1},{X:53248,Y:17517.73532928619,Z:0,name:"scneopening0014",frms:1},{X:57344,Y:18330.583115575657,Z:0,name:"scneopening0015",frms:1},{X:61440,Y:20113.1004175654,Z:0,name:"scneopening0016",frms:1},{X:65536,Y:22467.47027905016,Z:0,name:"scneopening0017",frms:1},{X:69632,Y:24018.040376472345,Z:0,name:"scneopening0018",frms:1},{X:73728,Y:24946.041614447993,Z:0,name:"scneopening0019",frms:1},{X:77824,Y:25678.289066961323,Z:0,name:"scneopening0020",frms:1},{X:81920,Y:26952.601058833345,Z:0,name:"scneopening0021",frms:1},{X:86016,Y:28952,Z:0,name:"scneopening0022",frms:1},{X:90112,Y:31439.275780097792,Z:0,name:"scneopening0023",frms:1},{X:94208,Y:33259.431625460915,Z:0,name:"scneopening0024",frms:1},{X:98304,Y:34899.20544735808,Z:0,name:"scneopening0025",frms:1},{X:102400,Y:36506.97675656864,Z:0,name:"scneopening0026",frms:1},{X:106496,Y:37757.29701469137,Z:0,name:"scneopening0027",frms:1},{X:110592,Y:38524.95390745731,Z:0,name:"scneopening0028",frms:1}] ;
		
		private var path:Path = new Path()
		//private var list:Array = [{X:4096,Y:942.0562407002188,Z:0,name:"scneopening0012",frms:1},{X:8192,Y:1875.0126778924878,Z:0,name:"scneopening0013",frms:1},{X:12288,Y:4119.48211249903,Z:0,name:"scneopening0014",frms:1},{X:16384,Y:6941.773917870906,Z:0,name:"scneopening0015",frms:1},{X:20478,Y:8926.966118679306,Z:0,name:"scneopening0016",frms:1},{X:24573.52,Y:9011.011667013958,Z:0,name:"scneopening0007",frms:1},{X:28665.359999999997,Y:7315.793474526306,Z:0,name:"scneopening0008",frms:1},{X:32754.520000000004,Y:6646.812218310002,Z:0,name:"scneopening0009",frms:1},{X:36839.68,Y:9288.425544759395,Z:0,name:"scneopening0010",frms:1},{X:36839,Y:10288,Z:0,name:"scneopening0011",frms:1},{X:45056,Y:15072.19170536059,Z:0,name:"hornetReceeding",frms:10}] ;
		private var entered:Boolean;
		private var asomething:Boolean;
		
		protected var woodhole:AnimatedScenary = new AnimatedScenary();
		private var pg:int = 0
		private var notran:Boolean = true;
		private var playingLoopVel:Number;
		private var loopStart:Number;
		private var speedSet:Boolean;
		private var stupidCheck:Boolean = true;
		private var enteredX:Number;
		private var enteredY:Number;
		private var struggle:int = 0;
		private var grab:int = 0;
		private var activeAlter:Boolean;
		private var t:int = -1;
		private var jumptree:Array;
		
		
		private var adict:Dictionary = new Dictionary();
		
		private var key:Array = [];
		private var isholding:Boolean = true;
		private var tick:int = 0;
		private var grndCverHrnt:Baddie;
		private var flyHornet:Hornet;
		private var hrntBlaise:Hornet;
		
		private var p1:Number;
		private var targetingRecticle:AnimatedScenary = new AnimatedScenary();
		private var opningScnefarbackground:Scenary
		private var overrideRecticle:Boolean = false;
		private var isloadCheck:Boolean = false;
		private var isSwitch:Boolean = false;
		private var isHoldingVine:Boolean = false;
		private var yHold:Number;
		private var prespaceBar:Boolean = false;
		public function OpeningScene()
		{
			super();
			
			
			// this just tells hey i havent checked the distance
			path.isDistanceChecked = false
			
			jumptree = new Array()
			// I made one extra.. whatevs
			for (var i:int = 0; i < 4; i++) 
			{
				var ty:Boolean = false
				jumptree[i] = ty
			}
			
			// basically it says if we put in whatever this value is it will be at this point at the array
			// and then interpolates between the points in the path if its too low it stays on the first point too high last
			
			path.lpair = [{val:0,path:0},{val:50,path:1},{val:150,path:3}]
			
		}
		
		override public function Waiting(actor:GeneralActor):String
		{	Hornet(actor).timeTocanAttack = 5000
			if (actor.name == "anim"){
				return customHornetWaiting(actor);
			}else{
				return Baddie(actor).Waiting();
			}
			
		}
		// ok so now i have to actually code this out i have to make it so 
		// i think thats all that neesds to get done is that code hornet 
		
		// create an animation custom hornetshit and export it it then load it
		
		private function customHornetWaiting(actor:GeneralActor):String
		{
			
			//I didnt need to do this so um yeah but it sets the stage if i wanna propegate this up
			// Ill do just an if loaded to get you going
			//if(someBlah blah shit and loaded )
			if(Assets.isTextureLoaded("hornetFlyThrough",4)){
				if(actor == hrntBlaise){
					actor.straightto("hornetFlyThrough")
				}
			}
			return Status.S_RUNNING;
		}
		
		
		override public function SonicDoubleJump(actor:GeneralActor):void
		{
			if(actor.DistTo(grndCverHrnt)> 400){
				super.SonicDoubleJump(actor);
			}else{
				isSwitch = true
				flashAnims["toGround"].p.ptsArray = [{X:Main.liveCamera.hero_mc.bdy.x,Y:Main.liveCamera.hero_mc.bdy.y,Z:0}, {X:grndCverHrnt.bdy.x,Y:grndCverHrnt.bdy.y,Z:0},{X:grndCverHrnt.bdy.x,Y:grndCverHrnt.bdy.y - 200,Z:0}]
			}
			
			
		}
		
		override public function LeaveCut():void{
			
			MainSceneMotor.mouseJoint.active = false;
		}
		override public function EnterScene():void{
			
			Main.liveCamera.hero_mc.alpha = 1
			
			woodhole = Main.liveCamera.addNewAnimatedScenary(-51921,-664,-64344,Assets.getAtlas("testin").getTextures("netCaught"))
			
			//			MainSceneMotor.floorBody.shapes.at(0).fluidEnabled = true
			//			MainSceneMotor.floorBody.setShapeFluidProperties(new FluidProperties(2,2));
			//			Director.scenary[0].scaleZ = 5
			// always use smart load to load scenary or Asets.loadque because then we have a singular place that doesnt get confused
			// but its already loaded ofcoure dont use it, because of name confusion, i honestly probably wont use it excect for texture atlases at the end
			//	woodhole = AnimatedScenary(Main.liveCamera.SmartLoadScenary(-4457,1148,-281,"name","woody",3))
			//woodhole = Main.liveCamera.addNewAnimatedScenary(-4457,1148,-281,Assets.getAtlas("BeachScntxtr1").getTextures("brknMess"),"wood")
			Assets.pushMovieTexturesToQue("sonicLookround",1)
			Assets.pushMovieTexturesToQue("whoknowstumble",9)
			Assets.pushMovieTexturesToQue("tumblethrough",9)
			Assets.pushMovieTexturesToQue("sonicRunDownSlope",5)
			Assets.pushMovieTexturesToQue("sonicDashftr",5)
			Assets.pushMovieTexturesToQue("sonicJumpGlee",9)
			Assets.pushMovieTexturesToQue("sonicglideDownhill",15)
			Assets.pushMovieTexturesToQue("slideDownHill",4)
			Assets.pushMovieTexturesToQue("OpeningScene_sonicFalling",5)
			
			// (TODO:JON) I JUST PUT 5 AS A TEMPERORARY ANIM YOU NEED TO ACTUALLY CHANGE THAT
			Assets.pushMovieTexturesToQue("hornetFlyThrough",4)
			
			//5900
			// hmm its very segmented i dont do auto load and place i think its good to keep it like this so I can really load them right at the best time
			// just ask if is texture loaded and then I cando it
			//Main.liveCamera.hero_mc.playedAnimations["sonicglideDownhill"] = new MovieClip(r, 24)
			//						1800
			
			targetingRecticle = Main.liveCamera.addNewAnimatedScenary(-51921,-664,-64344,Assets.getAtlas("testin").getTextures("targetingRecticle"))
			
			flyHornet = Hornet(Main.liveCamera.addNewBaddie(-21212120 , 1800 , 0,[],"Hornet",true))
			grndCverHrnt = Hornet(Main.liveCamera.addNewBaddie(23447 , 650 , 0,[],"Hornet",true))
			hrntBlaise = Hornet(Main.liveCamera.addNewBaddie(-4430 , 1904 , 0,[],"Hornet",true))
			
			hrntBlaise.name = "anim"
			//grndCverHrnt.name = "anim"
			
			// in the game you might wanna dynamically create them into movies, all you have to do is 
			// deppending on how many keys we have i have no idea
			
			
			for (var i:int = 1; i < 14; i++) 
			{
				key[i] = {beg:999999,end:9999999}
			}
			
			key[2].end = -7150
			key[2].beg = -7500
			key[2].name = "sonicDashftr"
			
			key[3].end = -8557
			key[3].beg = -8700
			
			key[4].end = -11800
			key[4].beg = -13900
			
			key[5].end = -17400
			key[5].beg = -18000
			
			key[6].end = -18500
			key[6].beg = -19500
			
			
			flashAnims["throughGround"] = {ticker:-1,p:new Path(),active:false}
			flashAnims["throughGround"].p.ptsArray = [{X:23557,Y:290,Z:0},{X:23557,Y:-1295,Z:0},{X:28000,Y:-1175,Z:0},{X:31200,Y:-2001,Z:0}]	
			flashAnims["throughGround"].p.endVal = 300	
			
			flashAnims["hornetThrough"] = {ticker:-1,p:new Path(),active:false}
			flashAnims["hornetThrough"].p.ptsArray = [{X:-6001.083509805244,Y:2038.373967618851,Z:759.8350},{X:-6501.083509805244,Y:2038.373967618851,Z:1259.8350},{X:-6000.083509805244,Y:2038.373967618851,Z:1759.8350}]//,{X:9590.074620780797,Y:1870.4447475680445,Z:0}]
			flashAnims["hornetThrough"].p.endVal = 150
			// should work but we'll see what happens
						
			flashAnims["pip"] = {ticker:-1,p:new Path(),active:false}
			flashAnims["pip"].p.ptsArray = [{X:33800,Y:-2400,Z:0},{X:37418,Y:-2563,Z:0}]
			flashAnims["pip"].p.endVal = 150
			
			flashAnims["jumptree0"] = {ticker:0,p:new Path(),active:true}
			flashAnims["jumptree0"].p.ptsArray = [{X:37418,Y:-40,Z:0},{X:37418,Y:-2400,Z:0}]
			flashAnims["jumptree0"].p.endVal = 30
			
			flashAnims["jumptree1"] = {ticker:0,p:new Path(),active:true}
			flashAnims["jumptree1"].p.ptsArray = [{X:37418,Y:-2400,Z:0},{X:39390,Y:-2400,Z:0}]
			
			flashAnims["jumptree2"] = {ticker:0,p:new Path(),active:true}
			flashAnims["jumptree2"].p.ptsArray = [{X:39390,Y:-2400,Z:0},{X:41045,Y:-2400,Z:0}]//[{X:421.85,Y:28.95,Z:0},{X:423.85,Y:28.95,Z:0},{X:459.5,Y:29.4,Z:0},{X:495.1,Y:29.85,Z:0},{X:530.75,Y:30.3,Z:0},{X:566.4,Y:30.75,Z:0},{X:602,Y:31.2,Z:0},{X:637.65,Y:31.7,Z:0},{X:673.25,Y:32.15,Z:0},{X:708.9,Y:32.6,Z:0},{X:744.55,Y:33.05,Z:0},{X:780.15,Y:33.5,Z:0},{X:815.75,Y:33.9,Z:0}] 
			flashAnims["jumptree2"].endVal = 150 
			
			p1 = 50
			
			flashAnims["hrntFlight"] = {ticker:0,p:new Path(),active:true}
			flashAnims["hrntFlight"].p.ptsArray = [{X:40000.23507501792,Y:-3504.2849927446937,Z:0},{X:42350.517164615165,Y:-2880.309060908366,Z:0},{X:43769.57343171677,Y:-2932.8969127197774,Z:0},{X:47240.13314444895,Y:-2831.936644797808,Z:0},{X:49621.04563470267,Y:-2672.81882169646,Z:0},{X:51802.05711872361,Y:-2132.8288122066688,Z:0}] 
			flashAnims["hrntFlight"].p.lpair = [{val:0,path:0},{val:p1,path:1},{path:flashAnims["hrntFlight"].p.ptsArray.length - 1,val:200}]
			
			flashAnims["jumpToHrnet"] = {ticker:0,p:new Path(),active:true}
			flashAnims["jumpToHrnet"].p.ptsArray = [{X:41045,Y:-2400,Z:0},{X:42350.517164615165,Y:-2880.309060908366,Z:0},{X:43769.57343171677,Y:-2932.8969127197774,Z:0},{X:47240.13314444895,Y:-2831.936644797808,Z:0},{X:49621.04563470267,Y:-2672.81882169646,Z:0},{X:51802.05711872361,Y:-2132.8288122066688,Z:0}] 
			flashAnims["jumpToHrnet"].p.lpair = [{val:0,path:0},{val:p1,path:1},{val:200,path:flashAnims["jumpToHrnet"].p.ptsArray.length - 1}]
			// setting the active automatically to true makes it bypass whatever is in the boolean, dont do that if you want a boolean condition
			
			flashAnims["thrwHornt"] = {ticker:0,p:new Path(),active:true}
			flashAnims["thrwHornt"].p.ptsArray = [{X:Main.liveCamera.hero_mc.bdy.x,Y:Main.liveCamera.hero_mc.bdy.y,Z:0},{X:54092,Y:-2490,Z:0}] 
			flashAnims["thrwHornt"].endVal = 50 
			
			flashAnims["toGround"] = {ticker:0,p:new Path(),active:false}
			flashAnims["toGround"].p.ptsArray = [{X:Main.liveCamera.hero_mc.bdy.x,Y:Main.liveCamera.hero_mc.bdy.y,Z:0},{X:54092,Y:-2490,Z:0}] 
			flashAnims["toGround"].endVal = 50 
			// two dimensional movements i just put one more convienence thing on there
			flashAnims["move"] = {ticker:0,p:new Path(),active:false,is2D:true}
			flashAnims["move"].p.ptsArray = [{X:-0.85,Y:144.9,Z:0},{X:0.6,Y:144.85,Z:0},{X:2.1,Y:144.85,Z:0},{X:3.55,Y:144.85,Z:0},{X:5.05,Y:144.85,Z:0},{X:6.5,Y:144.85,Z:0},{X:7.95,Y:144.85,Z:0},{X:9.45,Y:144.8,Z:0},{X:10.9,Y:144.8,Z:0},{X:12.35,Y:144.8,Z:0},{X:13.85,Y:144.8,Z:0},{X:15.3,Y:144.8,Z:0},{X:16.8,Y:144.8,Z:0},{X:18.25,Y:144.8,Z:0},{X:19.7,Y:144.8,Z:0},{X:21.2,Y:144.8,Z:0},{X:22.65,Y:144.8,Z:0},{X:24.15,Y:144.8,Z:0},{X:25.6,Y:144.8,Z:0},{X:27.05,Y:144.8,Z:0},{X:28.55,Y:144.75,Z:0},{X:30,Y:144.75,Z:0},{X:31.5,Y:144.75,Z:0},{X:32.95,Y:144.75,Z:0},{X:34.4,Y:144.75,Z:0},{X:35.9,Y:144.75,Z:0},{X:37.35,Y:144.75,Z:0},{X:38.8,Y:144.75,Z:0},{X:40.3,Y:144.75,Z:0},{X:41.75,Y:144.75,Z:0},{X:43.25,Y:144.75,Z:0},{X:44.7,Y:144.75,Z:0},{X:46.15,Y:144.75,Z:0},{X:47.65,Y:144.7,Z:0},{X:49.1,Y:144.7,Z:0},{X:50.6,Y:144.7,Z:0},{X:52.05,Y:144.7,Z:0},{X:53.5,Y:144.7,Z:0},{X:55,Y:144.7,Z:0},{X:56.45,Y:144.7,Z:0},{X:57.95,Y:144.7,Z:0},{X:59.4,Y:144.7,Z:0},{X:60.85,Y:144.7,Z:0},{X:62.35,Y:144.7,Z:0},{X:63.8,Y:144.7,Z:0},{X:65.25,Y:144.7,Z:0},{X:66.75,Y:144.65,Z:0},{X:68.2,Y:144.65,Z:0},{X:69.7,Y:144.65,Z:0},{X:71.15,Y:144.65,Z:0},{X:72.6,Y:144.65,Z:0},{X:74.1,Y:144.65,Z:0},{X:75.55,Y:144.65,Z:0},{X:77,Y:144.65,Z:0},{X:78.5,Y:144.65,Z:0},{X:79.95,Y:144.65,Z:0},{X:81.45,Y:144.65,Z:0},{X:82.9,Y:144.65,Z:0},{X:84.35,Y:144.65,Z:0},{X:85.85,Y:144.65,Z:0},{X:87.3,Y:144.6,Z:0},{X:88.8,Y:144.6,Z:0},{X:90.25,Y:144.6,Z:0},{X:91.7,Y:144.6,Z:0},{X:93.2,Y:144.6,Z:0},{X:94.65,Y:144.6,Z:0},{X:96.15,Y:144.6,Z:0},{X:97.6,Y:144.6,Z:0},{X:99.05,Y:144.6,Z:0},{X:100.55,Y:144.6,Z:0},{X:102,Y:144.6,Z:0},{X:103.45,Y:144.6,Z:0},{X:104.95,Y:144.6,Z:0},{X:106.4,Y:144.55,Z:0},{X:107.9,Y:144.55,Z:0},{X:109.35,Y:144.55,Z:0},{X:110.8,Y:144.55,Z:0},{X:112.3,Y:144.55,Z:0},{X:113.75,Y:144.55,Z:0},{X:115.25,Y:144.55,Z:0},{X:116.7,Y:144.55,Z:0},{X:118.15,Y:144.55,Z:0},{X:119.65,Y:144.55,Z:0},{X:121.1,Y:144.55,Z:0},{X:122.6,Y:144.55,Z:0},{X:124.05,Y:144.55,Z:0},{X:125.5,Y:144.55,Z:0},{X:127,Y:144.5,Z:0},{X:128.45,Y:144.5,Z:0},{X:129.9,Y:144.5,Z:0},{X:131.4,Y:144.5,Z:0},{X:132.85,Y:144.5,Z:0},{X:134.35,Y:144.5,Z:0},{X:135.8,Y:144.55,Z:0}] 
			flashAnims["move"].p.lpair = [{val:-59613.77291447164,path:0},{val:-62837.982987996904,path:93}]
			
//			flashAnims["move"] = {ticker:0,p:new Path(),active:false,is2D:true}
//			flashAnims["move"].p.ptsArray = [{X:611.85,Y:100.4,Z:0},{X:611.85,Y:100.4,Z:0},{X:441.95,Y:148.5,Z:0},{X:441.95,Y:148.5,Z:0},{X:295.65,Y:148.5,Z:0},{X:295.65,Y:148.5,Z:0},{X:260.65,Y:137.5,Z:0},{X:260.65,Y:137.5,Z:0},{X:245.65,Y:129.5,Z:0},{X:245.65,Y:129.5,Z:0},{X:238.65,Y:124.5,Z:0},{X:238.65,Y:124.5,Z:0},{X:235.65,Y:121.5,Z:0},{X:235.65,Y:121.5,Z:0},{X:234.65,Y:120.5,Z:0},{X:234.65,Y:120.5,Z:0},{X:233.9,Y:119.4,Z:0}] 
//			flashAnims["move"].p.lpair = [{val:-1000.77291447164,path:0},{val:-3000.982987996904,path:16}]
//			
//			flashAnims["move"].p.begPt = {X:611.85,Y:100.4,Z:0}
//			flashAnims["move"].p.endPt = {X:11.85,Y:400.4,Z:0}

			
			opningScnefarbackground = getscenary("opningScnefarbackground")
			isholding = true 
			
		}
		
		
		
		
		//		override public function ground(hero:Vector3, actor:GeneralActor):void
		//		{
		//			// maybe this will work?
		//			if(!EditKeyHandler.cntrl){
		//			msm.ground(actor.bdy.x);
		//			}else{
		//				msm.ground(14);
		//			}
		//		}
		
		
		public function weirdness():void{
			Main.liveCamera.scenary[0].dispose()
			trace(MainScene.hero)
			
			Main.liveCamera.scenary[0].removeFromParent();	
			Main.liveCamera.scenary[0] = null
			Director.scenary[0] = null
			Main.liveCamera.scenary.shift()
			Main.liveCamera.addNewScenary(hero.X,hero.Y,hero.Z+50,new Image(Assets.getTexture("blankImage")),Director.currSceneName+"scenary00"+Main.liveCamera.scenary.length.toString())
		}
		
		//		var y:Vector3D = LevelEditor.away3dView.project(new Vector3D(a.X+Math.sin((LevelEditor.awyCam.rotationY+90)*Math.PI/180)*90,a.Y,a.Z+Math.cos((LevelEditor.awyCam.rotationY + 90)*Math.PI/180)*90))
		//		var scale:Number = a.scaleZ*(y.x -r.x)/180 //fl/(fl +r.z);
		//
		//		var y:Vector3D = LevelEditor.away3dView.project(new Vector3D(a.X+90,a.Y,a.Z))//Math.sin((LevelEditor.awyCam.rotationX+90)*Math.PI/180)*a.width/2,a.Y,a.Z+Math.cos((LevelEditor.awyCam.rotationX + 90)*Math.PI/180)*a.width/2))
		//		var scale:Number = a.scaleZ*(y.x -r.x)/90
		//			
		//		var scale:Number = a.scaleZ*fl/(fl +r.z)//a.width //fl/(fl +r.z);
		
		/** keep playing if you get interrupted picks up where it left off, havent tested completely if it works but it shouldnt be too hard to fix so yea**/
		public function animationPlaythrough(actor:GeneralActor, anim:String):Object
		{
			if(actor.movie.name != anim){
				// i think in c++ itd be a simple matter of just creating a struct and having a pointer to that 
				if(adict[anim] == undefined){
					adict[anim] = {animation:anim,start:0}
					
				}
			}else{
				adict[anim].start = actor.movie.currentFrame
			}
			return adict[anim];
		}
		
		// this doesnt work yet since its not connected yet
		override public function SonicJumpDash(actor:GeneralActor):String
		{
			
			if(Assets.isTextureLoaded("sonicDashftr",6)){
				
				if(actor.X > key[2].beg && actor.X < key[2].end){
					
					return Hero(actor).JumpDash("sonicDashftr");
					
				}
			}
			
			if(jumpCharging != null)
				return Hero(actor).JumpDash(jumpDash);
			else
				return Hero(actor).JumpDash("jumpDash");
		}
		
		
		override public function SonicRunning(actor:GeneralActor):String
		{
			// if I put this into a for loop it can be very dynamic, also I can say it's groundkey[i].anim
			if(actor.X > key[3].beg && actor.X < key[3].end){
				return Hero(actor).SonicRunning("sonicRunDownSlope");
			}
			
			if(actor.X > key[4].beg && actor.X < key[4].end){
				return Hero(actor).SonicRunning("sonicglideDownhill");
			}
			
			if(actor.X > key[6].beg && actor.X < key[6].end){
				return Hero(actor).SonicRunning("tumblethrough");
			}
			
			//this is what it should look like
			
			//			for (var i:int = 0; i < keyRunning.length; i++) 
			//			{ 
			//				if(actor.X > keyRuning[i].beg && actor.X < keyRunning[i].end){
			//					return Hero(actor).SonicRunning(keyRunning[i].name);
			//				}
			//			}
			
			
			
			
			if(sonicRunning != null)
				return Hero(actor).SonicRunning(sonicRunning);
			else
				return Hero(actor).SonicRunning("sonicRunning");
		}
		
		override public function SonicJumpRising(actor:GeneralActor):String
		{
			if(actor.X > key[5].beg && actor.X < key[5].end){
				return Hero(actor).SonicJumpRising("sonicJumpGlee");
			}
			
			if(sonicJumpRising != null)
				return Hero(actor).SonicJumpRising(sonicJumpRising);
			else
				return Hero(actor).SonicJumpRising("sonicJumpRising"+resultingAngtoString());
		}
		override public function SonicJogging(actor:GeneralActor):String
		{
			//	var ani:String = sonicRunning+resultingAngtoString()
			// hmm putting is texture loaded is stupid because well it should be loaded
			// else it doesnt work just make sure the textures are loaded before getting to those points thats your job not the design part
			if(Assets.isTextureLoaded("sonicLookround",6)){
				
				if(actor.bdy.x > 2895 && actor.bdy.x < 4000){
					// I believe animationPlayThrough was a convienence method to make sure it plays the whole way through and picks back up if it was interrupted.. yeah jeez 
					var st:Object = animationPlaythrough(actor,"sonicLookround")
					return Hero(actor).SonicJogging(st)
				}
			}
			
			if(actor.X > key[3].beg && actor.X < key[3].end){
				
				return Hero(actor).SonicJogging("sonicRunDownSlope");
			}
			
			if(actor.X > key[4].beg && actor.X < key[4].end){
				return Hero(actor).SonicJogging("sonicglideDownhill");
			}
			
			if(actor.X > key[6].beg && actor.X < key[6].end){
				return Hero(actor).SonicJogging("tumblethrough");
			}
			
			if(sonicJogging != null)
				return Hero(hero).SonicJogging(sonicJogging);
			else
				return Hero(hero).SonicJogging("sonicJogging"+resultingAngtoString());
			
		}
		override public function SonicCustom(actor:GeneralActor):String
		{
			var minSkimSpeed:Number = 5000
			var spawnX:Number = 33610
			if(Main.liveCamera.hero_mc.customState && Main.liveCamera.hero_mc.isGrounded)
			{
				// all thats left is to play a splash animation
				
				//Main.liveCamera.hero_mc.Animateto("SplashAnimation")
				if(false && true||Main.liveCamera.hero_mc.movie.name == "SplashAnimation" && Main.liveCamera.hero_mc.movie.currentFrame == Main.liveCamera.hero_mc.movie.numFrames)
				{
					Main.liveCamera.hero_mc.bdy.x = spawnX
					Main.liveCamera.hero_mc.body.velocity.y = 0
					Main.liveCamera.hero_mc.body.velocity.x = 0
					Main.liveCamera.hero_mc.customState = false
				}
				
				
				
				return Status.S_RUNNING
				
			}
			return Status.S_FAILURE
		}
		override protected function UpdateScene(actor:GeneralActor=null):void{
			// all super does is give us where camera should be in the path, which im free to ignore
			super.UpdateScene(actor)
			
			//opningScnefarbackground.updateZdepth = false
				trace(opningScnefarbackground.x, " my pos")
				
			//			flyHornet.bdy.x = Main.liveCamera.hero_mc.bdy.x
			//			flyHornet.bdy.y = Main.liveCamera.hero_mc.bdy.y
			
			//			trace(" seeemsmsmsmsmsmssm");
			//			if(allLoaded()){
			//				throw Error("yepps")
			//			}
			playFlashAnim("move",opningScnefarbackground,true,LevelEditor.awyCam.x)
			//	flyHornet.bdy.x = Main.liveCamera.hero_mc.bdy.x
			var minSkimSpeed:Number = 4000;
			
			
			if(Main.liveCamera.hero_mc.bdy.x > 34072 && Main.liveCamera.hero_mc.bdy.x < 61081 && Main.liveCamera.hero_mc.body.velocity.x < minSkimSpeed)
			{
				Main.liveCamera.hero_mc.customState = true
			}
			
			if(!overrideRecticle){
				
				if(Main.liveCamera.hero_mc.isJumping)
				{
					if(Main.liveCamera.hero_mc.closestConcern !=null){
						if(Main.liveCamera.hero_mc.closestConcern.distToSonic < 400){
							////trace(stage_mc.hero_mc.localBaddies)
							targetingRecticle.x = Main.liveCamera.hero_mc.closestConcern.x
							targetingRecticle.y = Main.liveCamera.hero_mc.closestConcern.y
							// its uniform right now but may be usefull later to change that 
							targetingRecticle.Z = LevelEditor.awyCam.z+-200
							targetingRecticle.alpha = 1
							
						}else if(Main.liveCamera.hero_mc.closestConcern.dead)
						{
							//throw Error("dont target the dead no reason in this game")
						}
					}
				}else{
					targetingRecticle.alpha = 0
					targetingRecticle.x = Main.liveCamera.hero_mc.x
					targetingRecticle.y = Main.liveCamera.hero_mc.y
					targetingRecticle.Z = LevelEditor.awyCam.z+ -200// Main.liveCamera.hero_mc.Z
				}
			}
			
			
			
			
			if(allLoaded() && !isloadCheck){
				//throw Error("s")
				LevelEditor.isFollowSonic = true
				LevelEditor.isFollowPath = false
				isloadCheck = true
			}
			
			//flyHornet.canAttack = false
			//flyHornet.timeTocanAttack = 10000000
			//flyHornet.attacking = false
			//pg++
			
			//				if(Main.liveCamera.hero_mc.x > grndCverHrnt.x &&){
			//					if(!flashAnims["throughGround"]){
			//						// I coould put these all in the beginning.. but i like being messy on the top i want it to follow cannonically 
			//						flashAnims["throughGround"] = {ticker:0,p:new Path(),active:true}
			//						//I's not sure if its going to work with a relative position... no it should... but get the absolute position working first
			//						flashAnims["throughGround"].p.ptsArray = [{X:44363.11523713713,Y:565.3329765404344,Z:0},{X:45444.95996787115,Y:593.6923386812107,Z:0}]//[{X:42363.080320466746,Y:373.48789019063594,Z:0},{X:42387.36658768306,Y:368.91270698244267,Z:0},{X:42412.14046176575,Y:362.89553358807575,Z:0},{X:42437.40169891141,Y:355.4370910026282,Z:0},{X:42463.1500554385,Y:346.53809986069564,Z:0},{X:42489.38528778732,Y:336.19928043655625,Z:0},{X:42516.10715251997,Y:324.42135264435115,Z:0},{X:42543.31540632025,Y:311.2050360382644,Z:0},{X:42571.009805993635,Y:296.8842164793695,Z:0},{X:42598.69035846718,Y:281.459446219143,Z:0},{X:42626.35707066449,Y:264.9312772329355,Z:0},{X:42654.0099495057,Y:247.30026122010997,Z:0},{X:42681.64900190749,Y:228.56694960417974,Z:0},{X:42709.27423478308,Y:208.73189353294637,Z:0},{X:42736.88565504223,Y:187.79564387863752,Z:0},{X:42764.48326959125,Y:165.7587512380447,Z:0},{X:42792.067085332994,Y:142.62176593266108,Z:0},{X:42819.63710916687,Y:118.38523800881902,Z:0},{X:42827.86364954933,Y:111.12510663771114,Z:0},{X:42846.60911783276,Y:111.02479048958921,Z:0},{X:42864.19790986963,Y:110.80159570805463,Z:0},{X:42881.20033672363,Y:110.58584166768156,Z:0},{X:42897.6362544612,Y:110.37727640287733,Z:0}]//relativePosition([{X:210.45,Y:161.15,Z:0},{X:211.9,Y:159.15,Z:0},{X:212.25,Y:157.2,Z:0},{X:222.35,Y:156.45,Z:0},{X:232.15,Y:159.4,Z:0},{X:240.85,Y:164.95,Z:0},{X:248.2,Y:172.15,Z:0},{X:254.2,Y:180.55,Z:0},{X:258.95,Y:189.7,Z:0},{X:262.65,Y:199.3,Z:0},{X:265.6,Y:209.2,Z:0},{X:268.05,Y:219.2,Z:0},{X:270.1,Y:229.3,Z:0},{X:271.9,Y:239.45,Z:0},{X:273.35,Y:249.65,Z:0},{X:274.6,Y:259.9,Z:0},{X:275.6,Y:270.2,Z:0},{X:276.35,Y:280.45,Z:0},{X:291.3,Y:293.4,Z:0}])
			//						flashAnims["throughGround"].p.lpair = [{val:0,path:0},{val:flashAnims["throughGround"].p.ptsArray.length - 1,path:flashAnims["throughGround"].p.ptsArray.length - 1}]
			//						activeAlter = flashAnims["throughGround"].active
			//						// if 
			//						MainSceneMotor.mouseJoint.body2 = Main.liveCamera.hero_mc.body
			//						MainSceneMotor.mouseJoint.active = true;
			//						MainSceneMotor.mouseJoint.anchor1.setxy(flashAnims["throughGround"].p.ptsArray[0].X,flashAnims["throughGround"].p.ptsArray[0].Y);
			//						
			//						// this is for the auto one not the position based one
			//					}else if(activeAlter && flashAnims["throughGround"].ticker < flashAnims["throughGround"].p.ptsArray.length - 1.02)
			//					{
			//						
			//						
			//						//this was a hack so InAlter will only work on hero_mc for it to work create an altered list and check if anyofthem are alter
			//						var pos:Vector3 = flashAnims["throughGround"].p.pointOnLinkedPath(flashAnims["throughGround"].ticker)
			//						//pos =  MainSceneMotor.floor.PointOnPath(new Point(200, 200),true)
			//						// I have to change it to the ground path position
			//						MainSceneMotor.mouseJoint.anchor1.setxy(pos.X,pos.Y);
			//						flashAnims["throughGround"].ticker+=.02
			//					}else{
			//						//leave
			//						isMouseJointActve = false;
			//						jumptree[2] = false
			//						activeAlter = false
			//						
			//						// I could clean up flashAnims here but id recommend not, it should get cleaned up on the scene changes
			//						// I could do some clean up and stuff in here, umm i was thinking of 
			//						//making a function for this stuff and i may but id like to consider not doing it because the more tactile this is the better and more uniquely it will flow
			//						5900
			//						1800
			//					}
			//				}
			//**** NOTE JUST HAVE A FUNction that automatically checks if its loads it before sees if its there plays it once and kills it after
			
			
			// I dunno what this is but its probably deprecated 
			if(Assets.isTextureLoaded("sonicLookround",6) && Main.liveCamera.hero_mc.bdy.x > 2890 && tick == 0){
				var currentlyplaying:String = "sonicLookround"
				trace("the tick condition set")
				tick++
				var res:Vector.<starling.textures.Texture> = new <starling.textures.Texture>[]
				// we can make it more dynamic and shorten load times by asking if is texture loaded is there that way i can
				//also delete certain textures from the queue as well but i think it might be better to go sloppy to clean
				// in this scenario
				for(var i:int=1;Assets.isTextureLoaded(currentlyplaying,i);i++){
					if(i < 10)
						res.push(Assets.getTexture(currentlyplaying+"000"+i))
					else
						res.push(Assets.getTexture(currentlyplaying+"00"+i))
				}
				
				//var mov:MovieClip = new MovieClip(res)
				
				Main.liveCamera.hero_mc.playedAnimations[currentlyplaying] = new MovieClip(res)
			}
			
			
			// I remember I spent like hours or even days on
			// the solution that would work everywhere, this is much simpler and better
			// few minutes it took to do and its pretty awesome
			// umm if you want custom blocks to get rid of just check all of them and put in names
			// I can pretty easily change this to a function and put this in main, so uh yeah thats it
			
			//*** Image cycler// works great
			
			if( false){
				// dumb way to do it but yeah
				var c:Array = ["001","002","03","04","05","06","07","08","17","18","19","20","21","22"]
				if(stupidCheck){
					
					//trace(Main.liveCamera.scenary[0].name.search(c[i].toString())
					for (i = 0; i < Main.liveCamera.scenary.length; i++) 
					{
						for (var k:int = 0; k < c.length; k++) 
						{
							if(Main.liveCamera.scenary[i].name.search(c[k]) != -1)
								break;
						}
						
						if(k ==c.length)
							continue
						
						trace(Main.liveCamera.scenary[i].name, " ",i)
						
						Main.liveCamera.scenary[i].dispose()
						
						
						Main.liveCamera.scenary[i].removeFromParent();	
						Main.liveCamera.scenary[i] = null
						Director.scenary[i] = null
						
						Main.liveCamera.scenary.splice(i,1)
						Director.scenary.splice(i,1)
						i--
						
					}
					var killLength:uint = i
					//			for (i = 0; i < Main.liveCamera.scenary.length; i++) 
					//			{
					//				for (k = 0; k < c.length; k++) 
					//				{
					//					if(Main.liveCamera.scenary[i].name.search(c[k].toString()) != -1)
					//						break;
					//				}
					//				if(k ==c.length)
					//					continue
					//				
					//			Main.liveCamera.scenary.splice(i,1)
					//			Director.scenary.splice(i,1)
					//			}
					stupidCheck =false
				}
				stupidCheck = stupidCheck
			}
			
			/** How she starts**/
			//				if("initConditions" && flashAnims["pip"])
			//				{ 
			//					flashAnims["pip"] = {ticker:0,p:new Path()}
			//					flashAnims["pip"].p.ptsArray = relativePosition([{X:210.45,Y:161.15,Z:0},{X:211.9,Y:159.15,Z:0},{X:212.25,Y:157.2,Z:0},{X:222.35,Y:156.45,Z:0},{X:232.15,Y:159.4,Z:0},{X:240.85,Y:164.95,Z:0},{X:248.2,Y:172.15,Z:0},{X:254.2,Y:180.55,Z:0},{X:258.95,Y:189.7,Z:0},{X:262.65,Y:199.3,Z:0},{X:265.6,Y:209.2,Z:0},{X:268.05,Y:219.2,Z:0},{X:270.1,Y:229.3,Z:0},{X:271.9,Y:239.45,Z:0},{X:273.35,Y:249.65,Z:0},{X:274.6,Y:259.9,Z:0},{X:275.6,Y:270.2,Z:0},{X:276.35,Y:280.45,Z:0},{X:291.3,Y:293.4,Z:0}])
			//					flashAnims["pip"].p.lpair = [{val:0,path:0},{val:1,path:1},{val:2,path:2},{val:3,path:3},{val:4,path:4},{val:5,path:5},{val:6,path:6},{val:7,path:7},{val:8,path:8},{val:9,path:9},{val:10,path:10},{val:11,path:11},{val:12,path:12},{val:13,path:13},{val:14,path:14},{val:15,path:15},{val:16,path:16},{val:17,path:17},{val:18,path:18}]
			//				}
			//				if("animationStartCondition")
			//				{
			//					
			//					
			//					//this was a hack so InAlter will only work on hero_mc for it to work create an altered list and check if anyofthem are alter
			//					
			//					pos = flashAnims["pip"].p.pointOnLinkedPath(flashAnims["pip"].ticker)
			//					REPLACE_WITH_VAR_NAME.x = pos.X
			//					REPLACE_WITH_VAR_NAME.y = pos.Y
			//					flashAnims["pip"].ticker++ 
			//				}
			//				if("leaveCondition"){
			//					
			
			
			if(isSwitch){
				playHeroFlashAnim("toGround",Main.liveCamera.hero_mc,true)
			}
			
			
			// this is an example of how to just move sonic
			// Im not sure what activeAlter does or what it's point is, I could easily compress this but I kinda like it bigish like this 
			playHeroFlashAnim("throughGround",Main.liveCamera.hero_mc,(Main.liveCamera.hero_mc.bdy.x >23325.624794 && Main.liveCamera.hero_mc.bdy.x <23455.624794 && Main.liveCamera.hero_mc.isGrounded))
			// this can be put up into one handy dandy function, might be nice... nahh 
			playHeroFlashAnim("hornetThrough",flyHornet,(Main.liveCamera.hero_mc.bdy.x >6473.11707918339))
			
			
			//				}
			// create lastree scenary for the jump place
			//lastTree
			//Soo when i get back jut come in here make vine1 and then use similar logic for the rest of the stuff, grab just stop em, Ill make a swing thing later or whatevs
			// its funny that this works but the small x represents its on screen position which is why it works.. oddly enough i didnt know what i was doing but it turned out to be the right solution, which is duuummb
			//				if(Main.liveCamera.hero_mc.x >getscenary("vine1").x && Main.liveCamera.hero_mc.x <getscenary("lastTree").x+45)
			//				{
			//			
			//			
			//					if(struggle == 0){
			//						struggle=1
			//					}
			//					//I'm assuming -1 is up
			//					//I think grip on tree might be unnecessary
			//					 if(Main.liveCamera.hero_mc.key.Y == -1)
			//					{
			//						 
			//							 
			//						// I dunno i could just do it here but whatevs
			//						//just play a grab animation and dont move him
			//						grab = 1
			//							if(Main.liveCamera.hero_mc.spacebar && !activeAlter){
			//								// in here put the condition start for the animation
			//								// to the tree or what have you
			//								// it may work.. who knows
			//								isholding = false
			//								// ok on return just check the others work should be easy but you know how it goes
			//									trace(t, " is the condition that i am in")
			//									//check whats going on on this with grab it's some too clever coding which i hate so make sure it works other stuff should be relatively easy, honestly im not even really trying with this and im somehow making better progress than i expected i dont know if that speaks to the quality of the underlying archetecture or i just that lazy
			//									//that set up the other scenes roughly, get the main bits, then go and re storyboard it get it looking just how i want it, and do another pass on the roughs
			//							
			//							}
			//						// just look how I handled grab animation for the baddies
			//					}else{
			//						
			//						//you gotta deal with grab, make it reusable 
			//						grab = 0
			//					}
			//				}
			
			// so if ju
			
			// this is the thing that needs fixing, I really want something done by tommorow I say a tight schedule Ill work on it today 
			//				if(jumptree[1]){
			//					if(!flashAnims["jumptree1"]){
			//						// I coould put these all in the beginning.. but i like being messy on the top i want it to follow cannonically 
			//						flashAnims["jumptree1"] = {ticker:0,p:new Path(),active:true}
			//						//I's not sure if its going to work with a relative position... no it should... but get the absolute position working first
			//						flashAnims["jumptree1"].p.ptsArray = [{X:37418,Y:-2400,Z:0},{X:39390,Y:-2400,Z:0}]//[{X:418.9,Y:0.5,Z:0},{X:425.5,Y:0.6,Z:0},{X:456.4,Y:0.6,Z:0},{X:487.3,Y:0.6,Z:0},{X:518.2,Y:0.6,Z:0},{X:549.1,Y:0.6,Z:0},{X:580,Y:0.6,Z:0},{X:610.9,Y:0.6,Z:0},{X:641.8,Y:0.6,Z:0},{X:672.7,Y:0.6,Z:0},{X:703.6,Y:0.6,Z:0},{X:734.5,Y:0.6,Z:0},{X:765.4,Y:0.6,Z:0},{X:796.3,Y:0.6,Z:0},{X:827.2,Y:0.6,Z:0},{X:858.1,Y:0.6,Z:0},{X:889,Y:0.6,Z:0},{X:919.9,Y:0.6,Z:0},{X:950.8,Y:0.6,Z:0},{X:981.7,Y:0.6,Z:0},{X:1012.6,Y:0.6,Z:0},{X:1043.5,Y:0.6,Z:0},{X:1074.45,Y:0.6,Z:0}] 
			////[{X:42363.080320466746,Y:373.48789019063594,Z:0},{X:42387.36658768306,Y:368.91270698244267,Z:0},{X:42412.14046176575,Y:362.89553358807575,Z:0},{X:42437.40169891141,Y:355.4370910026282,Z:0},{X:42463.1500554385,Y:346.53809986069564,Z:0},{X:42489.38528778732,Y:336.19928043655625,Z:0},{X:42516.10715251997,Y:324.42135264435115,Z:0},{X:42543.31540632025,Y:311.2050360382644,Z:0},{X:42571.009805993635,Y:296.8842164793695,Z:0},{X:42598.69035846718,Y:281.459446219143,Z:0},{X:42626.35707066449,Y:264.9312772329355,Z:0},{X:42654.0099495057,Y:247.30026122010997,Z:0},{X:42681.64900190749,Y:228.56694960417974,Z:0},{X:42709.27423478308,Y:208.73189353294637,Z:0},{X:42736.88565504223,Y:187.79564387863752,Z:0},{X:42764.48326959125,Y:165.7587512380447,Z:0},{X:42792.067085332994,Y:142.62176593266108,Z:0},{X:42819.63710916687,Y:118.38523800881902,Z:0},{X:42827.86364954933,Y:111.12510663771114,Z:0},{X:42846.60911783276,Y:111.02479048958921,Z:0},{X:42864.19790986963,Y:110.80159570805463,Z:0},{X:42881.20033672363,Y:110.58584166768156,Z:0},{X:42897.6362544612,Y:110.37727640287733,Z:0}]//relativePosition([{X:210.45,Y:161.15,Z:0},{X:211.9,Y:159.15,Z:0},{X:212.25,Y:157.2,Z:0},{X:222.35,Y:156.45,Z:0},{X:232.15,Y:159.4,Z:0},{X:240.85,Y:164.95,Z:0},{X:248.2,Y:172.15,Z:0},{X:254.2,Y:180.55,Z:0},{X:258.95,Y:189.7,Z:0},{X:262.65,Y:199.3,Z:0},{X:265.6,Y:209.2,Z:0},{X:268.05,Y:219.2,Z:0},{X:270.1,Y:229.3,Z:0},{X:271.9,Y:239.45,Z:0},{X:273.35,Y:249.65,Z:0},{X:274.6,Y:259.9,Z:0},{X:275.6,Y:270.2,Z:0},{X:276.35,Y:280.45,Z:0},{X:291.3,Y:293.4,Z:0}])
			////						var setVal:Number = flashAnims["jumptree1"].p.ptsArray[0].Y
			////						for each (var j:Object in flashAnims["jumptree1"].p.ptsArray) 
			////						{
			////							j.Y = setVal
			////						}
			//						
			//						
			//						flashAnims["jumptree1"].p.lpair = [{val:0,path:0},{val:1000,path:flashAnims["jumptree1"].p.ptsArray.length - 1}]
			//						activeAlter = flashAnims["jumptree1"].active
			//						// if 
			//						MainSceneMotor.mouseJoint.body2 = Main.liveCamera.hero_mc.body
			//						MainSceneMotor.mouseJoint.active = true;
			//						
			//						
			//						var ps:Point = MainSceneMotor.floor.PointOnPath(new Point(flashAnims["jumptree1"].p.ptsArray[0].X,flashAnims["jumptree1"].p.ptsArray[0].Y))
			//						//trace(v.x, "my X is this")
			//						
			//						//Game plan I need to go and get the animation system working again, thats it
			//						// first investigate the key tp recprd shift 1 see if it has connection with old then go over old animation code
			//						// turn on the old plsy back, should be the first thing i do
			//						//MainSceneMotor.mouseJoint.anchor1.setxy(ps.x,ps.y);
			//						MainSceneMotor.mouseJoint.anchor1.setxy(flashAnims["jumptree1"].p.ptsArray[0].X,flashAnims["jumptree1"].p.ptsArray[0].Y);
			//
			//						// this is for the auto one not the position based one
			//					}else if(activeAlter && flashAnims["jumptree1"].ticker < 1000)//flashAnims["jumptree1"].p.ptsArray.length-1.02)
			//					{
			//						
			//						trace(flashAnims["jumptree1"].p.ptsArray.length," ",flashAnims["jumptree1"].ticker)
			//						//this was a hack so InAlter will only work on hero_mc for it to work create an altered list and check if anyofthem are alter
			//						var pos:Vector3 = flashAnims["jumptree1"].p.pointOnLinkedPath(flashAnims["jumptree1"].ticker)
			//						//pos =  MainSceneMotor.floor.PointOnPath(new Point(200, 200),true)
			//						// I have to change it to the ground path position
			////						MainSceneMotor.mouseJoint.anchor1.setxy(pos.X,pos.Y);
			//						Main.liveCamera.hero_mc.bdy.x = pos.X
			//						Main.liveCamera.hero_mc.bdy.y = pos.Y
			//						//Main.liveCamera.hero_mc.Y = pos.Y
			//						Main.liveCamera.hero_mc.body.velocity.setxy(0,0)
			//							
			//							
			//						if(isholding)
			//						flashAnims["jumptree1"].ticker+=.5
			//					}else{
			//						
			//						t++
			//							jumptree[t] = true 
			//						isholding = true
			//						//leave
			//						//isMouseJointActve = false;
			//						jumptree[1] = false
			//						
			//						activeAlter = false
			//						
			//						// I could clean up flashAnims here but id recommend not, it should get cleaned up on the scene changes
			//						// I could do some clean up and stuff in here, umm i was thinking of 
			//						//making a function for this stuff and i may but id like to consider not doing it because the more tactile this is the better and more uniquely it will flow
			//						
			//					}
			//				}
			//				
			//				
			//				if(jumptree[2]){//jumptree[2]){
			//					if(!flashAnims["jumptree2"]){
			//						// I coould put these all in the beginning.. but i like being messy on the top i want it to follow cannonically 
			//						flashAnims["jumptree2"] = {ticker:0,p:new Path(),active:true}
			//						//I's not sure if its going to work with a relative position... no it should... but get the absolute position working first
			//						flashAnims["jumptree2"].p.ptsArray = [{X:39390,Y:-2400,Z:0},{X:41045,Y:-2400,Z:0}]//[{X:421.85,Y:28.95,Z:0},{X:423.85,Y:28.95,Z:0},{X:459.5,Y:29.4,Z:0},{X:495.1,Y:29.85,Z:0},{X:530.75,Y:30.3,Z:0},{X:566.4,Y:30.75,Z:0},{X:602,Y:31.2,Z:0},{X:637.65,Y:31.7,Z:0},{X:673.25,Y:32.15,Z:0},{X:708.9,Y:32.6,Z:0},{X:744.55,Y:33.05,Z:0},{X:780.15,Y:33.5,Z:0},{X:815.75,Y:33.9,Z:0}] 
			//						flashAnims["jumptree2"].p.lpair = [{val:0,path:0},{val:1000,path:flashAnims["jumptree2"].p.ptsArray.length - 1}]
			//						activeAlter = flashAnims["jumptree2"].active
			//						// if 
			////						MainSceneMotor.mouseJoint.body2 = Main.liveCamera.hero_mc.body
			////						MainSceneMotor.mouseJoint.active = true;
			//						var v:Point = new Point(flashAnims["jumptree2"].p.ptsArray[0].X,flashAnims["jumptree2"].p.ptsArray[0].Y)
			//							
			//						//MainSceneMotor.mouseJoint.anchor1.setxy(v.x,v.y);
			//
			//						// this is for the auto one not the position based one
			//					}else if(activeAlter && flashAnims["jumptree2"].ticker < 1000)
			//					{
			//						
			//						
			//						//this was a hack so InAlter will only work on hero_mc for it to work create an altered list and check if anyofthem are alter
			//						var pos:Vector3 = flashAnims["jumptree2"].p.pointOnLinkedPath(flashAnims["jumptree2"].ticker)
			//						//pos =  MainSceneMotor.floor.PointOnPath(new Point(200, 200),true)
			//						// I have to change it to the ground path position
			//						v= MainSceneMotor.floor.PointOnPath(new Point(pos.X,pos.Y))
			//						
			//						Main.liveCamera.hero_mc.bdy.x = pos.X
			//						Main.liveCamera.hero_mc.bdy.y = pos.Y
			//						//Main.liveCamera.hero_mc.Y = pos.Y
			//						Main.liveCamera.hero_mc.body.velocity.setxy(0,0)
			//						
			//						flashAnims["jumptree2"].ticker+=.5
			//					}else{
			//						//leave
			//						isMouseJointActve = false;
			//						jumptree[2] = false
			//						activeAlter = false
			//						
			//						// I could clean up flashAnims here but id recommend not, it should get cleaned up on the scene changes
			//						// I could do some clean up and stuff in here, umm i was thinking of 
			//						//making a function for this stuff and i may but id like to consider not doing it because the more tactile this is the better and more uniquely it will flow
			//						
			//					}
			//				}
			
			//				// this is the second jump thing
			//				
			//				if(Main.liveCamera.hero_mc.x >= tree1)
			//				{
			//					//I'm assuming -1 is up
			//					 
			//						if(Main.liveCamera.hero_mc.key.Y == -1)
			//						{
			//							// I dunno i could just do it here but whatevs
			//							//just play a grab animation and dont move him
			//							grab = true
			//							if(Main.liveCamera.hero_mc.spacebar){
			//								// leave this I may come back to kill you if you do something stupid here but not now
			//								grab = false
			//									if(Main.liveCamera.hero_mc.x >= tree1jumpPoint){
			//										startJumpTotree2
			//									}
			//							}
			//							if(Main.liveCamera.hero_mc.key.X == 1){
			//								// play the running forward animation put it here
			//								startrunningOntree1 = true
			//							}
			//							// just look how I handled grab animation for the baddies
			//						}else{
			//							grab = false
			//						}
			//				}
			//				
			
			//					if(!flashAnims["pip"]){
			//						// I coould put these all in the beginning.. but i like being messy on the top i want it to follow cannonically 
			//					flashAnims["pip"] = {ticker:0,p:new Path(),active:true}
			//						//I's not sure if its going to work with a relative position... no it should... but get the absolute position working first
			//					flashAnims["pip"].p.ptsArray =  [{X:33800,Y:-2400,Z:0},{X:37418,Y:-2563,Z:0}]//[{X:33701.86536753929,Y:-2815.4329194170546,Z:0},{X:33742.93650240651,Y:-3612.6710222691036,Z:0},{X:33754.23502354388,Y:-3612.5899602169898,Z:0},{X:33765.14569290435,Y:-3612.511680835331,Z:0},{X:33775.68163921192,Y:-3612.4360899311528,Z:0},{X:33785.85554678528,Y:-3612.363096499899,Z:0},{X:33796.2469056716,Y:-3612.288542948568,Z:0},{X:33806.855607145226,Y:-3612.212430057221,Z:0},{X:33817.68154253487,Y:-3612.1347586055267,Z:0},{X:33828.72460322356,Y:-3612.055529372766,Z:0},{X:33839.98468064867,Y:-3611.9747431378296,Z:0},{X:33851.46166630181,Y:-3611.892400679218,Z:0},{X:33863.155451728875,Y:-3611.8085027750435,Z:0},{X:33875.06592852998,Y:-3611.723050203029,Z:0},{X:33887.192988359435,Y:-3611.636043740508,Z:0},{X:33899.53652292572,Y:-3611.547484164426,Z:0},{X:33912.09642399148,Y:-3611.4573722513396,Z:0},{X:33924.87258337346,Y:-3611.3657087774172,Z:0},{X:33937.864892942496,Y:-3611.2724945184395,Z:0},{X:33951.0732446235,Y:-3611.177730249799,Z:0},{X:33964.49753039541,Y:-3611.0814167465005,Z:0},{X:33978.13764229119,Y:-3610.9835547831613,Z:0},{X:33991.99347239777,Y:-3610.8841451340113,Z:0},{X:34006.06491285605,Y:-3610.783188572894,Z:0},{X:34020.35185586085,Y:-3610.6806858732643,Z:0},{X:34034.854193660896,Y:-3610.5766378081926,Z:0},{X:34049.5718185588,Y:-3610.4710451503606,Z:0},{X:34064.504622911,Y:-3610.3639086720655,Z:0},{X:34079.65249912778,Y:-3610.255229145217,Z:0},{X:34095.0153396732,Y:-3610.14500734134,Z:0},{X:34110.5930370651,Y:-3610.033244031572,Z:0},{X:34126.38548387505,Y:-3609.9199399866666,Z:0},{X:34142.39257272835,Y:-3609.8050959769917,Z:0},{X:34158.61419630397,Y:-3609.688712772529,Z:0},{X:34175.050247334555,Y:-3609.5707911428763,Z:0},{X:34191.70061860637,Y:-3609.451331857246,Z:0},{X:34208.56520295931,Y:-3609.330335684466,Z:0},{X:34225.64389328682,Y:-3609.20780339298,Z:0},{X:34242.93658253591,Y:-3609.0837357508476,Z:0},{X:34260.44316370714,Y:-3608.958133525744,Z:0},{X:34278.16352985453,Y:-3608.8309974849603,Z:0},{X:34296.097574085594,Y:-3608.702328395405,Z:0},{X:34314.2451895613,Y:-3608.572127023602,Z:0},{X:34332.60626949601,Y:-3608.4403941356927,Z:0},{X:34351.18070715751,Y:-3608.307130497435,Z:0},{X:34369.96839586693,Y:-3608.172336874204,Z:0},{X:34388.96922899874,Y:-3608.036014030992,Z:0},{X:34408.18309998074,Y:-3607.8981627324097,Z:0},{X:34427.609902294,Y:-3607.758783742684,Z:0},{X:34447.24952947286,Y:-3607.617877825661,Z:0},{X:34467.10187510487,Y:-3607.475445744804,Z:0},{X:34487.166832830815,Y:-3607.3314882631953,Z:0},{X:34507.44429634465,Y:-3607.186006143535,Z:0},{X:34527.93415939348,Y:-3607.0390001481423,Z:0},{X:34548.63631577754,Y:-3606.8904710389547,Z:0},{X:34569.550659350156,Y:-3606.7404195775293,Z:0},{X:34590.677084017734,Y:-3606.5888465250423,Z:0},{X:34612.015483739735,Y:-3606.435752642289,Z:0},{X:34633.56575252862,Y:-3606.281138689685,Z:0},{X:34655.327784449866,Y:-3606.125005427265,Z:0},{X:34677.3014736219,Y:-3605.967353614684,Z:0},{X:34699.486714216095,Y:-3605.808184011217,Z:0},{X:34721.88340045675,Y:-3605.647497375759,Z:0},{X:34744.49142662103,Y:-3605.4852944668264,Z:0},{X:34767.31068703898,Y:-3605.321576042556,Z:0},{X:34790.34107609348,Y:-3605.1563428607055,Z:0},{X:34813.5824882202,Y:-3604.9895956786536,Z:0},{X:34837.0348179076,Y:-3604.8213352534003,Z:0},{X:34860.69795969692,Y:-3604.651562341567,Z:0},{X:34884.57180818209,Y:-3604.480277699398,Z:0},{X:34908.65625800977,Y:-3604.3074820827574,Z:0},{X:34932.95120387928,Y:-3604.1331762471327,Z:0},{X:34957.45654054261,Y:-3603.9573609476333,Z:0},{X:34982.17216280436,Y:-3603.7800369389915,Z:0},{X:35007.09796552173,Y:-3603.601204975562,Z:0},{X:35032.233843604496,Y:-3603.420865811321,Z:0},{X:35057.579692014966,Y:-3603.2390201998705,Z:0},{X:35083.135405767986,Y:-3603.055668894433,Z:0},{X:35108.90087993088,Y:-3602.870812647856,Z:0},{X:35134.87600962344,Y:-3602.68445221261,Z:0},{X:35161.060690017905,Y:-3602.496588340789,Z:0},{X:35187.454816338926,Y:-3602.307221784112,Z:0},{X:35214.05828386354,Y:-3602.1163532939204,Z:0},{X:35240.87098792114,Y:-3601.923983621182,Z:0},{X:35267.89282389346,Y:-3601.7301135164876,Z:0},{X:35295.123687214545,Y:-3601.534743730053,Z:0},{X:35322.56347337072,Y:-3601.3378750117195,Z:0},{X:35350.21207790056,Y:-3601.1395081109526,Z:0},{X:35378.069396394894,Y:-3600.939643776844,Z:0},{X:35406.13532449673,Y:-3600.73828275811,Z:0},{X:35434.40975790127,Y:-3600.535425803093,Z:0},{X:35462.89259235585,Y:-3600.331073659761,Z:0},{X:35491.58372365996,Y:-3600.1252270757086,Z:0},{X:35520.48304766517,Y:-3599.917886798156,Z:0},{X:35549.590460275125,Y:-3599.7090535739494,Z:0},{X:35578.90585744553,Y:-3599.498728149563,Z:0},{X:35608.429135184095,Y:-3599.286911271096,Z:0},{X:35638.160189550545,Y:-3599.073603684276,Z:0},{X:35668.09891665656,Y:-3598.858806134457,Z:0},{X:35698.24521266578,Y:-3598.642519366621,Z:0},{X:35728.59897379374,Y:-3598.424744125376,Z:0},{X:35759.16009630789,Y:-3598.2054811549597,Z:0},{X:35789.92847652753,Y:-3597.984731199236,Z:0},{X:35820.90401082381,Y:-3597.762495001698,Z:0},{X:35852.086595619694,Y:-3597.5387733054663,Z:0},{X:35883.476127389935,Y:-3597.3135668532905,Z:0},{X:35915.07250266104,Y:-3597.0868763875483,Z:0},{X:35946.87561801126,Y:-3596.858702650247,Z:0},{X:35978.88537007056,Y:-3596.6290463830214,Z:0},{X:36011.10165552058,Y:-3596.3979083271374,Z:0},{X:36043.52437109462,Y:-3596.165289223489,Z:0},{X:36076.15341357763,Y:-3595.9311898125998,Z:0},{X:36108.98867980615,Y:-3595.695610834624,Z:0},{X:36142.0300666683,Y:-3595.458553029345,Z:0},{X:36175.27747110378,Y:-3595.220017136176,Z:0},{X:36208.730790103786,Y:-3594.980003894161,Z:0},{X:36242.389920711044,Y:-3594.738514041975,Z:0},{X:36276.25476001975,Y:-3594.495548317923,Z:0},{X:36310.32520517555,Y:-3594.25110745994,Z:0},{X:36344.60115337552,Y:-3594.005192205594,Z:0},{X:36379.08250186815,Y:-3593.757803292083,Z:0},{X:36413.76914795328,Y:-3593.5089414562362,Z:0},{X:36448.66098898212,Y:-3593.258607434515,Z:0},{X:36483.757922357196,Y:-3593.0068019630125,Z:0},{X:36519.059845532334,Y:-3592.7535257774534,Z:0},{X:36554.566656012634,Y:-3592.4987796131945,Z:0},{X:36588.86616778209,Y:-3592.2526953003253,Z:0},{X:36621.99924771952,Y:-3592.0149796364863,Z:0},{X:36654.00537936607,Y:-3591.7853493441726,Z:0},{X:36684.922709750994,Y:-3591.5635307347807,Z:0},{X:36714.78809463237,Y:-3591.349259384025,Z:0}]
			//					var setVal:Number = flashAnims["pip"].p.ptsArray[0].Y
			//					for each (var j:Object in flashAnims["pip"].p.ptsArray) 
			//					{
			//						j.Y = setVal
			//					}					
			//					
			//					
			//					
			//					flashAnims["pip"].p.lpair = [{val:0,path:0},{val:1000,path:flashAnims["pip"].p.ptsArray.length - 1}]
			//					activeAlter = flashAnims["pip"].active
			//					// if 
			//						
			//					var v:Point = MainSceneMotor.floor.PointOnPath(new Point(flashAnims["pip"].p.ptsArray[0].X,flashAnims["pip"].p.ptsArray[0].Y))
			//						
			//						
			//					MainSceneMotor.mouseJoint.body2 = Main.liveCamera.hero_mc.body
			//					MainSceneMotor.mouseJoint.active = true;
			//					
			//					MainSceneMotor.mouseJoint.anchor1.setxy(flashAnims["pip"].p.ptsArray[0].X,flashAnims["pip"].p.ptsArray[0].Y);
			//					//this is for the auto one not the position based one
			//					}else if(activeAlter && flashAnims["pip"].ticker < 1000)
			//					{
			//					
			//					
			//					//this was a hack so InAlter will only work on hero_mc for it to work create an altered list and check if anyofthem are alter
			//					var pos:Vector3 = flashAnims["pip"].p.pointOnLinkedPath(flashAnims["pip"].ticker)
			//					//pos =  MainSceneMotor.floor.PointOnPath(new Point(200, 200),true)
			//					// I have to change it to the ground path position
			//						
			//					v = MainSceneMotor.floor.PointOnPath(new Point(pos.X+85,pos.Y))
			//						
			//					//MainSceneMotor.mouseJoint.anchor1.setxy(pos.X,pos.Y);
			//					
			//					Main.liveCamera.hero_mc.bdy.x = pos.X
			//					Main.liveCamera.hero_mc.bdy.y = pos.Y
			//					//Main.liveCamera.hero_mc.Y = pos.Y
			//					Main.liveCamera.hero_mc.body.velocity.setxy(0,0)
			//						
			//					
			//					//var tD:Number = 1/30000
			//					flashAnims["pip"].ticker+=.5
			//						
			//				}else{
			//					//leave
			//					// i should do a safe way to access this 
			//					// but for now
			//					t++
			//					jumptree[t] = true 
			//					isholding = true
			//					// isMouseJointActve = false;
			//					struggle  = 2
			//						activeAlter = false
			//						
			//					// I could clean up flashAnims here but id recommend not, it should get cleaned up on the scene changes
			//					// I could do some clean up and stuff in here, umm i was thinking of 
			//					//making a function for this stuff and i may but id like to consider not doing it because the more tactile this is the better and more uniquely it will flow
			//
			//				}
			// it should be something like hit vine / tree / hornet 
			
			if(Main.liveCamera.hero_mc.key.Y == -1 &&
				Main.liveCamera.hero_mc.hitTestObject(getscenary("vine1")))
			{
				if(!isHoldingVine){
					yHold = Main.liveCamera.hero_mc.bdy.y	
					isHoldingVine = true
				}
			}else{
				isHoldingVine = false
			}
			
			
			if(isHoldingVine||Main.liveCamera.hero_mc.x >getscenary("vine1").x+500)// && Main.liveCamera.hero_mc.x <getscenary("lastTree").x+45)
			{
				
				if(Main.liveCamera.hero_mc.key.Y == -1)
				{
					//						Main.liveCamera.hero_mc.bdy.x = pos.X
					//						Main.liveCamera.hero_mc.bdy.y = pos.Y
					if(t!=5){
						Main.liveCamera.hero_mc.body.velocity.setxy(0,0)
						Main.liveCamera.hero_mc.bdy.y = yHold
						flashAnims["jumptree0"].p.ptsArray[0].Y = yHold
					}
					// I dunno i could just do it here but whatevs
					//just play a grab animation and dont move him
					//grab = 1
					if(spaceHit() && isholding){
						// in here put the condition start for the animation
						// to the tree or what have you
						t++
							// it may work.. who knows
							isholding = false
						if(t==5){
							flashAnims["thrwHornt"].p.ptsArray = [{X:Main.liveCamera.hero_mc.bdy.x,Y:Main.liveCamera.hero_mc.bdy.y,Z:0},{X:54092,Y:-2490,Z:0}] 
						}
						// ok on return just check the others work should be easy but you know how it goes
						//check whats going on on this with grab it's some too clever coding which i hate so make sure it works other stuff should be relatively easy, honestly im not even really trying with this and im somehow making better progress than i expected i dont know if that speaks to the quality of the underlying archetecture or i just that lazy
						//that set up the other scenes roughly, get the main bits, then go and re storyboard it get it looking just how i want it, and do another pass on the roughs
						
					}
					// just look how I handled grab animation for the baddies
				}
			}
			switch(t)
			{
				case 0:
				{
					playHeroFlashAnim("jumptree0",Main.liveCamera.hero_mc,true)
					if(flashAnims["jumptree0"].ticker >= flashAnims["jumptree0"].p.endVal)
					{
						isholding = true 
						struggle  = 2
						
					}
					
					
					break;
				}
				case 1:
				{
					playHeroFlashAnim("pip",Main.liveCamera.hero_mc,true)
					if(flashAnims["pip"].ticker >= flashAnims["pip"].p.endVal)
					{
						isholding = true 
						struggle  = 2
						
					}
					
					
					break;
				}
				case 2:
				{
					
					playHeroFlashAnim("jumptree1",Main.liveCamera.hero_mc,true)
					if(flashAnims["jumptree1"].ticker >= flashAnims["jumptree1"].p.endVal)
					{
						isholding = true 
						struggle  = 2
						
					}
					
					break;
				}
				case 3:
				{
					playHeroFlashAnim("jumptree2",Main.liveCamera.hero_mc,true)
					if(flashAnims["jumptree2"].ticker >= flashAnims["jumptree2"].p.endVal)
					{
						isholding = true 
						struggle  = 2
						
					}
					
					break;
				}
				case 4:
				{
					overrideRecticle = true
					// umm this is where we would change the hornets doings 
					if(flashAnims["jumpToHrnet"].ticker >= p1 && Main.liveCamera.hero_mc.key.Y == 0){
						
					}else{
						playHeroFlashAnim("jumpToHrnet",Main.liveCamera.hero_mc,true)
					}
					
					if(flashAnims["jumpToHrnet"].ticker >= p1+15&& flashAnims["jumpToHrnet"].ticker <= 200-25){
						//targetRecticle.x target rectice.y && targetrecticle.alpha = 1
					}
					
					playHeroFlashAnim("hrntFlight",hrntBlaise,true)
					// something less than 200
					if(flashAnims["jumpToHrnet"].ticker >= 100)
					{
						isholding = true 
						struggle  = 2	
					}
					
					break;
				}
				case 5:
				{
					
					playHeroFlashAnim("thrwHornt",hrntBlaise,true)
					if(flashAnims["thrwHornt"].ticker >= flashAnims["thrwHornt"].p.endVal)
					{
						
						
						//targetrecticle.alpha = 0
						isholding = true 
						struggle  = 2
						
					}else{
						//targetrecticle.alpha = 0
					}
					
					break;
				}	
				default:
				{
					break;
				}
			}
			
			if(overrideRecticle){
				targetingRecticle.X = -53707
				targetingRecticle.Y = 2582
				targetingRecticle.Z = 1710
			}
			
			//				
			//				if(Main.liveCamera.hero_mc.x >= tree2)
			//				{
			//					//I'm assuming -1 is up
			//					
			//						if(Main.liveCamera.hero_mc.key.Y == -1)
			//						{
			//							// I dunno i could just do it here but whatevs
			//							//just play a grab animation and dont move him
			//							grab = true
			//							if(Main.liveCamera.hero_mc.spacebar){
			//								// in here put the condition start for the animation
			//								// to the tree or what have you
			//								startjumpTohornet
			//							}
			//							// just look how I handled grab animation for the baddies
			//						}else{
			//							grab = false
			//						}
			//				}
			
			
			
			if("leaveCondition"){
				
			}
			
			
			/// this was just a test its not pip
			
			//			if(activeAlter && Main.liveCamera.hero_mc.bdy.x >=5347.532754390598&& Main.liveCamera.hero_mc.bdy.x <=6327.109905519005){
			//				// I put this as an identifier of an animation just make sure they are different even if they overlap
			//				if(flashAnims["pip"].ticker == 0){ 
			//					p.ptsArray = [{X:688.7,Y:76.25,Z:0},{X:688.45,Y:75.5,Z:0},{X:688.25,Y:74.7,Z:0},{X:686.4,Y:78.4,Z:0},{X:685.1,Y:79.35,Z:0},{X:684.35,Y:78.25,Z:0},{X:684,Y:75.45,Z:0},{X:683.8,Y:71.6,Z:0},{X:683.9,Y:67,Z:0},{X:683.95,Y:62.3,Z:0},{X:684.05,Y:57.85,Z:0},{X:683.9,Y:54.25,Z:0},{X:683.5,Y:52,Z:0},{X:682.8,Y:51.55,Z:0},{X:681.7,Y:52.55,Z:0},{X:680.55,Y:54.15,Z:0},{X:679.35,Y:56.25,Z:0},{X:678.05,Y:58.6,Z:0},{X:676.7,Y:61.15,Z:0},{X:675.45,Y:63.8,Z:0},{X:674.15,Y:66.4,Z:0},{X:672.95,Y:68.75,Z:0},{X:671.8,Y:70.8,Z:0},{X:670.85,Y:72.3,Z:0},{X:670,Y:73.2,Z:0},{X:669.35,Y:73.35,Z:0},{X:668.95,Y:72.65,Z:0},{X:668.75,Y:71,Z:0},{X:668.8,Y:68.1,Z:0},{X:669.2,Y:63.95,Z:0},{X:669.9,Y:58.35,Z:0},{X:666.75,Y:50.75,Z:0},{X:665.4,Y:50,Z:0},{X:664,Y:49.3,Z:0},{X:662.6,Y:48.6,Z:0},{X:661.15,Y:47.9,Z:0}] 
			//					Main.liveCamera.hero_mc.prxy = new Vector3()
			//					p.lpair = [{val:5347.532754390598,path:0},{val:5375.5206729942665,path:1},{val:5403.508591597935,path:2},{val:5431.496510201604,path:3},{val:5459.484428805273,path:4},{val:5487.4723474089415,path:5},{val:5515.46026601261,path:6},{val:5543.448184616279,path:7},{val:5571.436103219948,path:8},{val:5599.424021823617,path:9},{val:5627.411940427286,path:10},{val:5655.399859030955,path:11},{val:5683.3877776346235,path:12},{val:5711.375696238292,path:13},{val:5739.363614841961,path:14},{val:5767.35153344563,path:15},{val:5795.339452049298,path:16},{val:5823.327370652967,path:17},{val:5851.315289256636,path:18},{val:5879.303207860305,path:19},{val:5907.291126463973,path:20},{val:5935.279045067642,path:21},{val:5963.266963671311,path:22},{val:5991.2548822749795,path:23},{val:6019.242800878648,path:24},{val:6047.230719482317,path:25},{val:6075.218638085986,path:26},{val:6103.206556689655,path:27},{val:6131.194475293324,path:28},{val:6159.182393896993,path:29},{val:6187.170312500662,path:30},{val:6215.15823110433,path:31},{val:6243.146149707999,path:32},{val:6271.134068311668,path:33},{val:6299.1219869153365,path:34},{val:6327.109905519005,path:35}]
			//					enteredX = Main.liveCamera.hero_mc.x
			//					enteredY = Main.liveCamera.hero_mc.y
			//					// this is to change it to be relative to the position instead of absolute
			//					for (var j:int = p.ptsArray.length-1; j > 0; j--) 
			//					{
			//						if(j == 1){
			//							
			//							p.ptsArray[1].X = p.ptsArray[1].X - p.ptsArray[0].X  
			//							p.ptsArray[1].Y = p.ptsArray[1].Y - p.ptsArray[0].Y
			//							p.ptsArray[1].Z = p.ptsArray[1].Z - p.ptsArray[0].Z
			//							p.ptsArray[0].X = 0
			//							p.ptsArray[0].Y =0
			//							p.ptsArray[0].Z = 0
			//							trace("X = ",p.ptsArray[1].X," ",p.ptsArray[0].X)
			//						}else{
			//							p.ptsArray[j].X = p.ptsArray[j].X - p.ptsArray[j-1].X  
			//							p.ptsArray[j].Y = p.ptsArray[j].Y - p.ptsArray[j-1].Y
			//							p.ptsArray[j].Z = p.ptsArray[j].Z - p.ptsArray[j-1].Z
			//						}
			//						trace("X = ",p.ptsArray[j].X," ",p.ptsArray[j-1].X)
			//					}
			//					
			//					// test actions
			//					
			//				}
			//				Main.liveCamera.hero_mc.inAlter = true
			//				pos = p.pointOnLinkedPath(Main.liveCamera.hero_mc.bdy.x)
			//				Main.liveCamera.hero_mc.x = enteredX + pos.X
			//				Main.liveCamera.hero_mc.y = enteredY + pos.Y
			//			}
			
			if(grab== 1){
				grab++
				if(/*touching tree */false){
					activeAlter = false
				}
				// mini init grab stuf
				
				
			}
			if(grab == 2){
				//MainSceneMotor.mouseJoint.active = true;
			}
			
			
			//	trace(LevelEditor.awyCam.rotationY, "rotY")
			
			
			//				if(!LevelEditor.isFollow ){
			//				LevelEditor.awyCam.z = linkedCamPos.Z
			//				LevelEditor.awyCam.y = linkedCamPos.Y
			//				LevelEditor.awyCam.x = linkedCamPos.X
			//				}
			//				if(Main.liveCamera.hero_mc.bdy.x >= 6500 && Main.liveCamera.hero_mc.bdy.x < 6570 && Main.liveCamera.hero_mc.key.Y<=0 ){
			//					Main.liveCamera.hero_mc.bdy.x = 6500
			//					
			//					//trace(woodhole.name)
			//					woodhole.movie.play()
			//				}
			//				
			//				if(Main.liveCamera.hero_mc.bdy.x >= loopStart){
			//					if(!speedSet){
			//					playingLoopVel = hero.body.velocity.x
			//						speedSet = true
			//					}
			//					// this is sad because it may not work here but will work when I change the system over if so Ill just do a simple hack like += 10
			//					Main.liveCamera.hero_mc.bdy.x += playingLoopVel
			//						// and this has to work as well cuz when we change systems it's actually pretty simple for me to change so i might do it sooner than expected
			//					Main.liveCamera.hero_mc.bdy.y = MainSceneMotor.floor.GroundY(Main.liveCamera.hero_mc.bdy.x)
			//					
			//				}
			//				LevelEditor.awyCam.z = Main.liveCamera.hero_mc.Z + 900;
			//				LevelEditor.awyCam.x = Main.liveCamera.hero_mc.X;
			//				LevelEditor.awyCam.y = Main.liveCamera.hero_mc.Y;
			
			//trace(path.placement(pg).X,path.placement(pg).Y,path.placement(pg).Z)	
			
		}
		// um i think if you wanted to generalize this i would do an array that pushes its value on to this key value pair to check on a past one, then delete from the list when its no longer in the local state we inhabit
		private function spaceHit():Boolean
		{
			
			if(prespaceBar != Main.liveCamera.hero_mc.spacebar)
			{
				prespaceBar = Main.liveCamera.hero_mc.spacebar
				if(Main.liveCamera.hero_mc.spacebar)
					return true
			}
			
			return false;
		}
		//2000, 1100
		
		//var ng:Number = path.linkedValue(pg)
		//			LevelEditor.awyCam.z = Main.liveCamera.hero_mc.Z - 900;
		//			LevelEditor.awyCam.x = Main.liveCamera.hero_mc.X;
		//			LevelEditor.awyCam.y = Main.liveCamera.hero_mc.Y;
		
		//trace(path.placement(ng).X,path.placement(ng).Y,path.placement(ng).Z)
		//trace(LevelEditor., Main.liveCamera.scenary[0].alpha)
		
		//			
		////			MainSceneMotor.floorBody.shapes.at(0).fluidEnabled = true
		////			MainSceneMotor.floorBody.shapes.at(1).fluidEnabled = true
		////			MainSceneMotor.floorBody.shapes.at(2).fluidEnabled = true
		////			MainSceneMotor.floorBody.setShapeFluidProperties(new FluidProperties(2,2));
		//			
		//			if(allLoaded())
		//			{
		////				net.Z = LevelEditor.testthing12.z
		////				//stage_mc.test.scaleX = 
		////					
		////				
		////				net.x =  LevelEditor.testthing12.x - net.width*net.scaleX*.5
		////				net.y =  LevelEditor.testthing12.y - net.height*net.scaleY*.5
		////					
		//				
		//				////trace("Main.liveCamera.scenary[1].X", Main.liveCamera.scenary[1].X)
		////				Main.liveCamera.scenary[1].X =hero.X - 300//(j-1+11)*picWidth
		////			Main.liveCamera.scenary[1].Y =hero.Y - 300//(j-1+1
		//			
		//				if(false){
		//				for (var i:int =0; i < MainSceneMotor.floor.ptsArray.length; i++) 
		//				{
		//					if(MainSceneMotor.floor.ptsArray[i].D > hero.bdy.x)
		//						break;
		//					//tl.insert(TweenLite.to(MainSceneMotor.floor.ptsArray[i], time, {Y:end1,  ease:Linear.easeNone}));
		//				}
		//				MainSceneMotor.floor.ptsArray[i].Y += .03
		//					// when you recalculate the x you need to subsequently recalculate all the d
		//				MainSceneMotor.floor.ptsArray[i].X += 1
		//				
		//				// this should check for jumping
		//					
		//				MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.bdy.x, MainSceneMotor.floorBody,false);
		//				}
		////				if(hero.bdy.x <41607){
		////					hero.bdy.x =41607
		////					hero.bdy.y =13985
		////				}
		////				Main.liveCamera.scenary[1].X =hero.X//(j-1+11)*picWidth
		////				Main.liveCamera.scenary[1].Y =hero.Y//(j-1+11)*picWidth
		////			if(asomething){
		////			hero.bdy.y -=5000
		////			hero.bdy.x +=5000
		////			asomething = false
		////			}
		//					if(something){
		//						
		//				//		Main.liveCamera.swapChildrenAt(Main.liveCamera.getChildIndex(Main.liveCamera.scenary[1]),Main.liveCamera.getChildIndex(Main.liveCamera.scenary[8]));
		//						//Main.liveCamera.scenary[1].scaleZ=6*2.5*4
		//						var scaleW:Number = 2
		//						picWidth = scaleW*2048
		//						for (var j2:int = 0; j2 < Main.liveCamera.scenary.length; j2++) 
		//						{
		//							//							
		//							Main.liveCamera.scenary[j2].scaleZ = scaleW
		//						}
		////						for (var j:int = 11; j < Main.liveCamera.scenary.length; j++) 
		////						{
		////							
		////							Main.liveCamera.scenary[j].scaleZ = scaleW
		////							Main.liveCamera.scenary[j].Z = 0
		////							Main.liveCamera.scenary[j].X =(j-1+11)*picWidth
		////							newY = MainSceneMotor.floor.Groundforce((j-1+11)*picWidth)
		////							Main.liveCamera.scenary[j].Y =(newY+lastY)/2-scaleW/2
		////							lastY = newY
		////						}
		//						
		//						
		//						//heroEntryPoint()
		////						hero.bdy.x  =  6287.541603895139
		////						hero.bdy.y = 1800
		//
		////						Main.liveCamera.scenary[3].X = 0
		////						Main.liveCamera.scenary[3].Y = 0
		//						something = false
		//				
		//					}
		////					if(Main.tick ==450)
		////					LevelEditor.wichEV(new Point(hero.X,hero.Y),new Point(hero.X,hero.Y+30))
		//			}
		//			return
		////			if(hero.bdy.x > log1 &&hero.bdy.x < log2){
		////			sonicRolling = "sonicsliding"
		////			}else{
		////				sonicRolling = null
		////			}
		//			
		////			if(hero.bdy.x > somepoint && scIter < list.length){
		////				if(!entered){
		////					entered = true
		////						
		////					deleteOldies()
		////				}
		////				// list is the list of names of the new images
		////				if(!Assets.isTextureLoaded(list[scIter].name))
		////					{
		////					Assets.LoadTexture(list[scIter].name)
		////					}else{
		////						var myScenary:Object;
		////						Main.liveCamera.addNewScenary(list[scIter].X,list[scIter].Y,list[scIter].Z,new Image(Assets.getTexture(list[scIter].name)),list[scIter].name)
		////												
		////						
		////						
		////						scIter++
		////							
		////					}
		////					if(scIter == 16){
		////						for (var n2:int = 0; n2 < Main.liveCamera.scenary.length; n2++) 
		////						{
		////							Main.liveCamera.scenary[n2].scaleZ = 2.0
		////						}
		////						scIter++
		////					}
		////			}
		//			
		////			if(hero.bdy.x > skidStart &&hero.bdy.x < skidEnd){
		////			sonicSprinting = "sonicskidding"
		////			}else{
		////				sonicSprinting = null
		////			}
		//			
		//			if(actor.bdy.x < 300)
		//			{
		//				sonicJogging = "begsonicJogging"
		//				sonicWalking = "begsonicWalking"
		//			}else{
		//			//	hntArmtr.animation.gotoAndPlay("move",-1,-1)
		//				sonicJogging = "sonicJogging"
		//				sonicWalking = "sonicWalking"
		//					
		////					hntArmtr.display.x = hero.bdy.x
		////					hntArmtr.display.y = hero.bdy.y
		////					hntArmtr.armatureData.getAnimationData("firstPass");
		//			}
		//			
		//			
		//			if(actor.bdy.x > 10538*4.5 && !overide&& false){
		//				overide = true;
		//				speed = actor.body.angularVel/110
		//				center = new Point(actor.bdy.x, actor.bdy.y - 100)
		//				an = Math.PI/2
		//					Main.liveCamera.speed.X = 0;
		//					Main.liveCamera.speed.Y = 0;
		//			}
		//			
		//			if(overide){
		//				an-=speed
		//				
		//					MainSceneMotor.mouseJoint.body2 = Main.liveCamera.hero_mc.body
		//					MainSceneMotor.mouseJoint.anchor1.setxy(center.x + Math.cos(an)*100,center.y + Math.sin(an)*100);
		//					MainSceneMotor.mouseJoint.active = true;
		//					//MainSceneMotor.floor.ptsArray = [MainSceneMotor.floor.ptsArray[0],MainSceneMotor.floor.ptsArray[1]]
		//					////trace("these are the droids your looking for ",x2," ",y2)
		//			}
		//			
		//			if(an < -6/4*Math.PI && !called){
		//				called = true
		//				director.nextScene()
		//			}
		//		}
		
		
	}
}