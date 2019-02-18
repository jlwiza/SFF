package 
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	public class AppStarlingRoot extends Sprite
	{
		[Embed(source="Circle.png", mimeType="image/png")]
		private var BrushBm : Class;
		
		private var _renderTexture : RenderTexture;
		private var _canvas : Image;
		private var _brush : Image;
		private var _extraDraws : Array = [];
		// I added this terribly named scale brush because scaling because a bit of a pain if you dont
		private var scale_brush:Number = 1;
		
		public function AppStarlingRoot()
		{
			//trace("AppStarlingRoot.as -> AppStarlingRoot");
			addEventListener(Event.ADDED_TO_STAGE, addedEvent);
		}
		
		private function addedEvent(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedEvent);
			
			_renderTexture = new RenderTexture(1024, 768);
			_canvas = new Image(_renderTexture);
			addChild(_canvas);
			
			_brush = new Image(Texture.fromBitmap(new BrushBm()));
			_brush.pivotX = _brush.width >> 1;
			_brush.pivotY = _brush.height >> 1;
			_brush.color = 0x9900ff;
			_brush.scaleX = scale_brush
			_brush.scaleY = scale_brush
			// I added the brush just so you have something there and you know what it looks like before you use it
			addChild(_brush)
			stage.addEventListener(TouchEvent.TOUCH, touchEvent);
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
			
			_renderTexture.draw(_brush, matrix);
			
		}
		
		private function entFrame(event : Event) : void
		{
			_brush.scaleX = scale_brush
			_brush.scaleY = scale_brush
		}
	}
}