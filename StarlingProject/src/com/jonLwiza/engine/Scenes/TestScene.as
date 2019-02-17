package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	public class TestScene extends Cut
	{
		
		public function TestScene(name:String = null)
		{
			super();
			
		}
		
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			throw Error(" kj")
			//trace("correct")
			if(actor.body.position.x > 1000)
			Main.liveCamera.gDym.active = true
			else if(actor.body.position.x < 700)
			Main.liveCamera.gDym.active = false
		}
		
		override public function EnterCut():void
		{
			
		
//			var box:Body = new Body(BodyType.KINEMATIC);
//			box.shapes.add(new Polygon(Polygon.box(60, 80)));
//			box.position.setxy(5.914564796065, 814.250048828125);
//			box.space = MainSceneMotor.space;
			
		}
	}
}