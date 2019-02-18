package 
{
	
	import com.adobe.images.PNGEncoder;
	import com.adobe.utils.ArrayUtil;
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.GeneralElements.Ground;
	import com.jonLwiza.engine.GeneralElements.Path;
	import com.jonLwiza.engine.IO.KeyPress;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.actors.Scenes;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.baseConstructs.GeneralAnimation;
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;
	import com.jonLwiza.engine.baseConstructs.NSprite;
	import com.jonLwiza.engine.baseConstructs.SceneHandler;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	
	import mx.graphics.ImageSnapshot;
	
	import away3d.bounds.NullBounds;
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.controllers.HoverController;
	import away3d.entities.SegmentSet;
	import away3d.primitives.LineSegment;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Graphics;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.display.graphics.Graphic;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.FragmentFilter;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.LineSet;
	import starling.utils.VAlign;
	
	public class EditKeyHandler extends starling.display.Sprite
	{
		
		  
		[Embed(source="Cut1.png")]
		private var AtlasTexture:Class;
		
		private var _direction:Point = new Point;
		public static var spacebar:Boolean;
		public static var objWidth:Number = 50;
		public static var objHeight:Number= 50;
		public static var objDepth:Number = 1;
		
		private var up:Boolean;
		private var down:Boolean;
		private var left:Boolean;
		private var right:Boolean;
		private var directionUpdate:Boolean;
		//*** paint app part**IMPORTS**//
		
		[Embed(source="Circle.png", mimeType="image/png")]
		private var BrushBm : Class;
		 
		private var _renderTexture : RenderTexture;
		private var _canvas : Image;
		private var _brush : Image;
		private var _extraDraws : Array = [];
		private var scale_brush:Number = .5;
		private var _mask:Image;
		public static var enter:Boolean;
		private var enterPressed:Boolean;
		private var mc:MovieClip;
		public static var undoList:Array = [];
		private var ldr:URLLoader;
		private var save:Boolean;
		public static var camvas:Boolean= false;
		public static var shift:Boolean;
		private var nmbr1:Boolean;
		private var nmbr2:Boolean;
		private var nmbr7:Boolean;  
		private var nmbr6:Boolean;
		private var nmbr5:Boolean;
		private var nmbr4:Boolean;
		private var nmbr3:Boolean;
		private var _scnName:String = "HornetBossScene";
		private var _scnWidth:Number;
		private var _scnHeight:Number;
		private var _scnDepth:Number;
		public static var stage_mc:MainStage;
		public static var location:Point;
		private var edits:Array = [];
		private static var EditElement:DisplayObject;
		private var Edx:Number;
		private var Edy:Number;
		public static var points:Array = [];
		private static var lineLive:Boolean = false;
		private var linpts:Object;
		private var intialized:Boolean = false;
		private static var groundCMI:ContextMenuItem 
		private var pathCMI:ContextMenuItem
		private var camPathCMI:ContextMenuItem;
		// these represent the objects that just need the points 
		private var pathCMIS:Vector.<ContextMenuItem> = new Vector.<ContextMenuItem>();
		private var customContextMenu:ContextMenu = new ContextMenu();
		
		private static var s:flash.display.Sprite;
		private var penMode:Boolean;
		public static var bezTool:BezierCurve;
		private var someBull:Boolean = true;
		private var comma:Boolean;
		private var period:Boolean;
		private static var captureFrames:Boolean = false;
		private var scrollingFrames:Boolean = false;
		public static var Esc:Boolean = false;
		public static var State:int = 0;
		public static const SELECT:int = 0;
		public static const BEZIER:int = 1;
		public static const ADDSCENE:int = 2;
		// all inclusive its actor/anything
		public static const ADDSETPIECE:int = 3;
		public static var Animation:int = 4;
		public static var BOX:int= 5;
		public static var Painting:int= 6;
		public static var AWAY_CAM:int = 7;
		public static const Scale:int = 8;
		public static var CameraPath:int = 9;
		private static var conn:Connection;
		private static var har:Boolean;
		private static var text:TextField
		private static var clickCoolDown:int;
		private var roi:int;
		private static var flrpts:Array;
		private static var flrTool:BezierCurve;
		private static var liveFlr:Boolean;
		private var movement:Vector3D = new Vector3D();
		public static var cpsLock:Boolean = false;
		public static var cntrl:Boolean = false;
		private var undopos:uint;
		private var fresh:Boolean = true;
		private var delta:Vector3D = new Vector3D();
		public static var actorType:int = 0;
		private static var pathnodes:Array = [];
		//private var levelEdtr:LeveLEditorTest = new LeveLEditorTest();
		private var mainContextMenu:ContextMenu= new ContextMenu();;
		private var lstSelected:GeneralMotor;
		private static var touchCoolDown:int;
		public static var newImagePool:Array = [];
		public static var a:Array = [];
		private var xsheet:xSheet = new xSheet();

		private var loader:URLLoader;
		// whenever i make any change to a scene make sure that the scene.name is pushed out
		private var editedScnes:Vector.<String> = new Vector.<String>();
		private var editedSceneRs:Dictionary = new Dictionary;
		public static var square:VisualCube;
		private var otherBull:Boolean = true;
		public static var iter:int;
		
		
		public static var endAlterations:int;
		public static var imageAlterations:Boolean = false;
		public static var aObj:Object;
		public static var ainterp:int;
		public static var EditAnimation:int;
		private static var isPlayback:Boolean = false;
		private var newBull:Boolean = true;
		private static var groundPoints:Array = [];
		private static var liveflr2:Boolean;
		private var editedImages:Array = [];
		private static var skey:Boolean;
		private static var akey:Boolean;
		private static var wkey:Boolean;
		private static var dkey:Boolean;
		private static var direction:Vector3 = new Vector3();
		public static var myCurvePts:Array;

		private static var cmatFilt:FragmentFilter;
		private static var lastCampos:Point = new Point();

		private var lineSet:LineSet = new LineSet(Main.liveCamera)

		private var delta3D:Point;
		private var oldmouseInt:Vector3D;


		private var mouseInt:Vector3D = new Vector3D();

		private var origScle:Number;

		private var tch:Touch;
		public static var lastElement:GeneralMotor;
		private var isSonicFront:Boolean = true;

		private var yspeed:Number = 0;
		private var pathTool:Path;
		private var linkedPath:Path;
		private static var editlinkpaArry:Array = [];
		private var floorTool:int = 1;
		private var CamPath:int = 2;
		private static var tab:Boolean = false;
		public static var EditLink:Boolean = false;
		public static var del:Boolean;
		private static var editCamRot:Array =[];
		public static var edtSelected:int = -1;
		private static var editCamRotLink:Array =[];
		private var isStartedEdit:Boolean = false;
		public static var qButton:Boolean;

		private var fs:FileStream;
		private var pressedS1:uint = 0;

		private var pos:Point = new Point();
		private var recentDocuments:Array =  
			new Array("someFile","otherFile"); 
		private var oldLength:uint;
		/** I made this because I saw that editElement was private 
		 * 	so just to be safe to get the state of whether Im editing
		 *  an element or not I made this **/
		public static var editing:Boolean;
		public static var isAllLoaded:Boolean;

		private static var json:URLLoader;
		//public static var sceneList:Array = ["test1","test2"];
		
		
		private static var crLvJson:Object = new Object();
		private static var editJson:URLLoader;
		private static var editMainJson:Object = new Object();
		private var isXshtOn:Boolean  = false;

		private var elz:Number = 0;
		public static var alt:Boolean = false;

		
		
		
		
		public function EditKeyHandler()
		{
			
			
//			var texture:Texture = Texture.fromBitmap(new AtlasTexture());
//			var xml:XML = XML(new AtlasXML());
//			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
//			// this bit was only for testing
//			mc = new MovieClip(atlas.getTextures("run"), 30);
//			addChild(mc);
			flrpts = [{X:0,Y:4131,Z:0,D:0},{X:83,Y:4131,Z:0,D:83},{X:468,Y:4034,Z:0,D:468},{X:646,Y:3997,Z:0,D:646},{X:1094,Y:3949,Z:0,D:1094},{X:1658,Y:3941,Z:0,D:1658},{X:2126,Y:4057,Z:0,D:2126},{X:2561,Y:4230,Z:-200,D:2635.071}]
			Starling.juggler.add(mc);
			
			//conn = new Connection();
			
			cpsLock = !Keyboard.capsLock;
			/*PAINT APP PART **/
//			//trace("AppStarlingRoot.as -> AppStarlingRoot");
			addEventListener(starling.events.Event.ADDED_TO_STAGE, added2Event);
			
			s = new flash.display.Sprite();
			MainSceneMotor.editorStage.addChild(s);
			
			MainSceneMotor.editorStage.stage.addEventListener(flash.events.MouseEvent.MOUSE_OVER, rollOver)
			MainSceneMotor.editorStage.stage.addEventListener(flash.events.MouseEvent.CLICK, onClick)
			//MainSceneMotor.editorStage.ad
			//BezierCurve.segs.push(new BezierCurve())
			bezTool = BezierCurve.segs[BezierCurve.segs.length -1]
			
			VisualCube.boxes.push(new VisualCube())
			square = VisualCube.boxes[VisualCube.boxes.length -1]
			MainSceneMotor.editorStage.addChild(square)
			text = new TextField();
			
			MainSceneMotor.editorStage.addChild(text);
			groundCMI= new ContextMenuItem("Ground",false,true,true);
			groundCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, setGroundPath);
			pathCMI= new ContextMenuItem("snapToPath",false,true,true);
			pathCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, setPath);
			camPathCMI= new ContextMenuItem("setToCamPath",false,true,true);
			camPathCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, setCameraPath);
			//customContextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, idunno);
			customContextMenu.hideBuiltInItems();
			mainContextMenu.hideBuiltInItems();
			mainContextMenu.customItems.push(groundCMI);
			mainContextMenu.customItems.push(pathCMI);
			mainContextMenu.customItems.push(camPathCMI);
			MainSceneMotor.editorStage.contextMenu = customContextMenu;
			MainSceneMotor.editorStage.parent.contextMenu = mainContextMenu;
			//levelEdtr.contextMenu = customContextMenu;
			Main.liveCamera.addChild(bezTool);
			cmatFilt = new ColorMatrixFilter().tint(0xffff00,0.5)
			var root:NativeMenu = new NativeMenu();
			if (NativeWindow.supportsMenu){ 
				MainSceneMotor.editorStage.stage.nativeWindow.menu = new NativeMenu(); 
				MainSceneMotor.editorStage.stage.nativeWindow.menu.addEventListener(flash.events.Event.SELECT, selectCommandMenu); 
				var fileMenu:NativeMenuItem = MainSceneMotor.editorStage.stage.nativeWindow.menu.addItem(new NativeMenuItem("File")); 
				fileMenu.submenu = createFileMenu(); 
				var editMenu:NativeMenuItem = MainSceneMotor.editorStage.stage.nativeWindow.menu.addItem(new NativeMenuItem("Edit")); 
				editMenu.submenu = createEditMenu(); 
			} 
			
			if (NativeApplication.supportsMenu){ 
				NativeApplication.nativeApplication.menu.addEventListener(flash.events.Event.SELECT, selectCommandMenu); 
				fileMenu = NativeApplication.nativeApplication.menu.addItem(new NativeMenuItem("File")); 
				fileMenu.submenu = createFileMenu(); 
				editMenu = NativeApplication.nativeApplication.menu.addItem(new NativeMenuItem("Edit")); 
				editMenu.submenu = createEditMenu(); 
			} 
			
			
			
			
		}
		
		private function createEditMenu():NativeMenu
		{
			var editMenu:NativeMenu = new NativeMenu(); 
			editMenu.addEventListener(flash.events.Event.SELECT, selectCommandMenu); 
			
			
			var switchMenu:NativeMenuItem =  editMenu.addItem(new NativeMenuItem("switchMenu")); 
			switchMenu.addEventListener(flash.events.Event.SELECT, selectCommand); 
			
			// TODO Auto Generated method stub
			return editMenu;
		}
		
		public function createFileMenu():NativeMenu { 
			var fileMenu:NativeMenu = new NativeMenu(); 
			fileMenu.addEventListener(flash.events.Event.SELECT, selectCommandMenu); 
			
			/*** I think  I can create a new file and place it there with this that should work**/
			var newCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("New")); 
			newCommand.addEventListener(flash.events.Event.SELECT, selectCommand);
					var openCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("Open...")); 
			openCommand.addEventListener(flash.events.Event.SELECT, selectCommand); 
			var saveCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("Save")); 
			saveCommand.addEventListener(flash.events.Event.SELECT, selectCommand); 
			var saveAsCommand:NativeMenuItem = fileMenu.addItem(new NativeMenuItem("Save As...")); 
			saveAsCommand.addEventListener(flash.events.Event.SELECT, selectCommand); 
			var openRecentMenu:NativeMenuItem =  
				fileMenu.addItem(new NativeMenuItem("Open Recent"));  
			openRecentMenu.submenu = new NativeMenu(); 
			openRecentMenu.submenu.addEventListener(flash.events.Event.DISPLAYING, 
				updateRecentDocumentMenu); 
			openRecentMenu.submenu.addEventListener(flash.events.Event.SELECT, selectCommandMenu); 
			
			return fileMenu; 
		} 
		private function updateRecentDocumentMenu(event:flash.events.Event):void { 
			trace("Updating recent document menu."); 
			var docMenu:NativeMenu = NativeMenu(event.target); 
			
			for each (var item:NativeMenuItem in docMenu.items) { 
				docMenu.removeItem(item); 
			} 
			
			for each (var file:String in editMainJson.recentDocs) { 
				var menuItem:NativeMenuItem =  
					docMenu.addItem(new NativeMenuItem(file)); 
				menuItem.data = file; 
				menuItem.addEventListener(flash.events.Event.SELECT, selectRecentDocument); 
			} 
		} 
		
		private function selectRecentDocument(event:flash.events.Event):void { 
			trace("Selected recent document: " + event.target.data); 
		} 
		
		private function selectCommand(event:flash.events.Event):void { 
			trace("Selected command: " + event.target.label); 
			if(event.target.label == "Save"){
				SaveScene()
			}else if(event.target.label == "Save As..."){
				SaveAsHandlerWindow()
			}else if(event.target.label == "switchMenu")
			{
				switchMenu()
			}
		} 
		private function switchMenu():void{
			if(!isXshtOn){
				FeatherMain.nav.clearScreen()
				FeatherMain.nav.showScreen("xsheet");
				
				isXshtOn = !isXshtOn
			}else{
				FeatherMain.nav.clearScreen()
				FeatherMain.nav.showScreen("mainEditor");
				
				isXshtOn = !isXshtOn
			}
		}
		private function selectCommandMenu(event:flash.events.Event):void { 
			if (event.currentTarget.parent != null) { 
				var menuItem:NativeMenuItem = 
					findItemForMenu(NativeMenu(event.currentTarget)); 
				if (menuItem != null) { 
					trace("Select event for \"" +  
						event.target.label +  
						"\" command handled by menu: " +  
						menuItem.label); 
				} 
			} else { 
				trace("Select event for \"" +  
					event.target.label +  
					"\" command handled by root menu."); 
			} 
		} 
		
		private function findItemForMenu(menu:NativeMenu):NativeMenuItem { 
			for each (var item:NativeMenuItem in menu.parent.items) { 
				if (item != null) { 
					if (item.submenu == menu) { 
						return item; 
					} 
				} 
			} 
			return null; 
		} 
		
		protected function setPath(event:ContextMenuEvent):void
		{
			
				// TODO Auto-generated method stub
					
				//pathnodes.push({path:new Path(bezTool.curve[0]), bezCurve:bezTool.curve, prg:0.0, trgt:lstSelected})
				undoList.push({inc:3, path:pathnodes})
				// this is all set path does its liveupdate that does all the real work this just tells us who are partners are
		
					// this should actually grab and save which it is in the array and do this if its a new path
				//if(newPath)
				Director.paths.push({ptsArray:bezTool.curve[0]},{linkArray:linkedPath})	
				
			
			
			
		}
		protected function setCameraPath(event:ContextMenuEvent):void
		{
			// TODO Auto-generated method stub
			
			//pathnodes.push({path:new Path(bezTool.curve[0]), bezCurve:bezTool.curve, prg:0.0, trgt:lstSelected})
		//	undoList.push({inc:3, path:pathnodes})
			// this is all set path does its liveupdate that does all the real work this just tells us who are partners are
			
			Director.Campath = bezTool.curve[0]	
			Director.camlinkpair =  editlinkpaArry 
			Director.camRotation = editCamRot
			Director.camRotLink = editCamRotLink
			bezTool.type = CamPath
				
				
		}
		
		public static function MakeGroundPath():void{
			bezTool.type = 1 //floorTool
			//just check before probably whem beztool is updated to enabled
			if(true){
				flrTool =  bezTool
				flrTool.floorType = true;
				liveFlr = true
				//MainSceneMotor.floor.ptsArray = bezTool.curve[0];
				
				
				
				//trace(bezTool.curve[0][0].D,bezTool.curve[0][1].D,bezTool.curve[0][2].D,bezTool.curve[0][3].D);
				MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x, MainSceneMotor.floorBody,false);
				groundCMI.enabled = true;
				//throw Error("wh")
			}
		}
		
		protected function setGroundPath(event:ContextMenuEvent):void
		{
			bezTool.type = floorTool
			//just check before probably whem beztool is updated to enabled
			if(true){
					flrTool =  bezTool
					flrTool.floorType = true;
					liveFlr = true
			//MainSceneMotor.floor.ptsArray = bezTool.curve[0];
					

					
			//trace(bezTool.curve[0][0].D,bezTool.curve[0][1].D,bezTool.curve[0][2].D,bezTool.curve[0][3].D);
			MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x, MainSceneMotor.floorBody,false);
			groundCMI.enabled = true;
				//throw Error("wh")
			}
		}
		
		protected function rollOver(event:MouseEvent):void
		{
			var v:flash.display.Sprite = event.target as flash.display.Sprite
				// this is dumb but i think it works
			for (var i:int = 0; i <  BezierCurve.segs.length; i++) 
			{
				
				if(v && v.parent == BezierCurve.segs[i]){
					roi = i
					
					
					text.text = v.name
					text.border = true;
					text.borderColor = 0xDDDDDD
					text.selectable = false;
					text.backgroundColor = 0xFFFFFF
					text.background = true;
					MainSceneMotor.editorStage.setChildIndex(text,0);
					text.width = text.textWidth + 5;
					text.height = text.textHeight+ 5;
					
					text.x = event.localX;
					text.y = event.localY
						break;
				}
			}
			// use this to make a box editable label, later
				
		}		
		
		protected function onClick(event:MouseEvent):void
		{
			
			
				if(State == SELECT){
				if(Math.sqrt((text.x - event.target.x)*(text.x - event.target.x)+(text.y - event.target.y)*(text.y - event.target.y)) > 20){
					
				bezTool = BezierCurve.segs[roi];
				}
				}
				
		}
		
		public function recievePenInfoFromHtml(pressure,eraser):void
		{
			////trace(pressure, eraser);
		}
		
//		public function recievePenInfoFromHtml(pressure,eraser,x,y,hover):void {
//			
//			
//				var location : Point = touch.getLocation(_canvas);
//				
//				if (hover)
//				{
//					_brush.x = x;
//					_brush.y = y;
//					_brush.visible = true;
//					return;
//				}
//				
//				_brush.visible = false;
//				//var location : Point = touch.getLocation(_canvas);
//				
//				
//				var prevLocation : Point = touch.getPreviousLocation(_canvas);
//				9
//				
//				var startx:int = prevLocation.x;
//				var starty:int = prevLocation.y;
//				var endx:int = location.x;
//				var endy:int = location.y;
//				var delta_x:int;
//				var delta_y:int;
//				
//				var t:int;
//				var distance:int;
//				var xerr:int = 0;
//				var yerr:int = 0;
//				
//				var incx:int;
//				var incy:int;				
//				
//				delta_x=endx-startx;
//				delta_y=endy-starty;
//				
//				//				var gap : Number = Math.sqrt((gapX * gapX) + (gapY * gapY));
//				//				var fillGaps : int = Math.ceil(Math.round(gap) / (_brush.width * .05));
//				//				
//				//				for (var i : int = 1; i < fillGaps; i++)
//				//				{
//				//					_extraDraws.push(new Point(prevLocation.x + gapX * (i / fillGaps), prevLocation.y + gapY * (i / fillGaps)));
//				//				}
//				if(delta_x>0) incx=1;
//				else if(delta_x==0) incx=0;
//				else incx=-1;
//				
//				if(delta_y>0) incy=1;
//				else if(delta_y==0) incy=0;
//				else incy=-1;
//				
//				/* determine which distance is greater */
//				delta_x=Math.abs(delta_x);
//				delta_y=Math.abs(delta_y);
//				if(delta_x>delta_y) distance=delta_x;
//				else distance=delta_y;
//				
//				/* draw the line */
//				for(t=0; t<=distance+1; t++) {
//					wp(startx, starty);
//					
//					xerr+=delta_x;
//					yerr+=delta_y;
//					if(xerr>distance) {
//						xerr-=distance;
//						startx+=incx;
//					}
//					if(yerr>distance) {
//						yerr-=distance;
//						starty+=incy;
//					}w
//				}
//				
//				
//				//if(spacebar)
//				//_renderTexture.draw(_brush);
//				
//			
//		}
		// should be moved to the drawing and animation parts but they aint made yet
		
		
		
		private function added2Event(event : starling.events.Event) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.addEventListener(TouchEvent.TOUCH, touchEvent);
//			addEventListener(starling.events.Event.ENTER_FRAME, entFrame);
		}
		
//		private function addedEvent(event : starling.events.Event) : void
//		{
//			
//			_renderTexture = new RenderTexture(550, 400);
//			_canvas = new Image(_renderTexture);
//			removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedEvent);
//			_canvas.blendMode = BlendMode.NORMAL;
//			addChild(_canvas);
//			_canvas.x =100;
//			_canvas.y =50;
//			
//			_brush = new Image(Texture.fromBitmap(new BrushBm()));
//			_brush.pivotX = _brush.width >> 1;
//			_brush.pivotY = _brush.height >> 1;
//			_brush.color = 0x9900ff;
//			
//			_mask = new Image(Texture.fromBitmap(new BrushBm()));
//			_mask.pivotX = _brush.width >> 1;
//			_mask.pivotY = _brush.height >> 1;
//			_mask.color = 0x9900ff;
//			_mask.blendMode = BlendMode.ERASE;
//			_mask.alpha = .4;
//			_brush.scaleX = scale_brush
//			_brush.scaleY = scale_brush
//			addChild(_brush)
//			stage.addEventListener(TouchEvent.TOUCH, touchEvent);
//			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
//			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
//			addEventListener(starling.events.Event.ENTER_FRAME, entFrame);
//		}
		
		private function touchEvent(event : TouchEvent) : void
		{
			var touches : Vector.<Touch> = event.getTouches(event.target as DisplayObject);
			
			// so json is just a txt file.. heh , which means we can check for changes to the file if we put a time stamp on the file without parsing it, I can just check it like a string
// so i put this up on top of EditKeyhandler or whatever, load it in and we say its EditorData we'll load that in it
			// will be on the on top so dont worry load it in call it editJson  
			// then this  another version should be a function shouldnt take long to load a rough so we'll call crLvJson
//		dont put this as local its probably gonna be scoped globally??!?!?!?!?!?!???
			
			// in resourseManager I call and EditKeyHandler.sceneList[0] which would be opening scene and thats defined by the editJson
			
			//public static function loadLevel(currLevel:String):void{
//			 var json:URLLoader = new URLLoader();
//			json.addEventListener(Event.COMPLETE, parseJSON);
//			json.load(new URLRequest("whereverthefuckIam\data.json"))
//				}
			 
//			
//		firstline:::	var objStr:String = JSON.stringify({name:"Todd Anderson", company:"Infrared5"});
//			var obj:Object = JSON.parse( objStr, inflate );
			
//			...
//				protected function inflate( key:String, value:* ):*
//				{
//					return ( (typeof value) == "string" ) ? String(value).toUpperCase() : value;
//				}
//			var obj:Object = {testing:4}
//				trace("this is a test do not fear this is only a test  ", obj["testing"])
			// so yeah i cant run this more than once so this when we wanna save it we write this 
//			var outputJson:String = JSON.stringify(d, function (k,v):* { 
//				return Director[k]
//			});
				// so this seems honestly easier, a lot easier than my system of saving data, on creation create a key value pair of entities right when i make the level
			// and this would clear
//			var objStr:String = JSON.stringify( {
//				name:"Todd Anderson",
//				company:"Infrared5",
//				phone:15558576309
			// deflate is the replacement value bad thing i can't call it independently i can literally use a key value table, soo uh yeah
//			}, deflate,4 );
//			
//			trace( "JSON obj&gt;String: " + objStr ); // &gt;
//			// {"name":"Todd Anderson","company":"Infrared5"}
//			//
//				protected function deflate( key:String, value:* ):*
//				{
					

			for each (var touch : Touch in touches)
			{		
				
				if(EditElement && !EditElement is NSprite)
				{
					lastElement = GeneralMotor(EditElement)
						// I just made this because I saw that EditElement was static but it was private, and seems deliberate to me, so I made this just to be safe
						editing = true
				}else{
					editing = false
						if(EditElement is NSprite){
							State = BEZIER
						}
				}
				tch = touch
				
				//trace(touch.pressure)
				// if i ever, ever re rwrite this, it needs to be rewritten cohesively
				// this is all a horrible embarrasing mess
					
					
				if(!camvas){
				location = touch.getLocation(Main.liveCamera);
				if(State == Scale){
					
					ScaleEvent(event)
					return
				}
				}else{
					// this return = dumb
				return
				location = new Point(-8000,-8000);
				throw Error("Inconcievable")
				}
				
				if(location.x > mainEdit.screenWidth - mainEdit.windowWidth)
				return
				
				if (touch.phase == TouchPhase.HOVER && State == SELECT)
				{
					//trace(location.x, location.y)
					
					//highlight the things it goes over
//					for (var i:int = 0; i < Main.liveCamera.npcs.length; i++) 
//					{
					
					
				}else if(State == AWAY_CAM ){
					//EditElement = null
					if(cntrl){
						LevelEditor.awyCam.rotationY = 180
						LevelEditor.awyCam.rotationX = 0
						LevelEditor.awyCam.rotationZ = 0
					}
					
						
						
					return
				}
				if(touch.phase == TouchPhase.BEGAN ){
					
					
					// there might be some if condition I wanna put in here later but for now its fine
					
					MainSceneMotor.editorStage.stage.nativeWindow.alwaysInFront = false
					MainSceneMotor.FreezeMotor = false
						
					
					if(State == SELECT){
						
					
					if( Main.liveCamera.hitTest(location) == null){
						if(EditElement)
						EditElement.filter = null
						EditElement =null
							// this is my switch from one element to another
					}else if( Main.liveCamera.hitTest(location).parent != Main.liveCamera){
						if(EditElement)
						EditElement.filter = null
						EditElement = Main.liveCamera.hitTest(location).parent
							
					}else{
						EditElement.filter = null
						EditElement = Main.liveCamera.hitTest(location)
					}
					
					if(EditElement){
						EditElement.blendMode =  BlendMode.AUTO;
						EditElement.filter = cmatFilt
						
					}
					
					}
					// shouldnt do this should be a case method better yet a FSM but you know KISS
					if(State == BEZIER){
						if(someBull){
						var cam:Vector3 = cameraOrigin()
						// god i really shouldnt be doing this cuz i still havent investigated why i need that static shit.. but itll work
						if(bezTool){
						bezTool.onPointDown(location.x, location.y, cam.Z + 20);
						// you hadve to rememebr to add this again later when your done using bezier
						//stage.removeEventListener(TouchEvent.TOUCH, touchEvent);
						}else{
							
							
							bezTool.onPointDown(location.x, location.y, cam.Z + 20);
							
						}
						//throw Error("sdf  ");
						someBull = false
						}
						// eh lets figure that crap out later
					}else if(State == BOX){
						if(otherBull){
							var cm:Vector3 = cameraOrigin()
							square.attachedActor = newScene(location.x,location.y,cm.Z)
							square.attachedActor.name = "default";

							otherBull = false
						}
					}else if (State == SELECT || (State == Painting && !camvas))
					{
						
						
						if(!cpsLock){
							MainSceneMotor.mouseJoint.body2 = Main.liveCamera.hero_mc.body
							//MainSceneMotor.mouseJoint.anchor1.setxy(location.x,location.y);
							MainSceneMotor.mouseJoint.active = true;
						}
						// this is selecting a new bez in multiple bezes
						
						if(Math.sqrt((text.x - location.x)*(text.x - location.x)+(text.y - location.y)*(text.y - location.y)) < 15){
							
							bezTool = BezierCurve.segs[roi];
						}
						
					 if(EditElement != null){
						 //pathCMI.enabled = true;
						 if(EditElement != null){
							 
							 //pathCMI.enabled = false;
							 if(touchCoolDown > 0){
								
								 DoubleClick()
							 }else
							 {
								 touchCoolDown = 14
							 }
					if(!Main.liveCamera.hitTest(location))
					{	
						// this is us hitting empty space this is where we'd wanna check if were using a drawing tool
						// such as line or pen tool
						
							EditElement.blendMode =  BlendMode.AUTO;
							EditElement = null;
						}
					}else{
						
					
						if( Main.liveCamera.hitTest(location).parent != Main.liveCamera)
							EditElement = Main.liveCamera.hitTest(location).parent;
						else
							EditElement = Main.liveCamera.hitTest(location)	
						
						
						
					}
					if(EditElement is GeneralMotor && EditElement){
						
						
					
					}
					}
					}else if (State == ADDSETPIECE) 
					{
						addNewActor();
					}
				}else if(touch.phase == TouchPhase.MOVED && (State == SELECT || (State == Painting && !camvas))){
					if(!cpsLock){
						pos = new Point()
						//Main.liveCamera.hero_mc.isFrozen = true;
						//										pos.x =Main.liveCamera.hero_mc.body.position.x+movement.x*8
						//										pos.y =Main.liveCamera.hero_mc.body.position.y-movement.y*6
						// you can just comment out this line for the original code
						//pos = MainSceneMotor.floor.PointOnPath(location)
						//									Main.liveCamera.hero_mc.body.position.x =2000
						//									Main.liveCamera.hero_mc.body.position.y = pos.y;
						//Main.liveCamera.hero_mc.Damage()
						//var v:Vector3D = LevelEditor.away3dView.unproject(location.x,location.y,Main.liveCamera.hero_mc.zp)
						
						//TODO(JON): this is where the thing is 
						if(!Main.liveCamera.hero_mc.inAlter){
						pos = MainSceneMotor.floor.PointOnPath(new Point(location.x,location.y))
						//trace(v.x, "my X is this")
							trace(location.y)
						//Game plan I need to go and get the animation system working again, thats it
						// first investigate the key tp recprd shift 1 see if it has connection with old then go over old animation code
						// turn on the old plsy back, should be the first thing i do
						MainSceneMotor.mouseJoint.anchor1.setxy(pos.x,pos.y);
						}else{
							Main.liveCamera.hero_mc.x = location.x
							Main.liveCamera.hero_mc.y = location.y
						}
					
					}
					trace("dumbe")
					if(liveflr2)
					UpdateArray()
					// its some kinda weird bug i dunno i just decided to say fuck it, but I know casey has similar code ill watch how he handles it to figure out why shits bonkers
					//TODO(JON):its got some buggyness it pop up and in the z, dont know why really and also disapears for a sec, definitely need to figure that out
						if(EditElement){
							var s:GeneralMotor = GeneralMotor(EditElement)//MainSceneMotor.project(new Vector3D(GeneralMotor(EditElement).X,GeneralMotor(EditElement).Y,GeneralMotor(EditElement).Z))
							//var el:Vector3D = MainSceneMotor.project(new Vector3D(GeneralMotor(EditElement).X,GeneralMotor(EditElement).Y,GeneralMotor(EditElement).Z))
							if(oldmouseInt){
							oldmouseInt.x  = mouseInt.x
							oldmouseInt.y  = mouseInt.y
							oldmouseInt.z  = mouseInt.z
							}else{
								oldmouseInt = new Vector3D()
							oldmouseInt.x = location.x
							oldmouseInt.y = location.y
							oldmouseInt.z = GeneralMotor(EditElement).zp
							}
							mouseInt.x = location.x
							mouseInt.y = location.y
							mouseInt.z = GeneralMotor(EditElement).zp
							
							var delta:Point = new Point()
							delta.x = mouseInt.x - oldmouseInt.x
							delta.y = mouseInt.y - oldmouseInt.y	
							var olds:Object = {X:s.X,Y:s.Y,Z:s.Z}
								
							s.x += delta.x
								
							if(shift){s.zp -= delta.y }else{s.y += delta.y}
							
							var unp:Vector3D = MainSceneMotor.Unproject(new Vector3D(s.x,s.y,s.zp), new Vector3D(LevelEditor.awyCam.x,LevelEditor.awyCam.y,LevelEditor.awyCam.z),new Vector3D(LevelEditor.awyCam.rotationX, LevelEditor.awyCam.rotationY,LevelEditor.awyCam.rotationZ))
//							if(int(unp.x) != int(s.X) || int(unp.z) != int(s.Z))
//							trace("df")
							
							s.X = unp.x;
							s.Y = unp.y;
							s.Z = unp.z;
							
							
							//movement = new Vector3D(mouseInt.x - oldmouseInt.x, mouseInt.y - oldmouseInt.y, mouseInt.z - oldmouseInt.z)
							//MainSceneMotor.relativeXY(location,GeneralMotor(EditElement), 0, 0)
//							GeneralMotor(EditElement).X  += movement.x 	
//							GeneralMotor(EditElement).Y  += movement.y
//							GeneralMotor(EditElement).Z  += movement.z 
								trace(" before ", GeneralMotor(EditElement).X, "after ", mouseInt)
									//var grndInd:int =	Main.liveCamera.getChildIndex(foreground)
							if(isSonicFront){		
							Main.liveCamera.setChildIndex(Main.liveCamera. hero_mc,0)
							isSonicFront = false
							}
							
								if(Math.abs(movement.y)<.1){
									yspeed *=0 
								}else{
									yspeed += movement.y	
								}
								// cntrl shift clears my param
							if(shift){
							
							
									//GeneralMotor(EditElement).z += yspeed
									//GeneralMotor(EditElement).z = GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].Z
									GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].Z = GeneralMotor(EditElement).Z
							
							Main.liveCamera.sortChildren(sortScenary)
							}else{
								
								
									//GeneralMotor(EditElement).z += yspeed
									//GeneralMotor(EditElement).z = GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].Z
									GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].Y = GeneralMotor(EditElement).Y
									GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].X = GeneralMotor(EditElement).X

								
							// this was pain, but I change the z value to trigger the unprojection function
							// as safetly as I can I dont know why I need it to be safe, but I imagine it may break something down the line
								
								
							}
							
							//throw Error("uo");
							//lstSelected = GeneralMotor(EditElement);
							
							
							
							
							var textToCopy:String = ",["+ GeneralMotor(EditElement).X+","+ GeneralMotor(EditElement).Y+","+ GeneralMotor(EditElement).Z+",'noAnimyet']"
							Clipboard.generalClipboard.clear(); 
							Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, textToCopy, false); 
							
						}

				}else if(touch.phase == TouchPhase.ENDED && (State == SELECT || (State == Painting && !camvas))){
					//mouseInt = new Vector3D()
					oldmouseInt = null
				}
				
				if(touch.phase == TouchPhase.MOVED && State == Animation){
					trace("hate")
					throw Error("I still have to figure this out the movement whatever it is")
					//movement = touch.getMovement(Main.liveCamera);
					pos.x =Main.liveCamera.hero_mc.body.position.x+movement.x*8
					pos.y = Main.liveCamera.hero_mc.body.position.y-movement.y*6
					MainSceneMotor.mouseJoint.anchor1.setxy(pos.x,pos.y);
					if(xSheet.list.selectedIndex != -1){
					xSheet.frames[xSheet.list.selectedIndex].bodyx = pos.x
					xSheet.frames[xSheet.list.selectedIndex].bodyy = pos.y
					}
					//Main.liveCamera.hero_mc.body.position.y = pos.y
					
				}
				
				
				
				
				var oldx:Number =  location.x
				var oldy:Number =  location.y;
			}
			
		}
		
//		protected function clapOff(event:TimerEvent):void
//		{
//			var cam:Vector3 = cameraOrigin()
//			bezTool.onPointDown(location.x, location.y, cam.Z + 20);
//		}
		
		private function ScaleEvent(event:TouchEvent):void
		{
			if(tch.phase == TouchPhase.BEGAN){
			if(EditElement){
				EditElement.blendMode =  BlendMode.AUTO;
			
				
			}
			if( Main.liveCamera.hitTest(location) == null){
					trace("click nothing")
			}else if( Main.liveCamera.hitTest(location).parent != Main.liveCamera){
				
				EditElement = Main.liveCamera.hitTest(location).parent
				
			}else{
				EditElement = Main.liveCamera.hitTest(location)
			}
			
			origScle = Math.abs(EditElement.x -location.x)/GeneralMotor(EditElement).scaleZ
			}
			
			if(tch.phase == TouchPhase.MOVED && EditElement){
			GeneralMotor(EditElement).scaleZ = Math.abs((EditElement.x -location.x)/origScle)
			GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].ScaleY =GeneralMotor(EditElement).scaleZ 
			GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].ScaleX = GeneralMotor(EditElement).scaleZ 
			trace(origScle, EditElement.x, location.x)
			}
		}
		public function sortScenary(object1:DisplayObject, object2:DisplayObject):int
		{if(!(object1 is GeneralMotor && object2 is GeneralMotor))
			return 0
			var y1:Number = GeneralMotor(object1).zp;
			var y2:Number = GeneralMotor(object2).zp;
			
			//trace(this, "sortStuff y1:", y1, "y2", y2);
			
			if (y1 > y2)
				return -1;
			
			if (y1 < y2)
				return 1;
			
			return 0;
			
		}
		private function UpdateArray():void
		{
			// TODO Auto Generated method stub
			for (var i:int = 0; i < groundPoints.length; i++) 
			{
				// needs to be moved but we'll deal with it laterrrrrrr....
				
		
				MainSceneMotor.floor.ptsArray[i].X = groundPoints[i].X
				MainSceneMotor.floor.ptsArray[i].Y = groundPoints[i].Y
				MainSceneMotor.floor.ptsArray[i].Z = groundPoints[i].Z
				

			}
			MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x, MainSceneMotor.floorBody,false);
			
		}
		
		private function wp(startx:int, starty:int):void
		{
			_brush.x = startx - (_brush.width / 2);
			_brush.y = starty - (_brush.height / 2);
			
			var matrix:Matrix = new Matrix();
			matrix.scale(scale_brush,scale_brush);
			matrix.tx = _brush.x;
			matrix.ty = _brush.y;
			_renderTexture.drawBundled(function() : void
			{
			if(!spacebar)
			_renderTexture.draw(_brush, matrix);
			else
			_renderTexture.draw(_mask, matrix);
			});
		}
		
		public function update() : void
		{
			
			
			
			if(enter)
			enterPressed = true;
			
			
			
			if(enterPressed)
			{
				if(!enter)
				{
					
					//ReturnClick(mc)
					enterPressed = false;
				}
			}
//			_brush.scaleX = scale_brush
//			_brush.scaleY = scale_brush
//			_renderTexture.drawBundled(function() : void
//			{
//				for (var i : int = 0; i < 10; i++)Z
//				{
//					if (_extraDraws.length && spacebar)
//					{
//						var p : Point = _extraDraws.shift();
//						_brush.x = p.x;
//						_brush.y = p.y;
//						_renderTexture.draw(_brush);
//					}
//					else
//						break;
//				}
//			});
		}
		// we'll try pushing a function on here right now i wanna try just calling a function in this weird way
		private function pushUndo(parameters:Object):void{
			
			
			
		}
		
		
		private function undoTree(dir:int = -1):void
		{
			var l:Object = undoList[undopos];
			if(!l)
				return
			switch( l.inc)
			{
				// this is undo/redo a move
				case 1:
				{
					
					
					l.point.X += l.delta.x*dir;
					l.point.Y += l.delta.y*dir;
					l.point.Z += l.delta.z*dir;
					
					for each (var sprt:NSprite in l.pts) 
					{
						
						
						sprt.X += l.delta.x*dir
						sprt.Y += l.delta.y*dir
						sprt.Z += l.delta.z*dir
						
					}
					l.bez.drawCurve();
					l.bez.updateBez();
					
					break;
				}
				case 2:
				{
					// I think while pressing alt you can insert a bezier pt not sure
					var r:int = l.insert
					// If I ever have to do this for real just makebezier right create an unselectable first point or just a system that can grab the points probably both
					if(dir < 0){
						
						l.bez.removeChild(l.bez.bezierPts[r])
						l.bez.bezierPts.splice(r,1)
						l.bez.removeChild(l.bez.bCntrlPts[r*2])
						l.bez.bCntrlPts.splice(r*2,1)
						// ok this is a bit tricky but when you think about it it makes sense
						//when you got rid of the first one you have to get rid of it again because it goes down
						// so youd expect this to be r*2+1 but it ends up just being the same thing again cuz youve gotten rid of the other,
						//conversly to make this make sense you could get rid of the higher one first
						l.bez.removeChild(l.bez.bCntrlPts[r*2])
						l.bez.bCntrlPts.splice(r*2,1)
					}else{
						
						l.bez.MakeBezierPt(l.point.x,l.point.y,l.point.z,false,r)
					}
					// from i = 2 ++ <bezierpts.length -1 i think
					l.bez.drawCurve();
					l.bez.updateBez();
					
					break;
				}
				case 3:
				{
					Delete(l.child)
					break;
				}
				
				case 4:
				{
					r = l.insert
					// If I ever have to do this for real just makebezier right create an unselectable first point or just a system that can grab the points probably both
					if(dir >0){
						
					l.bez.removeChild(l.bez.bezierPts[r])
					l.bez.bezierPts.splice(r,1)
					l.bez.removeChild(l.bez.bCntrlPts[r*2])
					l.bez.bCntrlPts.splice(r*2,1)
					// ok this is a bit tricky but when you think about it it makes sense
					//when you got rid of the first one you have to get rid of it again because it goes down
					// so youd expect this to be r*2+1 but it ends up just being the same thing again cuz youve gotten rid of the other,
					//conversly to make this make sense you could get rid of the higher one first
					l.bez.removeChild(l.bez.bCntrlPts[r*2])
					l.bez.bCntrlPts.splice(r*2,1)
					}else{
						
						l.bez.MakeBezierPt(l.point.x,l.point.y,l.point.z,false,r)
							
						l.bez.bCntrlPts[r*2].X = l.cntrl1.x
						l.bez.bCntrlPts[r*2].Y = l.cntrl1.y
						l.bez.bCntrlPts[r*2].Z = l.cntrl1.z
						
						l.bez.bCntrlPts[r*2+1].X = l.cntrl2.x
						l.bez.bCntrlPts[r*2+1].Y = l.cntrl2.y
						l.bez.bCntrlPts[r*2+1].Z = l.cntrl2.z
						
					}
					// from i = 2 ++ <bezierpts.length -1 i think
					l.bez.drawCurve();
					l.bez.updateBez();
					
					break;
				}
				case 5:
				{
					// I think while pressing alt you can insert a bezier pt not sure
					r = l.insert
					// If I ever have to do this for real just makebezier right create an unselectable first point or just a system that can grab the points probably both
					if(dir < 0){
						
						l.bez.removeChild(l.bez.bezierPts[r])
						l.bez.bezierPts.splice(r,1)
						l.bez.removeChild(l.bez.bCntrlPts[r*2])
						l.bez.bCntrlPts.splice(r*2,1)
						// ok this is a bit tricky but when you think about it it makes sense
						//when you got rid of the first one you have to get rid of it again because it goes down
						// so youd expect this to be r*2+1 but it ends up just being the same thing again cuz youve gotten rid of the other,
						//conversly to make this make sense you could get rid of the higher one first
						l.bez.removeChild(l.bez.bCntrlPts[r*2])
						l.bez.bCntrlPts.splice(r*2,1)
							
						Director.camlinkpair.splice(r,1)
						Director.camRotation.splice(r,1)
						Director.camRotLink.splice(r,1)
					}else{
						l.bez.MakeBezierPt(l.point.x,l.point.y,l.point.z,false,r)
							//DONT USE THIS IT WONT WORK BECAUSE IT NEEDS A FOR STATEMENT to add p BUT I DONT WANNA WASTE TIME WORK ON IT
						Director.camlinkpair.splice(r,1,{val:l.val,path:(r+1)*bezTool.curvePoints})
						Director.camRotation.splice(r,1,{val:l.val,path:r+1})
						Director.camRotLink.splice(r,1,{X:l.X,Y:l.Y,Z:l.Z})
						for (var i:int = r; i < Director.camlinkpair.length; i++) 
						{
							Director.camlinkpair[i].path = (i+1)*bezTool.curvePoints
							Director.camRotation[i].path = (i+1)
						
						}
						
					}
					// from i = 2 ++ <bezierpts.length -1 i think
					l.bez.drawCurve();
					l.bez.updateBez();
					
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		 private function undo():void
		{
			 
			 // we should set it up so it first knows if its a bezier or not
			 // this may seem confusing when i look upon it in the future so future me
			 // even though notes never help me first it checks if we've ever been in there before if its our first entry we set the undo pos to the end then go down the line
			 // but if we add something else into the the list we delete the ones we had before, you cant redo if youve already done something basically that means your at the end of the list
			 
			 if(fresh || undoList.length > oldLength){
				 if(undoList.length > oldLength)
				 {
					 var amount:uint = oldLength - undopos
					 undoList.splice(undopos,amount)
				 }
				 
			 undopos = undoList.length-1;
			 oldLength = undoList.length
			 fresh = false
			 }
			
			undoTree(-1)
			 
			 undopos --
			
		}
		 
				 
		 
		 
		 private function redo():void
		 {
			 
			 // we should set it up so it first knows if its a bezier or not
			 // this may seem confusing when i look upon it in the future so future me
			 // even though notes never help me first it checks if we've ever been in there before if its our first entry we set the undo pos to the end then go down the line
			 // but if we add something else into the the list we delete the ones we had before, you cant redo if youve already done something basically that means your at the end of the list
			 
			 if(fresh || undoList.length > oldLength){
				 if(undoList.length > oldLength)
				 {
					 var amount:uint = oldLength - undopos
					 undoList.splice(undopos,amount)
				 }
				 
				 undopos = undoList.length-1;
				 oldLength = undoList.length
				 fresh = false
			 }
			 if(undopos < undoList.length - 1)
			 undopos ++
			 else
			 return
			 
			undoTree(+1)			 
			 
			 
		 }
		 
		 
		private function Delete(child:Object):void{
			
		}
		
		public function SaveAsHandlerWindow():void {
			var file:File = new File();
			configureListeners(file);
			
		file.browseForSave("SaveAs")//        (JSON.stringify(crLvJson))
	}
		
		public function OpenHandlerWindow():void {
			var file:File = new File();
			configureListeners(file);
			
			file.browse(getTypes())//        (JSON.stringify(crLvJson))
		}
		private function configureListeners(dispatcher:flash.events.IEventDispatcher):void {
			dispatcher.addEventListener(flash.events.Event.SELECT, SaveSceneAs);
			dispatcher.addEventListener(flash.events.Event.COMPLETE, completedHandler);
			dispatcher.addEventListener(flash.events.Event.OPEN, openHandler);
			dispatcher.addEventListener(flash.events.ProgressEvent.PROGRESS, progressHandler);
		}
//	
//	
		private function configureOpenListeners(dispatcher:flash.events.IEventDispatcher):void {
			dispatcher.addEventListener(flash.events.Event.SELECT, OpenScene);
			dispatcher.addEventListener(flash.events.Event.COMPLETE, completedHandler);
			dispatcher.addEventListener(flash.events.Event.OPEN, openHandler);
			dispatcher.addEventListener(flash.events.ProgressEvent.PROGRESS, progressHandler);
		}	
		private function getTypes():Array {
			var allTypes:Array = new Array(getTextTypeFilter());
			return allTypes;
		}
		
		
		private function getTextTypeFilter():FileFilter {
			return new FileFilter("Text Files (*.txt, *.json)", "*.txt;*.json");
		}

		private function selectHandler(event:flash.events.Event):void {
			var file:FileReference = FileReference(event.target)
			trace("Handler: " + event.target+"  "+file.name);
			
		}
		
		private function completedHandler(event:flash.events.Event):void {
			trace("completeHandler: " + event);
		}
		
		private function openHandler(event:flash.events.Event):void {
			trace("openHandler: " + event);
			OpenHandlerWindow();
		}
		
		private function progressHandler(event:flash.events.ProgressEvent):void {
			var file:FileReference = FileReference(event.target);
			trace("progressHandler name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}


		protected static function parseEdtJSN(e:flash.events.Event):void{
			trace("JSON file succesfully loaded")
			// lest pretend this is our json we loaded from whereverthefuck
			//{name:"Todd Anderson", company:"Infrared5"}
			trace(editJson.data)
			editMainJson = JSON.parse(editJson.data)
			LoadScene()
			editJson.close()
		}
		
		protected static function parseJSON(e:flash.events.Event):void{
							trace("JSON file succesfully loaded")
							// lest pretend this is our json we loaded from whereverthefuck
							//{name:"Todd Anderson", company:"Infrared5"}
							trace(json.data)
							crLvJson = JSON.parse(json.data)
								
								trace(JSON.stringify(crLvJson))
								json.close()
//			 those should be easy the ret
//			editjson is the same except it just has an array of strings
//			 and i say public static var sceneLst = an array of string in there ill probably call it parseJson.sceneList
							
							// its indirect in the way im going to copy over manually all the json to here anyway.. probably	
							// 
								
							Director.scenary = crLvJson.scenary
							Director.floorpts = crLvJson.floorpts
							Director.rings = crLvJson.rings
							Director.baddies = crLvJson.baddies
							
							Director.Campath = crLvJson.Campath
						
							Director.camlinkpair = crLvJson.camlinkpair
							Director.camRotation = crLvJson.camRotation 
							Director.camRotLink =  crLvJson.camRotLink
							Director.paths = crLvJson.paths
								
							ResourceManager.pathPts = crLvJson.pathPts
								// i coud probably permanately fix these in each of the jsons but yeah, not the biggest of deals
							
							if(!ResourceManager.pathPts)
								ResourceManager.pathPts = []
							if(!Director.Campath)
								Director.Campath = []
							if(!Director.camlinkpair)
								Director.camlinkpair = []
							if(!Director.camRotation)
								Director.camRotation = [] 
							if(!Director.camRotLink)
								Director.camRotLink = []
							if(!Director.paths)
								Director.paths = []
							if(!Director.scenary)
								Director.scenary = []
							if(!Director.rings)
								Director.rings = []
							if(!Director.baddies)
								Director.baddies = []
							isAllLoaded = true
							ResourceManager.placeItems()
									
								if(ResourceManager.pathPts.length != 0){
									if(bezTool){
									EditKeyHandler.State = BEZIER
									bezTool.CreateBez(ResourceManager.pathPts[0]);
									EditKeyHandler.State = SELECT
									}else{
										bezToolRemake()
									}
									//2 = CamPath
									//resetShit()
									if(false){
									MakeGroundPath()
									Main.liveCamera.hero_mc.body.position.x = Director.floorpts[1].D
									Main.liveCamera.hero_mc.body.position.y = Director.floorpts[1].Y+600
									Main.liveCamera.hero_mc.stuck = true	
									}
								}
						}
		public static function resetShit():void
		{
			bezToolDelete()
			Director.Campath = []
			Director.camlinkpair =  editlinkpaArry  = crLvJson.camlinkpair = []
			Director.camRotation = editCamRot =  crLvJson.camRotation  =[]
			Director.camRotLink = editCamRotLink = crLvJson.camRotLink = []
		}
		
		/**
		 * its good.. I think
		 */
		public  static function bezToolDelete():void
		{
			if(bezTool){
			bezTool.deleteline()
			
			bezTool.removeFromParent()
			bezTool = null
			}
			BezierCurve.segs[0] = new BezierCurve()
			bezTool = BezierCurve.segs[0]
			Main.liveCamera.addChild(bezTool)
		}
		
		/**
		 * 
		 * hmm i think that this is wrong because i just use a new BezierCurve but i think im supposed to use the the BezierCurve static list need to investigate why though
		 */
		
		public static function bezToolRemake():void
		{
			var oldState:int  = EditKeyHandler.State
			EditKeyHandler.State = BEZIER
			// use whatever you want to use in place of resource manager.pts
			bezTool.CreateBez(ResourceManager.pathPts[0]);
			EditKeyHandler.State = oldState
		
		}
			
		
		
		public static function LoadScene():void
		{
			
			if(!editJson){
			editJson = new URLLoader();
			editJson.addEventListener(flash.events.Event.COMPLETE, parseEdtJSN);
			editJson.load(new URLRequest(File.userDirectory.nativePath+"/Google Drive/StarlingProject/Resources/Json/editMain.json"))
			}else{
			trace(editMainJson.levels.OpeningScene)
			json = new URLLoader();
			json.addEventListener(flash.events.Event.COMPLETE, parseJSON);
			json.load(new URLRequest(File.userDirectory.nativePath+"/Google Drive/StarlingProject/Resources/Json/"+editMainJson.levels[Director.currSceneName]+".json"))
			
			
//			if(editMainJson.original)
//				editMainJson.levels[Director.currSceneName] = editMainJson.original
//				editMainJson.original = undefined
//				saveEditMain()
			}
		}
		// save as is similar but whatever i write it saves as
		public function SaveScene():void{
			
			//hmm for a more complete save take the spawn points and add those to to the world as just images representing what they are, and since its one image per type i can push them into spawn types and add them on creation, so to differentiate them from regular stuff made in game, have an onLevelInstation query so I dont make one during gameplay
			// umm yeah 
			var file:File = new File(File.userDirectory.nativePath+"/Google Drive/StarlingProject/Resources/Json/"+editMainJson.levels[Director.currSceneName]+".json" )
			var fs:FileStream = new FileStream();
			
			
			setJsonvals();
			
			var outputJson:String = JSON.stringify(crLvJson,null,1);
			
			
			
			//this may do it for us in save as but i could be wrong
			//file.browseForSave(
			// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
			
			
			fs.openAsync(file, FileMode.WRITE);
			fs.writeUTFBytes(outputJson);
			fs.close()
		}
		// right now they all have to be in json so theres that
		public function OpenScene(event:flash.events.Event):void {
//			EditKeyHandler[Director.currSceneName] =file.name
			var file:FileReference = FileReference(event.target)
			// this is dumb and probablematic only because i know i would end up using open scene to jump to different scenes
			// just manually coppy it over
			//editMainJson.original = editMainJson.levels[Director.currSceneName]
			editMainJson.levels[Director.currSceneName] = file.name
			editMainJson.recentDocs.push(file.name)
			// its probably pop slice but who knows 
			// we have to update and  write editorJson here and in savesceneas
			saveEditMain()
			
			var d:Director  = new Director()
				d.RestartScene()
				d = null
		}
		
//		MAYBE IMPORTANT FOR STUFF
//		if(destroyBez){
//			Main.liveCamera.removeChild(bezTool);
//			
//			BezierCurve.segs.length = 0;
//			BezierCurve.segs.push(new BezierCurve())
//			bezTool = BezierCurve.segs[BezierCurve.segs.length -1];
//			Main.liveCamera.addChild(bezTool);
//			destroyBez = false;
//			State = 0; 
//		}
		
		private function setJsonvals():void{
			
			var lPts:Array = []
			// this is always true for now but when we change it should be umm easier i think
			if(bezTool == BezierCurve.segs[BezierCurve.segs.length -1])
			lPts =  BezierCurve.segs[BezierCurve.segs.length -1].bezierPts
			
			var mainary:Array = [];
			var ary:Array = []
			for (var k:int = 0; k < lPts.length; k++) 
			{
				
				ary.push({X:lPts[k].X,Y:lPts[k].Y,Z:lPts[k].Z})
			} 
//			replacementData += ary+"],"
			// this was really dumb and i dunno why i didnt just add the sprites proper
//			if(bezTool.type == floorTool){
				lPts =[bezTool._control1,bezTool._control2]//.y,Z:bezTool._control1.Z}, {x:bezTool._control2.x, y:bezTool._control2.y,Z:bezTool._control2.Z}]
				lPts = lPts.concat(bezTool.bCntrlPts)
//			}else{
//				lPts = ResourceManager.myCurvePts[1] 
//			}
			var ary2:Array = [] 
			for (k = 0; k < lPts.length; k++) 
			{
				
				ary2.push({X:lPts[k].X,Y:lPts[k].Y,Z:lPts[k].Z})
			} 
			
			mainary.push(ary,ary2)
			mainary.push(BezierCurve.segs[0].floorType)
			// later push mainarray into resourceManager.myCurvePts
			
			// if you dont clear this array its a good way to make an infinite undo between saves
			ResourceManager.pathPts = []
			ResourceManager.pathPts.unshift(mainary)
			// umm consider going back to the old style
			//for(bzs) in a for(pts) statement var v:Object = {X:Y:Z:} if i2 == 0 v.active = (i2 == currentBez.Dindex)
//			var bezierep:Array = [];
//			for (var bz:int = 0; bz < BezierCurve.segs.length; bz++) 
//			{
//				for (var j:int = 0; j < BezierCurve.segs[bz].length; j++) 
//				{
//					var bez:Array = [];
//					var ary:Array = BezierCurve.segs[bz]
//					var a:Object = {}
//						if(j%3 == 0){
//						bez.push({X:ary[j].Y,Y:ary[j].Y,Z:ary[j].Z,active:(ary[j] == bezTool),type:ary[j].type})
//						}else if(j > 0 && j <3){
//						}else if(j==1){
//						bez.push({X:ary[j]._control1.X,Y:ary[j]._control1.Y,Z:ary[j]._control1.Z})
//						}else if(j==2){
//						bez.push({X:ary[j]._control2.X,Y:ary[j]._control2.Y,Z:ary[j]._control2.Z})
//
//					}else{
//						
//						// im not sure about the bandage i put here it may be a level fix but it may be set to zero
//						// which would mean we do -2 for each its probably this
//						if(j%1 == 0)
//						bez.push({X:ary[j]._control1.X,Y:ary[j]._control1.Y,Z:ary[j]._control1.Z})
//						else if(j%2 ==0)
//						bez.push({X:ary[j]._control2.X,Y:ary[j]._control2.Y,Z:ary[j]._control2.Z})
//
//						
//						bCntrlPts[j-2].X = ary[j+1].X
//						bCntrlPts[j-2].Y = ary[j+1].Y;
//						bCntrlPts[j-2].Z = ary[j+1].Z
//						
//						
//						bCntrlPts[j-1].X = ary[j+2].X
//						bCntrlPts[j-1].Y = ary[j+2].Y;
//						bCntrlPts[j-1].Z = ary[j+2].Z;
//					}
//				}
//				
//			}
//			
			crLvJson.scenary=Director.scenary  
			crLvJson.floorpts= MainSceneMotor.floor.ptsArray// Director.floorpts 
			crLvJson.rings= Director.rings 
			crLvJson.baddies=Director.baddies 
			crLvJson.pathPts=ResourceManager.pathPts 
			crLvJson.Campath=Director.Campath 
			crLvJson.camlinkpair=Director.camlinkpair 
			crLvJson.camRotation =Director.camRotation 
			crLvJson.camRotLink=Director.camRotLink 
		}
		
		
		public function SaveSceneAs(event:flash.events.Event):void{
			var f:FileReference = FileReference(event.target)
			//hmm for a more complete save take the spawn points and add those to to the world as just images representing what they are, and since its one image per type i can push them into spawn types and add them on creation, so to differentiate them from regular stuff made in game, have an onLevelInstation query so I dont make one during gameplay
			// umm yeah 
				
			var file:File = new File(File.userDirectory.nativePath+"/Google Drive/StarlingProject/Resources/Json/"+f.name+".json" )
			var fs:FileStream = new FileStream();
			
			setJsonvals();

			
			var outputJson:String = JSON.stringify(crLvJson,null,1);
			
			
			editMainJson.levels[Director.currSceneName] = f.name
			//this may do it for us in save as but i could be wrong
			//file.browseForSave(
			// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
			
			
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(outputJson);
			
			saveEditMain()
			fs.close();
		}
		
		private static function saveEditMain():void{
			var file:File = new File(File.userDirectory.nativePath+"/Google Drive/StarlingProject/Resources/Json/editMain.json" )
			var fs:FileStream = new FileStream();
			
			var outputJson:String = JSON.stringify(editMainJson,null,1);
			
			//this may do it for us in save as but i could be wrong
			//file.browseForSave(
			// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
			
			fs.open
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(outputJson);
			fs.close()
		}
		
		// I decided to temporarily cancel this out because it has deprecated code but its very usefull when wroking
		 private function saveItems():void{
			 //var textURL:URLRequest = new URLRequest("TestResources.txt");
			// loader = new URLLoader(textURL) 
//			 var file:File = new File(File.userDirectory.nativePath+"/Google Drive/StarlingProject/src/ResourceManager.as" )
//			 var fileStream:FileStream = new FileStream();
//			 fileStream.open(file, FileMode.READ);
//			 var str:String = fileStream.readUTFBytes(file.size);
//			 //trace(str)
//			 fileStream.close();
//			 
//			
//			
//				completeHandler(str, file)
			 
			 var replacementData:String= "Director.scenary = ";
			 if(Main.liveCamera.scnes != null){
				 var scnry:Array = Main.liveCamera.scenary
				 var ary:String = "["
				 for (var k:uint = 0; k < scnry.length; k++) 
				 {
					 if(k!=0)
						 ary+= ","
					 ary+="{X:"+scnry[k].X.toString()+",Y:"+scnry[k].Y.toString()+",Z:"+scnry[k].Z.toString()+",ScaleX:"+scnry[k].scaleZ.toString()+",ScaleY:"+scnry[k].scaleZ.toString()+",name:"+"\""+scnry[k].name+"\""+",frms:"+scnry[k].frms.toString()+"}";
				 } 
				 replacementData += ary
				 replacementData+= "] ;\n\t\t"
			 }
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
			 trace(replacementData)
		 }
		 // I decided to temporarily cancel this out because it has deprecated code but its very usefull when wroking
		 protected function completeHandler(textFile:String, file:File):void
		 {
			 //var loadedText:URLLoader = URLLoader(event.target);
			// myText_txt.text = loadedText.data;
		 
		
		 //this is for copying stuff from one place to another with a conversion works except its the appli
//		 var original:File = File.desktopDirectory.resolvePath("test2.txt"); 
//		 var newFile:File = File.applicationDirectory.resolvePath("testing.as");
//		 original.copyTo(newFile, true); \t
		 // its actually pretty easy to change the replacement data just take it from resourses and update that one, add ones take ones away
		 // so all that parsing and making usable data happens elsewhere
		 // to create the replacement data 
		 var replacementData:String = "Director.rings = "
		 var ary:String = "["
		 for (var k:int = 0; k < Main.liveCamera.rings.length; k++) 
		 {
			 if(k!=0)
			 ary+= ","
			ary+="["+Main.liveCamera.rings[k].X.toString()+","+Main.liveCamera.rings[k].Y.toString()+","+Main.liveCamera.rings[k].Z.toString()+","+"'noAnimyet'"+"]";
		 }
		 
			 replacementData += ary
			 replacementData+= "] ;\n\n\t\t\t"
			 replacementData+= "Director.floorpts = ";
			 if(MainSceneMotor.floor != null){
			 var flr:Array = MainSceneMotor.floor.ptsArray
			 ary = "["
			 for (k = 0; k < flr.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+flr[k].X.toString()+",Y:"+flr[k].Y.toString()+",Z:"+flr[k].Z.toString()+",D:"+flr[k].D.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "] ;\n\t\t"
			 }
			 
			 replacementData+= "Director.scenary = ";
			 if(Main.liveCamera.scnes != null){
			 var scnry:Array = Main.liveCamera.scenary
			 ary = "["
			 for (k = 0; k < scnry.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+scnry[k].X.toString()+",Y:"+scnry[k].Y.toString()+",Z:"+scnry[k].Z.toString()+",ScaleX:"+scnry[k].scaleZ.toString()+",ScaleY:"+scnry[k].scaleZ.toString()+",name:"+"\""+scnry[k].name+"\""+",frms:"+scnry[k].frms.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "] ;\n\t\t"
			 }
			 replacementData+= "Director.hornets = ";
			 ary = "["
			 for (k = 0; k < Main.liveCamera.baddies.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="["+Main.liveCamera.baddies[k].X.toString()+","+Main.liveCamera.baddies[k].Y.toString()+","+Main.liveCamera.baddies[k].Z.toString()+","+"'noAnimyet'"+"]";
			 }
			 
			 replacementData += ary
			 replacementData+= "] ;\n\n\t\t\t"
				 
			 replacementData+= "myCurvePts = ";
			 if(bezTool.bezierPts.length == 0)
			 {
				 EditKeyHandler.State = 1;
				 bezTool.CreateBez(myCurvePts);
				 var destroyBez:Boolean = true
			 }
			 if(bezTool.type == floorTool)
			 var lPts:Array = bezTool.bezierPts
			 else
				 lPts = ResourceManager.myCurvePts[0]
			 ary = "[["
			 for (k = 0; k < lPts.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+lPts[k].X.toString()+",Y:"+lPts[k].Y.toString()+",Z:"+lPts[k].Z.toString()+"}";
			 } 
			 replacementData += ary+"],"
			 // this was really dumb and i dunno why i didnt just add the sprites proper
			 if(bezTool.type == floorTool){
			 lPts =[bezTool._control1,bezTool._control2]//.y,Z:bezTool._control1.Z}, {x:bezTool._control2.x, y:bezTool._control2.y,Z:bezTool._control2.Z}]
			 lPts = lPts.concat(bezTool.bCntrlPts)
			 }else{
				 lPts = ResourceManager.myCurvePts[1] 
			 }
			 ary = "["
			 for (k = 0; k < lPts.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+lPts[k].X.toString()+",Y:"+lPts[k].Y.toString()+",Z:"+lPts[k].Z.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "]] ;\n\t\t"
				 
			 replacementData+= "camPathPts = ";
			 if(bezTool.bezierPts.length == 0)
			 {
				 EditKeyHandler.State = 1;
				 bezTool.CreateBez(myCurvePts);
				 var destroyBez:Boolean = true
			 }
			 if(bezTool.type == CamPath)
				  lPts = bezTool.bezierPts
			 else
				 lPts = ResourceManager.camPathPts[0]
			 ary = "[["
			 for (k = 0; k < lPts.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+lPts[k].X.toString()+",Y:"+lPts[k].Y.toString()+",Z:"+lPts[k].Z.toString()+"}";
			 } 
			 replacementData += ary+"],"
			 // this was really dumb and i dunno why i didnt just add the sprites proper
			 if(bezTool.type == CamPath){
				 lPts =[bezTool._control1,bezTool._control2]//.y,Z:bezTool._control1.Z}, {x:bezTool._control2.x, y:bezTool._control2.y,Z:bezTool._control2.Z}]
				 lPts = lPts.concat(bezTool.bCntrlPts)
			 }else{
				 lPts = ResourceManager.camPathPts[1] 
			 }
			 ary = "["
			 for (k = 0; k < lPts.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+lPts[k].X.toString()+",Y:"+lPts[k].Y.toString()+",Z:"+lPts[k].Z.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "]] ;\n\t\t"
				 
				 // I LEFT THIS A MESS FOR YOU ENJOY!!!!
				 
			 for (i = 0; i < ResourceManager.pathPts.length; i++) 
			 {
				
			 
			 
		
			 replacementData+= "pathPts["+i+"] = ";

			 
			
			 
					//Ok important to get this to work when your changing around the path, you push or alter the path
//			 var lPts:Array = bezTool.bezierPts
//			 else
				 lPts = ResourceManager.pathPts[i]
			 ary = "[["
			 for (k = 0; k < lPts.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+lPts[k].X.toString()+",Y:"+lPts[k].Y.toString()+",Z:"+lPts[k].Z.toString()+"}";
			 } 
			 replacementData += ary+"],"
// so remember we do all this everytime we update it, as opposed to when we save it
				 // probably could do that for all of em, but this is quicker to test
//			 if(bezTool.type == PathTool){
//				 lPts =[bezTool._control1,bezTool._control2]//.y,Z:bezTool._control1.Z}, {x:bezTool._control2.x, y:bezTool._control2.y,Z:bezTool._control2.Z}]
//				 lPts = lPts.concat(bezTool.bCntrlPts)
//			 }else{
				 lPts = ResourceManager.pathPts[i][1] 
			// }
			 ary = "["
			 for (k = 0; k < lPts.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+lPts[k].X.toString()+",Y:"+lPts[k].Y.toString()+",Z:"+lPts[k].Z.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "]] ;\n\t\t"
			 }
			 replacementData+= "Director.paths = ["
			 for (var j:int = 0; j < Director.paths.length; j++) 
			 {
				 
				 
				 if(j!=0)
				 replacementData+= ","
				 ary = "{ptsArray:["
					 var path:Array = Director.paths[j].ptsArray
				 for (k = 0; k < path.length; k++) 
				 {
					 if(k!=0)
						 ary+= ","
					 ary+="{X:"+path[k].X.toString()+",Y:"+path[k].Y.toString()+",Z:"+path[k].Z.toString()+",D:"+path[k].D.toString()+"}";
				 } 
				 replacementData += ary
				
				 replacementData+= "],linkArray:"
				 ary = "["
					 
				
				 path = Director.paths[j].linkArray
				 for (k = 0; k < path.length; k++) 
				 {
					 if(k!=0)
						 ary+= ","
					 ary+="{val:"+path[k].val.toString()+",path:"+path[k].path.toString()+"}"//+",Z:"+path[k].Z.toString()+",D:"+path[k].D.toString()+"}";
				 } 
				
				replacementData += ary
					var n:String = ""
					if(Director.paths[j].name)
						n = Director.paths[j].name
				replacementData +="],name: \""+n+"\"}";
				
				
			 }
			 replacementData+= "] ;\n\t\t"
			 replacementData+= "Director.Campath = ";
			 ary = "["
			 path= Director.Campath
			 for (k = 0; k < path.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
			//here i add the rotation position of the camera, a attached it onto the camlinkpair so it will be a bit confusing as it breaks the pattern of linkpair that i set up but it should work fine  
				 ary+="{X:"+path[k].X.toString()+",Y:"+path[k].Y.toString()+",Z:"+path[k].Z.toString()+",D:"+path[k].D.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "] ;\n\t\t"
			 
			 replacementData+= "Director.camRotation = ";
			 ary = "["
			 path= Director.camRotation
			 for (k = 0; k < path.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{X:"+path[k].X.toString()+",Y:"+path[k].Y.toString()+",Z:"+path[k].Z.toString()+",D:0}";
			 } 
			 replacementData += ary
			 replacementData+= "] ;\n\t\t"
				 
			 replacementData+= "Director.camRotLink = ";
			 ary = "["
			 path= Director.camRotLink
			 for (k = 0; k < path.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{val:"+path[k].val.toString()+",path:"+path[k].path.toString()+"}"//+",Z:"+path[k].Z.toString()+",D:"+path[k].D.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "] ;\n\t\t"
				 
			 replacementData+= "Director.camlinkpair = ";
			 ary = "["
			 
			 path = Director.camlinkpair
			 for (k = 0; k < path.length; k++) 
			 {
				 if(k!=0)
					 ary+= ","
				 ary+="{val:"+path[k].val.toString()+",path:"+path[k].path.toString()+"}"//+",Z:"+path[k].Z.toString()+",D:"+path[k].D.toString()+"}";
			 } 
			 replacementData += ary
			 replacementData+= "] ;\n\t\t"
			 
			 
			if(destroyBez){
				 Main.liveCamera.removeChild(bezTool);
				 
				 BezierCurve.segs.length = 0;
				 BezierCurve.segs.push(new BezierCurve())
				 bezTool = BezierCurve.segs[BezierCurve.segs.length -1];
				 Main.liveCamera.addChild(bezTool);
				 destroyBez = false;
				 State = 0; 
			 }
			 
		 var testResoursestxt:String =textFile
		 var stringSpprt:String
		//"package { import com.jonLwiza.engine.GeneralElements.Director; public final class TestResourses { public function TestResourses() {} public function TestScene():void { clearAll(); Director.rings = [[4,5],[14,12],[8,25]];		}	private function clearAll():void		{			// takes all the arrays not being used and clears them for the next scene			Director.rings = [];		}	}}"
		 var preString:String = "\n\t\t{\n\t\t\t\n\t\t\t"
		    
		 editedScnes[0] = Director.currSceneName
		 for (var i:int = 0; i < editedScnes.length; i++) 
		 {
			 // whenever we make changes to the scene we say 
			 //or something to the effect where we ask what scene were in********** this isnt here its just for example purposes
			 // look for TestScene():void {
				 // now lets make the replacement datastring we use the edited sceneRs to do it
				 // we go through every scene thats edited and save shit out
				 
//			 for (var j:int = 0; j < editedSceneRs[editedScnes[i]].length; j++) 
//			 {
//				 if(!editedSceneRs[editedScnes[i]][j].length > 1)
//					 continue	
//				 switch(j)
//				 {
//					 case TestResourses.Rings:
//					 {
//						stringSpprt= StringComplr("Rings", [editedScnes[i]][j]);
//						 
//						 break;
//					 }
//					 case TestResourses.Hornets:
//					 {
//						 stringSpprt= StringComplr("Hornets", [editedScnes[i]][j]);
//						 break;
//					 }
//					 case TestResourses.BaddieBoss:
//					 {
//						 stringSpprt= StringComplr("BaddieBoss",[editedScnes[i]][j]);
//						 break;
//					 }
//					 case TestResourses.Misc:
//					 {
//						 stringSpprt= StringComplr("Misc",[editedScnes[i]][j]);
//						 break;
//					 }
//					 case TestResourses.Scenary:
//					 {
//						 stringSpprt=  StringComplr("Scenary",[editedScnes[i]][j]);
//						 break;
//					 }
//					 case TestResourses.Scene:
//					 {
//						 stringSpprt=  StringComplr("Scene",[editedScnes[i]][j]);
//						 break;
//					 }
//					 case TestResourses.Heroic:
//					 {
//						 stringSpprt=  StringComplr("Hero",[editedScnes[i]][j]);
//						 break;
//					 }
//						 
//					 default:
//					 {
//						 break;
//					 }
//				 }
//				 replacementData += "["+editedScnes[i]+"]"+"["+stringSpprt+"];\n\t\t}"
//			 }
			 // not sure where this goes but i wanna do this for every scene of course
			
			// the trick or hard part is gonna be saving an array of these and accessing them using array access notation
			
//			so.data.floor = flrs//flrTool
//			so.flush()
			
			// how to get the info man
//			so.data.floor["whatevs"] 
			var functionName:String = editedScnes[0]+="():void"//{clearAll();"
			 var start:int =testResoursestxt.indexOf(functionName)+functionName.length
				 // if it returns negative 1 we have to add it
				 // find the last two end brackets and just add the code there
			var splitR:String = testResoursestxt.substring(start);
			// now we look for the end
			var end:int = splitR.indexOf("placeItems()")+start;
			// now we see if we can split it for reals
			var subString:String = testResoursestxt.substring(start,end);
			testResoursestxt = testResoursestxt.replace(subString, preString+replacementData+"\n\t\t\t");
			
			var fs:FileStream = new FileStream();
			// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
			fs.open
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(testResoursestxt);
			fs.close()
		 }
		 
	//	throw Error(" fdsf dse")
		 
//		 Clipboard.generalClipboard.clear(); 
//		 Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, textToCopy, false); 
		 if(xSheet.alteredMovies.length >=1)
			 saveImageSqueekal()
		
		 		}
		 
		 private function StringComplr(type:String, arry:Array):String
		 {
			 var output:String =type+"] = [";
			 for (var i:int = 0; i < arry.length; i++) 
			 {
				 
				var temp:String = "["+Number(arry[i][0]).toString()+","+Number(arry[i][1]).toString()+","+Number(arry[i][2]).toString()
					if(arry[i].length ==4)
					temp+=arry[i][3]
					temp+="]"
			 }
			 return output
		 }		 
		 
		 private function saveImage():void
		 {
			 for each (var m:Object in newImagePool) 
			 {
				 var fileReference:FileReference=new FileReference();
				 // this is gonna be a little bit recursive but whatevs
				 //fileReference.save(i.file, i.name); 
				
				 for (var j:int = 1; j < m.mc.movie.numFrames+1; j++) 
				 {
				 
				 for (var i:int = 0; i < m.pngs.length; i++) 
				 {
					
					 if(Texture.fromBitmapData(m.pngs[i]) == m.movie.getFrameTexture(j))
					 {
						 var byteArray:ByteArray = PNGEncoder.encode(m.pngs[i]);
						 if(j<10)
							 saveFrame(byteArray,m.movie.name+"000"+j.toString()); 
						 else if(j>=10 && j<100)
							 saveFrame(byteArray,m.movie.name+"00"+j.toString()); 
						 else
						 	saveFrame(byteArray,m.movie.name+"0"+j.toString()); 
						 break;
						 
					 }
					 
				 }
				 // now we'll check if it has found a newly made frame if not we resave the old one except with an updated position if needed
				 if(i == m.pngs.length)
				 {
					 // now were gonna check if its position matches its original position if it does we just continue out of the for loop
					 // if it doesnt we have to look for it
					 var number:String
					 if(j<10)
						number = "000"+j.toString(); 
					 else if(mc.numFrames>=10 && j<100)
						 number = "00"+j.toString(); 
					 else
					 number = "0"+j.toString(); 
					 
					 if(m.movie.getFrameTexture(j) == Texture.fromBitmapData(Assets[m.movie.name+number]))
						 continue;
					 for (var k:int = 1; k < m.numFrames+1; k++) 
					 {
						 if(k<10)
							 number = "000"+k.toString(); 
						 else if(mc.numFrames>=10 && j<100)
							 number = "00"+k.toString(); 
						 else
							 number = "0"+k.toString(); 
						 
						 if(m.movie.getFrameTexture(j) == Texture.fromBitmapData(Assets[m.movie.name+number]))
						 {
							 byteArray = PNGEncoder.encode(Assets[m.movie.name+number]);
							 if(j<10)
								 saveFrame(byteArray,m.movie.name+"000"+j.toString()); 
							 else if(j>=10 && j<100)
								 saveFrame(byteArray,m.movie.name+"00"+j.toString()); 
							 else
								 saveFrame(byteArray,m.movie.name+"0"+j.toString()); 
							 break;
						 }
						 
					 }
					 
				 }
				 }
				 
			 }
			 
		 }
		 private function saveImageSqueekal():void
		 {
			 
			 // just go through all the altered movies and save out all the frames
			// check if its in Xsheet.newFrames like //xSheet.newFrames["whateverthe name would be"]
			// if its not just save out the old one the one being used itll be easy to fix if something goes wrong
			 // and thats it so long as nothing goes wrong it should be pretty easy
			 // it wont be but you have a plan
			 for each (var gm:Object in editedImages)
			 {
				 
				 var byteArray:ByteArray = PNGEncoder.encode(gm.bitmapData);
				
				 
				 savePNG(byteArray,gm.name) 
			 }
			 for each (var d:MovieClip in xSheet.alteredMovies)
			 {
				 var fileReference:FileReference=new FileReference();
					
				 for (var i2:int = 1; i2 < d.numFrames+1; i2++) 
				 {
					 var name:String = d.name;
					 var number:String
					 if(i2<10)
						 number = "000"+i2.toString(); 
					 else if(i2>=10 && i2<100)
						 number = "00"+i2.toString(); 
					 else
						 number = "0"+i2.toString(); 
					 
					
					 if(xSheet.newFrames[name+i2] != undefined)
					 { 
						
						  byteArray = PNGEncoder.encode(xSheet.newFrames[name+i2].bitmapData);
						 name+=number;
						 var scene:String = getQualifiedClassName(Director.sceneList[Director.playingScene]);
						 var dname:String = scene.slice(scene.search("::")+2)
							 saveFrame(byteArray,dname+"_"+name); 
						 
					 }else{
					 }
				 }
				 
			 }
//			 for each (var m:Object in xSheet.newFrames) 
//			 {
//				 var fileReference:FileReference=new FileReference();
				 // this is gonna be a little bit recursive but whatevs
				 //fileReference.save(i.file, i.name); 
				
//				 for (var j:int = 1; j < m.mc.movie.numFrames+1; j++) 
//				 {
//				 
//				 for (var i:int = 0; i < m.pngs.length; i++) 
//				 {
//					
//					 if(Texture.fromBitmapData(m.pngs[i]) == m.movie.getFrameTexture(j))
//					 {
//						 var byteArray:ByteArray = PNGEncoder.encode(m.pngs[i]);
//						 if(j<10)
//							 saveFrame(byteArray,m.movie.name+"000"+j.toString()); 
//						 else if(j>=10 && j<100)
//							 saveFrame(byteArray,m.movie.name+"00"+j.toString()); 
//						 else
//						 	saveFrame(byteArray,m.movie.name+"0"+j.toString()); 
//						 break;
//					 }
//					 
//				 }
//				 // now we'll check if it has found a newly made frame if not we resave the old one except with an updated position if needed
//				 if(i == m.pngs.length)
//				 {
//					 // now were gonna check if its position matches its original position if it does we just continue out of the for loop
//					 // if it doesnt we have to look for it
//					 var number:String
//					 if(j<10)
//						number = "000"+j.toString(); 
//					 else if(mc.numFrames>=10 && j<100)
//						 number = "00"+j.toString(); 
//					 else
//					 number = "0"+j.toString(); 
//					 
//					 if(m.movie.getFrameTexture(j) == Texture.fromBitmapData(Assets[m.movie.name+number]))
//						 continue;
//					 for (var k:int = 1; k < m.numFrames+1; k++) 
//					 {
//						 if(k<10)
//							 number = "000"+k.toString(); 
//						 else if(mc.numFrames>=10 && j<100)
//							 number = "00"+k.toString(); 
//						 else
//							 number = "0"+k.toString(); 
//						 
//						 if(m.movie.getFrameTexture(j) == Texture.fromBitmapData(Assets[m.movie.name+number]))
//						 {
//							 var byteArray:ByteArray = PNGEncoder.encode(Assets[m.movie.name+number]);
//							 if(j<10)
//								 saveFrame(byteArray,m.movie.name+"000"+j.toString()); 
//							 else if(j>=10 && j<100)
//								 saveFrame(byteArray,m.movie.name+"00"+j.toString()); 
//							 else
//								 saveFrame(byteArray,m.movie.name+"0"+j.toString()); 
//							 break;
//						 }
//						 
//					 }
//					 
//				 }
//				 }
				 
//			 }
			 
		 }
		 
		 private function paste():void {
			 
			 
			 if(State == SELECT){
				
					 GeneralMotor(EditElement).z2 = elz
					 GeneralMotor(EditElement).drctrList[GeneralMotor(EditElement).drctrIndx].Z = GeneralMotor(EditElement).Z
					 
				
			 }else if(State == BEZIER){
			 
			 var l:Object = undoList[undopos];
			
			 		
					if(l.inc == 1){ 
					 // this may fail due to the whole object thing
					var oldZ:Number = l.point.Z
					 l.point.Z = elz
					 
					 for each (var sprt:NSprite in l.pts) 
					 {
						 
						 
						 
						 sprt.Z = elz
						 
					 }
					 l.bez.drawCurve();
					 l.bez.updateBez();
					 
					 l.delta.x = 0
					 l.delta.y = 0
					 l.delta.z = l.point.Z - oldZ
					 undoList.push(l)
					 
			 }
					
			 }
		 
			 }
		 
		 private function saveFrame(byteArray:ByteArray, fname:String):void
		 {
			 var vx:String = fname
			 var dname:String = vx.slice(0,vx.search("_"))
				 // tested the file path thing it should work
			var fl:File = new File(File.userDirectory.nativePath+"/Google Drive/StarlingProject/Resources/"+dname+"/"+fname+".png" )
			var fs:FileStream = new FileStream();
			// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
			fs.open
			fs.open(fl, FileMode.WRITE);
			fs.writeBytes(byteArray);
			fs.close()
		 }
		 private function savePNG(byteArray:ByteArray, fname:String):void
		 {
			 var vx:String = fname
				 // tested the file path thing it should work
			var fl:File = new File(File.userDirectory.nativePath+"/Google Drive/LevelEditor/bin-debug/"+fname+".png" )
			if(!fs)
			fs = new FileStream();
			// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
			
			fs.openAsync(fl, FileMode.WRITE);
			fs.writeBytes(byteArray);
			fs.close()
		 }
		 
		private function ReturnClick(mc:MovieClip):void
		{
			// add a new frame which is the image that i just made 
			
			// i dont remember exactly how this worked but yeah pretty much this
			// i really dont see any need for pressure sensitivity so we should get this off internetness
			if(EditKeyHandler.State == EditKeyHandler.Animation)
			{
			mc.addFrame(Texture.fromBitmapData(LevelEditor.bm.bitmapData))
			
			}
			var fileReference:FileReference=new FileReference();
			// were gonna make the new image pool a bit smarter
			// i think if we track and update the objects in the new image pool
			// so that when we make changes to the animation it also makes changes too the pool location
			// the thing that actually gets tricky is when i move them around, because that means i have to go in and
			// change the names of all the frames before hand, there are two options i can do to edit them
			// i can find how i can programatically alter their names, thats best option
			// number two is to stream them in again as soon as i know im altering frames then sereptitiously re load them, very stupid
			var byteArray:ByteArray = PNGEncoder.encode(LevelEditor.bm.bitmapData);
			// ok this gets confusing but when i add a frame no matter when i put it, its name throughout its duration until its saved
			// at the end of the frame numbers
			for (var i:int = 0; i < newImagePool.length; i++) 
			{
				if(mc == newImagePool[i].movie)
				{
					newImagePool[i].pngs.push(LevelEditor.bm.bitmapData)
					break;
				}
			}
			
			if(i == newImagePool.length){
				newImagePool.push({movie:mc, pngs:[LevelEditor.bm.bitmapData]})
			}
//			if(mc.numFrames<10)
//				newImagePool.push({movie:mc, pngs:[byteArray]})
//			else if(mc.numFrames>=10 && mc.numFrames<100)
//				newImagePool.push({name:mc.name+"00", file:byteArray, currFrame:0})
//			else
//				newImagePool.push({name:mc.name+"0", file:byteArray, currFrame:0})
			//fileReference.save(byteArray, "thisJunk.png"); 
//			ldr = new URLLoader();
//			ldr.addEventListener(flash.events.Event.COMPLETE, onLoad);
//			ldr.load(new URLRequest("Cut1.xml"));//or any script that returns xml
//			xSheet.ReturnClicked(Texture.fromBitmapData(LevelEditor.bm.bitmapData));
		}
		
		private function DoubleClick():void
		{
			// this needs some checks probably so this would work at all
			// we probably need to check the type to see what were checking 
			
			if(EditElement is GeneralAnimation){
			xSheet.DoubleClick(GeneralAnimation(EditElement))
			}
			// lets for now pretend the edit element is general actor so that is fine
		}
		
		
		//************** im out of time but i need to change the z to Z in the top thingy and i need to use the xpos to the actually x in other words xpos = x etc in the book
		
		public static function InGameCamUpdate():void
		{
			
			
			//I dont knw what this is for
//			if(EditElement){
//				editing = true
//			}else{
//				
//				editing = false
//			}
				
			//EditElement.blendMode = BlendMode.BELOW
			
			if(isPlayback)
			{
				
				
			
			if(xSheet.list.selectedIndex == xSheet.animation.length -1){
				isPlayback = false;
			}else{
				
				xSheet.list.selectedIndex++
			}
			// or plus equals two whatever you want 
			}else{
				// we should probably change the state back en forth but eh.. not that big o deal
			}
			for each (var e:Object in pathnodes) 
			{
				if(e.prg < 1)
				e.prg += .010
				
				var s:Vector3 =e.path.placement(e.prg);
				e.trgt.X = s.X
				e.trgt.Y = s.Y
				e.trgt.Z = s.Z
			}
			if(liveflr2){
				for (var i:int = 0; i < groundPoints.length; i++) 
				{				
			if(groundPoints[i].Z < Main.liveCamera.pos.Z - 50 ||groundPoints[i].Z > Main.liveCamera.pos.Z + 6000)
				groundPoints[i].alpha = 0
			else
				groundPoints[i].alpha = 1
				}
		}	
			if(liveFlr){
				if (MainSceneMotor.floor.ptsArray != flrTool.curve[0])
					MainSceneMotor.floor.ptsArray = flrTool.curve[0]
					flrTool.updateBez()
			if(flrTool.drag == true)
				MainSceneMotor.floor.GroundShape(Main.liveCamera.hero_mc.body.position.x, MainSceneMotor.floorBody,false);
			}
			if(bezTool)
				bezTool.updateBez();
			//bezTool.updateBez();
			if(clickCoolDown > 0){
			clickCoolDown --;
			
			}
			if(touchCoolDown > 0){
				
				touchCoolDown --;
			
			}
			//throw Error("hgf")
			//not exactly sure what this stuff is but uh... OH YEAH I MADE THIS TO SEE IF I COULD MAKE A #D LINE WITH points holy fuck i did this shit twice
			// well ill be 
			var vpX:Number = MainSceneMotor.vpX
			var vpY:Number = MainSceneMotor.vpY
			if(bezTool)
				bezTool.onLoop()
				//square.onLoop()
			if(false){
				bezTool.drawCurve();
				if (!lineLive) 
				{
				lineLive = true;
				
				}
				//BezierCurve._control1.z += 14;
				//BezierCurve._control1.y += 2;
				//
				//points = BezierCurve.curve[0]//[BezierCurve.curve[0],BezierCurve.curve[1],BezierCurve.curve[2]];
					////trace(points, "these are the points");
//					throw Error("I really dont care what the error is" )
//					lineLive = false
			}
//			var pt:Point = new Point(Main.liveCamera.hero_mc.X,Main.liveCamera.hero_mc.Y);
//			
//				if(lineLive){
//					//bezTool.updateBez();
//					
//					var angleY:Number = 0;
//					var cosY:Number = Math.cos(angleY);
//					var sinY:Number = Math.sin(angleY);
//
//					var angleX:Number = 0;
//					var cosX:Number = Math.cos(angleX);
//					var sinX:Number = Math.sin(angleX);
//				//trace("what up");
//				
//			for (var i:int = 0; i < points.length; i++) 
//			{
//				// this is the rotating stuff so is the stuff up there i dont know why i didnt type that
//				// so i guess this is here in case i feel like rotating the camera ever
//				
//				var x1:Number = points[i].X*cosY - points[i].Z*sinY;
//				var z1:Number = points[i].Z*cosY - points[i].X*sinY;
//				
//				var y1:Number = points[i].Y*cosX - z1*sinX;
//				var z2:Number = z1*cosX+points[i].Y*sinX
//				
//				points[i].X = x1;
//				points[i].Y = y1;
//				points[i].Z = z2;
//				
//				var scale:Number = MainSceneMotor.fl/(MainSceneMotor.fl + points[i].Z)
//				points[i].x = vpX +(points[i].X - vpX)*scale;
//				points[i].y = vpY +(points[i].Y - vpY)*scale;
//			}
			
			
			
			
//			fs.graphics.clear();
//			fs.graphics.lineStyle(1,0,1);
//			fs.graphics.moveTo(points[0].x,points[0].y);
//			fs.graphics.beginFill(0xFFFFFF);
			
//			for (var j:int = 0; j < points.length; j++) 
//			{
//				s.graphics.lineTo(points[j].x, points[j].y);
//				s.graphics.drawCircle(points[j].x, points[j].y, 2*MainSceneMotor.fl/(MainSceneMotor.fl +points[j].Z));
//			}
////			 
////			//trace(points[0].x, points[0].y,"uk worked************************************************************************************************************ **********")
//				}
			
			
			if(State == Painting || Main.testing== 3 ||Main.testing== 2){
				
				
				if(shift){
					if(wkey && !skey)
						direction.Z += 5.0;
					else if(!wkey && skey)
						direction.Z +=-5.0;
					else
						direction.Z =0.0;
				}else{
					direction.Z =0.0;
					if(wkey || skey||akey||dkey){
						LevelEditor.isFollowPath = false
							LevelEditor.isFollowSonic = false
							//if(!tab)
						//LevelEditor.camera3D =  new HoverController(LevelEditor.away3dView.camera, LevelEditor.lookAtTarget, 180, 0, 900, -15, 30);
					}
					
				if(wkey && !skey){
					direction.Y -= -5.0;
				}else if(!wkey && skey && !cntrl){
					direction.Y -=5.0;
				}else{
					direction.Y =0.0;
				}	
				
				
			}
				
				// if i want to add later I can put if both are being pressed as another like speed thing, nah this multiplies the speed stuff so i cant
				
				if(cntrl && !shift)
					Main.liveCamera.rotationY +=3/50
				if(cntrl && shift)
					Main.liveCamera.rotationY -=3/50
				if(dkey && !akey)
					direction.X += 5.0;
				else if(akey && !dkey)
					direction.X += -5.0;
				else
					direction.X = 0.0;
						
				var hero:Camera3D = LevelEditor.awyCam
				var	h:Hero = Main.liveCamera.hero_mc 
				var distToSonic:Number = h.zp
				
				BezierCurve.projDist = distToSonic
				hero = null
				h = null
					if(!tab&& false){
				LevelEditor.lookAtTarget.z += direction.Z;
				LevelEditor.lookAtTarget.y += direction.Y;
				LevelEditor.lookAtTarget.x += direction.X;
					}else{
						//LevelEditor.awyCam.z += direction.Z;
						
						LevelEditor.awyCam.x += (direction.Z*LevelEditor.awyCam.forwardVector.x);
						LevelEditor.awyCam.y += (direction.Z*LevelEditor.awyCam.forwardVector.y);
						LevelEditor.awyCam.z += (direction.Z*LevelEditor.awyCam.forwardVector.z);
						
						LevelEditor.awyCam.y += direction.Y;
						
						//LevelEditor.awyCam.x += direction.X;
						
						LevelEditor.awyCam.x += (direction.X*LevelEditor.awyCam.rightVector.x);
						LevelEditor.awyCam.y += (direction.X*LevelEditor.awyCam.rightVector.y);
						LevelEditor.awyCam.z += (direction.X*LevelEditor.awyCam.rightVector.z);
						
					}
			
				if(camvas||Main.testing== 2 && EditElement && !cntrl && EditElement is GeneralMotor){
					var tm:Matrix = new Matrix();
						tm.scale(EditElement.scaleX,EditElement.scaleY)
						//tm.translate(EditElement.x- EditElement.width/2,EditElement.y- EditElement.height/2)
						LevelEditor.bm.transform.matrix = tm
						//GeneralMotor(EditElement).z+= 0
							var nudge:Boolean = false
						if(direction.X +direction.Y +direction.Z != 0 && nudge){
						GeneralMotor(EditElement).y += direction.Y;
						GeneralMotor(EditElement).x += direction.X;
						GeneralMotor(EditElement).zp += direction.Z;
						}
						var spd:uint = 14
					if(cpsLock){
						spd = 1
					}

				}else if(!EditElement || cntrl){
				}else{
						
						
				}
				if(State == Painting && !camvas && !cntrl){
					if(shift)
					//trace(Main.liveCamera.pos.Z, direction.Z)
					var speed:int = 10
					Main.liveCamera.speed.X  = -direction.X*speed
					Main.liveCamera.speed.Y  = -direction.Y*speed
					
				
						//trace("dangerours method")
//					MainSceneMotor.UpdateZDepth(GeneralMotor(Main.liveCamera),false)
//					Main.liveCamera.Z -= direction.Z*(speed+5)
				}
			}
			//jeez this is always playing.. thats extremely costly, I have to remeber to kill this 
			
			//**** KKIIIILLLL MMMMEEEEEEE************///e
			
			UpdateWatchlist()   
			LevelEditor.update();
		}
		
		
		private static function UpdateWatchlist():void
		{
			if(captureFrames)
			{
				FrameHandler.Update()
			}
		}
		
		/** remember it doesnt actually push the scene to flash it just updates a jsfl that flash can run as a command**/
		public static function PushSceneToFLash():void
		{
			FrameHandler.Update()
			// so its the first element in the first frame, should be sonic
			
				// the thing in key up i can search it using this
			LevelEditor.UpdateFrames(FrameHandler.frmAtbts)	
			
			FrameHandler.frmAtbts =[]
		}
		
		
		private function onLoad(e:flash.events.Event):void
		{
			var loadedText:String = URLLoader(e.target).data;
			
			//create xml from the received string
			var xml:XML = new XML(loadedText);
			
			//modify it
//			var word2:XML = <TextureAtlas/>;
			// it should be in some sort of array or something
			var stext:XML = <Subtexture/>;
			
			//dealing with attributes
//			var data:XML = <node/>;
			
			var $my_attr:String = 'name';
			stext.@[$my_attr] = 'run000substitute';			
			stext.@["x"] =  int(1400).toString();			
			stext.@["y"] = int(1200).toString();			
			stext.@["width"] = int(550).toString();			
			stext.@["height"] = int(400).toString();			
			
			
			xml.insertChildAfter(xml.SubTexture[4], stext)
			//xml.appendChild(stext);
//			var title:String = "asdasd";
//			word2.appendChild("<title>" + title + "</title>");
//			xml.appendChild(word2);
			

			
			//save it
//			var ldr:URLLoader = new URLLoader();
//			ldr.addEventListener(flash.events.Event.COMPLETE, onSave);
			if(save){
			var f:FileReference = new FileReference()
			f.save( xml, "cut2.xml" ); 
			}
			// saves under the name myXML.xml, "myXML" being your root XML node
			
			
			//listen for other events here.
//			var data:URLVariables = new URLVariables();
//			data.xml = xml.toXMLString();
//			var req:URLRequest = new URLRequest("savexml.php");
//			req.data = data;
//			ldr.load(req);
		}
		
		private function onSave(e:flash.events.Event):void
		{
			
			//trace("save success");
		}
		
		//Keyboard junk
		
		protected function keyUp(event:KeyboardEvent):void
		{
			directionUpdate = true;
			switch(event.keyCode)
			{
				case Keyboard.ALTERNATE:
				{
					if(bezTool)
					bezTool.isInsert = false;
					
					alt = false
					
					break;
				}		
				case Keyboard.CONTROL:
				{
					
					cntrl = false;
					
					if(State == AWAY_CAM ){
						//EditElement = null
						
							LevelEditor.awyCam.rotationY = 180
							LevelEditor.awyCam.rotationX = 0
							LevelEditor.awyCam.rotationZ = 0
						}
					
					break;
				}			
				case Keyboard.EQUAL:
				{
					if(shift)
					xSheet.IncreaseHold()
					
					LevelEditor.awyCam.rotationY += 90
					
					break;
				}
				case Keyboard.MINUS:
				{
					
					if(shift)
					xSheet.DecreaseHold()
					
					
					break;
				}
				case Keyboard.TAB:
				{
					
					tab = !tab
					
					
					break;
				}
				case Keyboard.CAPS_LOCK:
				{
					
					cpsLock = !Keyboard.capsLock
					
					
					break;
				}
				case Keyboard.DELETE:
				{  
				// I should probably check the 
				 //bezTool.DeletePt()
					
					// I only got it for bezier points I think thats the only thing Ill need to delete honestly
					// im probably wrong, whatevs
					
					
					var r:int =bezTool.lstSelectedpt
					// you have to put the undo on on top seems obvious now, since you're deleting said point
					EditKeyHandler.undoList.push({inc:4, point:{x:bezTool.bezierPts[r].X,y:bezTool.bezierPts[r].Y,z:bezTool.bezierPts[r].Z},cntrl1:{x:bezTool.bCntrlPts[r*2].X,y:bezTool.bCntrlPts[r*2].Y,z:bezTool.bCntrlPts[r*2].Z},cntrl2:{x:bezTool.bCntrlPts[r*2+1].X,y:bezTool.bCntrlPts[r*2+1].Y,z:bezTool.bCntrlPts[r*2+1].Z}, insert:r, bez:bezTool});

					bezTool.removeChild(bezTool.bezierPts[r])
					bezTool.bezierPts.splice(r,1)
					bezTool.removeChild(bezTool.bCntrlPts[r*2])
					bezTool.bCntrlPts.splice(r*2,1)
					// ok this is a bit tricky but when you think about it it makes sense
					//when you got rid of the first one you have to get rid of it again because it goes down
					// so youd expect this to be r*2+1 but it ends up just being the same thing again cuz youve gotten rid of the other,
					//conversly to make this make sense you could get rid of the higher one first
					bezTool.removeChild(bezTool.bCntrlPts[r*2])
					bezTool.bCntrlPts.splice(r*2,1)
					bezTool.drawCurve();
					bezTool.updateBez();
					

					break;
					
				}
				case Keyboard.ESCAPE:
				{  
					escapeFunc()
					Esc = false;
					
					break;
				}
				case Keyboard.Q:
				{
					
					qButton = false;
					
					break;
				}	
				case Keyboard.Z:
				{
					
					//down =  false;
					
					if(cntrl){
						undo();
					}
					break;
				}
				case Keyboard.Y:
				{
					
					//down = false;
					
					if(cntrl){
						redo();
					}
					break;
				}
				case Keyboard.L:
				{
					
					//down = false;
					if(shift)  
					{
						if(liveflr2 == true){
								
							// an optimized solution of using he old points is just unnecessary since im lazy and is editing
							for each (var j:Scenary in groundPoints) 
							{
								j.Destroy()
							}
							groundPoints = []
						}else{
							liveflr2 = true
						}
						//bezTool.onPointDown(Director.floorpts[0].x,Director.floorpts[0].Y,Director.floorpts[0].Z)
						//bezTool.makeBez(Director.floorpts)
					
						lineSet.removeAllSegments()
						
						
						
						for (var i:int = 1; i < Director.floorpts.length; i++) 
						{
							// needs to be moved but we'll deal with it laterrrrrrr....
							//LevelEditor.
							
							//groundPoints.push(Main.liveCamera.addNewScenary(Director.floorpts[i].X,Director.floorpts[i].Y,Director.floorpts[i].Z,new Image(Assets.getTexture("Circle")),"",true))
							//groundPoints[i].scaleZ = 20
							
						//lineSet.addSegment(MainSceneMotor.project2Point(new Vector3D(Director.floorpts[i-1].X,Director.floorpts[i-1].Y,Director.floorpts[i-1].Z)),MainSceneMotor.project2Point( new Vector3D(Director.floorpts[i].X,Director.floorpts[i].Y,Director.floorpts[i].Z)),Color.PURPLE);		
						
						}
						//lineSet.removeAllSegments()
						//LevelEditor.away3dView.scene.addChild(lineSet);
						someBull = false
						
					}else{
						EditKeyHandler.State = 1;
						bezTool.CreateBez(ResourceManager.myCurvePts)
					}
					break;
				}
				case Keyboard.C:
				{
					if(State == SELECT){
					if(cntrl){
						
									elz = GeneralMotor(EditElement).z2
									trace("localZ offset set ", elz)
					}
					}
					break;
				}
//				case Keyboard.G:
//				{
//					if(cntrl){
//						addCamPt()
//					}
//					break;
//				}
				case Keyboard.V:
				{
					
					if(cntrl && elz != 0){
						paste()
					}
					
					
					
					if(!cntrl){
						// when you assign it to a path assign editlinkpaArryto the path and kill it, this also needs to be written/saved as well later
						
						// it will be this eventually but for now
						//bezTool.MakeBez(LevelEditor.awyCam.x,LevelEditor.awyCam.y,LevelEditor.awyCam.z)
						if(!EditLink){
						Director.camlinkpair.push({val:Main.liveCamera.hero_mc.body.position.x, path:bezTool.bezierPts.length *bezTool.curvePoints})
						Director.camRotation.push({val:Main.liveCamera.hero_mc.body.position.x, path:bezTool.bezierPts.length})

						Director.camRotLink.push({X:LevelEditor.awyCam.rotationX,Y:LevelEditor.awyCam.rotationY,Z:LevelEditor.awyCam.rotationZ})
						bezTool.MakeBezierPt(LevelEditor.awyCam.x,LevelEditor.awyCam.y,LevelEditor.awyCam.z,true)
						Director.Campath = bezTool.curve[0]	
						}else{
							if(!isStartedEdit){
								EditKeyHandler.State = 1;
								bezTool.CreateBez(ResourceManager.camPathPts);
								isStartedEdit = true
								bezTool.type = CamPath
							}
							
							
//							Director.camlinkpair =  editlinkpaArry
//							Director.camRotation = editCamRot
//							Director.camRotLink = editCamRotLink
							
						if(Director.camRotation.length == 0){
							for (var k:int = 0; k < Director.camlinkpair.length; k++) 
							{
								Director.camRotation[k] = {X:LevelEditor.awyCam.rotationX,Y:LevelEditor.awyCam.rotationY,Z:LevelEditor.awyCam.rotationZ}
								Director.camRotLink[k] = {val:Director.camlinkpair[k].val, path:k}
							}
							
						}
						Director.camRotLink[edtSelected].val = Main.liveCamera.hero_mc.body.position.x
						Director.camlinkpair[edtSelected].val = Main.liveCamera.hero_mc.body.position.x
//						var pnts:Vector3 = new Vector3()
						Director.camRotation[edtSelected].X = LevelEditor.awyCam.rotationX
						Director.camRotation[edtSelected].Y = LevelEditor.awyCam.rotationY
						Director.camRotation[edtSelected].Z = LevelEditor.awyCam.rotationZ
						//Director.camRotation[edtSelected] = {X:LevelEditor.awyCam.rotationX,Y:LevelEditor.awyCam.rotationY,Z:LevelEditor.awyCam.rotationZ}
						bezTool.bezierPts[edtSelected].X = LevelEditor.awyCam.x
						bezTool.bezierPts[edtSelected].Y = LevelEditor.awyCam.y
						bezTool.bezierPts[edtSelected].Z = LevelEditor.awyCam.z
						
						bezTool.bCntrlPts[2*edtSelected].X = LevelEditor.awyCam.x
						bezTool.bCntrlPts[2*edtSelected].Y = LevelEditor.awyCam.y
						bezTool.bCntrlPts[2*edtSelected].Z = LevelEditor.awyCam.z
							
						bezTool.bCntrlPts[2*edtSelected+1].X = LevelEditor.awyCam.x
						bezTool.bCntrlPts[2*edtSelected+1].Y = LevelEditor.awyCam.y
						bezTool.bCntrlPts[2*edtSelected+1].Z = LevelEditor.awyCam.z
						
						Director.Campath = bezTool.curve[0]	
							//LevelEditor.isFollow = true
								//EditLink = false
						}
						
						
						
						
					}
					break;
				}
				case Keyboard.W:
				{
					wkey = false
					break;
				}
				case Keyboard.A:
				{
					akey = false
					break;
				}
					
				case Keyboard.B:
				{
					var hero:Hero = Main.liveCamera.hero_mc
					Main.liveCamera.addNewBaddie(hero.body.position.x ,hero.body.position.y - 20,hero.localZ,[])
					break;
				}
				case Keyboard.P:
				{
					EditKeyHandler.State = 1;
					// we need to check if were making a path if we are not we go into the path making mode, disabling// or for now ignoring the mouse and then immediately creating this next line
					// we just have to go into the bezier creation mode with a few modifications
					hero = Main.liveCamera.hero_mc
					bezTool.MakeBezierPt(hero.X,hero.Y,hero.Z)
					pathTool.isderivedPath = true
					// im guessing the distance should be the same since well the distance is the same but who knows right
					pathTool.derivedPath.push({X:hero.body.position.x,Y:hero.body.position.y,Z:hero.localZ,D:bezTool.bezierPts[bezTool.bezierPts.length - 1].D})
						// = bezTool.bezierPts
					
					break;
				}
				case Keyboard.D:
				{
					dkey = false
					break;
				}
				case Keyboard.X:
				{
					if(Main.testing <= 3)
						Main.testing++
					else
						Main.testing = 1
				}
				case Keyboard.S:
				{
					skey = false
					
					//down = false;
					
						
					if(cntrl){
						SaveScene()
						saveItems();
					}
					break;
				}
				
					
				case Keyboard.LEFT:
				{
					left = false;
					break;
				}
				case Keyboard.RIGHT:
				{
					right = false;
					break;
				}
				case Keyboard.UP:
				{
					up = false;
					break;
				}
				case Keyboard.DOWN:
				{
					down = false;
					break;
				}
				case Keyboard.SHIFT:
				{
					shift = false;
					break;
				}
				case Keyboard.NUMBER_1:
				{
					if(shift && nmbr1){
						
					Shift1();
					trace("captcha frames");
					pressedS1++
					if(pressedS1 == 2){
					 LevelEditor.UpdateFrames(FrameHandler.frmAtbts)
					 LevelEditor.DepricatedUpdateFrames(FrameHandler.frmAtbts)
						 pressedS1 = 0
					}else{
						switchMenu()
					}
					}else if(!shift){	
					number1();
					}
					
					nmbr1 = false;
					break;
				}
				case Keyboard.NUMBER_0:
				{
					if(shift){
					LevelEditor.PutBack(FrameHandler.frmAtbts, index)
					}
					break;
				}
				case Keyboard.NUMBER_2:
				{
					if(shift && nmbr2)
					Shift2();
					else if(!shift)	
					number2();
					if(xSheet.list)
						var index:int = xSheet.list.selectedIndex
					else
						index = 0

					
					nmbr2 = false;
					break;
				}
				case Keyboard.NUMBER_3:
				{
					if(shift && nmbr3)
					Shift3();
					else if(!shift)	
						number3();
					
					nmbr3 = false;
					break;
				}
				case Keyboard.NUMBER_4:
				{
					if(shift && nmbr4)
					Shift4();
					else if(!shift)	
						number4();
					
					nmbr4 = false;
					break;
				}
				case Keyboard.NUMBER_5:
				{
					if(shift && nmbr5)
					Shift5();
					else if(!shift)	
						number5();
					
					nmbr5 = false;
					break;
				}
				case Keyboard.NUMBER_6:
				{
					if(shift && nmbr6)
					Shift6();
					else if(!shift)	
						number6();
					
					nmbr6 = false;
					break;
				}
				case Keyboard.NUMBER_7:
				{
					if(shift && nmbr7)
					Shift7();
					
					nmbr7 = false;
					break;
				}
				
				default:
				{
					directionUpdate = false;
					////trace("not directional")
					break;
				}
			}
			
			switch(event.keyCode)
			{
				case Keyboard.SPACE:
				{
					// needs some better checking but yeah
					if(State == Animation && xSheet.actor.isFrozen){
					isPlayback = !isPlayback
					
					}
					spacebar = false;
					break;
					
				}
				case Keyboard.COMMA:
				{
					comma = false;
					if(true){
						//such a weird way to do this, but it may still just work
						if(edtSelected == -1){
							for (i = 0; i < Director.camlinkpair.length; i++) 
							{
								if(Director.camlinkpair[i].val >= Main.liveCamera.hero_mc.body.position.x)
								{
									break
								}
							}
						
						edtSelected = i-1
						}else{
							edtSelected --
							if(edtSelected <0)
							edtSelected = 0
						}
						Main.liveCamera.hero_mc.body.position.x = Director.camlinkpair[edtSelected].val
						Main.liveCamera.hero_mc.body.velocity.y = 0
						if(MainSceneMotor.floor.p1.y <=MainSceneMotor.floor.p2.y)
							// this is kinda lame actually
							// i see what i did, the frame rate and animation dont sync so i had to hack aparently, very interesting solution
						Main.liveCamera.hero_mc.body.position.y = MainSceneMotor.floor.p2.Y + 35
						else
						Main.liveCamera.hero_mc.body.position.y = MainSceneMotor.floor.p1.Y	+35
						if(Director.camRotation[edtSelected]){
						LevelEditor.awyCam.rotationX = Director.camRotation[edtSelected].X
						LevelEditor.awyCam.rotationY = Director.camRotation[edtSelected].Y 
						LevelEditor.awyCam.rotationZ = Director.camRotation[edtSelected].Z 
						}
						// this doesnt work cuz it only changes the one point not all the proceeding and preceeding point from the edited point
						LevelEditor.awyCam.x = Director.Campath[edtSelected*5].X 
						LevelEditor.awyCam.y = Director.Campath[edtSelected*5].Y 
						LevelEditor.awyCam.z = Director.Campath[edtSelected*5].Z
						EditLink = true
					}else{
						commaClick();
					}
					break;
				}
				case Keyboard.PERIOD:
				{
					period = false;
					if(true){
						if(edtSelected == -1){
							for (i = 0; i < Director.camlinkpair.length; i++) 
							{if(Director.camlinkpair[i].val >= Main.liveCamera.hero_mc.body.position.x)
								{break}
							}
							
							edtSelected = i
						}else{
							edtSelected ++
						if(edtSelected > Director.camlinkpair.length - 1)
								edtSelected = Director.camlinkpair.length -1
						}
						Main.liveCamera.hero_mc.body.position.x = Director.camlinkpair[edtSelected].val
						Main.liveCamera.hero_mc.body.velocity.y = 0
						if(MainSceneMotor.floor.p1.y <=MainSceneMotor.floor.p2.y)
							Main.liveCamera.hero_mc.body.position.y = MainSceneMotor.floor.p2.Y + 35
						else
							Main.liveCamera.hero_mc.body.position.y = MainSceneMotor.floor.p1.Y	+35
						if(Director.camRotation[edtSelected]){
						LevelEditor.awyCam.rotationX = Director.camRotation[edtSelected].X
						LevelEditor.awyCam.rotationY = Director.camRotation[edtSelected].Y 
						LevelEditor.awyCam.rotationZ = Director.camRotation[edtSelected].Z 
						}
						LevelEditor.awyCam.x = Director.Campath[edtSelected*5].X 
						LevelEditor.awyCam.y = Director.Campath[edtSelected*5].Y 
						LevelEditor.awyCam.z = Director.Campath[edtSelected*5].Z
						EditLink = true
					}else{
						periodClick();
					}
					break;
				}
				case Keyboard.ENTER:
				{
//					registerClassAlias("BezierCurve", BezierCurve);
//					var so:SharedObject = SharedObject.getLocal("everythingfla","/");
				//var floor:Dictionary = (so.data)
//					so.data.floor["other"] = "other"
//					//trace(so.data.floor["other"], so.data.floor["test2"])
					//registerClassAlias("EditKeyHandler", EditKeyHandler);
					
					
					if(shift)
					Main.liveDirector.nextScene()
//					if(so.data.floor != null)
//					EditKeyHandler.flrTool = (so.data.floor["test1"] as BezierCurve);

					if(MainSceneMotor.FreezeMotor == true){
						
						MainSceneMotor.FreezeMotor = false
							
					}
						
					// id rather use shift n but this is fine for testing
					if(false){///xSheet.naming){
					xSheet.ReturnClicked();
					return;
					}
					if(enter && EditKeyHandler.State == Painting){
						if(!camvas){
						
						camvas = true;
						LevelEditor.bm.bitmapData = Assets.bitmap[GeneralMotor(EditElement).name].bitmapData
						LevelEditor.bm.x = EditElement.x + Main.liveCamera.x
						LevelEditor.bm.y = EditElement.y +Main.liveCamera.y
						LevelEditor.bm.scaleX = EditElement.scaleX 
						LevelEditor.bm.scaleY = EditElement.scaleY 
						LevelEditor.bm.alpha = .7;	
						if(GeneralMotor(EditElement).name =="blankImage" ){
							GeneralMotor(EditElement).name =  Director.currSceneName+"scenary00"+Main.liveCamera.getChildIndex(EditElement).toString()
						}
						//var editingItem:GeneralMotor =  GeneralMotor(EditElement)
							//throw Error("WJATA UP")
						
						}else{
							editedImages.push({bitmapData:LevelEditor.bm,name:GeneralMotor(EditElement).name})
							var byteArray:ByteArray = PNGEncoder.encode(LevelEditor.bm.bitmapData);
							
							
							savePNG(byteArray,GeneralMotor(EditElement).name) 
							if(EditElement is Scenary){
								//Main.liveCamera.addNewScenary(Scenary(EditElement).X,Scenary(EditElement).Y,Scenary(EditElement).Z,new Image(Texture.fromBitmap(LevelEditor.bm,false)),"ese");
								Scenary(EditElement).removeChild(Scenary(EditElement).imge, true) 
								Scenary(EditElement).imge = new Image(Texture.fromBitmap(LevelEditor.bm,false))
								Scenary(EditElement).imge.x = 0;
								Scenary(EditElement).imge.y = 0;
								Scenary(EditElement).addChild(Scenary(EditElement).imge)
								Scenary(EditElement).imge.alignPivot("center","center")	
								Assets.bitmap[GeneralMotor(EditElement).name] = LevelEditor.bm
								//Scenary(EditElement).imge = new Image(Texture.fromBitmap(LevelEditor.bm,false))
							}
							LevelEditor.bm.alpha = 0;
							camvas = false;
						}
						// hopefully that should do it, it might need help but i dunno
					// ReturnClick(GeneralActor(EditElement).movie);
					}
					enter = false;
					break;
				}
			}
			
			if(directionUpdate)
				UpdateDirection();
		}
		//If i need it i will add the distance live but hopefully i wooont
		private function addCamPt():void
		{
//			cmpthDis+=
//			Math.sqrt((Director.floorpts[i].X - Director.floorpts[i-1].X)*(Director.floorpts[i].X - Director.floorpts[i-1].X)+(Director.floorpts[i].Z - Director.floorpts[i-1].Z)*(Director.floorpts[i].Z - Director.floorpts[i-1].Z))
			Director.Campath.push({X:LevelEditor.awyCam.x,Y: LevelEditor.awyCam.y,Z:LevelEditor.awyCam.z,D:0})
			Director.camlinkpair.push({val: Main.liveCamera.hero_mc.x, path:Director.camlinkpair.length})
		
			Director.camRotation.push({X:LevelEditor.awyCam.rotationX,Y: LevelEditor.awyCam.rotationY,Z:LevelEditor.awyCam.rotationZ,D:0})
			Director.camRotLink.push({val: Main.liveCamera.hero_mc.x, path:Director.camlinkpair.length})
		
		
		}
		// okay increase hold decrease hold and insert frame are all bitches
		// like everything in programming that sounds easy it actually has some
		// hidden complexity and considering i already gave up once with dealing with the
		// list i may consider ditching the thing entirely to write my own it 
		// may take less time but we'll try dealing with this first
		// basically increase hold if its on insert is simple it just puts new frames in a none frame dependent manner, its more work then needed and the result is iffy, just it on twos to get a more realistic feel
		// override however respects the placement of the frames via framerate so 
		// it plays back as if it were the original at the time
		// they are all holds by default, just to make it more work to be lazy
		// so the one we really have to work on is getting insert working
		public static function increaseHold():void
		{
			throw Error("don't call")
			// we also have to check if were at the end otherwise this will break
			var actr:Object = xSheet.frames[xSheet.list.selectedIndex];
			if(xSheet.keyFrames[actr.anim] == undefined)
			{
			
			xSheet.keyFrames[actr.anim] = [actr.frame,actr.frame+1];
			xSheet.writeFrameToMemory(actr,xSheet.list.selectedIndex +1, actr.frame+1)
			}else{
				for (var i:int = 0; i < xSheet.keyFrames[actr.anim].length; i++) 
				{
					if(xSheet.keyFrames[actr.anim][i] <= actr.frame){
						xSheet.keyFrames[actr.anim] = xSheet.keyFrames[actr.anim][i+1];
						var dif:int = xSheet.keyFrames[actr.anim][i+1] - actr.frame;
						xSheet.writeFrameToMemory(actr,xSheet.list.selectedIndex +dif, actr.frame+dif)
					}
				}
				if(i == xSheet.keyFrames.length)
					xSheet.keyFrames.push(actr.frame)
			}
		}
		public static function decreaseHold():void
		{
			
		}
		private function reverse():void
		{
			var actr:Object = xSheet.frames[xSheet.list.selectedIndex];
			
			if(xSheet.keyFrames[actr.anim] && !shift)
			{
				
				
				// assume keyframes is [3,5] and our index is at 3 it goes one down
				for (var i:int = xSheet.keyFrames[actr.anim].length-1; i > -1; i--) 
				{
					// we do this to say hey if the first keyframe is greater than one or zero whatever just go down one and dont bother with the aray
					if(xSheet.keyFrames[actr.anim][0] >= actr.frame){
						xSheet.list.selectedIndex--
						xSheet.list.verticalScrollPosition -=24;
						break; 
					}else{
					if( xSheet.keyFrames[actr.anim][i] < actr.frame)
					{
						//throw Error("sdf")
						
						var spaces:int = 0 //= xSheet.keyFrames[actr.anim][i] - actr.frame
						
						while(xSheet.frames[xSheet.list.selectedIndex+spaces].frame >xSheet.keyFrames[actr.anim][i]){
							spaces--
						}
						xSheet.list.selectedIndex +=spaces ;
						xSheet.list.verticalScrollPosition +=24*spaces;
						break;
					}
					}
				}
				
				
			}else{
				xSheet.list.selectedIndex--
				xSheet.list.verticalScrollPosition -=24;
			}
		}
		
		private function forward():void
		{
			var actr:Object = xSheet.frames[xSheet.list.selectedIndex];
			
			if(xSheet.keyFrames[actr.anim]&& !shift)
			{
				
				
				// assume keyframes is [1,3,5] and our index is at 6 it goes one down
				for (var i:int = 0; i < xSheet.keyFrames[actr.anim].length; i++) 
				{
					// hokay what this does first is it checks if the last keyframe is less than the current frame we are in, if so, we just increment slowly up and break the array
					if(xSheet.keyFrames[actr.anim][xSheet.keyFrames[actr.anim].length-1] <= actr.frame){
						xSheet.list.selectedIndex++
						
						xSheet.list.verticalScrollPosition +=24;
						break; 
					}else{
					if( xSheet.keyFrames[actr.anim][i] > actr.frame)
					{
						
						var spaces:int = 0//= xSheet.keyFrames[actr.anim][i] - actr.frame
						// in here we need a while instead, because the reason being is we dont know when this will have the frame i want considering it could do it on ones, or twos, and two different instances will have two different frames
						//throw Error("sdf")
						// ok this works just like its supposed to, only i just didnt realize that it
						while(xSheet.frames[xSheet.list.selectedIndex+spaces].frame < xSheet.keyFrames[actr.anim][i]){
							spaces++
						}
						xSheet.list.selectedIndex += spaces;
						
						xSheet.list.verticalScrollPosition +=24*spaces;
						break;
					}
					}
				}
				
			}else{
				xSheet.list.selectedIndex++
				xSheet.list.verticalScrollPosition +=24;
			}
		}
		
		private function number3():void
		{
			State = ADDSCENE
		}
		private function number4():void
		{
			State = ADDSETPIECE
		}
		private function number5():void
		{
			State = BOX;
		}
		private function number6():void
		{
			State = Painting;
			if(lastCampos != null)
			{
				Main.liveCamera.pos.X = lastCampos.x;
				Main.liveCamera.pos.Y = lastCampos.y;
			}else{
				lastCampos = new Point()
			}
		}
		
		private function number2():void
		{
			State = BEZIER;
		}
		
		private function number1():void
		{
			State = SELECT;
			// RESET ZOOM FOR CAMERA
			Main.liveCamera.scaleX =1;
			Main.liveCamera.scaleY =1;
			if(lastCampos != null)
			{
			 lastCampos.x = Main.liveCamera.pos.X
			 lastCampos.y = Main.liveCamera.pos.Y
			}
		}
		
		private function escapeFunc():void
		{
			// everything escape does i guess
			//whatever
			if(State == BEZIER){
			bezTool.updateBez()
			BezierCurve.segs.push(new BezierCurve())
			bezTool = BezierCurve.segs[BezierCurve.segs.length -1]
			Main.liveCamera.addChild(bezTool);
			lineLive = false;
			someBull = true;
			}else if(State == Animation){
				//Main.liveCamera.hero_mc.isFrozen = true;
			}else{
				// umm trial but hopefully works
				if(EditElement){
				EditElement.blendMode =  BlendMode.AUTO;
				EditElement = null;
				}
				MainSceneMotor.mouseJoint.active = false
			}
		}
		
		private function periodClick():void
		{
			// lets just deal with the backwards way for now
			// mostly just laziness
			if(FrameHandler.DistFromLastFrame < 0)
			{
				// do something
			}
		}
		
		private function commaClick():void
		{
			FrameHandler.DistFromLastFrame --;
			// first check if frozen if not freeze 
			if(captureFrames && FrameHandler.frmAtbts.length + FrameHandler.DistFromLastFrame > 1)
			{
				captureFrames = false
			// then check what frame position were in
			ApplyAtributes();
			}
		}
		
		private function ApplyAtributes():void
		{
			// obviously this needs a for loop but for ease
			var val:Object = FrameHandler.frmAtbts[0][FrameHandler.DistFromLastFrame];
			FrameHandler.watchlist[0].body.position.x = val.x
			FrameHandler.watchlist[0].body.position.y = val.y
			FrameHandler.watchlist[0].body.velocity.x = val.yvel
			FrameHandler.watchlist[0].body.velocity.y = val.xvel
			
			// i dont think i use loops i may have remade em i dunno
			FrameHandler.watchlist[0].straightto(val.anim,false,val.frame);
			// this may be needed i dunno
			FrameHandler.watchlist[0].animationSeq.tick();
			//
			FrameHandler.watchlist[0].isFrozen
			
			
		}
//		private function addPoint(px:Number,py:Number,pz:Number):void
//		{
//			points.push({X:px,Y:py,Z:pz});
//			if(!intialized)
//			{
//				//eventually some clever array like lines but for now KISS
//				
//				intialized = true;
//			}
//			// i think i wanted to make this work on the fly i gotcha
//			// but it would use points not linpoints whatever that is
////			if(linpts.pts.length > 2)
////			{
////				Ground.ptsArray = linpts.pts
////			}
//			
//		}
		
		
		private function Shift7():void
		{
			penMode = true;
			// TODO Auto Generated method stub
			
		}
		
		private function Shift6():void
		{
			// TODO Auto Generated method stub
			// I guess we'll make this add point thingy
			
			
			
			//Main.liveCamera.addNewScenary(location.x,location.y,cam.Z,new Image(Texture.fromBitmapData(LeveLEditorTest.bm.bitmapData)));
			actorType = 2
			lineLive = true;
			
		}
		// also scenary things but whatevs
		private function addNewActor():void{
			var cam:Vector3 = cameraOrigin();
			switch(actorType)
			{
				case 0:
				{
					newRing(location.x,location.y,cam.Z);
					break;
				}
				case 1:
				{
					//should add that custom stuff there too somehow i dunno how right now though
					// it should start with the default and we override em
					newHornet(location.x,location.y,cam.Z)
					break;
				}
				case 2:
				{
					// we could try and put it here
					
					newScenary(location.x,location.y,cam.Z)
					break;
				}
					// i dunno if its supposed to be three
				case 3:
				{
				
					if(newBull){
						var cm:Vector3 = cameraOrigin()
						square.onPointDown(location.x, location.y, cm.Z + 20);
						// you have to rememebr to add this again later when your done using bezier
						//stage.removeEventListener(TouchEvent.TOUCH, touchEvent);
						square.attachedActor = newScene(location.x,location.y,cam.Z)
						// right now we only have one square to work with 
						// sooo.. we can be like stupid with this and just change its stuff
						//throw Error("sdf");
						newBull = false
					}
					
					break;
				}
				default:
				{
					break;
				}
			}
			cam = null;
		}
		
		
		private function Shift5():void
		{
			//Camera.addNewScenary();
			// test points
			
//			points[0] = {X:MainSceneMotor.vpX, Y:MainSceneMotor.vpY, Z:0, x:0,y:0}
//			points[1] = {X:MainSceneMotor.vpX+ 80, Y:MainSceneMotor.vpY+ 100, Z:100,x:0,y:0}
//			points[2] = {X:MainSceneMotor.vpX, Y:MainSceneMotor.vpY, Z:200,x:0,y:0}
//			var cam:Vector3 = cameraOrigin();
//			
//			addPoint(location.x,location.y,cam.Z);
			
			
			
			//Main.liveCamera.addNewScenary(location.x,location.y,cam.Z,new Image(Texture.fromBitmap(new BrushBm())));

			//lineLive = true;
			actorType = 3
		}
		/**eventually when I have animation on lock we'll just default to animated ones if it animates
		 * 
		 */	
		// Im disgusted that I wrote this
		private function newScenary(x:Number, y:Number, z:Number, r:Vector.<Texture> = null):void{
			
			// I have no idea what shift means I think I wanted to make it the same distance
			if(shift){
			var p:Vector3D =  LevelEditor.away3dView.unproject(location.x, location.y,GeneralMotor(lastElement).zp)
			}else{
			p =  LevelEditor.away3dView.unproject(location.x, location.y,200)
			}
			EditElement = Main.liveCamera.addNewScenary(p.x,p.y,p.z,new Image(Assets.getTexture("blankImage")),Director.currSceneName+"scenary00"+Main.liveCamera.scenary.length.toString())
			
			// this is awful cuz it creates pngs everytime i make one no matter if i save it or not, so i should fix this eventually, but for now i can just manually clean it up when i need to
			
			var byteArray:ByteArray = PNGEncoder.encode(Bitmap(Assets.bitmap["blankImage"]).bitmapData);
			
			
			savePNG(byteArray,GeneralMotor(EditElement).name)
		}
		/**
		 * line 1618 incase you get lost this class is stupid long
		 */
		private function newScene(x:Number, y:Number, z:Number):Scenes
		{
		// well its here
			return Main.liveCamera.addNewScene(x - 25,y - 25,z,45,45,45,"Scenes");
		}
		private function cameraOrigin():Vector3{
			return new Vector3(Main.liveCamera.pos.X-450,Main.liveCamera.pos.Y - 340,Main.liveCamera.pos.Z+45);
		}
		
		private function Shift4():void
		{
			// ok this is how this works you can put custom animations for each individual animations in hornet it self it takes the up animation the down the striking or whatever from this
			// if it exists if not it just uses the default, which is good for random then group dynamics whosiwhatsits handles the transitions
			actorType = 1
		}
		
		private function Shift3():void
		{
			actorType = 0
		}
		
		private function newRing(x:Number, y:Number, z:Number):void
		{
			if(shift){
				x = Main.liveCamera.hero_mc.X
				y = Main.liveCamera.hero_mc.Y
				z = Main.liveCamera.hero_mc.Z
			}
			// this is probably wrong the fact that i made a set value for what is probably the middle of the ring is soo stupid but whatevs
			Main.liveCamera.addNewRing(x - 25,y - 25,z,[],Director.rings.length);
			Director.rings.push({X:x-25,Y:y-25,Z:z})
			
			
			
		}
		private function newHornet(x:Number, y:Number, z:Number):void
		{
			Main.liveCamera.addNewBaddie(x,y,z,["temp1","temp2","temp3"],"Hornet",true,Director.baddies.length);
			Director.baddies.push({X:x,Y:y,Z:z,anim:"noAnimyet"})

		}
		
		private function Shift2():void
		{
			actorType = 2
//			var cam:Vector3 = cameraOrigin();
//			var c:SceneHandler = SceneHandler(getClassByAlias(scnName))
		}
		
		private function Shift1():void
		{
			var cam:Vector3 = cameraOrigin();
			// we need to add the width hieght and depth i dunno why i said deph but most of that makes sense
			Main.liveCamera.addNewScenary(cam.X,cam.Y,cam.Z,new Image(Texture.fromBitmapData(LevelEditor.bm.bitmapData)));
		// i was gonna erase that but it dont hurt
			// start recording
			// umm this looks 
			//like new code
			if(!captureFrames)
			{
			FrameHandler.init();
			
			}else{
				xSheet.ReturnClicked()
			}
			captureFrames =!captureFrames 
			
		}		
		
		
		protected function keyDown(event:KeyboardEvent):void
		{
			directionUpdate = true;
			switch(event.keyCode)
			{
				case Keyboard.ALTERNATE:
				{
					if(EditKeyHandler.State == BEZIER){
					bezTool.isInsert = true;
					}
					alt = true
					
					break;
				}
				case Keyboard.CONTROL:
				{
					
					cntrl = true;
					
					
					break;
				}
				case Keyboard.ESCAPE:
				{
					Esc = true;
					break;
				}
					
				case Keyboard.LEFTBRACKET:
				{
					LevelEditor.brushScale -=.05
					break;
				}
				case Keyboard.RIGHTBRACKET:
				{
					LevelEditor.brushScale +=.05
					break;
				}
				case Keyboard.DOWN:
				{
					down = true;
					break;
				}
				case Keyboard.UP:
				{
					up = true;
					break;
				}
					
				case Keyboard.LEFT:
				{
					left = true;
					break;
				}
				case Keyboard.RIGHT:
				{
					right = true;
					break;
				}
				case Keyboard.SHIFT:
				{
					shift = true;
					break;
				}
				case Keyboard.Q:
				{
					
					qButton = true;
					
					break;
				}	
				case Keyboard.F:
				{
					
					//down = false;
					
					if(EditKeyHandler.State == EditKeyHandler.Animation){
						if(xSheet.list.selectedIndex)
							reverse()
						
					}
					break;
				}
				case Keyboard.W:
				{
					wkey = true
					break;
				}
				case Keyboard.A:
				{
					akey = true
					break;
				}
				case Keyboard.S:
				{
					skey = true
					break;
				}
				case Keyboard.D:
				{
					dkey = true
					break;
				}
				case Keyboard.G:
				{
					
					//down = false;
					
					if(EditKeyHandler.State == EditKeyHandler.Animation){
						if(xSheet.list.selectedIndex)
							forward()
							
					}
					break;
				}
				
				case Keyboard.N:
				{
					if(shift)
					xSheet.NewAnimation(GeneralAnimation(EditElement))
					
					
					break;
				}
					
				case Keyboard.NUMBER_1:
				{
					nmbr1 = true;
					break;
				}
				case Keyboard.NUMBER_2:
				{
					
						
					nmbr2 = true;
					break;
				}
				case Keyboard.NUMBER_3:
				{
					nmbr3 = true;
					break;
				}
				case Keyboard.NUMBER_4:
				{
					nmbr4 = true;
					break;
				}
				case Keyboard.NUMBER_5:
				{
					nmbr5 = true;
					break;
				}
				case Keyboard.NUMBER_6:
				{
					nmbr6 = true;
					break;
				}
				case Keyboard.NUMBER_7:
				{
					nmbr7 = true;
					break;
				}
				case Keyboard.COMMA:
				{
					comma = true;
					break;
				}
				case Keyboard.PERIOD:
				{
					period = true;
					break;
				}
					
				default:
				{
					directionUpdate = false;
					////trace("not directional")
					break;
				}
			}
			
			
			switch(event.keyCode)
			{
				case Keyboard.SPACE:
				{
					spacebar = true;
					break;
				}
				case Keyboard.ENTER:
				{	
					enter = true;
					break;
				}
			}
			
			if(directionUpdate)
				UpdateDirection();
			
		}		
		
		private function UpdateDirection():void
		{
			if(up && !down)
				direction.y = -1.0;
			else if(!up && down)
				direction.y=1.0;
			else
				direction.y =0.0;
			
			// if i want to add later I can put if both are being pressed as another like speed thing, nah this multiplies the speed stuff so i cant
			
			Director
			if(right && !left)
				direction.x = 1.0;
			else if(left && !right)
				direction.x = -1.0;
			else
				direction.x = 0.0;
		}
		
		public function get direction():Point
		{
			return _direction;
		}
		
		public function set direction(value:Point):void
		{
			_direction = value;
		}

		public function get scnName():String
		{
			return _scnName;
		}

		public function set scnName(value:String):void
		{
			_scnName = value;
		}

		public function get scnWidth():Number
		{
			return _scnWidth;
		}

		public function set scnWidth(value:Number):void
		{
			_scnWidth = value;
		}

		public function get scnHeight():Number
		{
			return _scnHeight;
		}

		public function set scnHeight(value:Number):void
		{
			_scnHeight = value;
		}

		public function get scnDepth():Number
		{
			return _scnDepth;
		}

		public function set scnDepth(value:Number):void
		{
			_scnDepth = value;
		}
		
		
		
		
		public static function SwapOutMainEditor():void
		{
			
			
		}
	}
}