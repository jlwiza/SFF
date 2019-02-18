package
{
	import com.gskinner.utils.SWFBridgeAS3;
	import com.gskinner.utils.TwoWayLocalConnection;
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;
	import com.jonLwiza.engine.baseConstructs.SceneHandler;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.engine.BreakOpportunity;
	import flash.utils.Timer;
	
	import mx.core.BitmapAsset;
	
	import adobe.utils.MMExecute;
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.FollowController;
	import away3d.controllers.HoverController;
	import away3d.controllers.LookAtController;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.core.math.Matrix3DUtils;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.entities.SegmentSet;
	import away3d.events.Stage3DEvent;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.LineSegment;
	import away3d.primitives.WireframePlane;
	import away3d.textures.BitmapTexture;
	
	import awayphysics.collision.shapes.AWPBoxShape;
	import awayphysics.debug.AWPDebugDraw;
	import awayphysics.dynamics.AWPDynamicsWorld;
	import awayphysics.dynamics.AWPRigidBody;
	
	import starling.core.Starling;
	import starling.events.EnterFrameEvent;
	import starling.utils.Color;
	
	
	
	//oa3c of starling // height used to be 480 added a bit for the header strip
	[SWF( width="848", height="480")]		
	public class LevelEditor extends Sprite 
	{
		
		[Embed(source="Circle.png", mimeType="image/png")]
		private var BrushBm : Class;
		// I changed this from Bitmap Asset im not sure why it was that to begin with but uh seems to be working fine
		private var _brushPart:Bitmap = new BrushBm();
		private var _brush2Part:Bitmap = new BrushBm();
		
		private var _canvas : Sprite;
		private static var _brush : Sprite;
		private static var scale_brush:Number = .6;
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
		public static var away3dView : View3D;
		
		// Camera controllers 
		public static var camera3D : LookAtController;
		
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
		private var canvasOn:Boolean = true;
		private var painting:Boolean = true;
		private var oldBit:BitmapData;
		public static var connToGame:LocalConnection;
		private static var coolDown:int = 0;
		public static var module:*
		public static var liveEdit:Boolean = false;
		private var count:int = 0;
		public static var eraser:Boolean;
		public static var brushScale:Number = 1;
		private var _scene:Scene3D;

		//private var myBridge:SWFBridgeAS3
		private const _debug:Boolean = false;
//		private var _debugDraw:AWPDebugDraw;
//		public static  var _physicsWorld:AWPDynamicsWorld;
		private var startthis:Boolean = false;
		public static var awyCam:Camera3D;

		public static var testthing12:Vector3D;
		public static var lookAtTarget:ObjectContainer3D = new ObjectContainer3D;
		public static var isFollowPath:Boolean = true;
		public static var isFollowSonic:Boolean = false;
		private var once:Boolean = false;
		public static var onPath:Boolean = true;
		private var oldRot:Number;
		private var snehndlr:SceneHandler
		public static var perpRtYCos:Number;
		public static var perpRtYSin:Number;
		public static var connToEmisry:LocalConnection;
		public var c:int = 4;
		private var con:TwoWayLocalConnection;
		private var calledAddScenary:Boolean = false
		private var startCount:int = 99;
	
		private var bodyY:Number;
		private var cam:Vector3D = new Vector3D();
		private var camRot:Vector3D = new Vector3D();
		private var blnk:Scenary  = new Scenary()
		private var myScale:Number;
		
		public function LevelEditor()
		{
//			connToGame = new LocalConnection();
//			var fl:File = new File(File.userDirectory.nativePath+"/Google Drive/StarlingProject/")
//			trace(fl.url)
//			trace(fl.url)
//			trace(fl.url)
//			trace(fl.url)
//			// i also commented this next 2 line out
//				
//			 connToGame.client = this
//			 connToGame.allowDomain("*");
////			
//
//			//stage.nativeWindow.
//			stage.nativeWindow.alwaysInFront = true;
//			connToGame.connect("_ToGame");
			
			con = new TwoWayLocalConnection("_F",this)

			
//			connToEmisry = new LocalConnection()
//				trace("re232ss")
//			if(true){
//				
//					connToGame.close()
//				
//				connToEmisry.send("_ToEmisry", "updateChildren")//,Main.liveCamera.scenary)
//			
//					connToGame.connect("_ToGame")
//			}

			
			
			
			// I added these 2 lines
//			conn.addEventListener(StatusEvent.STATUS, onLcStatus)
//
//			conn.send("_modeServer", "moduleUpdate");

			//_bambooDockBridge = new BambooMiniImpl(this, new FlashFactory(new ChromeSettings(false)));
			
			// this is all you need its pretty awesom and you can put it anywhere
			////trace(BambooMiniGlobals.tabletState.penPressure);
			
			Main.Release = false
				
			init();
			//var star:Starling = new Starling(FeatherMain, stage)
			//star.start();
			//your paintness
			
			// this is the brush
		addEventListener(Event.ADDED_TO_STAGE, ready);
		stage.nativeWindow.addEventListener(Event.CLOSING, weAreClosing)
			
			
		}
		
		
		private function initProxies():void
		{
			// Define a new Stage3DManager for the Stage3D objects
			stage3DManager = Stage3DManager.getInstance(stage);
			
			// Create a new Stage3D proxy to contain the separate views
			stage3DProxy = stage3DManager.getFreeStage3DProxy();
			stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
			stage3DProxy.antiAlias = 8;
			stage3DProxy.color = Color.GRAY;
		}
		
		protected function weAreClosing(event:Event):void
		{
			con.close()
			// TODO Auto-generated method stub
			
		}		
		
		
		public function test(v:Vector3D):void{
			trace("and Im testing you");
			//con.send("test",32)
		}
		public function getSceneObjects():void{
			 con.send("updateChildren",Main.liveCamera.scenary);
		}
		public function getWatchList(bods:Boolean = false):void{
			if(!bods){
			UpdateFrames(FrameHandler.frmAtbts);
			}else{
				UpdateFrames(FrameHandler.frmAtbts, MainSceneMotor.floor.ptsArray)
			}
			
			
			// not sure what this does hmm.. 
					 
						 
						
			
		}
		
		public static function NamedText(image:String, interp:int = 1000):String
		{
			
			if(interp >1000)
				throw Error("typical atlases are too small to handle cases over 1000, hence it is silly to support this many frames in a single animation, consider a movie or breaking it up")
			//			if(interp == 0)
			//				return false;
			if(interp == 1000){
				// just means its not an animation
				var stepimage:String = image;
			}
			else if(interp< 10)
				stepimage = image +"000"+interp.toString()
			else if (interp>= 10 && interp <100)
				stepimage = image +"00"+interp.toString()
			else
				stepimage = image +"0"+interp.toString()
			return stepimage
		}
		
		
		// so pressing shift+0 starts the capture in frame capture ness then i press it again to get the data and put it to file
		public static function PutBack(fmsList:Array = null, frame:int = 0):void
		{
			var fc:Array = fmsList[frame]
			var wlist:Array = FrameHandler.watchlist
				
			// and thats it reaaally really simple
			Main.liveCamera.hero_mc.bdy.x = fc[0].bodyx
			Main.liveCamera.hero_mc.bdy.y = fc[0].bodyy
				
			for (var i:int = 1; i < fc.length; i++) 
			{
				// if somethng goes wrong in this reaaallly simple code is because i didnt want to be reduntant with watchlist sooo yeah its hizeire its easy honestly
				// real simple first i dont even put in its umm accelaration or velocity, we'll just set that to 0 
				
				
				wlist[i].X =fc[i].X
				wlist[i].Y =fc[i].Y
				wlist[i].Z =fc[i].Z
					
				//mm i think thats it ooh i should probably put sonic back on the path
			}
			
		}
		
			// I changed things apparently I realized that going through module was dumb... HURRAY
			// so pressing shift+1 starts the capture in frame capture ness then i press it again to get the data and put it to file
			
		public static function UpdateFrames(fmsList:Array = null, ground:Array = null):void
		{
			var preHead:String  = ""
			// now we wanna just make sure the exporter will be able to export the thing to the exact spot its supposed to so for every element besides sonic we just export an unprojected x y based upon its z depth and cam 
			// we have to push the cam orientation and position every frame 
			// i should fix this and make this complete
			
			
				var el:Object = fmsList[0][0]
			
			var animName:String = el.anim
			var xp:Number = el.x;
			var yp:Number = el.y;
			var scale:Number = el.scale
			var bodyx:Number = el.bodyx;
			// for these your gonna wanna change these to the camera position instead, real world i wouldnt want to put the camera position on this but i dont know if its a viable option otherwise, soo yeah..
			// I can add a z component but i shouldnt need to as long as the math is the same but before flash was acting strange and didnt have the same answer but yeahh we can take the chance
			var Ypos:Number = el.Y;
			var Xpos:Number = el.X;
			var zDepth:Number = el.z;
			var camX:Number = el.camrax 
			var camY:Number = el.camray
			var camZ:Number = el.camraz
			var camXrot:Number = el.camraXrot
			var camYrot:Number = el.camraYrot
			var camZrot:Number = el.camraZrot
			// the hornet code is basically a copy and paste job of this code only i put honet and its first order index next to it in place of hero
			// you coul look for  <layers> and start writing after that
			var nextFrme:String = ""
			var frstFrme:String ="                     <DOMLayer name=\"hero\" color=\"#9933CC\" autoNamed=\"false\">\n"
			
			frstFrme+="                         <frames>\n"
			frstFrme+="                              <DOMFrame index=\"0\" keyMode=\"9728\">\n"
			frstFrme+="                                   <elements>\n"
			frstFrme+="                                        <DOMSymbolInstance libraryItemName=\""+animName+"\" symbolType=\"graphic\" loop=\"loop\">\n"
			frstFrme+="                                             <matrix>\n"
			frstFrme+="													<Matrix a=\""+scale+"\" d=\""+scale+"\" tx=\""+xp+"\" ty=\""+yp+"\"/>\n"
			frstFrme+="                                             </matrix>\n"
			frstFrme+="                                             <transformationPoint>\n"
			frstFrme+="                                                  <Point x=\"0.1\"/>\n"
			frstFrme+="                                             </transformationPoint>\n"
			frstFrme+="                                             <persistentData>\n"
			frstFrme+="                                                  <PD n=\"bodyx\" t=\"d\" v=\""+bodyx+"\"/>\n"
			frstFrme+="                                                  <PD n=\"Ypos\" t=\"d\" v=\""+Ypos+"\"/>\n"
			frstFrme+="                                                  <PD n=\"Xpos\" t=\"d\" v=\""+Xpos+"\"/>\n"
			frstFrme+="                                                  <PD n=\"zDepth\" t=\"d\" v=\""+zDepth+"\"/>\n"
			frstFrme+="                                                  <PD n=\"camX\" t=\"d\" v=\""+camX+"\"/>\n"
			frstFrme+="                                                  <PD n=\"camY\" t=\"d\" v=\""+camY+"\"/>\n"
			frstFrme+="                                                  <PD n=\"camZ\" t=\"d\" v=\""+camZ+"\"/>\n"
			frstFrme+="                                                  <PD n=\"camXrot\" t=\"d\" v=\""+camXrot+"\"/>\n"
			frstFrme+="                                                  <PD n=\"camYrot\" t=\"d\" v=\""+camYrot+"\"/>\n"
			frstFrme+="                                                  <PD n=\"camZrot\" t=\"d\" v=\""+camZrot+"\"/>\n"
			frstFrme+="                                             </persistentData>\n"
			frstFrme+="                                        </DOMSymbolInstance>\n"
			frstFrme+="                                   </elements>\n"
			frstFrme+="                              </DOMFrame>\n"
			
			var j:int = 0
			var frm:int = 1
				// its element based, its each element i, and j represents i represents the frame
			for (var i:int = 0; i <fmsList.length; i++) 
			{// i may wanna change it 
				
				for (j = 1; j <  fmsList[0].length; j++) 
				{
					//trace(j)
					// we switch the reg order because we have to itterate consistant element not through the frame, because there is only one element i want in that layer
					// in the next one i dont reverse the j i
					
					el = fmsList[i][j]
				if(el.type != "Hero" || el.type == "")
					continue;
				
				
				frm = j
				xp = el.x;
				yp = el.y;
				scale = el.scale
				bodyx = el.bodyx;
				// for these your gonna wanna change these to the camera position instead, real world i wouldnt want to put the camera position on this but i dont know if its a viable option otherwise, soo yeah..
				// I can add a z component but i shouldnt need to as long as the math is the same but before flash was acting strange and didnt have the same answer but yeahh we can take the chance
				Ypos = el.Y;
				Xpos = el.X;
				zDepth = el.z;
				camX= el.camrax 
				camY= el.camray
				camZ= el.camraz
				camXrot= el.camraXrot
				camYrot= el.camraYrot
				camZrot= el.camraZrot
				animName = el.anim
				
				
				
				nextFrme+="				<DOMFrame index=\""+frm+"\" duration = \"1\" keyMode=\"9728\">\n"
				nextFrme+="                                   <elements>\n"
				// try and get rid of the 3DX and other stuff 3DY
				nextFrme+="                                        <DOMSymbolInstance libraryItemName=\""+animName+"\" symbolType=\"graphic\" centerPoint3DX=\""+xp+"\" centerPoint3DY=\""+yp+"\" loop=\"loop\">\n"
				nextFrme+="                                             <matrix>\n"
				// try and get rid of the a and d i dunno what they do and the 
				nextFrme+="                                                  <Matrix a=\""+scale+"\" d=\""+scale+"\" tx=\""+xp+"\" ty=\""+yp+"\"/>\n"
				nextFrme+="                                             </matrix>\n"
				nextFrme+="                                             <transformationPoint>\n"
				nextFrme+="                                                  <Point x=\"0.1\"/>\n"
				nextFrme+="                                             </transformationPoint>\n"
				nextFrme+="                                             <persistentData>\n"
				nextFrme+="                                                  <PD n=\"bodyx\" t=\"d\" v=\""+bodyx+"\"/>\n"
				nextFrme+="                                                  <PD n=\"Ypos\" t=\"d\" v=\""+Ypos+"\"/>\n"
				nextFrme+="                                                  <PD n=\"Xpos\" t=\"d\" v=\""+Xpos+"\"/>\n"
				nextFrme+="                                                  <PD n=\"zDepth\" t=\"d\" v=\""+zDepth+"\"/>\n"
				nextFrme+="                                                  <PD n=\"camX\" t=\"d\" v=\""+camX+"\"/>\n"
				nextFrme+="                                                  <PD n=\"camY\" t=\"d\" v=\""+camY+"\"/>\n"
				nextFrme+="                                                  <PD n=\"camZ\" t=\"d\" v=\""+camZ+"\"/>\n"
				nextFrme+="                                                  <PD n=\"camXrot\" t=\"d\" v=\""+camXrot+"\"/>\n"
				nextFrme+="                                                  <PD n=\"camYrot\" t=\"d\" v=\""+camYrot+"\"/>\n"
				nextFrme+="                                                  <PD n=\"camZrot\" t=\"d\" v=\""+camZrot+"\"/>\n"
				nextFrme+="                                             </persistentData>\n"
				nextFrme+="                                        </DOMSymbolInstance>\n"
				nextFrme+="                                   </elements>\n"
				nextFrme+="                              </DOMFrame>\n"
					
				}
				nextFrme+= "						</frames>\n"
				nextFrme+="                    </DOMLayer>\n"
				// this is only put like this to serve as a template for the hornets otherwise id of only done a single loop
				break
			}
			
			var hrnetCount:int = 1
			
			
			for (i = 0; i <fmsList.length; i++) 
			{// i may wanna change it 
				
				for (j = 0; j < fmsList[0].length; j++) 
				{
					//trace(j)
					// we switch the reg order because we have to itterate consistant element not through the frame, because there is only one element i want in that layer
					// in the next one i dont reverse the j i
					
					//should work didnt change any code if anything does notwork itll be because the type isnt Hornet... so yeah
					
					while(i<fmsList.length && fmsList[i][j].type != "Hornet" ){
						i++
					}
					if(i >= fmsList.length){
						if(hrnetCount -1 == 0)
						trace("there are no hornets")
						break
					}
					el = fmsList[i][j]
					if(j==0){
					nextFrme+="                     <DOMLayer name=\""+el.type+hrnetCount+"\" color=\"#9933CC\" autoNamed=\"false\">\n"
					
					nextFrme+="                         <frames>\n"
					hrnetCount++
					}
					
					frm = j
					xp = el.x;
					yp = el.y;
					scale = el.scale
					bodyx = el.bodyx;
					// for these your gonna wanna change these to the camera position instead, real world i wouldnt want to put the camera position on this but i dont know if its a viable option otherwise, soo yeah..
					// I can add a z component but i shouldnt need to as long as the math is the same but before flash was acting strange and didnt have the same answer but yeahh we can take the chance
					Ypos = el.Y;
					Xpos = el.X;
					zDepth = el.z;
					camX= el.camrax 
					camY= el.camray
					camZ= el.camraz
					camXrot= el.camraXrot
					camYrot= el.camraYrot
					camZrot= el.camraZrot
					animName = el.anim
					
					
					
					nextFrme+="				<DOMFrame index=\""+frm+"\" duration = \"1\" keyMode=\"9728\">\n"
					nextFrme+="                                   <elements>\n"
					// try and get rid of the 3DX and other stuff 3DY
					nextFrme+="                                        <DOMSymbolInstance libraryItemName=\""+animName+"\" symbolType=\"graphic\" centerPoint3DX=\""+xp+"\" centerPoint3DY=\""+yp+"\" loop=\"loop\">\n"
					nextFrme+="                                             <matrix>\n"
					// try and get rid of the a and d i dunno what they do and the 
					nextFrme+="                                                  <Matrix a=\""+scale+"\" d=\""+scale+"\" tx=\""+xp+"\" ty=\""+yp+"\"/>\n"
					nextFrme+="                                             </matrix>\n"
					nextFrme+="                                             <transformationPoint>\n"
					nextFrme+="                                                  <Point x=\"0.1\"/>\n"
					nextFrme+="                                             </transformationPoint>\n"
					nextFrme+="                                             <persistentData>\n"
					nextFrme+="                                                  <PD n=\"bodyx\" t=\"d\" v=\""+bodyx+"\"/>\n"
					nextFrme+="                                                  <PD n=\"Ypos\" t=\"d\" v=\""+Ypos+"\"/>\n"
					nextFrme+="                                                  <PD n=\"Xpos\" t=\"d\" v=\""+Xpos+"\"/>\n"
					nextFrme+="                                                  <PD n=\"zDepth\" t=\"d\" v=\""+zDepth+"\"/>\n"
					nextFrme+="                                                  <PD n=\"camX\" t=\"d\" v=\""+camX+"\"/>\n"
					nextFrme+="                                                  <PD n=\"camY\" t=\"d\" v=\""+camY+"\"/>\n"
					nextFrme+="                                                  <PD n=\"camZ\" t=\"d\" v=\""+camZ+"\"/>\n"
					nextFrme+="                                                  <PD n=\"camXrot\" t=\"d\" v=\""+camXrot+"\"/>\n"
					nextFrme+="                                                  <PD n=\"camYrot\" t=\"d\" v=\""+camYrot+"\"/>\n"
					nextFrme+="                                                  <PD n=\"camZrot\" t=\"d\" v=\""+camZrot+"\"/>\n"
					nextFrme+="                                             </persistentData>\n"
					nextFrme+="                                        </DOMSymbolInstance>\n"
					nextFrme+="                                   </elements>\n"
					nextFrme+="                              </DOMFrame>\n"
					
					if(j==fmsList[0].length - 1){	
					nextFrme+= "		</frames>\n"
					nextFrme+="                    </DOMLayer>\n"
					}
				}
				// this is only put like this to serve as a template for the hornets otherwise id of only done a single loop
			
			}
			
			var frstLyer:String = preHead+frstFrme+nextFrme
			
			
			// incase I wanna incoorporate the layer2 head into a repeating thing if I want to expand to better layer support but for now seems fine 
			
			 
			var layer2Head:String ="                    <DOMLayer name=\"Layer_1\" color=\"#00FFFF\" current=\"true\" isSelected=\"true\">\n"
			layer2Head+="                         <frames>\n"
			
			
			
			// so this would be a nested for loop for each of the elements in the first frame after youve finished  sonics for loops through all his frames
			var elfrme:String = ""
			// all of em should have the same number of frames so putting it fmsList[0] shouldnt matter
			for (i = 0; i <  fmsList[0].length; i++) 
			{
				frm = i
				elfrme+= "                              <DOMFrame index=\""+frm+"\" duration=\"1\" keyMode=\"9728\">\n"
				elfrme+="                                   <elements>\n"
				// i switch it to make j represent the elements because we care here more about what elements are in here rather than just putting one element in there because in this case weput all of them in a layer not just one guy
				for (j = 1; j < fmsList.length; j++) 
				{
					
					el = fmsList[j][i]
					if(el.type == "Hero" || el.type == "" || el.type == "Hornet")
						continue;
					// if this becomes slow just change this to 
					// while and j++
						
				
				
				
				xp = el.x;
				yp = el.y;
				scale = el.scale
				bodyx = el.bodyx;
				// for these your gonna wanna change these to the camera position instead, real world i wouldnt want to put the camera position on this but i dont know if its a viable option otherwise, soo yeah..
				// I can add a z component but i shouldnt need to as long as the math is the same but before flash was acting strange and didnt have the same answer but yeahh we can take the chance
				Ypos = el.Y;
				Xpos = el.X;
				zDepth = el.z;
				camX= el.camrax 
				camY= el.camray
				camZ= el.cramraz
				camXrot= el.camraXrot
				camYrot= el.camraYrot
				camZrot= el.camraZrot
				animName = el.anim
						
			// the elements on the second layer
		
			
			elfrme+="                                        <DOMSymbolInstance libraryItemName=\""+animName+"\" symbolType=\"graphic\" centerPoint3DX=\""+xp+"\" centerPoint3DY=\""+yp+"\" loop=\"loop\">\n"
			elfrme+="                                             <matrix>\n"
			elfrme+="                                                  <Matrix a=\""+scale+"\" d=\""+scale+"\" tx=\""+xp+"\" ty=\""+yp+"\"/>\n"
			elfrme+="                                             </matrix>\n"
			elfrme+="                                             <transformationPoint>\n"
			elfrme+="                                                  <Point/>\n"
			elfrme+="                                             </transformationPoint>\n"
			elfrme+="                                             <persistentData>\n"
			elfrme+="                                                  <PD n=\"zp\" t=\"d\" v=\""+zDepth+"\"/>\n"
			elfrme+="                                             </persistentData>\n"
			elfrme+="                                        </DOMSymbolInstance>\n"
			
				}
				elfrme+="										</elements>"
				elfrme+="									</DOMFrame>"
			}
			
			
			
			
			// just the end stays unchanged
			
			var end:String ="                         </frames>\n"
			end+="                    </DOMLayer>\n"
			end+="               </layers>\n"
			end+="          </DOMTimeline>\n"
			end+="     </timelines>\n"
			end+="     <scripts/>\n"
			end+="     <PrinterSettings/>\n"
			end+="     <publishHistory/>\n"
			end+="</DOMDocument>\n"
			
			var secndLayer:String = layer2Head+elfrme+end
			var doc:String = frstLyer+secndLayer
			
			Clipboard.generalClipboard.clear()
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,doc,false)
			//trace(doc)
			
		}
		
		
		// so at this point we have most everything here
		// we do need to make sure its outputting properly but thats not crazy big a deal
		// so set up a fight scenario in two different ways first a pure animation way
		// story board it and whatever just blocked, and tween too's 
		// then also do that for the game, this is important because 
		//if you do this, making varied animation becomes easier because im animating relative to the path that i know i want
		// this way then i can stretch it and do whatever with it is or move it in entirely odd ways, and add complexity on that if i feel needed 
		// eeek this is gonna get a little bit bigger than i wanted but its extremely powerful and towards the goal that i wanted... poop, and once 
		//it works , you could literally just put the keys in and itll work and i could move the keys around in game live if i felt like,
		// not only that the keys become really pivotal in that.. hmm maybe its not all that hard, all i have to do is get the set amount of points
		//right, and the key doesnt have to end up at the key's position.. but yeah it will but other than that you just say 
		
		//first in flash what is its local offset from the its (1-t)p0 + tP1 where t is represented by the number of frames from the last key
		// sooo... yeah then we just actually take that point take the angle to P(0) which we should establish at the beginning  and do the dot
		//product to get the x, then dot product to get the y, and that should give us its local position or something and then do the opposite 
		//or this on the actionscript side to get it back out again i shuld have it all straight when i watch casey again but yeah thats mostly it
		
		
		// i should make a program thats just a little notepad that takes keystrokes, and anytime i write note than a note it writes it in the notepad
		// then when im writing little notes just pop up like reminders and such.. who knows, kinda kool i thinks or so he thought, basically i little search program
		
		
		public static function DepricatedUpdateFrames(fmsList:Array = null, ground:Array = null):void
		{ 
			var jsfl:String = new String();
			var body:Boolean =  false
			if(ground){
				body = true
				jsfl += "var doc = fl.getDocumentDOM();\n"
				for (var i2:int = 0; i2 < ground.length-1; i2++) 
				{
					jsfl += "doc.addNewLine({x:"+ground[i2].D+", y:"+-ground[i2].Y+"}, {x:"+ground[i2+1].D+", y:"+-ground[i2+1].Y+"});\n"
				}
			}
			// I probably have to do an insert underneath or some garbage
				jsfl += "fl.showIdleMessage(false);\n"
				jsfl += "fl.getDocumentDOM().getTimeline().addNewLayer('hero')\n"
				jsfl+= "var gameLayer = 1 \n var heroLayer = 0\n"
				jsfl += "var getType = function (elem) {\n"
				jsfl += "	return Object.prototype.toString.call(elem);\n"
				jsfl += "};\n"
			
			var txtName:String 
			var usedImages:Array = []
			var used:Boolean = false
			//var j:int = 0
			trace(fmsList[0].length, " adfas", fmsList.length)
			for (var i:int = 0; i < fmsList[0].length; i++) 
			{
				if(i !=0){
					jsfl+= "fl.getDocumentDOM().getTimeline().insertKeyframe("+i+");\n"
				// later change one and make sure this is on some sort of loop it may not work and I have to do my hacking crap but yeah it should hopefully be fine.. who knows
				//jsfl+= "fl.getDocumentDOM().getTimeline().setSelectedLayers(1) \nfl.getDocumentDOM().getTimeline().insertFrames(1,false)\n"
				jsfl += "fl.clipCopyString(\" \");\n"
				jsfl += "fl.getDocumentDOM().getTimeline().setSelectedLayers("+"heroLayer"+",true)\n"					
				jsfl += "fl.getDocumentDOM().clipPaste(true);\n"
				jsfl += "try {fl.getDocumentDOM().deleteSelection()}catch(err) {}\n"
				jsfl+= "fl.getDocumentDOM().getTimeline().insertKeyframe("+i+");\n"

				}
					
				// i put it to three for testing cuz thats a number
				for (var j:int = 0; j < fmsList.length; j++) 
				{
					// I was supposed to copy this but uh i didnt oh well 
					
					
					//this is a bit complicated i have to find the image make it into a movieclip
					//hmm im concerned with name
					// this  code is useless since i automatically place the things on the screen i dont have any need for the other but alas it was made in two parts so umm yeah
					// this is a quick and dirty fix not entirely sure why its happening but figure i fix it here rather than at the source since i just call it and i didnt make er up
					if(!body){
						if(fmsList[j][i].type  == "Scenary"){
						txtName= "\""+fmsList[j][i].anim+"\""
							
						}else{
						trace("hero here")
						txtName= "\""+NamedText(fmsList[j][i].anim,(fmsList[j][i].frame != 0)?fmsList[j][i].frame:1)+"\""
						
						}
						
						if(fmsList[j][i].anim == null || fmsList[j][i].anim == "")
								continue
					}else{
						txtName = "\"Hero\""
					}
					//jsfl += fmsList[j][i].frame
					for (var k:int = 0; k < usedImages.length; k++) 
					{
						
						if(usedImages[k] == txtName){
							used = true
							break;
						}
					}
					var gameLayer:String = ((fmsList[j][i].type == "Scenary")?"gameLayer":"heroLayer")
					jsfl += "fl.clipCopyString(\" \");\n"
					jsfl += "fl.getDocumentDOM().getTimeline().setSelectedLayers("+gameLayer+",true)\n"					
					jsfl += "fl.getDocumentDOM().clipPaste(true);\n"
					jsfl += "try {fl.getDocumentDOM().deleteSelection()}catch(err) {}\n"
					
					
						
					if(!used){
						if(i >0){
							
							jsfl += "fl.getDocumentDOM().selection = [fl.getDocumentDOM().getTimeline().layers["+gameLayer+"].frames["+i+"].elements[0]]\n"
							jsfl += "try {fl.getDocumentDOM().deleteSelection()}catch(err) {}\n"
						}
						
						jsfl += " URI = 'file:///C|/Users/jonat/Google%20Drive/StarlingProject/Resources/';\n			\n			fl.getDocumentDOM().importFile(URI+"+txtName+"+'.png',false)\n			fl.getDocumentDOM().convertToSymbol('graphic',"+txtName+", 'center')\n				sltd = fl.getDocumentDOM().selection[0];\n									sltd.x = "+((!body)?+fmsList[j][i].x:fmsList[j][i].bodyx)+"\n				sltd.y = "+fmsList[j][i].y+"\n		sltd.scaleX = "+((!body)?+fmsList[j][i].scale:.5)+"\n   sltd.scaleY  = "+((!body)?+fmsList[j][i].scale:.5)+"\n		sltd.name = "+txtName+"\n				sltd.setPersistentData('zDepth', 'double',"+fmsList[j][i].z+");\n	"+((fmsList[j][i].type == "Scenary")?"":"")+"		\n"
						usedImages.push(txtName)
					}else{
						
						
						
						if(!body){
							jsfl += "	var els = fl.getDocumentDOM().getTimeline().layers["+gameLayer+"].frames["+i+"].elements\n   	for (i = "+((!body)?+0:1)+"; i < els.length; i++) {\n "
							jsfl += "if(getType(els[i]) === '[object SymbolInstance]')\n{"
								
							jsfl += "if(els[i].libraryItem.name.split(\".\")[0] == "+ txtName+"){\n 		fl.trace("+txtName+")\n			\n		\n			sltd = els[i];\n	sltd.name = "+txtName+"\n	"
							
							
							jsfl +="		sltd.scaleX  = "+fmsList[j][i].scale+"\n		sltd.scaleY  = "+fmsList[j][i].scale+"\n					sltd.x = "+fmsList[j][i].x+"\n				sltd.y = "+fmsList[j][i].y+"\n				\n				sltd.setPersistentData('zDepth', 'double',"+fmsList[j][i].z+");\n						"+((fmsList[j][i].type == "Scenary")?"":"\n	")+"		;break;	}\n}"
							jsfl +="else{\n"
								
							if(fmsList[j][i].type != "Scenary"){
							jsfl +="fl.getDocumentDOM().selection = [els[i]]\n"
							jsfl +="fl.getDocumentDOM().deleteSelection()\n"
							}
							jsfl += "}\n}"
						}else{
							jsfl += "var gameLayer = 0; \n	var els = fl.getDocumentDOM().getTimeline().layers[gameLayer].frames["+i+"].elements\n   			fl.trace("+txtName+")\n			\n		\n			sltd = els[0];\n	sltd.name = "+txtName+"\n	"
							
							jsfl +="		sltd.scaleX  = "+.5+"\n		sltd.scaleY  = "+.5+"\n					sltd.x = "+fmsList[j][i].bodyx+"\n				sltd.y = "+-1*fmsList[j][i].bodyy+"\n			\n					\n					\n	fl.getDocumentDOM().getTimeline().setSelectedLayers(1) \nfl.getDocumentDOM().getTimeline().insertFrames(1,false)"
						}
					}
					used = false
					// I'm going to want to experiment with try fail, the thing I wanna do now is get this in the game with basically just the images, and this becomes the image editing part of the thing, its easy and seperate
					// after i wanna do the same thing but just get the u or the lower case x of the objects and their actual place, and movie name this way i can use this one to actually code
					// special behaior very quickly and use update frames for updating imageness.., the thing is it also needs to take the points of the ground, it should be defined by the y and the distance to the next point
					// this has to be the last thing we are quickly running out of time and my drive seems crazy low I'm very concerned 2 day failures in a row
				}
				//	jsfl += "for (j = 0; j < flashChildren.length; j++) { URI = 'file:///C|/Users/jonat/Google%20Drive/StarlingProject/Resources/';				fl.trace(flashChildren[j].name)				fl.getDocumentDOM().importFile(URI+flashChildren[j].name+'.png',false)				fl.getDocumentDOM().convertToSymbol('graphic',flashChildren[j].name, 'center')				sltd = fl.getDocumentDOM().selection[0]									sltd.x = flashChildren[j].x				sltd.y = flashChildren[j].y				sltd.name = flashChildren[j].name				sltd.setPersistentData('zDepth', 'double', flashChildren[j].z);			}"
				
				// this is different since Im just taking things
				//from the library I have to figure out how it works		
				//jsfl += "for (j = 0; j < flashChildren[j].length; j++)\n {"
				
				
			}
			try { 
				//C:\Users\jonat\AppData\Local\Adobe\Animate CC 2018\en_US\Configuration\Commands\GameProcess
				var file:File = new File(File.userDirectory.nativePath+"/AppData/Local/Adobe/Animate CC 2018/en_US/Configuration/Commands/GameProcess/setFrames.jsfl")
				
				var fs:FileStream = new FileStream();
				// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
				fs.open
				fs.open(file, FileMode.WRITE);
				fs.writeUTFBytes(jsfl);	
				
				
				trace("Just remember the y is flipped/ *=-1, cuz if you forget that's gonna be a bit confusing on returning the data")
				//MMExecute(jsfl);
				
			} catch (e:Error) { 
				trace(jsfl," we're not in flash but you probably knew that")
			}
			usedImages = []
		}
		
		// Deprecated
		public function oldestupdateFrames(fmsList:Array = null, ground:Array = null):void
		{ 
			trace("hre")
			var jsfl:String = new String();
			var body:Boolean =  false
			if(ground){
				body = true
				jsfl += "var doc = fl.getDocumentDOM();\n"
				for (var i2:int = 0; i2 < ground.length-1; i2++) 
				{
					jsfl += "doc.addNewLine({x:"+ground[i2].D+", y:"+-ground[i2].Y+"}, {x:"+ground[i2+1].D+", y:"+-ground[i2+1].Y+"});\n"
				}
				jsfl += "fl.getDocumentDOM().getTimeline().addNewLayer('hero')\n"
			}
			var txtName:String 
			var usedImages:Array = []
			var used:Boolean = false
			//var j:int = 0
			trace(fmsList[0].length, " adfas", fmsList.length)
			for (var i:int = 0; i < fmsList[0].length; i++) 
			{
				if(i !=0)
					jsfl+= "fl.getDocumentDOM().getTimeline().insertKeyframe("+i+");\n"
				
				// i put it to three for testing cuz thats a number
				for (var j:int = 0; j < fmsList.length; j++) 
				{
					
					
					
					//this is a bit complicated i have to find the image make it into a movieclip
					//hmm im concerned with name
					// this  code is useless since i automatically place the things on the screen i dont have any need for the other but alas it was made in two parts so umm yeah
					// this is a quick and dirty fix not entirely sure why its happening but figure i fix it here rather than at the source since i just call it and i didnt make er up
					if(!body){
						trace(fmsList[j][i].type)
						txtName= "\""+NamedText(fmsList[j][i].anim,(fmsList[j][i].frame != 0)?fmsList[j][i].frame:1)+"\""
					}else{
						txtName = "\"Hero\""
					}
					//jsfl += fmsList[j][i].frame
					for (var k:int = 0; k < usedImages.length; k++) 
					{
						
						if(usedImages[k] == txtName){
							used = true
							break;
						}
					}
					
					if(!used){
						if(i >0){
						jsfl += "fl.getDocumentDOM().selection = [fl.getDocumentDOM().getTimeline().layers["+((true)?"gameLayer":fmsList[j][i].layer)+"].frames["+i+"].elements[0]]"
						jsfl += "\nfl.getDocumentDOM().deleteSelection()\n"
						}
						jsfl += " URI = 'file:///C|/Users/jonat/Google%20Drive/StarlingProject/Resources/';\n			\n			fl.getDocumentDOM().importFile(URI+"+txtName+"+'.png',false)\n			fl.getDocumentDOM().convertToSymbol('graphic',"+txtName+", 'center')\n				sltd = fl.getDocumentDOM().selection[0];\n									sltd.x = "+((!body)?+fmsList[j][i].x:fmsList[j][i].bodyx)+"\n				sltd.y = "+fmsList[j][i].y+"\n		sltd.scaleX = "+((!body)?+fmsList[j][i].scale:.5)+"\n   sltd.scaleY  = "+((!body)?+fmsList[j][i].scale:.5)+"\n		sltd.name = "+txtName+"\n				sltd.setPersistentData('zDepth', 'double',"+fmsList[j][i].z+");\n			\n"
						
						if(body){
							jsfl+= "\n				sltd.setPersistentData('Xpos', 'double',"+fmsList[j][i].X+");\n sltd.setPersistentData('Ypos', 'double',"+fmsList[j][i].Y+");\n		"
								
						}
						
						usedImages.push(txtName)
					}else{
						
						
						
						if(!body){
						jsfl += "var gameLayer = 0; \n	var els = fl.getDocumentDOM().getTimeline().layers[gameLayer].frames["+i+"].elements\n   	for (i = "+((!body)?+0:1)+"; i < els.length; i++) {\n if(els[i].libraryItem.name.split(\".\")[0] == "+ txtName+"){\n 		fl.trace("+txtName+")\n			\n		\n			sltd = els[i];\n	sltd.name = "+txtName+"\n	"
						
						
							jsfl +="		sltd.scaleX  = "+fmsList[j][i].scale+"\n		sltd.scaleY  = "+fmsList[j][i].scale+"\n					sltd.x = "+fmsList[j][i].x+"\n				sltd.y = "+fmsList[j][i].y+"\n			sltd.setPersistentData('zDepth', 'double',"+fmsList[j][i].z+");\n					sltd.setPersistentData('bodyx', 'double',"+fmsList[j][i].bodyx+")\n;break;	}\n}"
						}else{
							jsfl += "var gameLayer = 0; \n	var els = fl.getDocumentDOM().getTimeline().layers[gameLayer].frames["+i+"].elements\n   			fl.trace("+txtName+")\n			\n		\n			sltd = els[0];\n	sltd.name = "+txtName+"\n	"

							jsfl +="		sltd.scaleX  = "+.5+"\n		sltd.scaleY  = "+.5+"\n					sltd.x = "+fmsList[j][i].bodyx+"\n				sltd.y = "+-1*fmsList[j][i].bodyy+"\n			\n				sltd.setPersistentData('Xpos', 'double',"+fmsList[j][i].X+");\n sltd.setPersistentData('Ypos', 'double',"+fmsList[j][i].Y+");\n				\n				sltd.setPersistentData('zDedsadsfadfsfapth', 'double',"+fmsList[j][i].z+");\n	\n	fl.getDocumentDOM().getTimeline().setSelectedLayers(1) \nfl.getDocumentDOM().getTimeline().insertFrames(1,false)"
						}
					}
					used = false
					// I'm going to want to experiment with try fail, the thing I wanna do now is get this in the game with basically just the images, and this becomes the image editing part of the thing, its easy and seperate
					// after i wanna do the same thing but just get the u or the lower case x of the objects and their actual place, and movie name this way i can use this one to actually code
					// special behaior very quickly and use update frames for updating imageness.., the thing is it also needs to take the points of the ground, it should be defined by the y and the distance to the next point
					// this has to be the last thing we are quickly running out of time and my drive seems crazy low I'm very concerned 2 day failures in a row
				}
				//	jsfl += "for (j = 0; j < flashChildren.length; j++) { URI = 'file:///C|/Users/jonat/Google%20Drive/StarlingProject/Resources/';				fl.trace(flashChildren[j].name)				fl.getDocumentDOM().importFile(URI+flashChildren[j].name+'.png',false)				fl.getDocumentDOM().convertToSymbol('graphic',flashChildren[j].name, 'center')				sltd = fl.getDocumentDOM().selection[0]									sltd.x = flashChildren[j].x				sltd.y = flashChildren[j].y				sltd.name = flashChildren[j].name				sltd.setPersistentData('zDepth', 'double', flashChildren[j].z);			}"
				
				// this is different since Im just taking things
				//from the library I have to figure out how it works		
				//jsfl += "for (j = 0; j < flashChildren[j].length; j++)\n {"
				
				
			}
			try { 
				
				var file:File = new File(File.userDirectory.nativePath+"/AppData/Local/Adobe/Animate CC 2017/en_US/Configuration/Commands/GameProcess/setFrames.jsfl")
				
				var fs:FileStream = new FileStream();
				// i may wanna do this fs.openAsync(fl,FileMode.WRITE);
				fs.open
				fs.open(file, FileMode.WRITE);
				fs.writeUTFBytes(jsfl);	
				
				
				trace("Just rememnm  ber the y is flipped/ *=-1, cuz if you forget that's gonna be a bit confusing on returning the data")
				//MMExecute(jsfl);
				
			} catch (e:Error) { 
				trace(jsfl," we're not in flash but you probably knew that")
			}
			usedImages = []
		}
		
		protected function onLcStatus(event:StatusEvent):void
		{
			//trace("on LcStatus:", event.code)
		}
		
		public function AddScenary(vx:Number,vy:Number,vz:Number,name:String = null,scale:Number = 0, numOfScnaryFrms:uint = 0):void
		{
			//umm i have to handle copies and stuff but seeing that doesnt happen yet its cool
			Assets.gameTextures[name] = undefined
			Assets.bitmap[name] = undefined
			var p:Vector3D =Main.liveCamera.hero_mc.Unproject(vx,vy,vz)
			Main.liveCamera.SmartLoadScenary(p.x,p.y,p.z,name,name,numOfScnaryFrms,false,scale)
				
		}
		
		
		public function preTest (vx:Number,vy:Number,vz:Number,name:String = null,scale:Number = 0, numOfScnaryFrms:uint = 0, bodyx:Number = 0,bodyy:Number = 0,camX:Number = 0,camY:Number = 0,camZ:Number = 0,camrotX:Number = 0,camrotY:Number = 0,camrotZ:Number = 0):void
		{
		
		
		cam.x = camX
		cam.y = camY
		cam.z = camZ
		camRot.x = camrotX
		camRot.y = camrotY
		camRot.z = camrotZ
		
			
		LevelEditor.awyCam.z = camZ
		LevelEditor.awyCam.rotationX = camrotX
		LevelEditor.awyCam.rotationY = camrotY
		LevelEditor.awyCam.rotationZ = camrotZ
		LevelEditor.awyCam.x = camX
		LevelEditor.awyCam.y = camY
		
		//umm i have to handle copies and stuff but seeing that doesnt happen yet its cool
		Assets.gameTextures[name] = undefined
		Assets.bitmap[name] = undefined
		var p:Vector3D =MainSceneMotor.Unproject(new Vector3D(vx,vy,900),cam,camRot)
		// that scaleX and scaleY gets undone bt the projection formula so yeah
		Director.scenary.push({X:p.x,Y:p.y,Z:p.z,ScaleX:1,ScaleY:1,name:name,frms:numOfScnaryFrms})
		
		if(numOfScnaryFrms == 1){
			Main.liveCamera.SmartLoadScenary(p.x,p.y,p.z,name,name,numOfScnaryFrms,false,scale,Director.scenary.length -1)
			var fl:Number = MainSceneMotor.fl
			myScale =  (scale*2.4)/(fl/(p.z - fl))
			blnk = Main.liveCamera.getScenaryByName(name)[0]
			blnk.scaleZ = myScale
			blnk.drctrList[blnk.drctrIndx].ScaleY = blnk.scaleZ 
			blnk.drctrList[blnk.drctrIndx].ScaleX = blnk.scaleZ 

		}else{
			
		}
			
			// we just have to do the thing and update some of the functionality of unproject
			// so im gonna open and move mainscene motor to the right and then i need to update the damn thing
			// im gonna see if i need to add the camra shit to the next bit or whatever
			// not sure why i did this indirection its pointless but uh yeah i may be to just move the thing over
			trace(camrotX)
			
			if(EditKeyHandler.State != EditKeyHandler.AWAY_CAM && bodyx ){
//			Main.liveCamera.hero_mc.body.position.x = bodyx
//			Main.liveCamera.hero_mc.body.position.y = MainSceneMotor.floor.GroundY(bodyx)
			}	
			//MainSceneMotor.FreezeMotor = true
			
			//addEventListener(Event.ENTER_FRAME, justWork, false, 0, true);
			//
				stage.nativeWindow.alwaysInFront = true
		trace("firstChecl")
			startCount = 0
			
		}
		
			public function AddTest(name = "test",scale:Number = 1, numOfScnaryFrms:uint = 1):void
		{
		
			
			//umm i have to handle copies and stuff but seeing that doesnt happen yet its cool
			// that scaleX and scaleY gets undone bt the projection formula so yeah
			if(numOfScnaryFrms == 1){
				// OOOOOOOOOOOKKKK________________ this is where you left off, move all this code
				// up to pretest with the only thing remaning the num of scenaryframes if check, and blnk thingy
			trace(blnk.scaleX, "is the scale ",Main.liveCamera.scenary[Main.liveCamera.scenary.length - 1].name )
			
			blnk.scaleZ = myScale
			//Main.liveCamera.hero_mc.scaleZ = 300
			}else{
				
			}
				
			// this code is a cluster fuck of whatever
			stage.nativeWindow.alwaysInFront = false
			// jon youve turned into a elitist coding premadona who cant spell premadona, i hate you for that most of all
			//trace("am Iing?!!??!",vx," ",vy," ",vz, name)
		//	MainSceneMotor.FreezeMotor = false
			startCount = 99
		//	con.send("back")
		// this is more of a patch then anything but I may have wanted to block the loading dynamically so I only put it here so its safer I think
		Assets.isLoadQueOn = true
				
		}
		// ok strangely enough i havent completely fucked up i think that the only thing i have to do is test it and debug it it should work but i think
		// we should look like at the unproject and see if its enough ok hold on jon
		
		
		public function moduleUpdate():void
		{
			
				
				
			
				
				
				// this is very bad programming but umm, I dont know if I can make more than one function per connection so yeah
				if(coolDown == 0){
				trace("yo m     a")
				// the reason i do the cool down thing is cuz a im lazy probably took it from somewhere else
				// and b to kill the the loop, hey look i started saying i instead of we, must be my ego growing
				
				//	var fl:File = new File(File.userDirectory.nativePath+"/Google Drive/Module/bin-debug/Module.swf")
				var fl:File = new File(File.userDirectory.nativePath+"/AppData/Local/Adobe/Animate CC 2017/en_US/Configuration/WindowSWF/Module1.swf")
				
				var img1Request:URLRequest = new URLRequest(fl.url);
				img1Loader = new Loader();
				img1Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
				//img1Loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, complete);
				img1Loader.load(img1Request);
				coolDown = 30
				
				
			}
		}
		
		protected function complete(event:Event):void
		{
			//trace("update complete")
			module = img1Loader.content
//				count++
//					if(count == 2)
//					throw Error("complete error")
			// go through and find all the modules in the scene
			// update set their modules, and check if they
			// want to use the live version
			// actually just take the scene sonic is in
			// you dont use multiple scenes to control
			// everything, scenes alter sonics behaviour
			// in some shape or form if not its just an assets
			// actor or scenary, this way they can still be updated
			// without being wasteful
			Main.liveCamera.hero_mc.currScene[0].setModule()
		}
		public static function update():void
		{
			
			if(coolDown> 0)
				coolDown --;
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
			if(false)
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
			var location : Point =bm.globalToLocal(new Point(event.localX, event.localY));
			var prevLocation : Point =oldLoc;
			oldLoc = location	
			
			if(!xSheet.frameMarked && EditKeyHandler.State == EditKeyHandler.Animation && bm.bitmapData.rect.containsPoint(location)){

				xSheet.frameMarked = true;
				xSheet.call = 0
				//				var actr:Object = xSheet.frames[xSheet.list.selectedIndex];
				//					if(xSheet.keyFrames[actr.name].indexOf(actr.frame) == -1) // if newDog isn't already in the array
				//					{
				//						xSheet.keyFrames[actr.name].push(actr.frame)
				//					}
				//					else
				//					{
				//						//trace("No, thanks. We've already got that keyframe" );
				//						
				//					}
				//oldBit = bm.bitmapData
			}
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
				wp(startx, starty,brushScale,eraser);
				
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
		public static function wichEV(newLoc:Point, oldLoc:Point):void
		{
			var location : Point =bm.globalToLocal(newLoc);
			var prevLocation : Point =oldLoc;
			oldLoc = location	
			
			if(!xSheet.frameMarked && EditKeyHandler.State == EditKeyHandler.Animation && bm.bitmapData.rect.containsPoint(location)){

				xSheet.frameMarked = true;
				xSheet.call = 0
				//				var actr:Object = xSheet.frames[xSheet.list.selectedIndex];
				//					if(xSheet.keyFrames[actr.name].indexOf(actr.frame) == -1) // if newDog isn't already in the array
				//					{
				//						xSheet.keyFrames[actr.name].push(actr.frame)
				//					}
				//					else
				//					{
				//						//trace("No, thanks. We've already got that keyframe" );
				//						
				//					}
				//oldBit = bm.bitmapData
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
				wp2(startx, starty,brushScale,eraser);
				
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
				//bm.bitmapData.draw(_brush, matrix,cAlph2, BlendMode.NORMAL);
				//playing = true;//!playing;
				bm.bitmapData.draw(_brush, matrix,new ColorTransform(255,255,255,achnl2), BlendMode.NORMAL);

			}
			else
			{
				if(EditKeyHandler.cpsLock)
				bm.bitmapData.draw(_brush, matrix,new ColorTransform(1,1,1,.5), BlendMode.NORMAL);
				else
				bm.bitmapData.draw(_mask, matrix,cAlph, BlendMode.ERASE);
				
				//playing = false;
			}
			
			
		}
		private static function wp2(startx:int, starty:int, pressure:Number = 1, eraser:Boolean = false):void
		{
		
			_brush.x = startx - (_brush.width / 2);
			_brush.y = starty - (_brush.height / 2);
			
			var matrix:Matrix = new Matrix();
			matrix.scale(scale_brush*pressure,scale_brush*pressure);
			_brush.alpha = 0;
			//cAlph2.alphaMultiplier = pressure;
			matrix.tx = _brush.x;
			matrix.ty = _brush.y;
				bm.bitmapData.draw(_brush, matrix,cAlph2, BlendMode.NORMAL);
				
			
			
		}
		//***************** AWAY STUFFFF!!!!*************************///
		public function init():void
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			initProxies();
		}
		
		
		private function onContextCreated(event : Stage3DEvent) : void {
			initPhysicsEngine();
			initAway3D();
			initStarling();
			initMaterials();
			initObjects();
			initButton();
			
			
			addEventListener(Event.ENTER_FRAME, physicsReady, false, 0, true);

			
		}
		
		private function physicsReady(e:Event):void {
			var someCheck:Boolean = true
			if (someCheck) {
				removeEventListener(Event.ENTER_FRAME, physicsReady);
				initListeners();
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
			//PerspectiveLens(away3dView.camera.lens).focalLength = 35
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
		featherMain = new Starling(FeatherMain, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
//			// you must start it if you want mouse functionality 
			featherMain.start();
			
		}
		
		// testing purposes but you know how that goes but this should really be moved, but its not necessary for this game i dont thingk
		private function initPhysicsEngine():void {
			
//			_physicsWorld = AWPDynamicsWorld.getInstance();
//			_physicsWorld.initWithDbvtBroadphase();
//			_physicsWorld.gravity = new Vector3D(0, -10, 0);
//			
//			if (_debug) {
//				_debugDraw = new AWPDebugDraw(away3dView, _physicsWorld);
//				_debugDraw.debugMode = AWPDebugDraw.DBG_DrawCollisionShapes;
//			}
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
			cube1.x = 2000; 
			cube2.z = -750;
			cube3.x = 750;
			cube4.z = 750;
			cube1.y = cube2.y = cube3.y = cube4.y = cube5.y = 150;
			away3dView.scene.addChild(lookAtTarget)
			
			// Add the cubes to view 1
			
			away3dView.scene.addChild(cube1);
			away3dView.scene.addChild(cube2);
			
			//var cubeShape:AWPBoxShape=new AWPBoxShape(300,300,300);
			//var cubeRigidBody:AWPRigidBody=new AWPRigidBody(cubeShape,cube1,1); // notice the final "1" as it's dynamic
//			_physicsWorld.addRigidBody(cubeRigidBody);
//			cubeRigidBody.friction=1;
			
			//			away3dView.scene.addChild(cube3);
			//			away3dView.scene.addChild(cube4);
			//			away3dView.scene.addChild(cube5);
			away3dView.scene.addChild(new WireframePlane(3000, 3000, 20, 20, 0xbbbbb0, 0.5, WireframePlane.ORIENTATION_XZ));
//			cubeRigidBody.position=new Vector3D(-750,0,0);
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
			
			if(startCount != 99)
			{
				startCount++
					if(startCount == 2)
					AddTest()
			}
			
			
			if(awyCam.rotationX !=oldRot){
				perpRtYCos = Math.cos((LevelEditor.awyCam.rotationY+90)*Math.PI/180)
				perpRtYSin = Math.sin((LevelEditor.awyCam.rotationY+90)*Math.PI/180)
				oldRot = awyCam.rotationX 
			}
			testthing12 = away3dView.project(cube1.scenePosition)
				cube1.x=50
				cube1.y=-50
				cube1.z=50
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
					if(EditKeyHandler.cntrl && EditKeyHandler.qButton){
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
						
						LevelEditor.awyCam.z = Main.liveCamera.hero_mc.Z + 20;
						LevelEditor.awyCam.x = Main.liveCamera.hero_mc.X;
						LevelEditor.awyCam.y = Main.liveCamera.hero_mc.Y;
					}
				//camera3D.distance +=3
			//if(startthis)
				//_physicsWorld.step(1/30, 1, 1/30);
			//trace(away3dView.project(cube1.scenePosition).x, away3dView.project(cube1.scenePosition).y,away3dView.project(cube1.scenePosition).z)
			inGameUpdate()
			
			if(EditKeyHandler.imageAlterations)
			EditKeyHandler.InGameCamUpdate()
			
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
				// ill probably forget but uncomment this to get the 3d world back
				// Render the Starling stars layer
				featherMain.nextFrame();
				
				//game.nextFrame()
				
			} else if (renderOrder == FEATHER_GAME) {
				
				away3dView.render();
				
				// Render the Starling animation layer
				if(!EditKeyHandler.camvas){
					if(canvasOn){
						//	turnOffCanvas();
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, touchEvent);
						
						canvasOn = false
					}
					game.nextFrame();
				}else{
					eraser = EditKeyHandler.cntrl
					if(!canvasOn){
						
						//	turnOnCanvas(canvX,canvY, canvWidth,canvHeig ht);
						stage.addEventListener(MouseEvent.MOUSE_MOVE, touchEvent);
						canvasOn = true;
					}
					game.nextFrame();
					//game.render()
					
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
			}else if (renderOrder == AWAY_GAME){
				away3dView.render();
			
				
				game.nextFrame()
			}
		}
		
		private function inGameUpdate():void
		{
			if (mouseDown && EditKeyHandler.State == EditKeyHandler.AWAY_CAM) {
				awyCam.rotationY = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
				awyCam.rotationX = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
				trace(awyCam.rotationX," ", awyCam.rotationY)
			}
		}
		
		/**
		 * Handle the mouse down event and remember details for hovercontroller
		 */
		private function onMouseDown(event : MouseEvent) : void {
			//This rotates the view works really well
			//if(!EditKeyHandler.cpsLock ||EditKeyHandler.State == EditKeyHandler.AWAY_CAM){
			if(!isFollowPath && !isFollowSonic){
			mouseDown = true;
			startthis = true
			
			lastPanAngle = awyCam.rotationY ;
			lastTiltAngle = awyCam.rotationX;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			
			}
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

