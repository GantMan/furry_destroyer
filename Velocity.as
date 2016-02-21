/**
*	Velocity Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Momentum along the X and Y
*/

class Velocity {
	
	// Velocity Propeties
	private var myX:Number;
	private var myY:Number;
	
	// Velocity constructor
	public function Velocity(startX:Number, startY:Number) 
	{
		
		// initialize
		this.myX = startX;
		this.myY = startY;
		
	} // end constructor
	
	//////////////////////////////////////////////// Accessors
	public function getX()
	{
		return this.myX;
	} // end getX
	
	public function getY()
	{
		return this.myY;
	} // end getY
	
	//////////////////////////////////////////////// Mutators
	public function setX(newX:Number)
	{
		this.myX = newX;
	} // end setX
	
	public function setY(newY:Number)
	{
		this.myY = newY;
	} // end setY
	
} // end Velocity class


