package
{
	import com.jonLwiza.engine.Main;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.NSprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.core.BitmapAsset;
	
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.events.Stage3DEvent;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.WireframePlane;
	import away3d.textures.BitmapTexture;
	
	import starling.core.Starling;
	
	public class AwayEditor extends Sprite
	{
		[Embed(source="Circle.png", mimeType="image/png")]
		private var BrushBm : Class;
		// I changed this from Bitmap Asset im not sure why it was that to begin with but uh seems to be working fine
		private var _brushPart:Bitmap = new BrushBm();
		private var _brush2Part:Bitmap = new BrushBm();
		
		private var _canvas : Sprite;
		private var _brush : Sprite;
		private var scale_brush:Number = .6;
		private static var canvWidth:Number = 550;
		private static var canvHeight:Number = 400;		
		public static var bmd:BitmapData =new BitmapData(canvWidth,canvHeight, true, 0x0);
		public static var bm:Bitmap = new Bitmap(bmd)
		private var oldLoc:Point = new Point();
		private var _mask:Sprite;
		
		// Stage manager and proxy instances
		private var stage3DManager : Stage3DManager;
		private var stage3DProxy : Stage3DProxy;
		
		// Away3D view instances
		private var away3dView : View3D;
		
		// Camera controllers 
		private var hoverController : HoverController;
		
		// Materials
		private var cubeMaterial : TextureMaterial;
		
		// Objects
		private var cube1 : Mesh;
		private var cube2 : Mesh;
		private var cube3 : Mesh;
		private var cube4 : Mesh;
		private var cube5 : Mesh;
		
		// Runtime variables
		private var lastPanAngle : Number = 0;
		private var lastTiltAngle : Number = 0;
		private var lastMouseX : Number = 0;
		private var lastMouseY : Number = 0;
		private var mouseDown : Boolean;
		private var renderOrderDesc : TextField;
		public static var renderOrder : int = 3;
		//private var gameState:int = 0;
		
		// Starling instances
		private var featherMain:Starling;
		private var game:Starling;
		
		private var cAlph:ColorTransform;
		private var achnl:Number = .8;
		private var cAlph2:ColorTransform;
		private var achnl2:Number = .9;
		
		// Constants
		public static const AWAY:int = 0;
		public static const GAME:int = 1;
		public static const FEATHER_AWAY:int = 2;
		public static const FEATHER_GAME:int = 3;
		public static const PAUSE:int = 4;
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
		private var canvX:int;
		private var canvY:int;
		private var canvasOn:Boolean = true;
		private var painting:Boolean = false;
		public function AwayEditor()
		{
			init();
			//var star:Starling = new Starling(FeatherMain, stage)
			//star.start();
			//your paintness
			
			
			addEventListener(Event.ADDED_TO_STAGE, ready);
			
		}
		
		protected function ready(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, ready);
			
			_brush = new Sprite();
			_mask = new Sprite();
			//_brush.blendMode = BlendMode.ERASE
			
			cAlph = new ColorTransform(1,1,1,achnl);
			cAlph2 = new ColorTransform(1,1,1,achnl2);
			
			_brush.scaleX = scale_brush
			_brush.scaleY = scale_brush
			_brush.addChild(_brushPart)
			_brush.cacheAsBitmap = true;
			
			addChild(bm)
			_mask.addChild(_brush2Part)
			canvX = 100;
			canvY = 100;
			bm.x = canvX;
			bm.y = canvY;
			
			//turnOnCanvas(canvX,canvY, 1,1);
			
			_mask.alpha = .5;
			
			this.blendMode = BlendMode.LAYER
			// this shit is such a mess ughjahljkdsahf;d f
			if(painting)
				stage.addEventListener(MouseEvent.MOUSE_MOVE, touchEvent);
		}
		
		//		public function turnOffCanvas():void 
		//		{
		//			
		//			ExternalInterface.call("removeCanvas");	
		//		}
		//		public function HtmlturnOffCanvas():void 
		//		{
		//			
		//			EditKeyHandler.camvas = false;
		//		}
		//		
		//		public function turnOnCanvas(x:Number, y:Number, width:Number, height:Number):void 
		//		{
		//			ExternalInterface.call("addCanvas",x,y,width,height);	
		//		}
		//		public function EditCanvasDimensions(x:Number, y:Number, width:Number, height:Number):void 
		//		{
		//			ExternalInterface.call("editCanvas",x,y,width,height);	
		//		}
		
		//		public function removeCanvas():void 
		//		{
		//			EditCanvasDimensions(0,0,5,5)	
		//		}
		//		public function defaultCanvas():void 
		//		{
		//			EditCanvasDimensions(canvX,canvY, canvWidth,canvHeight);	
		//		}
		
		//		public function recievePenInfoFromHtml(pressure,eraser,mX,mY,hover):void {
		//			//trace(hover);
		//			var location : Point =new Point(mX,mY);
		//			var prevLocation : Point =oldLoc;
		//			oldLoc = location
		//			if(hover)
		//			{
		//				return;
		//			}
		//			//brush.visible = false;
		//			//var location : Point = touch.getLocation(_canvas);
		////						if(prevLocation.x == 0 && prevLocation.y == 0)
		////						{
		////							prevLocation.x = location.x;
		////							prevLocation.y = location.y;
		////							
		////						}
		//			
		//			
		//			var startx:int = prevLocation.x;
		//			var starty:int = prevLocation.y;
		//			var endx:int =  location.x;
		//			var endy:int = location.y;
		//			var delta_x:int;
		//			var delta_y:int;
		//			
		//			var t:int;
		//			var distance:int;
		//			var xerr:int = 0;
		//			var yerr:int = 0;
		//			
		//			var incx:int;
		//			var incy:int;				
		//			
		//			delta_x=endx-startx;
		//			delta_y=endy-starty;
		//			
		//			//				var gap : Number = Math.sqrt((gapX * gapX) + (gapY * gapY));
		//			//				var fillGaps : int = Math.ceil(Math.round(gap) / (_brush.width * .05));
		//			//				
		//			//				for (var i : int = 1; i < fillGaps; i++)
		//			//				{
		//			//					_extraDraws.push(new Point(prevLocation.x + gapX * (i / fillGaps), prevLocation.y + gapY * (i / fillGaps)));
		//			//				}
		//			if(delta_x>0) incx=1;
		//			else if(delta_x==0) incx=0;
		//			else incx=-1;
		//			
		//			if(delta_y>0) incy=1;
		//			else if(delta_y==0) incy=0;
		//			else incy=-1;
		//			
		//			/* determine which distance is greater */
		//			delta_x=Math.abs(delta_x);
		//			delta_y=Math.abs(delta_y);
		//			if(delta_x>delta_y) distance=delta_x;
		//			else distance=delta_y;
		//			
		//			/* draw the line */
		//			for(t=0; t<=distance+1; t++) {
		//				wp(startx, starty,pressure, eraser);
		//				
		//				xerr+=delta_x;
		//				yerr+=delta_y;
		//				if(xerr>distance) {
		//					xerr-=distance;
		//					startx+=incx;
		//				}
		//				if(yerr>distance) {
		//					yerr-=distance;
		//					starty+=incy;
		//				}
		//			}
		//			
		//		}
		
		protected function touchEvent(event:MouseEvent):void
		{
			var location : Point =new Point(event.localX-bm.x, event.localY-bm.y);
			var prevLocation : Point =oldLoc;
			oldLoc = location
			if(!event.buttonDown)
			{
				return;
			}
			//brush.visible = false;
			//var location : Point = touch.getLocation(_canvas);
			//			if(!prevLocation)
			//			{
			//				oldLoc =new Point(event.stageX, event.stageY)
			//					cont=inue
			//			}
			
			
			var startx:int = prevLocation.x;
			var starty:int = prevLocation.y;
			var endx:int =  location.x;
			var endy:int = location.y;
			var delta_x:int;
			var delta_y:int;
			
			var t:int;
			var distance:int;
			var xerr:int = 0;
			var yerr:int = 0;
			
			var incx:int;
			var incy:int;				
			
			delta_x=endx-startx;
			delta_y=endy-starty;
			
			//				var gap : Number = Math.sqrt((gapX * gapX) + (gapY * gapY));
			//				var fillGaps : int = Math.ceil(Math.round(gap) / (_brush.width * .05));
			//				
			//				for (var i : int = 1; i < fillGaps; i++)
			//				{
			//					_extraDraws.push(new Point(prevLocation.x + gapX * (i / fillGaps), prevLocation.y + gapY * (i / fillGaps)));
			//				}
			if(delta_x>0) incx=1;
			else if(delta_x==0) incx=0;
			else incx=-1;
			
			if(delta_y>0) incy=1;
			else if(delta_y==0) incy=0;
			else incy=-1;
			
			/* determine which distance is greater */
			delta_x=Math.abs(delta_x);
			delta_y=Math.abs(delta_y);
			if(delta_x>delta_y) distance=delta_x;
			else distance=delta_y;
			
			/* draw the line */
			for(t=0; t<=distance+1; t++) {
				wp(startx, starty);
				
				xerr+=delta_x;
				yerr+=delta_y;
				if(xerr>distance) {
					xerr-=distance;
					startx+=incx;
				}
				if(yerr>distance) {
					yerr-=distance;
					starty+=incy;
				}
			}
			
		}
		
		private function wp(startx:int, starty:int, pressure:Number = 1, eraser:Boolean = false):void
		{
			_brush.x = startx - (_brush.width / 2);
			_brush.y = starty - (_brush.height / 2);
			
			var matrix:Matrix = new Matrix();
			matrix.scale(scale_brush*pressure,scale_brush*pressure);
			_brush.alpha = 0;
			//cAlph2.alphaMultiplier = pressure;
			matrix.tx = _brush.x;
			matrix.ty = _brush.y;
			if(!eraser){
				bmd.draw(_brush, matrix,cAlph2, BlendMode.NORMAL);
				//playing = true;//!playing;
			}
			else
			{
				
				bmd.draw(_mask, matrix,cAlph, BlendMode.ERASE);
				
				//playing = false;
			}
			
		}
		//***************** AWAY STUFFFF!!!!*************************///
		public function init():void
		{
			
			
			//this.stage.scaleMode = StageScaleMode.NO_SCALE;
			//this.stage.align = StageAlign.TOP_LEFT;
			
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
			initMaterials();
			initObjects();
			initButton();
			initListeners();
			
		}
		
		
		/**
		 * Initialise the Away3D views
		 */
		private function initAway3D() : void
		{
			// Create the first Away3D view which holds the cube objects.
			away3dView = new View3D();
			away3dView.stage3DProxy = stage3DProxy;
			away3dView.shareContext = true;
			
			hoverController = new HoverController(away3dView.camera, null, 45, 30, 1200, 5, 89.999);
			
			addChild(away3dView);
			
			if(renderOrder == AWAY || renderOrder ==FEATHER_AWAY )
				addChild(new AwayStats(away3dView));
		}
		
		/**
		 * Initialise the Starling sprites
		 */
		private function initStarling() : void
		{
			// Create the Starling scene to add the checkerboard-background
			game = new Starling(Main, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
			game.start()
			
			// Create the Starling scene to add the particle effect
			featherMain = new Starling(FeatherMain, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
			// you must start it if you want mouse functionality 
			featherMain.start();
		}
		
		/**
		 * Initialise the materials
		 */
		private function initMaterials() : void {
			//Create a material for the cubes
			var cubeBmd:BitmapData = new BitmapData(128, 128, true, 0x0);
			cubeBmd.perlinNoise(7, 7, 5, 12345, true, true, 7, true);
			cubeMaterial = new TextureMaterial(new BitmapTexture(cubeBmd));
			cubeMaterial.gloss = 20;
			cubeMaterial.ambientColor = 0x808080;
			cubeMaterial.ambient = 1;
			
		}
		
		private function initObjects() : void {
			// Build the cubes for view 1
			var cG:CubeGeometry = new CubeGeometry(300, 300, 300);
			var colorMaterial:ColorMaterial = new ColorMaterial(0x0000bb,0.5)
			colorMaterial.gloss = 80;
			cube1 = new Mesh(cG, colorMaterial);
			cube2 = new Mesh(cG, cubeMaterial);
			cube3 = new Mesh(cG, cubeMaterial);
			cube4 = new Mesh(cG, cubeMaterial);
			cube5 = new Mesh(cG, cubeMaterial);
			
			// Arrange them in a circle with one on the center
			cube1.x = -750; 
			cube2.z = -750;
			cube3.x = 750;
			cube4.z = 750;
			cube1.y = cube2.y = cube3.y = cube4.y = cube5.y = 150;
			
			// Add the cubes to view 1
			away3dView.scene.addChild(cube1);
			away3dView.scene.addChild(cube2);
			//			away3dView.scene.addChild(cube3);
			//			away3dView.scene.addChild(cube4);
			//			away3dView.scene.addChild(cube5);
			away3dView.scene.addChild(new WireframePlane(3000, 3000, 20, 20, 0xbbbbb0, 0.5, WireframePlane.ORIENTATION_XZ));
		}
		
		/**
		 * Initialise the button to swap the rendering orders
		 */
		private function initButton() : void {
			//			this.graphics.beginFill(0x0, 0.7);
			//			this.graphics.drawRect(0, 0, stage.stageWidth, 60);
			//			this.graphics.endFill();
			//			
			//			var button:Sprite = new Sprite();
			//			button.x = 130;
			//			button.y = 5;
			//			button.addChild(new ButtonBitmap());
			//			button.addEventListener(MouseEvent.CLICK, onChangeRenderOrder);
			//			addChild(button);
			//			
			//			renderOrderDesc = new TextField();
			//			renderOrderDesc.defaultTextFormat = new TextFormat("_sans", 11, 0xffff00);
			//			renderOrderDesc.width = stage.stageWidth;
			//			renderOrderDesc.x = 300;
			//			renderOrderDesc.y = 5;
			//			addChild(renderOrderDesc);
			
			//updateRenderDesc();
		}
		
		/**
		 * Set up the rendering processing event listeners
		 */
		private function initListeners() : void {
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			stage3DProxy.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * The main rendering loop
		 */
		private function onEnterFrame(event : Event) : void {
			// Update the hovercontroller for view 1
			if (mouseDown) {
				hoverController.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
				hoverController.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
				
				
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
			
			cube1.rotationY = cube2.rotationY = cube3.rotationY = cube4.rotationY +=3
			
			if(!playing){
				
				
				game.render()
				featherMain.render()
				return;
			}
			// Use the selected rendering order
			if (renderOrder == FEATHER_AWAY) {
				
				// Render the Starling animation layer
				//				starlingCheckerboard.nextFrame();
				
				// Render the Away3D layer
				away3dView.render();
				
				// Render the Starling stars layer
				featherMain.nextFrame();
				
				
			} else if (renderOrder == FEATHER_GAME) {
				
				
				
				// Render the Starling animation layer
				if(!EditKeyHandler.camvas){
					if(canvasOn){
						//	turnOffCanvas();
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, touchEvent);
						canvasOn = false
					}
					game.nextFrame();
				}else{
					if(!canvasOn){
						//	turnOnCanvas(canvX,canvY, canvWidth,canvHeight);
						stage.addEventListener(MouseEvent.MOUSE_MOVE, touchEvent);
						canvasOn = true;
					}
					game.render()
				}
				// Render the Starling stars layer
				featherMain.nextFrame();
			} else if (renderOrder == AWAY){
				
				// Render the Away3D layer
				away3dView.render();
				
				// Render the Starling animation layer
				//				starlingCheckerboard.nextFrame();
			}else if (renderOrder == GAME){
				
				// Render the game layer
				game.nextFrame();
			}
		}
		
		/**
		 * Handle the mouse down event and remember details for hovercontroller
		 */
		private function onMouseDown(event : MouseEvent) : void {
			mouseDown = true;
			lastPanAngle = hoverController.panAngle;
			lastTiltAngle = hoverController.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
		}
		
		/**
		 * Clear the mouse down flag to stop the hovercontroller
		 */
		private function onMouseUp(event : MouseEvent) : void {
			mouseDown = false; 
		}
		
		/**
		 * Swap the rendering order 
		 */
		private function onChangeRenderOrder(event : MouseEvent) : void {
			//			if (renderOrder == CHECKERS_CUBES_STARS) {
			//				renderOrder = STARS_CHECKERS_CUBES;
			//			} else if (renderOrder == STARS_CHECKERS_CUBES) {
			//				renderOrder = CUBES_STARS_CHECKERS;
			//			} else {
			//				renderOrder = CHECKERS_CUBES_STARS;
			//			}
			//			
			//			updateRenderDesc();
		}		
		
		/**
		 * Change the text describing the rendering order
		 */
		private function updateRenderDesc() : void {
			var txt:String = "Demo of integrating three framework layers onto a stage3D instance. One Away3D layer is\n";
			txt += "combined with two Starling layers. Click the button to the left to swap the layers around.\n";
			txt += "EnterFrame is attached to the Stage3DProxy - clear()/present() are handled automatically\n";
			txt += "Mouse down and drag to rotate the Away3D scene.\n\n";
			//			switch (renderOrder) {
			//				case CHECKERS_CUBES_STARS : txt += "Render Order (first:behind to last:in-front) : Checkers > Cubes > Stars"; break;
			//				case STARS_CHECKERS_CUBES : txt += "Render Order (first:behind to last:in-front) : Stars > Checkers > Cubes"; break;
			//				case CUBES_STARS_CHECKERS : txt += "Render Order (first:behind to last:in-front) : Cubes > Stars > Checkers"; break;
			//			}
			renderOrderDesc.text = txt;
		}
	}
}