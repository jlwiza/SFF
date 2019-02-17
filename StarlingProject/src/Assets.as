package
{
	
	
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.actors.AnimatedScenary;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.text.engine.BreakOpportunity;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	final public class Assets extends Sprite
	{
		
//		[Embed(source="../Code/assets/Dragon1.swf", mimeType="application/octet-stream")]
//		private static const DragonData:Class;
		
		
		
		// umm for this the name of this thingy is the same name as the factory 
//		[Embed(source = "../Resources/sonicAnimation/Dragon3.png", mimeType = "application/octet-stream")]
//		public static const Dragon:Class;
		
//		[Embed(source = "../Resources/sonicAnimation/dotin.png", mimeType = "application/octet-stream")]
//		public static const Dotin:Class;
		
		[Embed(source="../Resources/sonicAnimation/image03.jpg")]
		public static const Control:Class;
		
		
		
		[Embed(source="../Resources/sonicAnimation/ring.png")]
		public static const Ring:Class;
		
		[Embed(source="../Resources/sonicAnimation/test1.png")]
		public static const test1:Class;
		
		[Embed(source="../Resources/sonicAnimation/hornet.png")]
		public static const Hornet:Class;
		
		[Embed(source="../Resources/sonicAnimation/brokenHornet.png")]
		public static const brokenHornet:Class;
		
		[Embed(source="../Resources/sonicAnimation/brokenMess.png")]
		public static const brokenMess:Class;
		
		[Embed(source="../Resources/sonicAnimation/Cars.png")]
		public static const Cars:Class;
		[Embed(source="../Resources/SpiritRuin_Top.png")]
		public static const SpiritRuin_Top:Class;
		[Embed(source="../Resources/SpiritRuin_Back.png")]
		public static const SpiritRuin_Back:Class;
		[Embed(source="../Resources/SpiritRuin_Bottom.png")]
		public static const SpiritRuin_Bottom:Class;
		[Embed(source="../Resources/SpiritRuin_Front.png")]
		public static const SpiritRuin_Front:Class;
		[Embed(source="../Resources/SpiritRuin_Left.png")]
		public static const SpiritRuin_Left:Class;
		[Embed(source="../Resources/SpiritRuin_Right.png")]
		public static const SpiritRuin_Right:Class;
		
		
		[Embed(source="../Resources/sonicAnimation/bigB.png")]
		public static const bigB:Class;
		
		[Embed(source="../Resources/Circle.png")]//, mimeType="application/octet-stream")]
		public static const Circle:Class;
		
		[Embed(source="../Resources/sonicAnimation/Sonic-Saudade.xml", mimeType="application/octet-stream")]
		public static const SonicSaXML:Class;
		
		[Embed(source="../Resources/sonicAnimation/Sonic-Saudade.png")]
		public static const SonicSa:Class;
		
		
		[Embed(source="../Resources/sonicAnimation/SpiritRuinAtlas.xml", mimeType="application/octet-stream")]
		public static const SpiritRuinAtlasXML:Class;
		
		[Embed(source="../Resources/sonicAnimation/SpiritRuinAtlas.png")]
		public static const SpiritRuinAtlas:Class;
		
		[Embed(source="../Resources/sonicAnimation/FinalCutAtlas.xml", mimeType="application/octet-stream")]
		public static const FinalCutAtlasXML:Class;
		
		[Embed(source="../Resources/sonicAnimation/FinalCutAtlas.png")]
		public static const FinalCutAtlas:Class;
		
		[Embed(source="BeachScntxtr-1.xml", mimeType="application/octet-stream")]
		public static const BeachScntxtr1XML:Class;
		
		[Embed(source="BeachScntxtr-1.png")]
		public static const BeachScntxtr1:Class;
		
		[Embed(source="../Resources/sonicAnimation/testing.xml", mimeType="application/octet-stream")]
		public static const testinXML:Class;
		
		[Embed(source="../Resources/sonicAnimation/testing.png")]
		public static const testin:Class;

		[Embed(source="../Resources/sonicAnimation/backgrounds.xml", mimeType="application/octet-stream")]
		public static const backgrndsXML:Class;
		
		[Embed(source="../Resources/sonicAnimation/backgrounds.png")]
		public static const backgrnds:Class;
		
		[Embed(source="../Resources/sonicAnimation/blankImage.png")]
		public static const blankImage:Class;
		
		[Embed(source="../Resources/sonicAnimation/BigBaddie.png")]
		public static const BigBaddie:Class;
		
		
		
//		[Embed(source="../Resources/sonicAnimation/BigBaddie.xml", mimeType="application/octet-stream")]
//		public static const BigBaddieXML:Class;
		
		[Embed(source="../Resources/mapTextures/interp_01.png")]
		public static const interp_00:Class;
		
		[Embed(source="../Resources/mapTextures/interp_79.png")]
		public static const interp_79:Class;
		
		
		private static var gameArmatures:Dictionary = new Dictionary();
		public static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlasXML:Dictionary = new Dictionary();
		public static var gameTextureAtlasIMGE:Dictionary = new Dictionary();
		
		public static var fBitmapLoader:Loader;
		public static var finished:Boolean = false;
		public static var started:Boolean = false;
		private static var count:int = 0;
		public static var tileSheetSprite:Texture;
		public static var tileBit:Vector3 = new Vector3();
//		private static var bgWorker:Workers
//		private static var bgWorkerCommandChannel:
//		private static var resultChannel:MessageChannel;
		private static var urlthingy:String;
		public static var stepimage:String;
		private static var loaded:Boolean = false;
		private static var imageBytes:ByteArray;
		private static var armaName:String;
		private static var loaderContext:LoaderContext;
		public static var loadingArmature:Boolean;
		public static var finishedArmature:Boolean = false;
		public static var Frames:Array;
		public static var LoadQue:Vector.<String> = new Vector.<String>();
		private static var loadingScene:MainScene;
		public static var bitmap:Dictionary = new Dictionary();
		private static var stepimage2:String;
		public static var ScenaryQue:Array = new Array();
		public static var isLoadQueOn:Boolean;
		private static var isLoadingAtlas:Boolean;
		private static var assetCount:int = 0;

		
		public function Assets()
		{
			//initialize();\
			// frames is a multideminsional array that has its frames = [scene1,scene2,scene3, and whatever]
			//each scene is an object with animations and stills most of the time i think itll just have animations but who knows
			// but this is an example of how it goes{}
			
		}
		
		public static function InitFrames():void
		{
			// just print it out on the game side see if there are any newly made animations and just put em here, or make some dynamic class that i edit and can read from i dunno
			//frames example
			Frames = [{stills:[],anims:[]},{stills:[],anims:[]}]
		}
		
		public static function RandomIntRange(max:int, min:int = 0):int
		{
			return Math.random() * (max - min) + min;
		}
		
		
		private function initialize():void
		{
			
//			bgWorker = WorkerDomain.current.createWorker(Workers.TestWorker);
//			
//			// Set up the MessageChannels for communication between workers
//			bgWorkerCommandChannel = Worker.current.createMessageChannel(bgWorker);
//			bgWorker.setSharedProperty("incomingCommandChannel", bgWorkerCommandChannel);
//			
////			progressChannel = bgWorker.createMessageChannel(Worker.current);
////			progressChannel.addEventListener(Event.CHANNEL_MESSAGE, handleProgressMessage)
////			bgWorker.setSharedProperty("progressChannel", progressChannel);
//			
//			resultChannel = bgWorker.createMessageChannel(Worker.current);
//			resultChannel.addEventListener(Event.CHANNEL_MESSAGE, handleResultMessage);
//			bgWorker.setSharedProperty("resultChannel", resultChannel);
//			
//			// Start the worker
//			bgWorker.addEventListener(Event.WORKER_STATE, handleBGWorkerStateChange);
//			bgWorker.start();
//			loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			
		}	
		public static function clone(source:Object):* 
		{ 
			var myBA:ByteArray = new ByteArray(); 
			myBA.writeObject(source); 
			myBA.position = 0; 
			return(myBA.readObject()); 
		}
		
		public static function pushMovieTexturesToQue(name:String, frms:uint):void{
			for (var i:int = 0; i < frms; i++) 
			{
				Assets.LoadQue.push(Assets.frameName(name,i+1))
			}
		}
		public static function runLoadQue():void{
			if(LoadQue.length ==0 || !isLoadQueOn)
				return;
			
			
			if(Assets.LoadTexture(LoadQue[0])){
				if(ScenaryQue.length >=1){
					if(ScenaryQue[0].imageName == LoadQue[0] && ScenaryQue[0].frames == 1){
						var scnry:Scenary = Main.liveCamera.getScenaryByName(ScenaryQue[0].scenaryName)[0]
						//scnry.removeChild(Main.liveCamera.getScenaryByName("testing").imge )
							var scnyRef:Array = Main.liveCamera.getScenaryByName(ScenaryQue[0].scenaryName)
							//Main.liveCamera.getScenaryByName("testing").refreshImage()
							if(Main.liveCamera.getScenaryByName(ScenaryQue[0].scenaryName).length == 1){
								scnry.imge = new Image(Assets.getTexture(ScenaryQue[0].imageName))

							Main.liveCamera.addChild(Main.liveCamera.getScenaryByName(ScenaryQue[0].scenaryName)[0])
							assetCount++
							}else{
								scnry.imge.texture = Assets.gameTextures[ScenaryQue[0].imageName]
								Main.liveCamera.getScenaryByName(ScenaryQue[0].scenaryName, true);
							}
							scnry.X = ScenaryQue[0].x;
							scnry.Y = ScenaryQue[0].y;
							scnry.Z = ScenaryQue[0].z;
							
							scnry.drctrIndx= ScenaryQue[0].dIndex
							//Main.liveCamera.getScenaryByName("testing").name = ScenaryQue[0].name
							scnry.frms = 1;
							
							//Main.liveCamera.getScenaryByName("testing").scaleZ =ScenaryQue[0].scale
							ScenaryQue.shift();
					}else if(frameName(ScenaryQue[0].imageName,ScenaryQue[0].frames) == LoadQue[0] && ScenaryQue[0].frames>1){
						// this is a real quick and dirty way to do it and its not error resistance, it says that if we are
						// equal to the last frame than we can assume we've loaded the others, it should be fine though
						var imageSn:String;
						if(ScenaryQue[0].frames< 10)
							imageSn= ScenaryQue[0].imageName +"000"+ScenaryQue[0].frames.toString()
						else if (ScenaryQue[0].frames>= 10 && ScenaryQue[0].frames <100)
							imageSn= ScenaryQue[0].imageName +"00"+ScenaryQue[0].frames.toString()
						else if (ScenaryQue[0].frames>= 100 && ScenaryQue[0].frames <1000)
							imageSn= ScenaryQue[0].imageName +"0"+ScenaryQue[0].frames.toString()
								
								if(LoadQue[0]== imageSn){
									var texts:Vector.<Texture> = new Vector.<Texture>()
									for (var i:int = 0; i < ScenaryQue[0].frames; i++) 
									{
										texts.push(getTexture(frameName(ScenaryQue[0].imageName,i+1)))
									}
									
									var animScnry:AnimatedScenary = AnimatedScenary(Main.liveCamera.getScenaryByName(ScenaryQue[0].scenaryName)[0])
									animScnry.texts = texts	
									//animScnry.movie = new MovieClip(texts,24);
									//ScenaryQue[0].scnery = Main.liveCamera.addNewAnimatedScenary(ScenaryQue[0].x,ScenaryQue[0].y,ScenaryQue[0].z,texts,ScenaryQue[0].scenaryName);
									Main.liveCamera.addChild(Main.liveCamera.getScenaryByName(ScenaryQue[0].scenaryName)[0])
									animScnry.X = ScenaryQue[0].x;
									animScnry.Y = ScenaryQue[0].y;
									animScnry.Z = ScenaryQue[0].z;
									animScnry.drctrIndx= ScenaryQue[0].dIndex
									//Main.liveCamera.getScenaryByName("testing").name = ScenaryQue[0].name
									animScnry.frms =ScenaryQue[0].frames;
									
									texts = null;
									ScenaryQue.shift();
								}
					}
				}
					LoadQue.shift();
			}
		}
		public static function frameName(imageName:String, frameNumber:uint):String{
			var imageSna:String
			if(frameNumber< 10)
				imageSna= imageName +"000"+frameNumber.toString()
			else if (frameNumber>= 10 && frameNumber <100)
				imageSna= imageName +"00"+frameNumber.toString()
			else if (frameNumber>= 100 && frameNumber <1000)
				imageSna= imageName +"0"+frameNumber.toString()
					return imageSna
		}
		
		public static function getAtlas(name:String = "SonicSaudade"):TextureAtlas
		{
			trace("Retrieving texture from Atlas: ",name)
			if (gameTextureAtlasXML[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				var tex:Texture = Texture.fromBitmap(bitmap, false);
				//				tex.mipMapping = false;
				gameTextureAtlasIMGE[name] = tex;
				var xml:XML = XML(new Assets[name+"XML"]);
				gameTextureAtlasXML[name] = new TextureAtlas(tex, xml);
			}
			// while editing please remember to get rid of this its wastefull
			//*****DELETE WHEN FINISHED HIGHLY WAStefull***
			

			return gameTextureAtlasXML[name];
		}
		
		public static function loadAtlas(name:String = ""):TextureAtlas
		{
			trace("Retrieving texture from Atlas: ",name)
			if (gameTextureAtlasXML[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				var tex:Texture = Texture.fromBitmap(bitmap, false);
				//				tex.mipMapping = false;
				gameTextureAtlasIMGE[name] = tex;
				var xml:XML = XML(new Assets[name+"XML"]);
				gameTextureAtlasXML[name] = new TextureAtlas(tex, xml);
			}
			// while editing please remember to get rid of this its wastefull
			//*****DELETE WHEN FINISHED HIGHLY WAStefull***
			
			
			return gameTextureAtlasXML[name];
		}
		public static function getTexture(name:String):Texture
		{
			
			if (gameTextures[name] == undefined)
			{
				trace(name)
				var bmap:Bitmap = new Assets[name]();
				
				var tex:Texture = Texture.fromBitmap(bmap, false);
//				tex.mipMapping = false;
				bitmap[name] = bmap;
				gameTextures[name] = tex;
			}
			return gameTextures[name];
		}
	
		// this is dumb
		//sees if the textures loaded if not it loads it so it can be accessed by get texture
		public static function isTextureLoaded(image:String, frms:int = 1000):Boolean
		{
		
			if(frms >1000)
			{
				// my current self disagrees but whatever I currently only support 99 frames, since I use a 0 to denote that its different something else I shouldnt copy over
				throw Error("typical atlases are too small to handle cases over 1000, hence it is silly to support this many frames in a single animation, consider a movie or breaking it up")
			}
			//			if(interp == 0)
			//				return false;
			if(frms == 1000){
				//why wasnt 0 picked instead????!?!
				// just means its not an animation
				stepimage2 = image;
			}
			if(frms< 10)
				stepimage2 = image +"000"+frms.toString()
			else if (frms>= 10 && frms <100)
				stepimage2 = image +"00"+frms.toString()
			else if (frms>= 100 && frms <1000)
				stepimage2 = image +"0"+frms.toString()
				//trace(stepimage2)
			if (gameTextures[stepimage2] == undefined)
			return false;
			
			return true;
			
			
		}
//		public static function isArmatureLoaded(name:String = "Dragon"):Boolean
//		{
//			if (gameArmatures[name] == undefined)
//			{
//				if (!loadingArmature) 
//				{
//					loadingArmature = true;
//					factory = new StarlingFactory();
//					
//					factory.addEventListener(Event.COMPLETE, texureArmatureCompleteHandler);
//					factory.parseData(new Dotin)
//					armaName = name;
//				}
//				
////				var texture:Texture = getTexture(name);
////				var xml:XML = XML(new Assets[name+"XML"]);
////				gameArmatures[name] = new TextureAtlas(texture, xml);
//				return false;
//			}
			
//			return true;
//		}
		
//		public static function getArmature(name:String = "Dragon"):Armature
//		{
//			return gameArmatures[name];
//		}
//		
//		protected static function texureArmatureCompleteHandler(event:Event):void
//		{
//			factory.removeEventListener(Event.COMPLETE, texureArmatureCompleteHandler);
//			gameArmatures[armaName] = factory.buildArmature("Symbol 1");;
//		
//			armaName = null;
//			factory = null;
//		}
		
	
		
//		public static function LoadTexture(interp:int = 31):Boolean
//		{
//			if(interp == 0)
//				return false;
//			if(interp< 10)
//				stepimage = "interp_0"+interp.toString()
//					else
//				stepimage = "interp_"+interp.toString()
//			if (gameTextures[stepimage] == undefined)
//			{
//				if(!started){
//					started = true;
//					fBitmapLoader = new Loader();
//					
//					//sf.
//					urlthingy = "../Resources/mapTextures/"+stepimage+".png";
//					fBitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, textureLoaded);
//					fBitmapLoader.load(new URLRequest(urlthingy), loaderContext);
//					
//					
//					////trace("trying to load ",stepimage);
//				}
//				return false;
//			}
//		//	//trace("shits up");
//			return true;
//			
//			
//		}
		// ill use this for the dynamically loaded textures for now that i want to later put into texture atlases but might be too lazy at the moment
		// ok the bases of this thing is pretty simple it just loads the textures dynamically and im ok with this really bein the
		// crux of the assets, instead of frontloading everything problem is thinking where does this load the texture because i dont wan't it to 
		// be too dependent on the scene changes it should be able to load whenever it deams things necessary
		// might wanna make an unloader, heck i dunno, i say lets keep it simple right now with the levelstreamer, itll load the scene
		// then after
		/** this is essentially the heart of most of what makes this works, it simply just checks if the image you're 
		 * looking for is in the folder then begins to load it if it isnt **/
		public static function LoadTexture(image:String, interp:int = 1000,folder:String="Resources", scene:MainScene = null, isAtlas:Boolean =false):Boolean
		{
			
			loadingScene = scene;
			
			if(interp >1000)
			throw Error("typical atlases are too small to handle cases over 1000, hence it is silly to support this many frames in a single animation, consider a movie or breaking it up")
//			if(interp == 0)
//				return false;
			if(interp == 1000){
				// just means its not an animation
				stepimage = image;
			}
			else if(interp< 10)
				stepimage = image +"000"+interp.toString()
			else if (interp>= 10 && interp <100)
				stepimage = image +"00"+interp.toString()
			else
				stepimage = image +"0"+interp.toString()
			if (gameTextures[stepimage] == undefined)
			{
				
				if(!started){
					started = true;
					fBitmapLoader = new Loader();
					
					// I may want to make this more dynamic so it makes sense and isnt all in 
					//for testing it wasnt working like this so i just unneately dumped neaded images
					urlthingy = "/"+folder+"/"+stepimage+".png";
					// ok I put this in here just for LevelEditing but the cool thing when I put it online I can stream resources from really anywhere
				//	var fl:File = new File(File.userDirectory.nativePath+"/Google Drive/StarlingProject/"+urlthingy)
				// For web
						trace(Main.liveCamera.scenary.length)
						var web:Boolean = false//Main.Release
					if(web){
						urlthingy = "http://www.whateverMyDomainIs.com/"+urlthingy
					}else{
						urlthingy = "file:///C:/Users/jonat/Google%20Drive/StarlingProject"+urlthingy
					}
					trace(urlthingy)
					//urlthingy = stepimage+".png";
					fBitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, textureLoaded);
					fBitmapLoader.load(new URLRequest(urlthingy), loaderContext);
					
					fBitmapLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(ioError:IOErrorEvent){
						//trace(ioError.text);
						fBitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, textureLoaded);
						trace("The file "+stepimage+" was not found in [C:\\Users\\jonat\\Google Drive\\Starlingroject\\Resources")
						throw Error("Error:::imageSafe")
						fBitmapLoader.close()
						fBitmapLoader.unload()
						started = false;                                           
						fBitmapLoader = new Loader();
						isLoadingAtlas = isAtlas
						fBitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, textureLoaded);
						
						fBitmapLoader.load(new URLRequest("error.png"), loaderContext);
					});
					
				}
				return false;
			}
			//throw Error("makes no sense that you should be trying to load the same image again... fix it");
			return true;
			
			
		}
		
		protected static function onSecurityError(event:Event):void
		{
			throw Error("you suck")
		}		
		
		
		protected static function textureLoaded(event:Event):void
		{
			
			if(loadingScene != null){
				loadingScene.textureLoaded()
			}
			
			var bmp:Bitmap =fBitmapLoader.content as Bitmap;
			
//			//fBitmapLoader.content.
//			imageBytes = new ByteArray();
//			bmp.bitmapData.copyPixelsToByteArray(bmp.bitmapData.rect, imageBytes);
			tileSheetSprite = Texture.fromBitmap(bmp,false);
			
		if(isLoadingAtlas){
			gameTextureAtlasIMGE[stepimage] = tileSheetSprite;
			var xml:XML = XML(new Assets[stepimage+"XML"]);
			gameTextureAtlasXML[stepimage] = new TextureAtlas(tileSheetSprite, xml);
		}else{
			gameTextures[stepimage] = tileSheetSprite;
			bitmap[stepimage] = bmp;
			
		}
			fBitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, textureLoaded);
//			//trace("loaded ",stepimage);÷
			//stepimage = null;
			//bgWorkerCommandChannel.send(imageBytes);
			finished = true;
			started = false;
		}
	
//		protected static function handleResultMessage(event:Event):void
//		{
//			if (!resultChannel.messageAvailable)
//				return;
//			
//			
//			//trace("see how often it gets called");
//			
//			tileSheetSprite = resultChannel.receive() as Texture
//			////trace("finished");
//			finished = true;
//			
//			
//			//var result:CountResult = resultChannel.receive() as CountResult;
//			//setPercentComplete(100);
//			//_statusText.text = "Counted to " + result.countTarget + " in " + (Math.round(result.countDurationSeconds * 10) / 10) + " seconds";
//		}
		
		protected static function handleBGWorkerStateChange(event:Event):void
		{
			
//			if (bgWorker.state == WorkerState.RUNNING)
//			{
//				//trace("somethom");
//				//_statusText.text = "Background worker started";
//				bgWorkerCommandChannel.send(tileBit);
//				loaded = false;
//			}
		}
		
		
//		

		//loads raw animations images and such in jpeg format, it preloads which is good for testing but later i'll wan't to change that
		// at first we also want it as dumb as possible we will label them local to their scene for specific scene animations and handle
		// performance issues as they arise, this way i can curve my production to meet areas on need
		//** TEMP DATA	
		
		
	}
}