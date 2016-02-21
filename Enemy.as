/**
*	Ememy Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	The Enemy programming
*/

import flash.geom.Point;

dynamic class Enemy extends MovieClip {
	
	// Properties
	public var eSpeed:Number;
	public var eHealth:Number;
	public var eLocation:Point;

	private var maxShapes:Number;
	private var alive:Boolean;
	private var dive:Number
	
	// constructor
	public function Enemy()
	{
		// default settings
		this.maxShapes = 3;
		//this.eSpeed = 0.995;	// must be between 0 and 1
		this.dive = 05;		// speed added when close
		this.eHealth = 100;
		this.eLocation = new Point(this._x, this._y);
		this.isAlive = true;
		// begin off screen
		this._x = -500;
		this._y = -500;
		
		// randomly choose shape
		var chooseShape:Number = Math.ceil(Math.random() * this.maxShapes);
		this.gotoAndStop("furry" + chooseShape);

	}	//end constructor
	
	function onEnterFrame()
	{
		var heroPos:Point = new Point(_root.mainChar._x, _root.mainChar._y);
		advanceAttack(heroPos);
	}	// end onEnterFrame

	public function struck(damage:Number):Void
	{
		this.eHealth -= damage;

		if ((this.eHealth <= 0) && (this.alive == true))
		{
			this.isAlive = false;
		} // end if
	} // end struck
	
	//////////////////////////////////////// Mutators
	public function set isAlive(status:Boolean):Void
	{
		if (status == true)
		{
			this.alive = true;
		}
		else
		{
			_root.enemiesDestroyed++;
			this.alive = false;
			this.play();
			// messy game specific code
			_root.gcMain.randomPowerup(this.eLocation);
		}
	} // end mutator
	
	//////////////////////////////////////// Accessors
	public function get isAlive():Boolean
	{
		return this.alive;
	}
	
	////////////////////////////////////////////////////
	////	PRIVATE FUNCTIONS
	////////////////////////////////////////////////////	
	private function advanceAttack(myDestination:Point):Void
	{
		var newLocation:Point = new Point();
		newLocation = Point.interpolate(this.eLocation, myDestination, this.eSpeed);
		moveMe(newLocation);
	} // end advanceAttack
	
	private function moveMe(newPos:Point):Void
	{
		this._x = newPos.x;
		this._y = newPos.y;
		this.eLocation = newPos.clone();
	} // end moveMe
	
	private function debugPoint(myPoint:Point):Void
	{
		trace(myPoint.x);
		trace(myPoint.y);
	} // end debugPoint
	
} // end Enemy class