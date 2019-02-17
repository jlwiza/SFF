package com.jonLwiza.engine.helperTypes
{
	import flash.text.engine.BreakOpportunity;

	//import flash.events.Event;
	//import flash.net.URLLoader;
	//import flash.net.URLRequest;
	//import flash.xml.XMLDocument;

	public class TMXParser
	{
//		private var xmlString:URLRequest = new URLRequest("../Resources/gameLevelcopy.xml");
//		private var myLoader:URLLoader = new URLLoader(xmlString);
		public function TMXParser()
		{
			//myLoader.addEventListener("complete", init);
		}
	
		public static const OBJECTLAYERS:int = 1; 
		public static const TILELAYERS:int = 0; 
		public static const ALLLAYERS:int = 2; 
		private var _PolyLinepoints:Array = new Array();
		
		// its simple and not dynamic yet but we'll fix that later
		private var x:XML;
		private var gid:Number;
		private var i5:int;
		public function initPolyLine(source:XML, polyOriginX:Number, polyOriginY:Number):Array
		{
			
			////trace(x.toXMLString());
			////trace(x.objectgroup.object[1].polyline.@points);
			//var source:XML = XML(x.objectgroup.object[1].polyline);
			var dataString:String = source.@points;
			var dataArray:Array = dataString.split(" ");
			var pointString:String;
			var commaIndex:int;
			//change these to ints
			//var polyOriginX:Number = Number();
			//var polyOriginY:Number = Number(x.objectgroup.object[1].@y);
//			for (var i:int = 0; i < dataArray.length; ++i)
//			{
//				pointString = dataArray[i];
//				commaIndex = pointString.search(",");
//				
//				_PolyLinepoints.push([Number(pointString.slice(0, commaIndex))+ polyOriginX, Number(pointString.slice(commaIndex + 1, pointString.length))+polyOriginY]);
//			}
			
//			//trace(PolyLinepoints);
//			throw Error("error message");
		 return [[83,4131,0,83],[468,4034,0,468],[646,3997,0,646],[1094,3949,0,1094],[1658,3941,0,1658],[2126,4057,0,2126],[2561,4230,-200,2126+509.071],[3037,4535],[3418,4700],[3465,4704],[3503,4710],[4338,4760],[6996,4774],[7732,4769],[8232,4763],[8865,4733],[9321,4716],[9872,4615]];		}
		
		// it sets up all the objects by default, its kinda dumb but that option is there
		// this makes life easy  I must of stole this bit of code from somewhere its so clever but basically you 
		//just send this the type of oject you want and itll give you the an array of all the objects there
//		public function objectSetByLayer(type:String ="allTypes", name:String = null):Array
//		{
//		
//		}
		/** Ok as long as actionscript isnt weird i should be able to treat group layer as a boolean with a null or 3 as a default*/
		public function objectSet(type:String ="allTypes", name:String = null, groupLayer:uint =2, layer:String = null):Array
		{
			
			x =new XML //XML(new EmbeddedXML());
			var dataArray:Array = [];
			
			switch(groupLayer)
			{
				case 0:
				{
					for (var k:int = 0; k < x.objectgroup.length(); ++k)
					{
						if (x.layer.@name ==layer) 
						{
							for (i5 = 0; i5 < x.tileset.length(); i5++) 
							{
								if(x.objectgroup.object[k].@gid == x.tileset[i5].@firstgid){
									gid =Number(x.tileset[i5].@tileheight);
									break;
								}
								
							}
							// this should obviously be expanded but shouldwork for now
							dataArray.push([Number(x.objectgroup.object[k].@x),Number(x.objectgroup.object[k].@y)- gid]);
						}
					}
					break;
				}
				
				case 1:
				{
					for (var j:int = 0; j < x.objectgroup.length(); ++j)
					{ 
						if (x.objectgroup[j].@name ==layer) 
						{
							
							for (var i2:int = 0; i2 < x.objectgroup[j].object.length(); i2++) 
							{
								for (i5 = 0; i5 < x.tileset.length(); i5++) 
								{
									if(x.objectgroup[j].object[i2].@gid == x.tileset[i5].@firstgid){
										gid =Number(x.tileset[i5].@tileheight);
//										//trace(gid);
										break;
									}
									
								}
								
								dataArray.push([Number(x.objectgroup[j].object[i2].@x),Number(x.objectgroup[j].object[i2].@y)-gid]);	

							}
							
						}
					}
					break;
				}
				
				default:
				{
					for (var i:int = 0; i < x.objectgroup.object.length(); ++i)
					{
						if(type =="allTypes"){
							if(x.objectgroup.object[i].polyline){
								initPolyLine(XML(x.objectgroup.object[i].polyline), Number(x.objectgroup.object[i].@x), Number(x.objectgroup.object[i].@y));
							}else{
								dataArray.push([Number(x.objectgroup.object[i].@x),Number(x.objectgroup.object[i].@y)]);
							}
						}else if(x.objectgroup.object[i].@type){
							
							if (x.objectgroup.object[i].@type == type) 
							{
								if(type == "Ground"){
									
									dataArray = initPolyLine(XML(x.objectgroup.object[i].polyline), Number(x.objectgroup.object[i].@x), Number(x.objectgroup.object[i].@y-100));
								}else{
									if (type == "Trigger") 
									{
										
										if(x.objectgroup.object[i].@name == name)
											dataArray.push([Number(x.objectgroup.object[i].@x),Number(x.objectgroup.object[i].@y),Number(x.objectgroup.object[i].@width),Number(x.objectgroup.object[i].@height)]);
									}else{
										for (i5 = 0; i5 < x.tileset.length(); i5++) 
										{
											
											if(x.objectgroup.object[i].@gid == x.tileset[i5].@firstgid){
												gid =Number(x.tileset[i5].@tileheight);	
												////trace(gid);
												break;
											}
											////trace(x.objectgroup.object[i].@gid, " ",x.tileset[i5].@firstgid);
										}
										if(name == null)
											dataArray.push([Number(x.objectgroup.object[i].@x),Number(x.objectgroup.object[i].@y)-gid]);
										else if(x.objectgroup.object[i].@name == name)
											dataArray.push([Number(x.objectgroup.object[i].@x),Number(x.objectgroup.object[i].@y)-gid]);
									}
								}
							}
							
						}
					}
					
					break;
				}
			}
			
			return dataArray;
		}
		

		public function get PolyLinepoints():Array
		{
			return _PolyLinepoints;
		}

		public function set PolyLinepoints(value:Array):void
		{
			_PolyLinepoints = value;
		}
		
		
//		private function init(event:Event):void{
//			var myXML:XML = XML(myLoader.data)
//			var xmlDoc:XMLDocument = new XMLDocument();
//			xmlDoc.ignoreWhite = true;
//			var platformCoodXML:XML = XML(myLoader.data);
//			xmlDoc.parseXML(platformCoodXML.toXMLString());
//			
//			//trace(xmlDoc);
//		}
	}
}