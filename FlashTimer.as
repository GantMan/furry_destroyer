/**
*	FlashTimer Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Enables the ability to change a property for a given amount of time
*/

class FlashTimer {
	
	// Properties
	private var runList:Array;
	
	// constructor
	public function FlashTimer()
	{
		// default settings
		runList = new Array();
		
	}	//end constructor
	
	// sets the property to tempValue for mTime (milliseconds)
	public function timeTask(theProperty:String, tempValue:Number, mTime:Number):Void
	{
		// verify not already a timed task
		if (this.notTasked(theProperty))
		{
			// calculate when the value should switch back
			var calcExpire:Number = getTimer() + mTime;
			// keep original value
			var originalValue:Number = eval(theProperty);
			// set to temp valu instantly
			set(theProperty, tempValue);
			// queue value switchback on runList
			this.runList.push(Array(calcExpire, originalValue, theProperty));
		}
	}
	
	// see if there is anything in the run list
	public function numRunners():Number
	{
		return this.runList.length;
	}
	
	// every frame check for switchbacks
	public function runTimeCheck()
	{
		var workList:Array = new Array();
		var curArray:Array = new Array();
		
		// iterate the command listing
		while(this.runList.length > 0)
		{
			// grab one
			curArray = Array(this.runList.pop());
			
			// check for expiration
			if(getTimer() > curArray[0][0])
			{
				// Expired: execute current array element value change
				set(curArray[0][2], curArray[0][1]);
			}
			else
			{
				// Not Expired: package for storage
				workList.push(curArray[0]);
			} // end if
			
		} // end array

		// if packaged items, then store them
		if (workList.length != 0)
		{
			this.runList = workList;
		} // end if
		
		
	} // end runTimeCheck
	
	// clear out the runList
	public function runFlush()
	{
		while(this.runList.length > 0)
		{
			var curArray:Array = Array(this.runList.pop());
			set(curArray[0][2], curArray[0][1]);
		} // end while
	} // end runFlush
	
	// verify if property is already being tasked
	private function notTasked(theProperty:String):Boolean
	{
		for (var iCount:Number = 0; iCount < this.runList.length; iCount++)
		{
			if(this.runList[iCount][2] == theProperty)
			{
				// match found
				return false;
			}  // end if
		} // end for
		
		return true;
	} // end function
	
} // end FlashTimer class