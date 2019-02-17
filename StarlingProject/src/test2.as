package
{
	import com.jonLwiza.engine.GeneralElements.Director;

	public final class TestResourses
	{
		public function TestResourses()
		{
		}
		
		public function TestScene():void
		{
			clearAll(); 
			Director.rings = [[4,5],[14,12],[8,25]];
		}
		
		private function clearAll():void
		{
			// takes all the arrays not being used and clears them for the next scene
			Director.rings = [];
		}
	}
}