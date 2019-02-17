package com.jonLwiza.engine.helperTypes
{
	import flashx.textLayout.elements.BreakElement;

	public class Insertion
	{
		public function Insertion()
		{
		}
		
		public static function sort(a:Array):void
		{
			var N:int = a.length;
			for(var i:int = 0; i < N;i++)
			{
				for (var j:int = i; j >0; j--) 
				{
					if(a[j] < a[j-1])
						exch(a,j,j-1);
						else break;
				}
			}
			
			
		}
		private static function exch(a:Array,i:int, j:Number):void
		{
			var swap:Number = a[i];
			a[i] = a[j];
			a[j] = swap;
		}
		
	}
}