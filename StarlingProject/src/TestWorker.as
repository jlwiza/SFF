package 
{
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.NSprite;
	import flash.display3D.Context3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	//import starling.textures.Texture;
	
	public class TestWorker extends Sprite
	{
		
		private var commandChannel:MessageChannel;
		private var progressChannel:MessageChannel;
		private var resultChannel:MessageChannel;
		private var fBitmapLoader:Loader;
		private var imageBytes:ByteArray;
		
		public function TestWorker()
		{
			//TODO: implement function
			initialize();
		}
		
		
		private function initialize():void
		{
			
			
			// Get the MessageChannel objects to use for communicating between workers
			// This one is for receiving messages from the parent worker
			commandChannel = Worker.current.getSharedProperty("incomingCommandChannel") as MessageChannel;
			commandChannel.addEventListener(Event.CHANNEL_MESSAGE, handleCommandMessage);
			
			// These are for sending messages to the parent worker
			resultChannel = Worker.current.getSharedProperty("resultChannel") as MessageChannel;
			
			commandChannel.receive(true);
			//var result:CountResult = new CountResult(targetValue, elapsedTime / 1000);
			//resultChannel.send(result);
			
			
		} 
		
		private function handleCommandMessage(event:Event):void
		{
			
			
			//var message:Vector3 = commandChannel.receive() as Vector3;
//			
			
			
				//imageBytes = commandChannel.receive();
				var bmp:Bitmap = new Bitmap();
				
				bmp.bitmapData.setPixels(bmp.bitmapData.rect, commandChannel.receive());
				
				//started = true;
				//var	bmp:Bitmap = message[0] as Bitmap;
				//var result:Texture = Texture.fromBitmap(bmp);
//				var result:Texture = new Texture();
//				var stuff:Context3D = new Context3D();
//				//stuff.
//				//trace(result, "let us see");
//				var data:ByteArray = new ByteArray()//result as ByteArray;
//				data.writeBytes(result as ByteArray);
//				result.uploadFromByteArray(data, 0);
//				//trace(result, "thisis what happened");
					//flash.display3D.textures.Texture
				//resultChannel.send(result);
				
			//}
		}
		
//		protected function textureLoaded(event:Event):void
//		{
//			fBitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, textureLoaded);
//			var sprite:DisplayObject =fBitmapLoader.content
//			var	bmp:Bitmap = Bitmap(sprite);
//			var result:Texture = Texture.fromBitmap(bmp);
//			resultChannel.send(result);
//		
//			//finished = true;
//		}		
		
		
	}
}