package com.jonLwiza.engine.baseConstructs
{
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.helperTypes.Vector3;

	// this would extend scene mod which extends mainscene bit
	public class ForceToPointScene extends MainScene
	{
		// think about replacing this with an array thats more dynamic 
		private var _point1:Vector3 = new Vector3();
		private var _point2:Vector3 = new Vector3();
		private var _point3:Vector3 = new Vector3();
		
		private var points:Array = [_point1, _point2, _point3];
		private var falltoPoint1:String;
		private var toPoint1:String;
		private var falltoPoint2:String;
		private var toPoint2:String;
		private var falltoPoint3:String;
		private var toPoint3:String;
		
		public function ForceToPointScene()
		{
			super();
			point1.X = this.x+width/3;
			point1.Y = this.y+height/2;
			point2.X = this.x+width/2;
			point2.Y = this.y+height/2;
			point3.X = this.x+width;
			point3.Y = this.y+height/2;
		}
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			for each (var point:Vector3 in points) 
			{
				if(actor.DistToPoint(point) < 5){
				actor.x = point.X;
				actor.y = point.Y;
				if(point !=points[points.length -1]){
				actor.stuck = true;
				actor.isGrounded = true;
				actor.gv.Y = 0;
				if(Hero(actor).spacebar)
				{
					actor.gv.Y = -5;
					actor.x += 1;
				}
				}
			}
			}
			
			
			
			if(actor.x< point1.X){
			if(actor.currMBehaviour == "JumpFalling" ||actor.currMBehaviour == "JumpRising" ||actor.currMBehaviour == "Falling" ||actor.currMBehaviour == "Rising" )
			{
				actor.x += (point1.X - actor.x)/6
				sonicFalling = falltoPoint1;
				sonicJumpFalling  = falltoPoint1;
				sonicJumpRising = toPoint1;
				sonicRising = toPoint1;
				
			}
			}else if(actor.x> point1.X && actor.x< point2.X)
			{
				actor.x += (point2.X - actor.x)/6
				sonicFalling = falltoPoint2;
				sonicJumpFalling  = falltoPoint2;
				sonicJumpRising = toPoint2;
				sonicRising = toPoint2;
				
				
			}else if(actor.x> point2.X && actor.x< point3.X)
			{
				actor.x += (point3.X - actor.x)/6
				sonicFalling = falltoPoint3;
				sonicJumpFalling  = falltoPoint3;
				sonicJumpRising = toPoint3;
				sonicRising = toPoint3;
				
			}
		}
		
		override protected function HeroEntered():void
		{
			if(hero.isGrounded)
			hero.gv.Y = -8
		
		}

		public function get point1():Vector3
		{
			return _point1;
		}

		public function set point1(value:Vector3):void
		{
			_point1 = value;
		}

		public function get point2():Vector3
		{
			return _point2;
		}

		public function set point2(value:Vector3):void
		{
			_point2 = value;
		}

		public function get point3():Vector3
		{
			return _point3;
		}

		public function set point3(value:Vector3):void
		{
			_point3 = value;
		}


	}
	
	
	
}