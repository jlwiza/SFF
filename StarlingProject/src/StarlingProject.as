package
{
	import com.gskinner.utils.TwoWayLocalConnection;
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.baseConstructs.SceneHandler;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.NSprite;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.LookAtController;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.events.Stage3DEvent;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.WireframePlane;
	
	import awayphysics.dynamics.AWPDynamicsWorld;
	
	import org.osmf.events.TimeEvent;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.URLResource;
	
	import starling.core.Starling;

	//import starling.events.Event;
	
	[SWF(frameRate="30", width="848", height="480", backgroundColor="0x333333")]
	public class StarlingProject extends flash.display.Sprite
	{
		private static var myStarling:Starling;
		//private static var mps:MediaPlayerSprite;
		private var tic:int;
		private var circle:Sprite;
		public static var away3dView : View3D;
		//private var world:AWPDynamicsWorld;
		public static var Cutscene:uint  = 0;
		public static var lookAtTarget:ObjectContainer3D = new ObjectContainer3D;
		private var stage3DManager:Stage3DManager;
		private var stage3DProxy:Stage3DProxy;
		private var _scene:Scene3D;
		public static var awyCam:Camera3D;
		private var canvasOn:Boolean;
		public static var isFollowSonic:Boolean = false;

		private static var canvWidth:Number = 550;
		private static var canvHeight:Number = 400;		
		public static var bmd:BitmapData =new BitmapData(canvWidth,canvHeight, true, 0x0);
		public static var bm:Bitmap = new Bitmap(bmd)
		private var oldLoc:Point = new Point();
		private var _mask:Sprite;
		
		// Stage manager and proxy instances
		
		public static var camera3D : LookAtController;
		
		// Materials
		private var cubeMaterial : TextureMaterial;
		
		// Objects
		
		
		// Runtime variables
		private var lastPanAngle : Number = 0;
		private var lastTiltAngle : Number = 0;
		private var lastMouseX : Number = 0;
		private var lastMouseY : Number = 0;
		private var mouseDown : Boolean;
		private var renderOrderDesc : TextField;
		
		
		// Starling instances
		private var featherMain:Starling;
		private var game:Starling;
		
		private var cAlph:ColorTransform;
		private var achnl:Number = .8;
		private static var cAlph2:ColorTransform;
		private var achnl2:Number = .9;
		public static var renderOrder : int = 3;
		//private var gameState:int = 0;
		
		// Constants
		public static const AWAY:int = 0;
		public static const GAME:int = 1;
		public static const FEATHER_AWAY:int = 2;
		public static const FEATHER_GAME:int = 3;
		public static const PAUSE:int = 4;
		public static const AWAY_GAME:int = 5;
		public static var playing:Boolean = true;
		
		//		public var methodName:String = "sendPenInfoFromHtml";
		//		
		//		public var method:Function = recievePenInfoFromHtml;
		//		public var wasSuccessful:Boolean = ExternalInterface.addCallback(methodName, method)
		//		public var sendOff:String = "sendOffFromHtml";
		//		
		//		public var recieveOff:Function = HtmlturnOffCanvas;
		//		public var tOffwasSuccessful:Boolean = ExternalInterface.addCallback(sendOff, recieveOff)
		//		
		
		//***UGGHH THIS NEEDS TO BE CLEANED UP
		private var img1Loader:Loader;
		private var canvX:int;
		private var canvY:int;
		private var painting:Boolean = true;
		private var oldBit:BitmapData;
		public static var connToGame:LocalConnection;
		private static var coolDown:int = 0;
		public static var module:*
		public static var liveEdit:Boolean = false;
		private var count:int = 0;
		public static var eraser:Boolean;
		public static var brushScale:Number = 1;
		
		
		//private var myBridge:SWFBridgeAS3
		private const _debug:Boolean = false;
		//		private var _debugDraw:AWPDebugDraw;
		//		public static  var _physicsWorld:AWPDynamicsWorld;
		private var startthis:Boolean = false;
		
		public static var testthing12:Vector3D;
		public static var isFollowPath:Boolean = true;
		private var once:Boolean = false;
		public static var onPath:Boolean = true;
		private var oldRot:Number;
		private var snehndlr:SceneHandler
		public static var perpRtYCos:Number;
		public static var perpRtYSin:Number;
		public var c:int = 4;
		private var calledAddScenary:Boolean = false
		private var startCount:int = 99;
		private var myvx:Number;
		private var myvy:Number;
		private var mySname:String;
		private var myNumOFScnryFms:uint;
		private var myScale:Number;
		private var myvz:Number;
		private var bodyY:Number;
		
		public function StarlingProject()
		{
			// oh weird that's right it's gonna need all this shit I copyied over from LevelEditor to handle that 3d shit
			// ok Ill probably put the global check here, but since the game starts in main we'll create it in Main
			// so I'd put
			/**CHECK TO SEE IF WE ARE IN EDIT MODE OR RELEASE**/
			Main.Release = true
			init()
		}	
		
		public function init():void
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			initProxies();
		}
		private function initProxies():void
		{
			// Define a new Stage3DManager for the Stage3D objects
			stage3DManager = Stage3DManager.getInstance(stage);
			
			// Create a new Stage3D proxy to contain the separate views
			stage3DProxy = stage3DManager.getFreeStage3DProxy();
			stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
			stage3DProxy.antiAlias = 8;
			stage3DProxy.color = 0x333333;
		}
		
		private function onContextCreated(event : Stage3DEvent) : void {
			
			initAway3D();
			initStarling();
			initObjects();
			
			
			
			addEventListener(Event.ENTER_FRAME, physicsReady, false, 0, true);
			
			
		}
		
		private function initObjects() : void {
			// Build the cubes for view 1
		
			
			away3dView.scene.addChild(lookAtTarget)
			
		//			away3dView.scene.addChild(cube5);
			away3dView.scene.addChild(new WireframePlane(3000, 3000, 20, 20, 0xbbbbb0, 0.5, WireframePlane.ORIENTATION_XZ));
			//			cubeRigidBody.position=new Vector3D(-750,0,0);
		}
		
		private function physicsReady(e:Event):void {
			var someCheck:Boolean = true
			if (someCheck) {
				removeEventListener(Event.ENTER_FRAME, physicsReady);
//				initListeners();
				stage3DProxy.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
			}
			
		}
		
		public function testP():void{
			var h:Hero = Main.liveCamera.hero_mc
			var c:Camera3D = away3dView.camera
			var fl:Number = PerspectiveLens(c.lens).focalLength
			trace("this mess ",h.X," should = ",Math.PI/180)
			
			
		}
		/**
		 * Initialise the Away3D views
		 */
		private function initAway3D() : void
		{
			// Create the first Away3D view which holds the cube objects.
			away3dView = new View3D();
			_scene = new Scene3D();
			
			away3dView.scene = _scene;
			awyCam = away3dView.camera
			away3dView.camera.lens = new PerspectiveLens(65);
			away3dView.camera.lens.far = 50000;
			away3dView.camera.lens.near = 1;
			
			away3dView.camera.y = 30;
			away3dView.stage3DProxy = stage3DProxy;
			away3dView.shareContext = true;
			//new FollowController(
			//camera3D =  new HoverController(away3dView.camera, lookAtTarget, 180, 0, 900, -15, 30);
			// i'll fix this after
			camera3D = new LookAtController(away3dView.camera, lookAtTarget)
			camera3D.autoUpdate = true;
			
			
			
			
			MainStage.distance = 900
			
			
			
			addChild(away3dView);
			
			if(renderOrder == AWAY || renderOrder ==FEATHER_AWAY || renderOrder == AWAY_GAME )
				addChild(new AwayStats(away3dView));
		}
		
		/**
		 * Initialise the Starling sprites
		 */
		private function initStarling() : void
		{
			// Create the Starling scene to add the checkerboard-background
			game = new Starling(com.jonLwiza.engine.Main, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
			game.start()
			
			// Create the Starling scene to add the particle effect
//			featherMain = new Starling(FeatherMain, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
//			//			// you must start it if you want mouse functionality 
//			featherMain.start();
			
		}
		
		private function onEnterFrame(event : Event) : void {
			// Update the hovercontroller for view 1
			
			if(startCount != 99)
			{
				startCount++
				//if(startCount == 2)
				//AddTest()
			}
			
			
			if(awyCam.rotationX !=oldRot){
				perpRtYCos = Math.cos((StarlingProject.awyCam.rotationY+90)*Math.PI/180)
				perpRtYSin = Math.sin((StarlingProject.awyCam.rotationY+90)*Math.PI/180)
				oldRot = awyCam.rotationX 
			}
		//	testthing12 = away3dView.project(cube1.scenePosition)
//			cube1.x=50
//			cube1.y=-50
//			cube1.z=50
			// this is hackey and dirty considering i have other fixes but its quick and dirty
			// ok isfollow probably refers to the path and we quickly get it to look at sonic for no reason whatsoever
			if(isFollowPath){
				if(!once){
					lookAtTarget.x =Main.liveCamera.hero_mc.X
					lookAtTarget.y =Main.liveCamera.hero_mc.Y
					lookAtTarget.z =Main.liveCamera.hero_mc.Z
					once = true
				}
				//		I moved this to main because of errors in processing the camera			
				//				LevelEditor.awyCam.z = Main.liveCamera.hero_mc.Z - 900;
				//				LevelEditor.awyCam.x = Main.liveCamera.hero_mc.X;
				//				LevelEditor.awyCam.y = Main.liveCamera.hero_mc.Y;
			}
			
			MainStage.lookAtTarget.x = lookAtTarget.x
			MainStage.lookAtTarget.y = lookAtTarget.y
			MainStage.lookAtTarget.z = lookAtTarget.z
			//public static var testthing12
			camera3D.autoUpdate = true;
			if(false){//EditKeyHandler.cntrl && EditKeyHandler.qButton){
				//						lookAtTarget.x =Main.liveCamera.hero_mc.X
				//						lookAtTarget.y =Main.liveCamera.hero_mc.Y
				//						lookAtTarget.z =Main.liveCamera.hero_mc.Z
				lookAtTarget.x =0//Main.liveCamera.hero_mc.X
				lookAtTarget.y =0//Main.liveCamera.hero_mc.Y
				lookAtTarget.z =0//Main.liveCamera.hero_mc.Z
				
				if(!once){
					lookAtTarget.x =Main.liveCamera.hero_mc.X
					lookAtTarget.y =Main.liveCamera.hero_mc.Y
					lookAtTarget.z =Main.liveCamera.hero_mc.Z
					//							once = true
				}
				
				StarlingProject.awyCam.z = Main.liveCamera.hero_mc.Z - 900;
				StarlingProject.awyCam.x = Main.liveCamera.hero_mc.X;
				StarlingProject.awyCam.y = Main.liveCamera.hero_mc.Y;
			}
			//camera3D.distance +=3
			//if(startthis)
			//_physicsWorld.step(1/30, 1, 1/30);
			//trace(away3dView.project(cube1.scenePosition).x, away3dView.project(cube1.scenePosition).y,away3dView.project(cube1.scenePosition).z)
			//inGameUpdate()
			
			
			// replaced
			if(false)
			//	EditKeyHandler.InGameCamUpdate()
			
			if (mouseDown) {
				
				if(!playing){
					
					game.stop();
				}else
				{
					
					game.start();
				}
			}
			
			// Update the scenes
			// i think he got the instance so that he could update it in time
			//var starlingCheckerboardSprite:StarlingCheckerboardSprite = StarlingCheckerboardSprite.getInstance();
			//			if (starlingCheckerboardSprite)
			//				starlingCheckerboardSprite.update();
			
			
			if(!playing){
				
				
				game.render()
				featherMain.render()
				return;
			}
			// Use the selected rendering order
//			if (renderOrder == FEATHER_AWAY) {
//				
//				// Render the Starling animation layer
//				//				starlingCheckerboard.nextFrame();
//				
//				// Render the Away3D layer
//				away3dView.render();
//				// ill probably forget but uncomment this to get the 3d world back
//				// Render the Starling stars layer
//				featherMain.nextFrame();
//				
//				//game.nextFrame()
//				
//			} else if (renderOrder == FEATHER_GAME) {
//				
//				away3dView.render();
//				
//				// Render the Starling animation layer
//				if(!EditKeyHandler.camvas){
//					if(canvasOn){
//						//	turnOffCanvas();
//						stage.removeEventListener(MouseEvent.MOUSE_MOVE, touchEvent);
//						
//						canvasOn = false
//					}
//					game.nextFrame();
//				}else{
//					eraser = EditKeyHandler.cntrl
//					if(!canvasOn){
//						
//						//	turnOnCanvas(canvX,canvY, canvWidth,canvHeig ht);
//						stage.addEventListener(MouseEvent.MOUSE_MOVE, touchEvent);
//						canvasOn = true;
//					}
//					game.nextFrame();
//					//game.render()
//					
//				}
//				
//				// Render the Starling stars layer
//				featherMain.nextFrame();
//			} else if (renderOrder == AWAY){
//				
//				// Render the Away3D layer
//				away3dView.render();
//				// Render the Starling animation layer
//				//				starlingCheckerboard.nextFrame();
//			}else if (renderOrder == GAME){
//				
//				// Render the game layer
//				game.nextFrame();
//			}else if (renderOrder == AWAY_GAME){
				away3dView.render();
				
				
				game.nextFrame()
//			}
		}
			
//			world=AWPDynamicsWorld.getInstance();
//			world.initWithDbvtBroadphase();
		//	addEventListener(Event.ENTER_FRAME,update);
//			myStarling.showStats = true
//			myStarling.stage3D.visible = true;
//			
////			myStarling = new Starling(Game, stage);
//			myStarling.antiAliasing = 1;
//			//doStuff();
//			// just remove this when you get back onlinr that and the comment on do stuff
//			myStarling.start();
			
			//stage.addEventListener(MouseEvent.CLICK,addCube);
//		}
		
		// this function creates a cube in the same way seen before
//		private function addCube(e:MouseEvent):void {
//			var cubeMesh:Mesh=new Mesh(new CubeGeometry(50,50,50));
//			cubeMesh.material=new ColorMaterial();
//			cubeMesh.material.lightPicker = new StaticLightPicker([light]);
//			mainView.scene.addChild(cubeMesh);
//			var cubeShape:AWPBoxShape=new AWPBoxShape(50,50,50);
//			var cubeRigidBody:AWPRigidBody=new AWPRigidBody(cubeShape,cubeMesh,1); // notice the final "1" as it's dynamic
//			world.addRigidBody(cubeRigidBody);
//			cubeRigidBody.friction=1;
//			cubeRigidBody.position=new Vector3D(Math.random()*600-300,400,Math.random()*600-300);
//			dacube = cubeRigidBody
//			
//		}	
//		private function update(e:Event):void {
//			// first, we iterate the physics engine...
//			world.step(1/30, 1, 1/30);
//			
////			if(dacube)
////				//trace(dacube.position.y)
////			// then we render the 3D scene
////			mainView.render();
//		}
		
//		private function doStuff():void
//		{
////			mps = new MediaPlayerSprite();
////			addChild(mps);
////			circle = new Sprite();
//////			
////			mps.resource = new URLResource("http://adobe.edgeboss.net/download/adobe/adobetv/platform_evangelism/believe.mp4");
////			mps.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown) 
//			mps.mediaPlayer.volume = 0;
//			circle.graphics.beginFill(0xFFCC00); 
//			circle.graphics.drawRect(0,0,50,50);
//			addChild(circle); 
//			
//			circle.addEventListener(MouseEvent.CLICK, onClick) 
//				
//				circle.alpha = .3;
//			//mps.addEventListener(MouseEvent.CLICK, onClick);
//			//mps.mediaPlayer.addEventListener(TimeEvent.CURRENT_TIME_CHANGE, currentTime);
//		}
//		 
//		
//		private function onClick(event:MouseEvent):void 
//		{ 
////			circle.removeEventListener(MouseEvent.CLICK, onClick);
////			removeChild(circle);
//			if(mps.mediaPlayer.playing){
//			mps.mediaPlayer.pause();
//			myStarling.stage3D.visible = true;
//			//removeChild(mps);
//			myStarling.start();
//			
//			}else{
//				myStarling.stage3D.visible = false;
//				//myStarling.stop()
//				//addChild(mps);
//				//myStarling = null;
//				myStarling.stop();
//				mps.mediaPlayer.play();
//				
//			}
//			
//			
//		} 
//		
//		private static function PlayCutScene(event:Event):void
//		{
//			if(mps.mediaPlayer.playing){
//				mps.mediaPlayer.pause();
//				myStarling.stage3D.visible = true;
//				//removeChild(mps);
//				myStarling.start();
//				
//			}else{
//				myStarling.stage3D.visible = false;
//				//myStarling.stop()
//				//addChild(mps);
//				//myStarling = null;
//				myStarling.stop();
//				mps.mediaPlayer.play();
//				
//			}
//		}
		
		
//		protected function currentTime(event:TimeEvent):void
//		{
//			
//			tic++
//			if (tic == 15) 
//			{
//						
//			}
//		}
		
		
	}
}