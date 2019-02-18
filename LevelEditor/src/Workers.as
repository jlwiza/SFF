/*******************************************************************************************************************************************
 * This is an automatically generated class. Please do not modify it since your changes may be lost in the following circumstances:
 *     - Members will be added to this class whenever an embedded worker is added.
 *     - Members in this class will be renamed when a worker is renamed or moved to a different package.
 *     - Members in this class will be removed when a worker is deleted.
 *******************************************************************************************************************************************/

package 
{
	
	import flash.utils.ByteArray;
	
	public class Workers
	{
		
		[Embed(source="../workerswfs/TestWorker.swf", mimeType="application/octet-stream")]
		private static var TestWorker_ByteClass:Class;
		
//		[Embed(source="../workerswfs/Assets.swf", mimeType="application/octet-stream")]
//		private static var Assets_ByteClass:Class;
		public static function get TestWorker():ByteArray
		{
			return new TestWorker_ByteClass();
		}
		
//		public static function get Assets():ByteArray
//		{
//			return new Assets_ByteClass();
//		}
		
		
	}
}
