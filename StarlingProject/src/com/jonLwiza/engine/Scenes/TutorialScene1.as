package com.jonLwiza.engine.Scenes
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainScene;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.actors.MainStage;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.helperTypes.TMXParser;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	public class TutorialScene1 extends MainScene
	{
		private var triggered:Boolean = false;
		private var started:Boolean = false;
		private var tl:TimelineMax;
		private var tmx:TMXParser = new TMXParser();
		private var collisionVolume:Body;
		public function TutorialScene1()
		{
			super();
		}
		
		override protected function HeroEntered():void
		{
			collisionVolume = new Body(BodyType.KINEMATIC)
			var tutorialBarrier:Array = tmx.objectSet("Trigger","TutorialBarrier");
			collisionVolume.shapes.add(new Polygon(Polygon.rect(tutorialBarrier[0][0],tutorialBarrier[0][1],tutorialBarrier[0][2],tutorialBarrier[0][3])))
			
			collisionVolume.space = MainSceneMotor.space;
			
		}
		
		override public function Update(actor:Hero = null):void
		{
			if(hero.hitTestObject(this) && hero.key.Y == -1 && !hero.hanging && !triggered)
			{
				triggered = true;
			// turn on the cutscene somehow and place you falling from a hornet
			// in other words this part will have an in game cutscene and a out of game cutscene
			}
			msm.ProcessMotion(actor);
			// i made this so I can just put some extra functionality without disturbing the mainScene set up aka I dont wanna have to keep rewriting this garbage, or whatever garbage I put here
			// but if i want i can start from scratch and use a different thing to process motion if i override this one, but just dont override it, unless all of a sudden i go into outerspace
			// or whatever
			UpdateScene(actor);
		}
		
		override public function additionalForces(cam:MainStage):void
		{
			if(triggered)
			{
				MainSceneMotor.handJoint.anchor1.set(cam.hero_mc.body.position);
			if(!started){
				started = true;
				// umm this seems uh stupid but im future proofing it so when i wanna do more fancy stuff it aint a headache
			MainSceneMotor.handJoint.active = true;
			MainSceneMotor.handJoint.anchor2.set(cam.hero_mc.body.position)
			tl = new TimelineMax()
				
			tl.insert(TweenLite.to(MainSceneMotor.handJoint.anchor2, 0.5, {x:cam.hero_mc.body.position.x+5000));	
			}
				}
			
		}
			if(tl.currentTime == tl.totalTime)
			{
			this.x -= 9000;
			}
			
			}
	}
}