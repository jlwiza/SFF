package
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.actors.Hero;
	import com.jonLwiza.engine.actors.Scenary;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	
	import flash.utils.getQualifiedClassName;

	/**when initializing and you can add new actors to the watchlist
	 * if you dont itll use the default 
	 * */
	public final class FrameHandler
	{
		// this "thing" is very specific so i will say sonic instead of hero
		public static var watchlist:Array = new Array();
		public static var frmAtbts:Array = new Array();
		//distanceFrom last frame
		public static var DistFromLastFrame:int = 0
		
		public static var heroFrames:Array = new Array();
		public static function Clear():void{
			Main.liveCamera
		}
		// okay right now to keep this real simple we'll just record its position 
		public static function Update():void{
			DistFromLastFrame = 0;
			// i don't realistally need every frame but its here i guess
			// this should be temp but i know me
			//var actr:Hero = frmAt
			
			
			for (var i:int = 0; i < watchlist.length; i++) 
			{
				// ok here is where you would check and see what it is.. if its a hornet or a scenary or a hornet whatever it is, basically all scenary are handled the same, each hornet or whatever gets their own layer just because of how layers are handled in flash
				if(frmAtbts[i] == undefined)
					frmAtbts[i] = []
				Main.liveCamera.hero_mc.movie.currentFrame
				// we know its an actor but we dont know if its physical like the hornet changes  so here is where we would check and update just the value we need but since
				//Hero(fdf).movie.currentFrame
				// its sonic we know all the time its the body so we'll use that, we do it x and why to make suer its the same whether using nape or someyvel other physics library
				// honestly its just laziness but thats a good reason too isnt it                                                                                                                   umm this was made year ago, but i think i have a behavior array that may be of some use if the watchlist doesnt work                                      
				//frmAtbts[i].push({x:watchlist[i].body.position.x,y:watchlist[i].body.position.y, xvel:watchlist[i].body.velocity.x,yvel:watchlist[i].body.velocity.y,anim:watchlist[i].movie.name, frame:watchlist[i].movie.currentFrame, state:watchlist[i].motorBTree, statelist:watchlist[i].lineage});
				//frmAtbts[i].push({x:watchlist[i].x,y:watchlist[i].y,z:watchlist[i].z,scale:watchlist[i].scaleX, xvel:watchlist[i].body.velocity.x,yvel:watchlist[i].body.velocity.y,anim:watchlist[i].movie.name, frame:watchlist[i].movie.currentFrame, state:watchlist[i].motorBTree, statelist:watchlist[i].lineage});
				//WOW SOMETIMES I DONT EVEN KNOW HOW I COME UP WITH.. THE WAY THIS WORKS IS REALLY BEAUTIFUL IT UPDATES BASICALLY EACH THING ON THE WATCHLIST IT TELLS YOU WHAT IT DOES FOR EACH FRAME SO SAY SONICS INFO LOOKS LIKE THIS [{SONICFRAME1INFO,{TreeScenaryFRAMEINFO}],[SCENARYF1INFO,SCENCARYF2INFO]
				
				var vx:String = getQualifiedClassName(watchlist[i])
				var clsname:String = vx.slice(vx.search("::")+2)
				
				if(watchlist[i] is Hero){
					// im asuming its hero its a hack ill have to legitimize for only hornets
					var camra:Object = {X:LevelEditor.awyCam.x,Y:LevelEditor.awyCam.y, Z:LevelEditor.awyCam.z,rot:{x:LevelEditor.awyCam.rotationX,y:LevelEditor.awyCam.rotationY, z:LevelEditor.awyCam.rotationZ},fl:200}

						
					// its a lazy shortcut that should be fixed in Xsheet so i woulddnt have to look around for its distinguishing feature
					heroFrames.push({x:watchlist[i].x,bodyx:watchlist[i].body.position.x,bodyy:watchlist[i].body.position.y,y:watchlist[i].y,z:watchlist[i].zp,scale:watchlist[i].scaleX,anim:watchlist[i].movie.name, frame:watchlist[i].movie.currentFrame,name:watchlist[i].name,X:watchlist[i].X,Y:watchlist[i].Y,movie:watchlist[i].movie})//ty,anim:watchlist[i].movie.name, frame:watchlist[i].movie.currentFrame, state:watchlist[i].motorBTree, statelist:watchlist[i].lineage});
// poop i have to push characters ifferently for now we'll assume 
					// I should make one especially for animated scenary since that is handled different
				frmAtbts[i].push({camrax:camra.X,camray:camra.Y,camraz:camra.Z,camraXrot:camra.rot.x,camraYrot:camra.rot.y,camraZrot:camra.rot.z,x:watchlist[i].x,bodyx:watchlist[i].bdy.x,bodyy:watchlist[i].bdy.y,y:watchlist[i].y,z:watchlist[i].zp,scale:watchlist[i].scaleX,anim:watchlist[i].movie.name, frame:watchlist[i].movie.currentFrame,name:watchlist[i].name,X:watchlist[i].X,Y:watchlist[i].Y,type:"Hero"})//ty,anim:watchlist[i].movie.name, frame:watchlist[i].movie.currentFrame, state:watchlist[i].motorBTree, statelist:watchlist[i].lineage});
			}else{
				//*** TODO when you come back in ten check to see what you take out in 
				if(clsname == "Scenary"){
				var anim:String = watchlist[i].name
					var frame:int = 0
				}else{
					anim = watchlist[i].movie.name
					frame = watchlist[i].movie.currentFrame
				}
				frmAtbts[i].push({x:watchlist[i].x,y:watchlist[i].y,z:watchlist[i].zp,scale:watchlist[i].scaleX,anim:anim, name:watchlist[i].name,frame:frame,type:clsname})//ty,anim:watchlist[i].movie.name, frame:watchlist[i].movie.currentFrame, state:watchlist[i].motorBTree, statelist:watchlist[i].lineage});
	
			}
				

			}
			
		}
		public static function init(actors:Array = null):void{
			if(!actors){
			watchlist = [Main.liveCamera.hero_mc];
			watchlist = watchlist.concat(Main.liveCamera.baddies)
			watchlist = watchlist.concat(Main.liveCamera.scenary)
			
			}else{
				watchlist = actors;
				
			}
			
			
		}
		public static function Watch(actors:Array):void{
			watchlist = actors;
		}
		public function FrameHandler()
		{
		}
		
		
		
	}
}