package
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.NSprite;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Line;
	import starling.utils.LineSet;

	public class BezierTool
	{
		private var bezier:int;
		private var step:Number;
		private var curvePoint:Number;
		private var stage:Sprite
		private var line:LineSet;
		private var nline:LineSet
		private static var location:Point;
		public var bezierPts:Array = new Array();
		public static var segs:Array = [];
		private var projDist:Number;

		
		public function BezierTool(stage:Sprite)
		{
			this.stage = stage
			bezier = EditKeyHandler.BEZIER
				// this probably isnt the name
			segs.push(this)
			line = new LineSet(stage)
			nline = new LineSet(stage)
				step = 1/curvePoint
					
		}
		
		
//		
//		protected function loaded(event:Event):void
//		{
//			stage.addEventListener(TouchEvent.TOUCH, touchEvent);
//			
//		}
//		
		
		// i shouldnt need any of this i just take the location 
//		private function touchEvent(event : TouchEvent) : void
//		{
//			touch= event.getTouch(event.target as DisplayObject);
//			
//			
//			if(touch){
//				location = touch.getLocation(this);
//				if(touch.phase == TouchPhase.BEGAN)// ||touch.phase == TouchPhase.MOVED)
//					MouseDown(event)
//				
//				if(touch.phase == TouchPhase.ENDED)
//					onPointUp(event)
//				
//			}
//		}
		
		
		private function drawPoint (s:NSprite, color:uint=0xFF1100):void
		{
			
			// interesting why did i put it at that random position
			//	throw Error("why cant you draw")
			var imge:Image = new Image(Assets.getTexture("Circle"));
			imge.x -= 27;
			imge.y -= 30;
			imge.scaleX = 4
			imge.scaleY = 4
			s.addChild(imge);
			s.alignPivot("center","center")
		
			//s.Update()
			
		}
		
		public function updateBez():void
		{ 
			// the thing about this nsprite and lines is it updates all the nsprites and all the lines as well that are 3d
			var n:Array = bezierPts
			for (var i:int = 0; i < n.length; i++) 
			{
				n[i].Update()
			}
			var lns:Array = line.segs
				
			for (i = 0; i < lns.length; i++) 
			{
				lns[i].Update()
			}
			
			// so with that we should be updating the lines and the points lets test it and see if it works then we'll get the lines working
			
		}
		
		// so youll have to go and use bezier segs and do this for every one of the segments in segs
		public function MouseDown(loc:Point):void
		{
			location = loc
			if(true){//this == EditKeyHandler.bezTool){
				var t:Object = Main.liveCamera.hitTest(location);
				
				// ok this what i want it to do is just get a location back from this
				trace(location.x, location.y)
				
				
				// we get its parent because the hit it should get is image, and images parent is NSprite
				if(t)
				var s:NSprite = t.parent as NSprite
				else
					s = null
				
				if(s){
					
				}else{
				// this is adding so yeah
					bezierPts.push(new NSprite())
					
					var st:Vector3D = MainSceneMotor.Unproject(new Vector3D(location.x,location.y,500))

					bezierPts[bezierPts.length-1].X = st.x
					bezierPts[bezierPts.length-1].Y = st.y
					bezierPts[bezierPts.length-1].Z = st.z
						 
					drawPoint(bezierPts[bezierPts.length-1])
					stage.addChild(bezierPts[bezierPts.length-1])
					//var oldst:Vector3D = new Vector3D()
					//line.addSegment(oldst, st)
				}
//					trace("this shouldnt happen")
//				else
//					trace("should happen")
				
				
				// so since it seems to be working we want to get an nsprite on to the screen and then see if it can 
				// properly descern from em
					
					
			}
		}
		
		
		
		
		
		
		
		
	}
}