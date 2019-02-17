package com.jonLwiza.engine.actors
{
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.LevelEvent;
	
	import flash.utils.getQualifiedClassName;
	
	public class Scenes extends MainScene
	{
		// seems like i put these here for individual level control
		// because sometimes id wanna use parts but it depended
		private var _enteredFunc:Boolean = true;
		private var _updateFunc:Boolean = true;
		private var _leftFunc:Boolean = false;
		private var mname:String;
		private var mscne:*;
		public function Scenes(name:String= null)
		{
			super();
			this.name= name;
		}
		
		override protected function OnEnterTrigger(event:LevelEvent):void
		{
			//get sonic and tell 
			// change to getchildatIndex
			if(stage_mc!= event.actor.parent)
			stage_mc = MainStage(event.actor.parent);
			event.actor.currScene.unshift(this);
			
			HeroEntered()
		}
		override protected function HeroEntered():void
		{
			
			// heres the deal i dont wanna subclass scenes
			// for every single scene thats a lot of work
			// considering id have to tell liveedit about it too
			// so instead i can make a function call on the cut im on
			mname = getQualifiedClassName(stage_mc.hero_mc.currScene[stage_mc.hero_mc.currScene.length-1])
			if(LevelEditor.liveEdit){
				mscne = LevelEditor.module.setScene(mname)
			}
			if(name && enteredFunc)
			{
				if(!LevelEditor.liveEdit){
				
				stage_mc.hero_mc.currScene[stage_mc.hero_mc.currScene.length-1][this.name+"HeroEntered"](stage_mc.hero_mc)
				
				}else{
				mscne[this.name+"HeroEntered"](this)
				
				}
			}
			
		}
		override public function Update(actor:Hero =null):void
		{ 
			msm.ProcessMotion(actor);
			// heres the deal i dont wanna subclass scenes
			// for every single scene thats a lot of work
			// considering id have to tell liveedit about it too
			// so instead i can make a function call on the cut im on
			if(name && updateFunc)
			{
				if(!LevelEditor.liveEdit){
				
				actor.currScene[stage_mc.hero_mc.currScene.length-1][this.name+"UpdateScene"](actor)
				}else{
				mscne[this.name+"UpdateScene"](actor, this)
			}
			}
		}
		
		override protected function OnLeaveTrigger(e:LevelEvent):void
		{
			
			//if(hero.currScene.length > 1){
			for (var i:int = 0; i < e.actor.currScene.length; i++) 
			{
				
				if(this == e.actor.currScene[i])
					e.actor.currScene.splice(i,1);
			}
		HeroLeft()	
		}
		
		override protected function HeroLeft():void
		{
			// heres the deal i dont wanna subclass scenes
			// for every single scene thats a lot of work
			// considering id have to tell liveedit about it too
			// so instead i can make a function call on the cut im on
			if(name && leftFunc)
			{
				if(!LevelEditor.liveEdit){
				
				stage_mc.hero_mc.currScene[stage_mc.hero_mc.currScene.length-1][this.name+"HeroLeft"]
				}else{
				mscne[this.name+"HeroLeft"]
				}
			}
		}

		public function get enteredFunc():Boolean
		{
			return _enteredFunc;
		}

		public function set enteredFunc(value:Boolean):void
		{
			_enteredFunc = value;
		}

		public function get updateFunc():Boolean
		{
			return _updateFunc;
		}

		public function set updateFunc(value:Boolean):void
		{
			_updateFunc = value;
		}

		public function get leftFunc():Boolean
		{
			return _leftFunc;
		}

		public function set leftFunc(value:Boolean):void
		{
			_leftFunc = value;
		}


	}
}