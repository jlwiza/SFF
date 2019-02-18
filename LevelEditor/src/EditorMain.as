package
{
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class EditorMain extends Sprite
	{
		
		
		private var _direction:Point = new Point;
		public static var spacebar:Boolean;
		
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
		private var scale_brush:Number = .2;
		private var _mask:Image;
		private var enter:Boolean;
		private var enterPressed:Boolean;

		private var mc:MovieClip;
		
		
		public function EditorMain()
		{
			
			
			//mc = new MovieClip()//atlas.getTextures("run"), 30);
			addChild(mc);
			
			Starling.juggler.add(mc);
			
			/*PAINT APP PART **/
			addEventListener(Event.ADDED_TO_STAGE, added2Event);
			
			
		}
		
		private function added2Event(event : Event) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			addEventListener(Event.ENTER_FRAME, entFrame);
		}
		
		private function addedEvent(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedEvent);
			
			_renderTexture = new RenderTexture(550, 400);
			_canvas = new Image(_renderTexture);
			_canvas.blendMode = BlendMode.NORMAL;
			addChild(_canvas);
			_canvas.x =100;
			_canvas.y =50;
			
			_brush = new Image(Texture.fromBitmap(new BrushBm()));
			_brush.pivotX = _brush.width >> 1;
			_brush.pivotY = _brush.height >> 1;
			_brush.color = 0x9900ff;
			
			_mask = new Image(Texture.fromBitmap(new BrushBm()));
			_mask.pivotX = _brush.width >> 1;
			_mask.pivotY = _brush.height >> 1;
			_mask.color = 0x9900ff;
			_mask.blendMode = BlendMode.ERASE;
			_mask.alpha = .4;
			_brush.scaleX = scale_brush
			_brush.scaleY = scale_brush
			addChild(_brush)
			stage.addEventListener(TouchEvent.TOUCH, touchEvent);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			addEventListener(Event.ENTER_FRAME, entFrame);
		}
		
		private function touchEvent(event : TouchEvent) : void
		{
			var touches : Vector.<Touch> = event.getTouches(event.target as DisplayObject);
			for each (var touch : Touch in touches)
			{
				var location : Point = touch.getLocation(_canvas);
				
				if (touch.phase == TouchPhase.HOVER)
				{
					_brush.x = _canvas.localToGlobal(location).x;
					_brush.y = _canvas.localToGlobal(location).y;
					_brush.visible = true;
					continue;
				}
				
				_brush.visible = false;
				//var location : Point = touch.getLocation(_canvas);

				
				var prevLocation : Point = touch.getPreviousLocation(_canvas);

				
				var startx:int = prevLocation.x;
				var starty:int = prevLocation.y;
				var endx:int = location.x;
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
				
				
				//if(spacebar)
				//_renderTexture.draw(_brush);
				
			}
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
		
		private function entFrame(event : Event) : void
		{
			if(enter)
			enterPressed = true;
			
			if(enterPressed)
			{
				if(!enter)
				{
					ReturnClick()
					enterPressed = false;
				}
			}
//			_brush.scaleX = scale_brush
//			_brush.scaleY = scale_brush
//			_renderTexture.drawBundled(function() : void
//			{
//				for (var i : int = 0; i < 10; i++)
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
		
		private function ReturnClick():void
		{
			// add a new frame which is the image that i just made 
			mc.addFrame(Texture.fromBitmapData(LevelEditor.bm.bitmapData))
		}
		
		//Keyboard junk
		
		protected function keyUp(event:KeyboardEvent):void
		{
			directionUpdate = true;
			switch(event.keyCode)
			{
				
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
					
				default:
				{
					directionUpdate = false;
					break;
				}
			}
			
			switch(event.keyCode)
			{
				case Keyboard.SPACE:
				{
					spacebar = false;
					break;
				}
				case Keyboard.ENTER:
				{
					enter = false;
					break;
				}
			}
			
			if(directionUpdate)
				UpdateDirection();
		}
		
		
		
		protected function keyDown(event:KeyboardEvent):void
		{
			directionUpdate = true;
			switch(event.keyCode)
			{
				
				case Keyboard.UP:
				{
					up = true;
					break;
				}
					
				case Keyboard.DOWN:
				{
					down = true;
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
					
				default:
				{
					directionUpdate = false;
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
		
		
	}
}