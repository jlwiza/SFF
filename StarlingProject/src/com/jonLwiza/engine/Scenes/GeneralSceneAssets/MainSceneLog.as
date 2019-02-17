package com.jonLwiza.engine.Scenes.GeneralSceneAssets
{
	import com.jonLwiza.engine.actors.MainStage;

	public class MainSceneLog extends MainScene
	{
		// when we put this in it takes over where the main scene would be
		//these are the main scenes we make and camera handles where sonic starts
		// but if we want sonic running we handle it in probably maube init scene, im not entirely sure
		// since i might want fancier back n forth scene handling
		private var _scene:int;
		private var _camera:MainStage;
		public function MainSceneLog(scne:int,cam:MainStage)
		{
			super();
			scene = scne;
			camera = cam;
		}
		public function initScene():void
		{
			
		}

		public function get scene():int
		{
			return _scene;
		}

		public function set scene(value:int):void
		{
			_scene = value;
		}

		public function get camera():MainStage
		{
			return _camera;
		}

		public function set camera(value:MainStage):void
		{
			_camera = value;
		}


	}
}