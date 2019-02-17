package 
{
	
	
	import flash.display.*;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	//import flash.filesystem.File;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	import adobe.utils.MMExecute;
	
	
	
	
	[SWF(backgroundColor="#000000", frameRate="60")]
	
	public class Module2 extends MovieClip
	{
		private var img1Loader:Loader;
		public static var conn:LocalConnection;
		private static var coolDown:int;
		public static var module:*
		//plane texture
		
		
		//engine variables
		
		/**
		 * Constructor
		 */
		public function Module2()
		{
			
			conn = new LocalConnection();
			conn.client = this
			conn.allowDomain("*");
			// I comment this out cuz if you test it itll mess up sometimes
			conn.connect("_modeServer");
			
			var jsfl:String = new String();
			jsfl += "fl.getDocumentDOM().getTimeline().layers[0].frames[0].elements[0].x= 600 ;";
			MMExecute(jsfl);
		}
		
		public function moduleUpdate():void{
			
			
			
			if(coolDown == 0){
				//var fl:File = new File(File.userDirectory.nativePath+"/Google Drive/Module/bin-debug/Module.swf")
				//var fl:File = new File(File.userDirectory.nativePath+"/AppData/Local/Adobe/Animate CC 2017/en_US/Configuration/WindowSWF/Module2.swf")

				//var img1Request:URLRequest = new URLRequest("C:/Users/jonat/AppData/Local/Adobe/Animate%20CC%202017/en_US/Configuration/WindowSWF/Module.swf");
				var img1Request:URLRequest = new URLRequest("Module.swf")
				img1Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
				//img1Loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, complete);
				img1Loader.load(img1Request);
				
				coolDown = 30
			}else{
				//trace("failure")
			}
		}
		
		protected function complete(event:Event):void
		{
			//trace("update complete")
			module = img1Loader.content
				//				count++
			
			//module.test();
			//Main.liveCamera.hero_mc.currScene[0].setModule()
		}
		
	}
}

//package {
//	import away3d.containers.*;
//	import away3d.controllers.*;
//	import away3d.core.managers.*;
//	import away3d.debug.*;
//	import away3d.entities.*;
//	import away3d.events.*;
//	import away3d.materials.*;
//	import away3d.primitives.*;
//	import away3d.textures.*;
//	
//	import flash.display.*;
//	import flash.events.*;
//	import flash.text.*;
//	
//	import starling.core.*;
//	import starling.rootsprites.*;
//	
//	
//	public class Module2 extends MovieClip {
//		
//		
//		// Stage manager and proxy instances
//		private var stage3DManager : Stage3DManager;
//		private var stage3DProxy : Stage3DProxy;
//		
//		// Away3D view instances
//		private var away3dView : View3D;
//		
//		// Camera controllers 
//		private var hoverController : HoverController;
//		
//		// Materials
//		private var cubeMaterial : TextureMaterial;
//		
//		// Objects
//		private var cube1 : Mesh;
//		private var cube2 : Mesh;
//		private var cube3 : Mesh;
//		private var cube4 : Mesh;
//		private var cube5 : Mesh;
//		
//		// Runtime variables
//		private var lastPanAngle : Number = 0;
//		private var lastTiltAngle : Number = 0;
//		private var lastMouseX : Number = 0;
//		private var lastMouseY : Number = 0;
//		private var mouseDown : Boolean;
//		private var renderOrderDesc : TextField;
//		private var renderOrder : int = 0;
//		
//		// Starling instances
//		
//		
//		// Constants
//		private const CHECKERS_CUBES_STARS:int = 0;
//		private const STARS_CHECKERS_CUBES:int = 1;
//		private const CUBES_STARS_CHECKERS:int = 2;
//		
//		/**
//		 * Constructor
//		 */
//		public function Module2()
//		{
//			init();
//		}
//		
//		/**
//		 * Global initialise function
//		 */
//		private function init():void
//		{
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.align = StageAlign.TOP_LEFT;
//			
//			initProxies();
//		}
//		
//		/**
//		 * Initialise the Stage3D proxies
//		 */
//		private function initProxies():void
//		{
//			// Define a new Stage3DManager for the Stage3D objects
//			stage3DManager = Stage3DManager.getInstance(stage);
//			
//			// Create a new Stage3D proxy to contain the separate views
//			stage3DProxy = stage3DManager.getFreeStage3DProxy();
//			stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
//			stage3DProxy.antiAlias = 8;
//			stage3DProxy.color = 0x0;
//		}
//		
//		private function onContextCreated(event : Stage3DEvent) : void {
//			initAway3D();
//			initStarling();
//			initMaterials();
//			initObjects();
//			initListeners();
//			initListeners();
//		}
//		
//		
//		/**
//		 * Initialise the Away3D views
//		 */
//		private function initAway3D() : void
//		{
//			// Create the first Away3D view which holds the cube objects.
//			away3dView = new View3D();
//			away3dView.stage3DProxy = stage3DProxy;
//			away3dView.shareContext = true;
//			
//			hoverController = new HoverController(away3dView.camera, null, 45, 30, 1200, 5, 89.999);
//			
//			addChild(away3dView);
//			
//			addChild(new AwayStats(away3dView));
//		}
//		
//		/**
//		 * Initialise the Starling sprites
//		 */
//		private function initStarling() : void
//		{
//			// Create the Starling scene to add the checkerboard-background
////			starlingCheckerboard = new Starling(StarlingCheckerboardSprite, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
////			
////			// Create the Starling scene to add the particle effect
////			starlingStars = new Starling(StarlingStarsSprite, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
//		}
//		
//		/**
//		 * Initialise the materials
//		 */
//		private function initMaterials() : void {
//			//Create a material for the cubes
//			var cubeBmd:BitmapData = new BitmapData(128, 128, false, 0x0);
//			cubeBmd.perlinNoise(7, 7, 5, 12345, true, true, 7, true);
//			cubeMaterial = new TextureMaterial(new BitmapTexture(cubeBmd));
//			cubeMaterial.gloss = 20;
//			cubeMaterial.ambientColor = 0x808080;
//			cubeMaterial.ambient = 1;
//		}
//		
//		private function initObjects() : void {
//			// Build the cubes for view 1
//			var cG:CubeGeometry = new CubeGeometry(300, 300, 300);
//			cube1 = new Mesh(cG, cubeMaterial);
//			cube2 = new Mesh(cG, cubeMaterial);
//			cube3 = new Mesh(cG, cubeMaterial);
//			cube4 = new Mesh(cG, cubeMaterial);
//			cube5 = new Mesh(cG, cubeMaterial);
//			
//			// Arrange them in a circle with one on the center
//			cube1.x = -750; 
//			cube2.z = -750;
//			cube3.x = 750;
//			cube4.z = 750;
//			cube1.y = cube2.y = cube3.y = cube4.y = cube5.y = 150;
//			
//			// Add the cubes to view 1
//			away3dView.scene.addChild(cube1);
//			away3dView.scene.addChild(cube2);
//			away3dView.scene.addChild(cube3);
//			away3dView.scene.addChild(cube4);
//			away3dView.scene.addChild(cube5);
//			away3dView.scene.addChild(new WireframePlane(2500, 2500, 20, 20, 0xbbbb00, 1.5, WireframePlane.ORIENTATION_XZ));
//		}
//		
//		/**
//		 * Initialise the button to swap the rendering orders
//		 */
//		private function initButton() : void {
//			this.graphics.beginFill(0x0, 0.7);
//			this.graphics.drawRect(0, 0, stage.stageWidth, 100);
//			this.graphics.endFill();
//			
//			
//			
//			renderOrderDesc = new TextField();
//			renderOrderDesc.defaultTextFormat = new TextFormat("_sans", 11, 0xffff00);
//			renderOrderDesc.width = stage.stageWidth;
//			renderOrderDesc.x = 300;
//			renderOrderDesc.y = 5;
//			addChild(renderOrderDesc);
//			
//			updateRenderDesc();
//		}
//		
//		/**
//		 * Set up the rendering processing event listeners
//		 */
//		private function initListeners() : void {
//			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
//			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
//			
//			stage3DProxy.addEventListener(Event.ENTER_FRAME, onEnterFrame);
//		}
//		
//		/**
//		 * The main rendering loop
//		 */
//		private function onEnterFrame(event : Event) : void {
//			// Update the hovercontroller for view 1
//			if (mouseDown) {
//				hoverController.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
//				hoverController.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
//			}
//			
//			// Update the scenes
////			var starlingCheckerboardSprite:StarlingCheckerboardSprite = StarlingCheckerboardSprite.getInstance();
////			if (starlingCheckerboardSprite)
////				starlingCheckerboardSprite.update();
//			
//			// Use the selected rendering order
//			if (renderOrder == CHECKERS_CUBES_STARS) {
//				
//				// Render the Starling animation layer
//				//starlingCheckerboard.nextFrame();
//				
//				// Render the Away3D layer
//				away3dView.render();
//				
//				// Render the Starling stars layer
//			//	starlingStars.nextFrame();
//				
//			} else if (renderOrder == STARS_CHECKERS_CUBES) {
//				
//				// Render the Starling stars layer
//				//starlingStars.nextFrame();
//				
//				// Render the Starling animation layer
//				//starlingCheckerboard.nextFrame();
//				
//				// Render the Away3D layer
//				away3dView.render();
//				
//			} else {
//				
//				// Render the Away3D layer
//				away3dView.render();
//				
//				// Render the Starling stars layer
//				//starlingStars.nextFrame();
//				
//				// Render the Starling animation layer
//				//starlingCheckerboard.nextFrame();
//			}
//		}
//		
//		/**
//		 * Handle the mouse down event and remember details for hovercontroller
//		 */
//		private function onMouseDown(event : MouseEvent) : void {
//			mouseDown = true;
//			lastPanAngle = hoverController.panAngle;
//			lastTiltAngle = hoverController.tiltAngle;
//			lastMouseX = stage.mouseX;
//			lastMouseY = stage.mouseY;
//		}
//		
//		/**
//		 * Clear the mouse down flag to stop the hovercontroller
//		 */
//		private function onMouseUp(event : MouseEvent) : void {
//			mouseDown = false; 
//		}
//		
//		/**
//		 * Swap the rendering order 
//		 */
//		private function onChangeRenderOrder(event : MouseEvent) : void {
//			if (renderOrder == CHECKERS_CUBES_STARS) {
//				renderOrder = STARS_CHECKERS_CUBES;
//			} else if (renderOrder == STARS_CHECKERS_CUBES) {
//				renderOrder = CUBES_STARS_CHECKERS;
//			} else {
//				renderOrder = CHECKERS_CUBES_STARS;
//			}
//			
//			updateRenderDesc();
//		}		
//		
//		/**
//		 * Change the text describing the rendering order
//		 */
//		private function updateRenderDesc() : void {
//			var txt:String = "Demo of integrating three framework layers onto a stage3D instance. One Away3D layer is\n";
//			txt += "combined with two Starling layers. Click the button to the left to swap the layers around.\n";
//			txt += "EnterFrame is attached to the Stage3DProxy - clear()/present() are handled automatically\n";
//			txt += "Mouse down and drag to rotate the Away3D scene.\n\n";
//			switch (renderOrder) {
//				case CHECKERS_CUBES_STARS : txt += "Render Order (first:behind to last:in-front) : Checkers > Cubes > Stars"; break;
//				case STARS_CHECKERS_CUBES : txt += "Render Order (first:behind to last:in-front) : Stars > Checkers > Cubes"; break;
//				case CUBES_STARS_CHECKERS : txt += "Render Order (first:behind to last:in-front) : Cubes > Stars > Checkers"; break;
//			}
//			renderOrderDesc.text = txt;
//		}
//	}
//}