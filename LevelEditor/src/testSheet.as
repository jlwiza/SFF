package 
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.AnimationHandler;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.baseConstructs.GeneralAnimation;
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	
	import nape.phys.Body;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.Image;
	
	public class testSheet extends Screen
	{
		
		
		[Embed(source="header.png")]
		private static const HEADER_IMAGE:Class;
		
		
		
		
		
		private var font:BitmapFont;
		
		private var iconAtlas:TextureAtlas;
		private static var header:Header;
		//this is a mess but uhh whatevs
		public static var list:List;

		public static var animation:ListCollection;
		public static var newFrames:Dictionary = new Dictionary();
		// just enter the name of the the animation you want the keyframes for and itll return you an array
		public static var keyFrames:Dictionary = new Dictionary();
		private static var listWidth:Number;
		private static var listHeight:Number;
		private static var listy:Number;
		private static var listx:Number;
		public static var frameMarked:Boolean = false
		private var footer:Header;
		private var override:Boolean = true;

		public static var actor:GeneralActor;
		public static var editing:Boolean;

		public static var frames:Array;

		private static var prevIndex:int;
		private static var prevActr:Object;

		private static var input:TextInput;
		public static var naming:Boolean;
		public static var call:int;
		private static var Alterations:Boolean;
		public static var alteredMovies:Array = new Array();
		
		public function testSheet()
		{
		}
		
		override protected function draw():void
		{
			header.alpha = 1
			header.width = actualWidth/4;
			listWidth = actualWidth/4
			list.y = header.height;
			listy = header.height;	 
			list.x = actualWidth - header.width
			listx = actualWidth - header.width
			header.x = actualWidth //- header.width
			list.width = actualWidth/4;
			list.height = actualHeight - header.height;
			listHeight = actualHeight - header.height*2;
			list.alpha = 1
			footer.width = actualWidth/4;
			footer.x = actualWidth //- header.width
			footer.y = actualHeight - footer.height;
			
		}
		
		override protected function initialize():void
		{
//			var texture:Texture = Texture.fromBitmap(new AtlasTexture());
//			var xml:XML = XML(new AtlasXML());
//			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
////			
//			iconAtlas = new TextureAtlas(Texture.fromBitmap(new ICONS_IMAGE(), false), XML(new ICONS_XML()));
//			font = new BitmapFont();
			
			footer = new Header();
			header = new Header();
			header.title = "digiXsheet";
			
			var button:ToggleButton = new ToggleButton()
			button.label = "insert/overide";
			button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			input = new TextInput();
			input.text = "";
			input.prompt = "Animation Name";
			footer.leftItems = new <DisplayObject>[button];
			footer.rightItems = new <DisplayObject>[input]
			header.backgroundSkin = new Image(Texture.fromBitmap(new HEADER_IMAGE()));
//			header.titleFactory = function():ITextRenderer
//			{
//				var titleRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
//				titleRenderer.textFormat = new TextFormat( "Sans_", 20, 0x000022, true);
//				return titleRenderer;
//			}
			
			
			
			list = new List();
//			list.itemRendererFactory = function():IListItemRenderer
//			{
//				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer()
//				
//				renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(font, 20, 0x000000);
//				return renderer;
//			}
			list.hasElasticEdges = false;
			//list.interactionMode = "INTERACTION_MODE_MOUSE"
			addChild(list)
			addChild(header)
			addChild(footer);
			
			
			list.addEventListener( Event.CHANGE, list_changeHandler );
			//list.itemRendererProperties.
			
			//list.backgroundSkin = 
			animation = new ListCollection(
				[
				//[{ text: "a", thumbnail: atlas.getTexture( "run0001" ) },
//					{ text: "b", thumbnail: atlas.getTexture( "run0002" ) },
//					{ text: "c", thumbnail: atlas.getTexture( "run0003" ) },
//					{ text: "d", thumbnail: atlas.getTexture( "run0004" ) },
				]);
			
			
			list.dataProvider = animation;
			
			list.itemRendererProperties.iconSourceField = "thumbnail";
			list.itemRendererProperties.iconPosition = Button.ICON_POSITION_RIGHT;
			list.itemRendererProperties.labelField = "text";
			
			//animation.push({ text: "5", thumbnail: atlas.getTexture( "run0005" ) })
			
			//animation.removeItem(animation.getItemAt(2))
			
			//animation.push({ text: "5", thumbnail: atlas.getTexture( "run0005" ) })	
			
			
		}
		
		private function button_triggeredHandler(event:Event):void
		{
			var button:ToggleButton = ToggleButton( event.currentTarget );
			override = button.isSelected
		}		
		
		
		public static function ReturnClicked():void
		{
			if(naming && input.text != ""){
				naming = false;
				actor.playedAnimations[input.text] =  new MovieClip(Assets.getAtlas(actor.atlas[0]).getTextures("blink"), 24);
				actor.movie.stop();
				actor.removeChild(actor.movie,true);
				starling.core.Starling.juggler.remove(actor.movie);
				actor.movie = actor.playedAnimations[input.text]
				actor.movie.name = input.text
				actor.movie.x = 0;
				actor.movie.y = 0;
				actor.movie.loop = false;
				starling.core.Starling.juggler.add(actor.movie);
				actor.addChild(actor.movie);
				
				
				animation.removeAll()
			
			for (var i:int = 0; i < FrameHandler.watchlist.length; i++) 
			{
				if(FrameHandler.watchlist[i] == actor)
					break
			}
			// might wanna save the old one out, i dunnod
			actor.body = new Body()
			actor.body.position.x = 0;
			actor.body.position.y = 0;
			FrameHandler.frmAtbts[i] = new Array();
			for (var pi:int = 0; pi < actor.movie.numFrames; pi++) 
			{
			FrameHandler.frmAtbts[i].push({x:actor.body.position.x,y:actor.body.position.y, xvel:actor.body.velocity.x,yvel:actor.body.velocity.y,anim:actor.movie.name, frame:pi, state:actor.motorBTree, statelist:actor.lineage});
			}
			for (i = 0; i < actor.movie.numFrames; i++) 
			{
			animation.push({ text: (actor.movie.name+actor.movie.currentFrame).toString(), thumbnail: actor.movie.getFrameTexture(actor.movie.currentFrame) })
			}
			
			actor.isFrozen = true;
			// clear animation push these on here pause it put it on Animation only difference is it stays still really
			// the rest is the same
			//animation.push({ text: "hjf", thumbnail: texture })
			EditKeyHandler.State = EditKeyHandler.Animation;
			
			// we really need to check if its an animation or an image thingy but whatevs
			PopUpManager.removePopUp(input)
			}
		}
		
		//The listener might look something like this:
		
		private function list_changeHandler( event:Event ):void
		{
			if(EditKeyHandler.State == EditKeyHandler.Animation){
			selectFrame();
			}else if(EditKeyHandler.State == EditKeyHandler.EditAnimation){
				editFrame();
			}
		}
		
		public static function editFrame():void
		{
			if(list.selectedIndex == -1)
				return;
			
			if(frameMarked){
				writeFrameToMemory(prevActr, prevIndex);
				if(keyFrames[prevActr.anim] == undefined)
				{
					keyFrames[prevActr.anim] = new Array();
					keyFrames[prevActr.anim].push(prevActr.frame)
				}else{
					for (var i:int = 0; i < keyFrames[prevActr.anim].length; i++) 
					{
						
						if(keyFrames[prevActr.anim][i] == prevActr.frame)
							break
					}
					if(i == keyFrames[prevActr.anim].length)
						keyFrames[prevActr.anim].push(prevActr.frame)
				}	
				
				keyFrames[prevActr.anim].sort(Array.NUMERIC)
				
				frameMarked = false
			}
			//trace( "selectedIndex:", list.selectedIndex );
			if(list.selectedIndex == -1)
				return;
			
			var actr:Object = {frame:list.selectedIndex+1, anim:input.text }
			
			for ( i = 0; i < FrameHandler.watchlist.length; i++) 
			{
				if(FrameHandler.watchlist[i] == actor)
					break
			}
			
			var p:Point = MainSceneMotor.local3DToGlobal(new Vector3D(actor.X,actor.Y,actor.Z))
			p = Main.liveCamera.localToGlobal(p)
			LevelEditor.bm.x = p.x;
			LevelEditor.bm.y = p.y;
			if(newFrames[actr.anim+actr.frame.toString()] != undefined)
			{
				
				//trace("this one got called: "+actr.anim+actr.frame.toString()+"newFrames[actr.anim+actr.frame] != undefined")
				
				// this says theyre ones from this session that ive changed and have put a stroke on em
				
				LevelEditor.bm.bitmapData = newFrames[actr.anim+actr.frame.toString()].bitmapData
				actor.movie.alpha = 0
			}else{
				
				// theyll be loaded in via level loader director thing
				if(Assets.bitmap[actr.anim+actr.frame.toString()] != undefined){
					//trace("the assets got called")
					LevelEditor.bm = Assets.bitmap[actr.anim+actr.frame.toString()];
					actor.movie.alpha = 0
				}else{
					//trace("the new bitmap got called")
					if(newFrames[actr.anim+actr.frame.toString()] == undefined){
						LevelEditor.bm.bitmapData =new BitmapData(actor.width,actor.height, true, 0x0);
						actor.movie.alpha = 1;
					}
				}
			}
			//			LevelEditor.bm.width = actor.width;
			//			LevelEditor.bm.height = actor.height;
			actor.movie.currentFrame = actr.frame
			actor.movie.pause()
			prevIndex = list.selectedIndex
			prevActr = actr
			
		}
		public static function selectFrame():void
		{
			if(list.selectedIndex == -1)
				return;
			if(editing){
				// we'll save out the old edit if we made any changes
				//do stuff 
			}else{
				// freeze the game if its not already frozen
				actor.isFrozen = true;
				editing = true;
			}
			
			if(frameMarked){
			writeFrameToMemory(prevActr, prevIndex);
			if(keyFrames[prevActr.anim] == undefined)
			{
				keyFrames[prevActr.anim] = new Array();
				keyFrames[prevActr.anim].push(prevActr.frame)
			}else{
			for (var i:int = 0; i < keyFrames[prevActr.anim].length; i++) 
			{
				
				if(keyFrames[prevActr.anim][i] == prevActr.frame)
					break
			}
			if(i == keyFrames[prevActr.anim].length)
				keyFrames[prevActr.anim].push(prevActr.frame)
			}	
			
			keyFrames[prevActr.anim].sort(Array.NUMERIC)
				
			frameMarked = false
			}
			if(list.selectedIndex == -1)
				return;
			
			// okay goal of the day is getting this working 
			// okay d
			// i also need to add a movie = [1, 4 5 6]
			// for all its keys and what not then when i press up or down e d or whatever i can flip between keys , i dunno how well this should work but we'll 
		// this should match up to the animation perfectly considering it made it so um yeah
			for (i = 0; i < FrameHandler.watchlist.length; i++) 
			{
				if(FrameHandler.watchlist[i] == actor)
					break
			}
			
				
			frames = FrameHandler.frmAtbts[i]
			var actr:Object = frames[list.selectedIndex];
			actor.body.position.x = actr.x
			actor.body.position.y = actr.y
				if(actor.movie != actor.playedAnimations[actr.anim] ){
				actor.movie.pause()
				actor.removeChild(actor.movie, true);
				
				actor.movie =actor.playedAnimations[actr.anim];
				
				actor.movie.x = 0;
				actor.movie.y = 0;
				actor.movie.loop = false;
				
				starling.core.Starling.juggler.add(actor.movie);
				actor.addChild(actor.movie);
				}else{
			actor.movie = actor.playedAnimations[actr.anim];
				}
			
			
			
			var p:Point = MainSceneMotor.local3DToGlobal(new Vector3D(actor.X,actor.Y,actor.Z))
			p = Main.liveCamera.localToGlobal(p)
			LevelEditor.bm.x = p.x;
			LevelEditor.bm.y = p.y;
			if(newFrames[actr.anim+actr.frame.toString()] != undefined)
			{
			
				
				// this says theyre ones from this session that ive changed and have put a stroke on em
				
				LevelEditor.bm.bitmapData = newFrames[actr.anim+actr.frame.toString()].bitmapData
				actor.movie.alpha = 0
			}else{
				
				// theyll be loaded in via level loader director thing
				if(Assets.bitmap[actr.anim+actr.frame.toString()] != undefined){
				LevelEditor.bm = Assets.bitmap[actr.anim+actr.frame.toString()];
				actor.movie.alpha = 0
				}else{
					if(newFrames[actr.anim+actr.frame.toString()] == undefined){
				LevelEditor.bm.bitmapData =new BitmapData(actor.width,actor.height, true, 0x0);
				actor.movie.alpha = 1;
					}
				}
			}
//			LevelEditor.bm.width = actor.width;
//			LevelEditor.bm.height = actor.height;
			actor.movie.currentFrame = actr.frame
			actor.movie.pause()
			prevIndex = list.selectedIndex
			prevActr = actr
		}
		/**
		 * it writes the frameobjects frame to the index of the framehandler
		 * the "actr" has two parameters it needs thats frame and anim so make an object
		 * {frame:frame of movie, anim:"nameofmovie}, then the index of the array you wanted
		 * to add in
		 */
		public static function writeFrameToMemory(actr:Object, index:int, interp:int=1000):void
		{
			if(frameMarked){
				call++
			if(call >1)
			return
			if(interp == 1000)
			interp = actr.frame
			var name:String;
			var image:String = actr.anim;
			if(interp > 1000)
			throw Error("unhandled exception");
			// umm i think i'll just do this when i save it but for now.. just 
			if(false){
			if(interp< 10)
				name = image +"000"+interp.toString()
			else if (interp>= 10 && interp <100)
				name = image +"00"+interp.toString()
			else
				name = image +"0"+interp.toString()
			}
			
			name = image +interp.toString()
			var mov:MovieClip = actor.playedAnimations[actr.anim]
			// if this doesnt work use like in gamebm
				//if(newFrames[name] == undefined){
			
			var bmd:BitmapData = LevelEditor.bm.bitmapData.clone()
			newFrames[name] = new Bitmap(bmd)
			for (var i2:int = 0; i2 < alteredMovies.length; i2++) 
			{
				if(alteredMovies[i2] == mov)
					break;
			}
			if(i2 == alteredMovies.length)
			alteredMovies.push(mov)
			
			
				//}else{
			//LevelEditor.bm.bitmapData = newFrames[name].bitmapData.merge(LevelEditor.bmd ,new Rectangle(0, 0, actor.width, actor.height),new Point(0,0),128,128,128,128)
				
			//	}
			
				
			var tex:Texture = Texture.fromBitmap(newFrames[name], false);
			//				tex.mipMapping = false;
			
			if(Assets.gameTextures[name] == undefined)
			Assets.gameTextures[name] = tex;
			
			mov.setFrameTexture(interp, tex);
			
			// i shouldnt need to update frame handler since it doesnt take literals it asks what movie and what frame both of which i change

//			for (var i:int = 0; i < FrameHandler.watchlist.length; i++) 
//			{
//				if(FrameHandler.watchlist[i] == actor)
//					break
//			}
			//FrameHandler.watchlist[i][prevIndex] = 
			var obj:Object = { text: name , thumbnail: tex  };

			// this is too large scale and unnecessary we should only do it for local items then do that for 
			// okay were only gonna check whats around us then when we click on a new one we'll see if that texture is the right texture if not
			// we'll pop that sucker
			
				
			var start:int = index - 20
			var finish:int = index + 20
			
				if(start < 1)
					start = 1
				if(finish>xSheet.frames.length -1)
					finish = xSheet.frames.length -1;
//			if(!Alterations){
//				Alterations = true
			for (var i:int = start; i <= finish; i++) 
			{
				if(frames[i].frame == interp && frames[i].anim == frames[index].anim){
					 
					animation.setItemAt({text: name , thumbnail: tex},i); 
					animation.updateItemAt(i)
//					call = 0;
//					writeFrameToMemory(actr,i)
					
				}
			// now if there is a keyframe higher than this we keep all the names the same
			// just change the texts on em 
			
			
			}	
			// i dunno sometimes i may just wanna replace specific ones
			if(true && keyFrames[actr.anim] != undefined){
			for (var j:int = 0; j < keyFrames[actr.anim].length; j++) 
			{
				if(keyFrames[actr.anim][xSheet.keyFrames[actr.anim].length-1] <= actr.frame)
				break;
				
				if(keyFrames[actr.anim][j] > actr.frame)
				{
					var spaces:int = 0
					while(frames[index+spaces].frame < xSheet.keyFrames[actr.anim][j]){
						animation.setItemAt({text: actr.anim+frames[index+spaces].frame , thumbnail: tex},index+spaces); 
						animation.updateItemAt(index+spaces)
						spaces++
					}
					for (var k:int = actr.frame; k <= keyFrames[actr.anim][j]; k++) 
					{
						mov.setFrameTexture(k, tex);
						
					}
					
					
					
					break;
				}
			}
			
//			Alterations = false
//			}
			frameMarked = false	
//			if(!EditKeyHandler.imageAlterations){
//				
//			EditKeyHandler.iter = start
//			EditKeyHandler.endAlterations = finish
//			EditKeyHandler.imageAlterations = true
//			EditKeyHandler.ainterp = interp
//			EditKeyHandler.aObj = obj
			
//			EditKeyHandler.InGameCamUpdate()
//			throw Error("wtf")
		//	}
		//	list.selectedIndex = -1
			}
			}
		}
		
//		var ue:uint = list.selectedIndex+1
//			var start:uint = 0;
//			var end:uint = 0;

//			while(frames[list.selectedIndex+start].frame == frames[list.selectedIndex].frame){
//				
//				start++
//			}
//			
//			while(frames[list.selectedIndex+start+end].frame == frames[list.selectedIndex+start].frame){
//				end++
//			}
		public static function IncreaseHold():void
		{
			
			// increase and decrease hold are kinda annoying and shit is buggy
			// we'll work around not using this, so yeah fuck this we dont need it
			// i dont want it
			var tex:Texture = actor.movie.getFrameTexture(frames[list.selectedIndex].frame)
			// if this works ill wanna make a check to make sure its not the last frame of the animation
			var actr:Object = frames[list.selectedIndex+1]
			var mov:MovieClip = actor.playedAnimations[actr.anim]
			var frame:uint = frames[list.selectedIndex].frame
			mov.addFrameAt(frame,tex);
			animation.addItemAt({text: actr.anim+frames[list.selectedIndex].frame , thumbnail: tex},list.selectedIndex); 
			animation.updateItemAt(list.selectedIndex)
			var spaces:uint = 1
			frames.splice(list.selectedIndex,0,actr);
//			while(frames[list.selectedIndex+spaces].anim == mov.name)
//				{
//				
//				frames[list.selectedIndex+spaces].frame--
//				
//					spaces++
//				}
		}
		public static function DecreaseHold():void
		{
			var ue:uint = list.selectedIndex+1
			var spaces:uint = 1;
			var tex:Texture = actor.movie.getFrameTexture(frames[xSheet.list.selectedIndex+spaces].frame)
			var actr:Object = frames[xSheet.list.selectedIndex]
			while(frames[xSheet.list.selectedIndex+spaces].frame == frames[ue].frame){
				animation.setItemAt({text: actr.anim+frames[xSheet.list.selectedIndex+spaces].frame , thumbnail: tex},list.selectedIndex+spaces); 
				animation.removeItemAt(list.selectedIndex+spaces)
				animation.updateItemAt(list.selectedIndex+spaces)
					
					//	spaces++
					
			}
		}
		
		public static function NewAnimation(editElement:GeneralAnimation):void
		{
			// we put the name of the animation
			PopUpManager.addPopUp(input)
				naming = true;				
				// we really need to check if its an animation or an image thingy but whatevs
				actor = GeneralActor(editElement);
		}
		
		public static function DoubleClick(editElement:GeneralAnimation):void
		{
			
			// clear context 
			// through  for statement animation.length
			//if(EditKeyHandler.State == EditKeyHandler.Animation && editElement == actor){
				// this means we want to edit an image just call the image editing function
				// actually i think too much as soon as were in the animation state we should be ready to draw 
				// we'll not use this itd be too finicky with drawing 
			if(EditKeyHandler.State != EditKeyHandler.Animation && editElement != actor){
			EditKeyHandler.State = EditKeyHandler.Animation;
		
			// we really need to check if its an animation or an image thingy but whatevs
			actor = GeneralActor(editElement);
			var mc:MovieClip = editElement.movie
				actor.isWatched = true;
				
			// ******** Edited it it doesnt have this implemented yet i dont know if i made it and its not there anymore or what but doesnt matter
			//var ct: =Cut(m.currScene[m.currScene.length - 1])
			
			// ok if i follow the drift of this logic we should check if this has already been double clicked or whatevs
			// if edit m doesnt equal old m //we clear the frames and make them the ones there
			
			if(animation)
			animation.removeAll()
		
				
				//	var txt:Vector.<Texture> = new Vector.<Texture>;

			
//			for (var i:int = 0; i < mc.numFrames; i++) 
//			{
//				// we populate the txt texture vecture 
//				txt.push(mc.getFrameTexture(i));
//				// then add it to the animation list
//				animation.push({ text: (i+1).toString(), thumbnail: mc.getFrameTexture(i) })
//			}   
			
//			throw Error ((typeof m.currScene[m.currScene.length - 1]))
			var vx:String = getQualifiedClassName(actor.currScene[actor.currScene.length - 1])
			var dname:String = vx.slice(vx.search("::")+2)
			if(mc.name.indexOf(dname+"_") == 0)
			{
				// then we have one were in editing mode this isnt something we really care about right now
				// this means its a game generated title specific for that scene which it probably should be for most all of em
			}else{
				
				//do this stuff when its being selected instead and dont forget to look for this one om default and fall back to the regular if its default isnt found
				
//				var aName:String = dname+"_"+mc.name;
//				header.title = aName;
//				newAnimations[aName] = new MovieClip(txt);
//				MovieClip(newAnimations[aName]).name = aName
				}
			}
		}
		
		private static function draw():void
		{
			list.y = header.height;
			list.x = listx
			
			list.width = listWidth
			list.height = listHeight*4
			list.alpha =1
		}
	}
}