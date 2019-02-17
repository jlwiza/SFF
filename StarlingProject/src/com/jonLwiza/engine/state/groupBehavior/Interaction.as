package com.jonLwiza.engine.state.groupBehavior
{
	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.state.groupBehavior.interaction.End;
	import com.jonLwiza.engine.state.groupBehavior.interaction.Fight;
	import com.jonLwiza.engine.state.groupBehavior.interaction.Spot;
	
	//change to sequence  later but for now leave as selector so i can just play with fight for just now
	// when you put it as spot make sure you ask if this is the first meeting or  they've met before.. the interaction is only started over if player leaves
	public class Interaction extends BehaviorSelector
	{
		private var spot:Spot = new Spot();
		private var fight:Fight = new Fight();
		private var end:End = new End();
		
		public function Interaction(actor:GeneralActor=null)
		{
			super(actor);
			childNodes = [spot,fight,end];
		}
	}
}