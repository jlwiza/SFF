﻿package com.jonLwiza.engine.state{	import com.jonLwiza.engine.baseConstructs.BehaviorSelector;	import com.jonLwiza.engine.baseConstructs.Behaviour;	import com.jonLwiza.engine.baseConstructs.GeneralActor;	import com.jonLwiza.engine.helperTypes.Status;	import com.jonLwiza.engine.state.groupBehavior.Alone;	import com.jonLwiza.engine.state.groupBehavior.Interaction;
		public class GroupBehavior extends BehaviorSelector	{		private var alone:Alone = new Alone();		private var interact:Interaction = new Interaction()		private var _childNodes:Array = new Array();		private var currentChild:Behaviour = new Behaviour();		private var i:uint;				public function GroupBehavior(actor:GeneralActor=null)		{			super(actor);			childNodes = [alone, interact];		}																					}}