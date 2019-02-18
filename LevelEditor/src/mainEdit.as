package 
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;
	
	import flash.text.TextFormat;
	
	import away3d.controllers.HoverController;
	import away3d.controllers.LookAtController;
	
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.controls.Screen;
	import feathers.controls.ToggleButton;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	import feathers.skins.FunctionStyleProvider;
	import feathers.system.DeviceCapabilities;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class mainEdit extends Screen
	{
		
		
		[Embed(source="atlas.xml")]
		private static const ICONS_XML:Class;
		
		[Embed(source="atlas.png")]
		private static const ICONS_IMAGE:Class;
		
		[Embed(source="header.png")]
		private static const HEADER_IMAGE:Class;
		
		
		
		
		
		
		private var header:Header;
		private var list:List;
		
		private var iconAtlas:TextureAtlas;
		
		private var font:BitmapFont;
		private var pageIndicator:PageIndicator;

		public static var windowWidth:Number;

		private var newImage:Button;
		public static var screenWidth:Number;
		
		public function mainEdit()
		{
		}
		
		override protected function draw():void
		{
			
			windowWidth = actualWidth/9
			header.alpha = .9
			header.width = windowWidth;
			header.height = 55;
			header.x = actualWidth - header.width
			screenWidth = actualWidth
			
			list.y = header.height;
			list.x = actualWidth - header.width
			
			list.width = windowWidth;
			list.height = actualHeight - header.height;
//			list.alpha =.8
//			pageIndicator.x = list.x + list.width/2 - pageIndicator.width/2
//			pageIndicator.y = actualHeight*0.9;
		}
		
		
		
		override protected function initialize():void
		{
		
//			var texture:Texture = Texture.fromBitmap(new AtlasTexture());
//			
//			var xml:XML = XML(new AtlasXML());
			//var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			iconAtlas = new TextureAtlas(Texture.fromBitmap(new ICONS_IMAGE(), false), XML(new ICONS_XML()));
			//font = new BitmapFont(iconAtlas.getTexture("arial20_0"), XML(new FONT_XML()));
			
			header = new Header();
			
			
			header.backgroundSkin = new Image(Texture.fromBitmap(new HEADER_IMAGE()));
			header.titleFactory = function():ITextRenderer
			{
				var titleRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				titleRenderer.textFormat = new TextFormat( "arial", 20, 0x000022, true);
				return titleRenderer;
			}
			
			header.title = "Library";
			addChild(header)
			
			list = new List();
			
			//list.interactionMode = "INTERACTION_MODE_MOUSE"
			addChild(list)
			
			var edit:ListCollection = new ListCollection(
				[
					//{ text: "the first", thumbnail: atlas.getTexture( "run0001" ) },
					{ label: "new Scenary"},
					{ label: "BezierPoints"},
					{ label: "select"},
					{ label: "Paint"},
					{ label: "Scale"},
					{ label: "EditLink"},
					{ label: "FollowSonic"},
					{ label: "FreeCam"},
					{ label: "Record"},
					{ label: "AwayCam"},
					{ label: "FollowCamPath"}
				]);
			
			const listLayout:TiledRowsLayout = new TiledRowsLayout();
			listLayout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			listLayout.useSquareTiles = false;
			listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			listLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			list.addEventListener( Event.CHANGE, list_changeHandler );
			
			list.dataProvider = edit
				
			
			
			function skinButton( button:Button ):void
			{
				button.defaultSkin = new Quad( 200, 60, 0xcccccc );
				button.downSkin = new Quad( 200, 60, 0x999999 );
			}
			
			var customButtonStyles:FunctionStyleProvider = new FunctionStyleProvider( skinButton );
//			list.itemRendererFactory = function():IListItemRenderer
//			{
//				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer()
//				
//				renderer.labelField = "text";
//				renderer.iconSourceField = "thumbnail";
//				renderer.iconPosition = Button.ICON_POSITION_TOP;
//				
//				//renderer.defaultIcon = new Image(atlas.getTexture("run0001"))
//					
//				renderer.scaleY = .50;
//				renderer.scaleX = .50
//				renderer.height = 400*renderer.scaleY
//				renderer.width = 250*renderer.scaleX
//					
//				renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(font, NaN, 0x000000);
//				return renderer;
//			}
			//list.addEventListener(Event.SCROLL, list_scrollHandler);
			
			const normalSymbolTexture:Texture = this.iconAtlas.getTexture("normal-page-symbol");
			const selectedSymbolTexture:Texture = this.iconAtlas.getTexture("selected-page-symbol");
			pageIndicator = new PageIndicator();
			pageIndicator.normalSymbolFactory = function():Image
			{
				return new Image(normalSymbolTexture);
			}
			pageIndicator.selectedSymbolFactory = function():Image
			{
				return new Image(selectedSymbolTexture);
			}
			
			
//			pageIndicator.direction = PageIndicator.DIRECTION_HORIZONTAL;
//			pageIndicator.pageCount = 3;
//			pageIndicator.gap = 3;
//			pageIndicator.paddingTop = this.pageIndicator.paddingRight = this.pageIndicator.paddingBottom =
//			pageIndicator.paddingLeft = 6;
//			pageIndicator.addEventListener(Event.CHANGE, pageIndicator_changeHandler);
//			addChild(this.pageIndicator);
//			

			
//			list.itemRendererProperties.iconSourceField = "thumbnail";
//			list.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
//			list.itemRendererProperties.labelField = "text";
			
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
//			animation.push({ text: "fifth", thumbnail: atlas.getTexture( "run0005" ) })
			
//			animation.removeItem(animation.getItemAt(2))
//			
//			animation.push({ text: "fif", thumbnail: atlas.getTexture( "run0005" ) })	
			
			//layout()
		}
		
		
		private function list_changeHandler( event:Event ):void
		{
			
			var list:List = List( event.currentTarget );
		
			if(list.selectedItem.label == "new Scenary"){
				EditKeyHandler.State = EditKeyHandler.ADDSETPIECE
				EditKeyHandler.actorType = 4
			}else if(list.selectedItem.label == "BezierPoints"){
				EditKeyHandler.State = EditKeyHandler.ADDSETPIECE
				EditKeyHandler.actorType = 2
			}else if(list.selectedItem.label == "select"){
				EditKeyHandler.State = EditKeyHandler.SELECT
			}else if(list.selectedItem.label == "Paint"){
				EditKeyHandler.State = EditKeyHandler.Painting
					enterPaintFunc()
				EditKeyHandler.enter = true;
			}else if(list.selectedItem.label == "Scale"){
				EditKeyHandler.State = EditKeyHandler.Scale
			}else if(list.selectedItem.label == "EditLink"){
				if(EditKeyHandler.bezTool.lstSelectedpt > -1){
					var yt:int = EditKeyHandler.bezTool.lstSelectedpt
				EditKeyHandler.EditLink = !EditKeyHandler.EditLink;
				if(EditKeyHandler.cntrl){
				LevelEditor.awyCam.x = EditKeyHandler.bezTool.bezierPts[yt].X
				LevelEditor.awyCam.y = EditKeyHandler.bezTool.bezierPts[yt].Y
				LevelEditor.awyCam.z = EditKeyHandler.bezTool.bezierPts[yt].Z
				}
				}
			}else if(list.selectedItem.label == "FreeCam"){
				LevelEditor.isFollowPath = false
					// away cam just says you cant click on shit.. so I dont really need to turn it off 
				//EditKeyHandler.State = EditKeyHandler.AWAY_CAM
					LevelEditor.isFollowSonic = false
						
						
						
						//				if(!LevelEditor.isFollow)
//				LevelEditor.camera3D =  new HoverController(LevelEditor.away3dView.camera, LevelEditor.lookAtTarget, 180, 0, 900, -15, 30);
//				else
//				LevelEditor.camera3D = new LookAtController(LevelEditor.away3dView.camera, LevelEditor.lookAtTarget)
				
			}else if(list.selectedItem.label == "AwayCam"){
				LevelEditor.isFollowPath = false
				// away cam just says you cant click on shit.. so I dont really need to turn it off 
				EditKeyHandler.State = EditKeyHandler.AWAY_CAM
				LevelEditor.isFollowSonic = false
					
			}else if(list.selectedItem.label == "FollowSonic"){
				// basically if we are in free cam but still wanna lock to sonic 
				// we use this
				
				LevelEditor.isFollowSonic = true
				LevelEditor.isFollowPath = false
			}else if(list.selectedItem.label == "FollowCamPath"){	
				LevelEditor.isFollowPath = true
				LevelEditor.isFollowSonic = false
					// just good form to have a return on all these 
				return
			}else if(list.selectedItem.label == "PushScene"){
				
				EditKeyHandler.PushSceneToFLash();
				return
			}else if(list.selectedItem.label == "empty"){
//				FeatherMain.nav.removeScreen("mainEditor")
//				FeatherMain.nav.showScreen("xsheet");
				
				return
				
			}
			
			if(list.selectedItem.label != "Paint"){
				EditKeyHandler.enter = false;
			}
			
//			switch(list.selectedIndex)
//			{
//				case 0:
//				{
//			
//			     break;
//				}
//				default:
//				{
//					EditKeyHandler.State =EditKeyHandler.SELECT
//					break;
//				}
//				
//			}
			//trace( "button triggered:", button.label );
			// Make sure this is at the bottom so nothing gets called after this hokay
			
		}
		
		private function enterPaintFunc():void
		{
			if(!EditKeyHandler.lastElement)
			return
			EditKeyHandler.camvas = true;
			LevelEditor.bm.bitmapData = Assets.bitmap[GeneralMotor(EditKeyHandler.lastElement).name].bitmapData
			LevelEditor.bm.x = EditKeyHandler.lastElement.x + Main.liveCamera.x
			LevelEditor.bm.y = EditKeyHandler.lastElement.y +Main.liveCamera.y
			LevelEditor.bm.scaleX = EditKeyHandler.lastElement.scaleX 
			LevelEditor.bm.scaleY = EditKeyHandler.lastElement.scaleY 
			LevelEditor.bm.alpha = .7;	
			if(GeneralMotor(EditKeyHandler.lastElement).name =="blankImage" ){
				GeneralMotor(EditKeyHandler.lastElement).name =  Director.currSceneName+"scenary00"+Main.liveCamera.getChildIndex(EditKeyHandler.lastElement).toString()
			}
		}
		private function select_triggeredHandler( event:Event ):void
		{
			var button:Button = Button( event.currentTarget );
			//trace( "button triggered:", button.label );
		}
		private function foul_triggeredHandler( event:Event ):void
		{
			var button:Button = Button( event.currentTarget );
			//trace( "button triggered:", button.label );
		}
//		private function layout():void
//		{
//			pageIndicator.width = windowWidth;
//			pageIndicator.validate();
//			//pageIndicator.y = this.stage.stageHeight - pageIndicator.height;
//			
//			const shorterSide:Number = Math.min(this.stage.stageWidth, this.stage.stageHeight);
//			const layout:TiledRowsLayout = TiledRowsLayout(list.layout);
//			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
//				layout.paddingLeft = shorterSide * 0.06;
//			layout.gap = shorterSide * 0.04;
//			
//			list.itemRendererProperties.gap = shorterSide * 0.01;
//			
//			list.width = this.stage.stageWidth;
//			list.height = pageIndicator.y;
//			list.validate();
//			
//			pageIndicator.pageCount = list.horizontalPageCount;
//		}
//		
//		protected function list_scrollHandler(event:Event):void
//		{
//			this.pageIndicator.selectedIndex = this.list.horizontalPageIndex;
//		}
		
//		protected function pageIndicator_changeHandler(event:Event):void
//		{
//			list.scrollToPageIndex(this.pageIndicator.selectedIndex, 0, this.list.pageThrowDuration);
//		}
		
		//this should be moved to global or something
		
		
	}
}