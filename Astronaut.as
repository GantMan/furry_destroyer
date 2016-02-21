/**
*	Astronaut Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	This is to handle the game logic for the astronaut in space
*/

class Astronaut {
	
	// Astronaut Propeties
	private var myMomentum:Momentum;
	private var friction:Number;
	private var jetForce:Number;
	public var hasFriction:Boolean;
	public var health:Number;
	public var isAlive:Boolean;

	// Astronaut constructor
	public function Astronaut() 
	{
		
		// initialize defaults
		this.spaceFriction = .9;			// space friction (WAHAHAHAHA!)
		this.jetPower = 2;					// force from jetpack
		this.hasFriction = true;
		this.health = 1;
		this.isAlive = true;
		
		// create new velocity with zero speed
		this.myMomentum = new Momentum(0,0);
		
	} // end constructor
	
	public function applyThrust(curAngle:Number):Void
	{
		// set X and Y momentum by angle		
		this.myMomentum.setFromPolar(curAngle, this.jetForce);
	} // end applyThrust
	
	public function applyFriction():Void
	{
		if (this.hasFriction)
		{
			// apply friction to slow astronaut
			this.myMomentum.x = (this.myMomentum.x * this.friction);
			this.myMomentum.y = (this.myMomentum.y * this.friction);
		} // end if
	}
	
	public function getNextXPos(currentXPos:Number):Number
	{
		// apply the force to the current position and return
		currentXPos += this.myMomentum.x;
		
		// keep on screen
		currentXPos %= Stage.width;
		currentXPos = (currentXPos < 0) ? (Stage.width) : (currentXPos);
		
		return currentXPos;		
	} // end getNextPos

	public function getNextYPos(currentYPos:Number):Number
	{
		// apply the force to the current position and return
		currentYPos += this.myMomentum.y;
		
		// keep on screen
		currentYPos %= Stage.height;
		currentYPos = (currentYPos < 0) ? (Stage.height) : (currentYPos);
		
		return currentYPos;	
	} // end getNextPos

	//////////////////////////////////////// Mutators
	public function set jetPower (newJet:Number):Void
	{
		this.jetForce = newJet;		// force from jetpack
	} // end setJetForce
	
	// 0 = 100% friction
	// 1 = No friction
	public function set spaceFriction (newFriction:Number):Void
	{
		// keep within friction bounds
		newFriction = (newFriction < 0) ? (0) : (newFriction);
		newFriction = (newFriction > 1) ? (1) : (newFriction);
		
		// set spaceFriction
		this.friction = newFriction;
	} // end setFriction
	
	/*
	*	ALREADY AVAILABLE IN THE POINT CLASS
	*/
	
	////////////////////////////////////////////////////
	////	PRIVATE FUNCTIONS
	////////////////////////////////////////////////////
	private function convertToRadians(degrees:Number):Number
	{
		return degrees * (Math.PI/180);
	}  // end convert to Radians
	
} // end Astronaut class


