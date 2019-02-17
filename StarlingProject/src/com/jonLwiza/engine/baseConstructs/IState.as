package com.jonLwiza.engine.baseConstructs
{
	import com.jonLwiza.engine.helperTypes.Status;

	public interface IState
	{
		function initialize():void;
		function update():Status;
		function exit(status:Status):void;
	}
}