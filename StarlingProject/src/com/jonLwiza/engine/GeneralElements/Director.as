package com.jonLwiza.engine.GeneralElements
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.BeachScene;
	import com.jonLwiza.engine.Scenes.CatchScene;
	import com.jonLwiza.engine.Scenes.CliffScene;
	import com.jonLwiza.engine.Scenes.FinalCut;
	import com.jonLwiza.engine.Scenes.OpeningScene;
	import com.jonLwiza.engine.Scenes.OpeningScene;
	import com.jonLwiza.engine.Scenes.SkateScne;
	import com.jonLwiza.engine.Scenes.SpiritRuin;
	import com.jonLwiza.engine.Scenes.SwarmScene;
	import com.jonLwiza.engine.Scenes.TestScene;
	import com.jonLwiza.engine.Scenes.TutScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.baseConstructs.Cut;
	import com.jonLwiza.engine.baseConstructs.SceneHandler;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import starling.core.Starling;

	/**
	 * The main idea of the director is the director handles high level changes to interaction to further the
	 * story such as calling in game movies and special scripts in group dynamics, also it doubles as the log line(what scene comes next)
	 */
	public final class Director
	{
		// the main visual tool of the director (in the editor) is collision block which basically we collide or something collides
		// and we make a call to the director from anywhere and from there the director tells hopefully usually the group dynamics
		// to do something, but 
		// ok your also gonna tell the game when to start prepping for scenes
		
		//also aim for this to be readible instead of efficient so lean towards dictionaries rather than arrays
		public static var sceneList:Array = [];
		public static var floorpts:Array = [];
		public static var rings:Array = [];
		public static var playingScene:int = -1;
		public static var currSceneName:String = "";
		public static var scenary:Array = [];
		public static var animations:Array = [];
		public static var baddies:Array = [];
		public static var paths:Array = [];
		public static var links:Array = [];
		public static var Campath:Array = [];
		public static var camlinkpair:Array = [];
		public static var camRotation:Array =  [];
		public static var camRotLink:Array = [];
		public static var isStrartSceneEarly:Boolean = false;
		
		public function Director()
		{
			
		}
		
		public function init():void
		{
			
			sceneList = [new com.jonLwiza.engine.Scenes.OpeningScene,new SkateScne,new BeachScene/*,new TutScene,new CliffScene*/,new SwarmScene,new SpiritRuin, new FinalCut]
			nextScene()
		}
		
		public function startPreloading(scene:String):void
		{
			Director[scene]();
		}
		
		public function nextScene():void
		{
			

			playingScene ++
			var scene:String = getQualifiedClassName(sceneList[playingScene]);
			var dname:String = scene.slice(scene.search("::")+2)
				
			currSceneName = dname
			ResourceManager.clearScene()
			ResourceManager[dname]()
			
			
			// I have to wait till this is loaded so that i can get that
			//sceneList[Director.playingScene].heroEntryPoint()
			
			
			
			
			// umm something like 
				//JESUS wtf do i change frame rate midgame or something? completely unexpected
			Starling.current.nativeStage.frameRate = sceneList[Director.playingScene].frameRate;
			Main.liveCamera.hero_mc.currScene =  [sceneList[playingScene]]; 
			Main.liveCamera.gDym.initialize(Main.liveCamera.hero_mc,Main.liveCamera.baddies)
			Main.liveCamera.gDym.active = false
			
//			var s:Camera = Main.liveCamera
//			rings = [s.collisionTarget].concat(s.rings)//s.rings//[s.r1,s.r2,s.r3,s.r4,s.r5,s.r6,s.r7,s.r8,s.r9,s.r10,s.r11,s.r12,s.r13,s.r14,s.r15,s.r16,s.r17,s.r18,s.r19,s.r20,s.r21,s.r22,s.r23,s.r24,s.r25,s.r26,s.r27,s.r28,s.r29,s.r30,s.r31,s.r32,s.r33,s.r34,s.r35,s.r36,s.r37,s.r38, s.r39,s.r40];
//			var baddies:Array = s.hrnets;//,s.hbHornet, stage_mc.h1,s.h2,s.h3,s.h4,s.h5,s.h6,s.h7,s.h8,s.h9,s.h10,s.h11,s.h12,s.h13,s.h14,s.h15,s.h16,s.h17,s.h18,s.h19,s.h20,s.h21,s.h22,s.h23,s.h24,s.h25,s.h26,s.h27,s.h28,s.h29,s.h30,s.h31,s.h32,s.h33,s.h34,s.h35,s.h36,s.h37,s.h38, s.h39,s.h40, s.bBoss]
//			//			testgroup1 = [s.bBoss];
//			
//			s.npcs = rings.concat(baddies);
//			//			//trace
			
			
				
		}
		public function RestartScene():void
		{
			
			
			var scene:String = getQualifiedClassName(sceneList[playingScene]);
			var dname:String = scene.slice(scene.search("::")+2)
			
			currSceneName = dname
			ResourceManager.clearScene()
			ResourceManager[dname]()
			
			sceneList[Director.playingScene].heroEntryPoint()
			
			
			
			
			// umm something like 
			Starling.current.nativeStage.frameRate = sceneList[Director.playingScene].frameRate;
			Main.liveCamera.hero_mc.currScene =  [sceneList[playingScene]]; 
			Main.liveCamera.gDym.initialize(Main.liveCamera.hero_mc,Main.liveCamera.baddies)
			Main.liveCamera.gDym.active = false				
			
				
		}
		public static function lastScene(n:SceneHandler):SceneHandler
		{
			return new MainScene()
		}
	}
}