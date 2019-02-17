package com.jonLwiza.engine.actors
{
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;
	import com.jonLwiza.engine.baseConstructs.SceneHandler;
	import com.jonLwiza.engine.helperTypes.TMXParser;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Map extends GeneralMotor
	{
		private var column:int;
		private var row:int;
		private var visRows:uint = 3;
		private var iterNum:int = 12;
		private var dij:Image;
		private var _targetingRecticle:Image;
		private var firstMap:Vector3 =new Vector3();
		private var fMapRows:uint  = 79;
		private var textureImage:String = "interp_";
		private var gid:Array = new Array();
		private var loaded:Boolean = false;
		private var que:Array = [[1,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
		private var tmx:TMXParser = new TMXParser(); 
		private var bgImages:Vector.<Image> = new Vector.<Image>(); 
		private var relMapCam:Vector3= new Vector3();
		private var sqPixel:uint  = 256;
		private var lastQue:Array = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
		private var board:Vector.<Image> = new Vector.<Image>();
		private var live:Vector.<Boolean> = new Vector.<Boolean>();
		private var _hrnets:Array = new Array();//Vector.<Hornet> = new Vector.<Hornet>(); 
		private var _scnes:Vector.<SceneHandler> = new Vector.<SceneHandler>();
		//private var assets:Assets = new Assets();
		private var waitList:Array = [[1,0,0],[0,0,0],[0,0,0],[0,0,0],[0 ,0,0],[0,0,0]]
		private var gThrough:Boolean = false;
		private var knum:int= 0;
		private var map:Sprite = new Sprite();
		private var camAdjust:Boolean;
		
		public function Map()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			for (var i:int = 0; i < iterNum; i++) 
			{
				lastQue.push([0,0,0]);
				que.push([0,0,0])
				waitList.push([0,0,0])
				live.push(false);
				bgImages.push(new Image(Assets.getTexture("interp_79")));	
			}
			// its just a strange bug workaround
			
			
		
			
			
//			map.x = 0;
	//		map.y = 0;
		}
		
		
		public function Update(name:String, cam:MainStage):void
		{
			
			
			
			
			//			 how this is gonna work is you load it here, when its dynamic you'll check if it needs to load based on the cameras location and size and it will load out the ones  it needs with a velocity bias
			
			if(Assets.finished)
			{
				Assets.started = false;
				Assets.finished = false;
				
				for (var j:int = 0; j < live.length; j++) 
				{
					if(!live[j])
						break
				}
				////trace(textureImage+waitList[j][0]," == ",Assets.stepimage);		
				
				if(waitList[j][0]< 10)
					textureImage = name+"0"
				else
					textureImage = name
				
				if(textureImage+waitList[j][0] == Assets.stepimage){
					
					
					bgImages[j].removeFromParent(true);
					bgImages[j] = new Image(Assets.getTexture(textureImage+waitList[j][0]))
					bgImages[j].x =waitList[j][1];
					bgImages[j].y =waitList[j][2];
					addChild(bgImages[j])
//					//trace("tjos thing is here ",textureImage," ghg", bgImages[j].x, " ", bgImages[j].y)
					live[j] = true;
					
				}else{
				//	Assets.LoadTexture(waitList[j][0])
				}
				//when the asset both hasnt started and hasnt finished that means its ready to load the next one on que
				
				
				
				
				// also remove the first one from the que stack move it to active
			}
			// we do both !started and not !finished so we dont load the same tile on two different spots
			if(!Assets.started && !Assets.finished && que.length > 0)
			{
				
				
				knum = 0;
				////trace("got called");
				for (var k:int = 0; k < iterNum; k++){ 
					// yeah i literall have no idea what i was doing befor so yeah sorry, well it wasnt working anyway so whatevs, and most of the code works i think so whatever right?
					//if(Assets.isTextureLoaded(que[k][0],name))
					if(Assets.isTextureLoaded(que[k][0],2))
					{
						if(que[k][0]< 10)
							textureImage = name+"0"
						else
							textureImage = name
						
						bgImages[k].removeFromParent(true);
						//bgImages[k] = new Image(Assets.getTexture(textureImage+que[k][0]))
						////trace("loaded ques"," ",k," ",que[k][0]," ",que[k][1]," ",que[k][2])	
						bgImages[k].x = que[k][1];
						bgImages[k].y = que[k][2];
						addChild(bgImages[k])
						
						live[k] = true;
					}else{ 
						////trace("not loaded ques"," ",k," ",que[k][0]," ",que[k][1]," ",que[k][2])	
						live[k] = false;
						if (waitList[k] != que[k]) 
						{
							waitList[k] = que[k]
						}
						
						
						
					}
					
					
					
				}
				
				for (var g:int = 0; g < live.length; g++) 
				{
					if(!live[g])
						break
				}
				////trace(g, live.length);
				if (g < live.length) 
				{
				//	Assets.LoadTexture(waitList[g][0])
				}
				
				
				
			}
			
			
			
			if(cam.hero_mc.key.X>= 0)
				camAdjust = true
			else
				camAdjust = false
			
			// some weird load error work around this map thing i wrote is really shitty but it works
			if (!camAdjust) 
				relMapCam.X = cam.pos.X+cam.pheight/2- x;
			else
				relMapCam.X = cam.pos.X+cam.pwidth/2 - x;	
			
			 relMapCam.Y = cam.pos.Y+cam.pheight/2 - y;
			// we'd be like if the things in the bounds do this
			////trace(" dsa ae ",map.y);
			column = int((relMapCam.X)/sqPixel);
			row = int((relMapCam.Y)/sqPixel);
			
			//it would be the int(mapWidth/512) which in this case is 40 actwally just get this from the tmx
			// we dont need this yet but when were using the map
			var i:uint =row*79+column;
			
			//if(gid[i] != 0)
			//{
			
			
			if(i < 632 && i > 1){
				que[0][0] = i+1;
				que[0][1] = column*sqPixel;
				que[0][2] = row*sqPixel;
				var y:uint = 0;
				// the 2 in rws loop represents the number of rows total in the map incase of zooms and such in other words that 2 needs to be adjusted for scale for optimazation i may just never do it, hopefully wont actually
				//i2 represents columns //whole loop this represents the ones < than your screen u can create another loop for greater
				for (var rws:int = 0; rws < visRows; rws++) 
				{
					
					
					for (var clms:int = 0; clms < iterNum/visRows; clms++) 
					{
						
						if((row-rws)*fMapRows+(column-clms) <632 && (row-rws)*fMapRows+(column-clms) >= 0){
							
							//					if(que.length < (clms+1)*(rws+1)-1)
							//					que.push((row-rws)*fMapRows+(column-clms)+1)
							
							que[y][0]=(row-rws)*fMapRows+(column-clms)+1;
							que[y][1]=(column-clms)*sqPixel;
							que[y][2]=(row-rws)*sqPixel;
							////trace("orig ques"," ",y," ",que[(clms+1)*(rws+1)-1][0]," ",que[y][1]," ",que[y][2])
							y++
						}
					}
				}
				
				
			}
			
			
			
		}
		
		
	}
}