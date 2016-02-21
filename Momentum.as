/**
*	Momentum Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Momentum along the X and Y
*/

import flash.geom.Point;

class Momentum {
	
	// Velocity Propeties
	private var myX:Number;
	private var myY:Number;
	
	// Velocity constructor
	public function Momentum(startX:Number, startY:Number)
	{
		
		// initialize
		this.myX = startX;
		this.myY = startY;
		
	} // end constructor
	
	// calculate angled force in X & Y
	public function setFromPolar(myAngle:Number, mySpeed:Number):Void
	{
		this.myX += Math.sin(this.convertToRadians(myAngle)) * mySpeed;
		this.myY -= Math.cos(this.convertToRadians(myAngle)) * mySpeed;
	} // end setFromPolar
	
	//////////////////////////////////////////////// Accessors
	public function get x():Number
	{
		return this.myX;
	} // end getX
	
	public function get y():Number
	{
		return this.myY;
	} // end getY
	
	//////////////////////////////////////////////// Mutators
	public function set x(newX:Number):Void
	{
		this.myX = newX;
	} // end setX
	
	public function set y(newY:Number):Void
	{
		this.myY = newY;
	} // end setY
	
	////////////////////////////////////////////////////
	////	PRIVATE METHODS
	////////////////////////////////////////////////////
	private function convertToRadians(degrees:Number):Number
	{
		return degrees * (Math.PI/180);
	}

} // end Momentum class


