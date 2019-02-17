package com.jonLwiza.engine.Scenes
{
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.Hornet;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.Baddie;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.ActorPool;
	import com.jonLwiza.engine.helperTypes.Status;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.core.Starling;

	public class HornetBossScene extends HornetBossBattle
	{
		private var numberOfBaddies:int;
		private var hitBossEnabled:Boolean = false;
		private var boss:GeneralActor;
		private var killBoss:Boolean;
		//private var addAnimation1:Scenary = new Scenary();
		//private var addAnimation2:Scenary = new Scenary();
		
		private var que:uint = 0;
		private var cam:MainStage;
		private var check:Boolean;
		public function HornetBossScene()
		{
			super();
		}
		
		override protected function addedToStage():void{
			
		}
		
		override protected function HeroEntered():void
		{
			
			// itll make my life easy if stage_mc works if not...CRRRAAAPPPP
			// umm i need to make two spawning points that animate 
//			addAnimation1 =Scenary(this.parent.getChildByName("addBaddie"));
//			addAnimation2 =Scenary(this.parent.getChildByName("addBaddie2"));
			starling.core.Starling.juggler.add(stage_mc.spawn1);
			starling.core.Starling.juggler.add(stage_mc.spawn2);
			stage_mc.addChild(stage_mc.spawn1);
			stage_mc.addChild(stage_mc.spawn2);
		}
		// i think something was lost
		// just pass the baddie array into the gdyn you can override the functions here if you see fit
		// asll we really need to worry about is spawning and the end kill thingy
		override protected function UpdateScene(actor:GeneralActor=null):void
		{
			// lets have these four and four more check against their position in there
			// if they are there they itterate on the number of baddies in the scene, through hero, hero checks and tells how many baddies are in that scene, but not in the main scene, because that would be silly

			//			if(stage_mc.spawn1.currentFrame >= 8)
//			{
//				stage_mc.addChild(thorn);
//				thorn.x = addAnimation1.x;
//				thorn.y = addAnimation1.y;
//				stage_mc.hero_mc.localBaddies.push(thorn);
//				que--;
//				
//			}
//			if(stage_mc.spawn2.currentFrame >= 8)
//			{
//				stage_mc.addChild(thorn);
//				thorn.x = stage_mc.spawn2.x;
//				thorn.y = stage_mc.spawn2.y;
//				stage_mc.hero_mc.localBaddies.push(thorn);
//				que--;
//				
//			}
			
			
			if(stage_mc.hero_mc.localBaddies.length <= 2){// && que <=2){		
				que++
				addHornet(Hero(actor))
//				//trace("second thing checks out")
				check = true
			}
		
			
		if(stage_mc.hero_mc.localBaddies.length <= 4 && stage_mc.hero_mc.spacebar)
		{
//			//trace("the first thing checks out and its almost done")
			//somehow play the defeating baddie scene
			// then lay over the stats in actionscript
			if (check) 
			{
//				//trace("we be done boss dead cutscene")
				//stage_mc.removeChild(this, true);
				stage_mc.hornetBossScene.x = -2000;
//				for (var i:int = 0; i < stage_mc.scnes.length; i++) 
//				{
//					if(stage_mc.scnes[i]== stage_mc.hornetBossScene)
//						stage_mc.scnes.splice(i,1);
//			
//				}
			}
		}
				
		
	
		
		// we have to deal with targeting the main boss in this, its kind of early since we dont have a targeting thingy set up 
		}
		
		private function addHornet(hero:Hero):void
		{
//			if(que ==1){
//				stage_mc.spawn1.x = hero.x-100;
//				stage_mc.spawn1.y = hero.y;
//				stage_mc.spawn1.play();
//			}else{
//				stage_mc.spawn2.x = hero.x+100;
//				stage_mc.spawn2.y = hero.y;
//				stage_mc.spawn2.play();
//			}
			var h:Hornet = ActorPool.getSprite() as Hornet;
			h.dead = false;
			stage_mc.addChild(h);
			stage_mc.npcs.push(h)
			hero.localBaddies.push(h)
			h.x = hero.X+randomRange(50,-50);
			h.y = hero.Y+randomRange(5,-5);	
			// now after doing this add this to numberOf baddies so we numberOfBaddies.push, so i can have some control over it
			// then we say numberOfBaddies[numberOfBaddies.length -1].x = randomRange(cam.x+cam.width - 300,200+x), numberOfBaddies[numberOfBaddies.length -1].y = randomRange(cam.y+cam.height - 300,200+cam.y)
		//boss.anim = "spawnInHornetBattle"
		}
		
		
		
//		override public function Throwing(actor:GeneralActor):String
//		{
//			if(!Hornet(actor).thrown)
//			{
//				return Status.S_FAILURE
//			}else{
//				throwBaddie(Hornet(actor));
//				return Status.S_RUNNING
//				
//			}
//		}

		override public function Throwing(actor:GeneralActor):String
		{
			if(hitBossEnabled)
			{
				killBoss = true;
				
				stage_mc.removeChild(this);
				// switch scene to finishedlevel, where it adds a whole bunch of hud elements which disappear by themselves
				// again this is a dumb way to do it for now but hey itll get the job done
				return "failure";				
			}else
			{
			return Baddie(actor).Thrown();
			}
		}
		
		override protected function playCutScene(ctScene:String):void
		{
			//ctScene.playAnimation("KillBoss");
		}
		
//		public function throwBaddie(hornet:Hornet):void
//		{
//			// Im gona need to remember to change this one
//			// good not taking
//			var an:Number = 10*(Math.PI/180)
//			x+= Math.cos(an)*20;
//			y+= Math.sin(an)*20;
//			if(!hornet.throwing && !hitBossEnabled){	
//				hero.gv.Y = 45*hero.key.Y;
//				hero.moveVector.X = 25*hero.key.X;
//				hornet.throwing = true;
//			}else if(!hornet.throwing && hitBossEnabled){
//				ThrowFlyingBadGuy(hero, hornet);
//				hornet.throwing = true;
//			}
//		}
		
	}
}