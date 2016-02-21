/**
*	Powerup Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Handles powerups around the stage
*	Requires: _root.gcMain:GameControl Class
*			  FlashTimer.as
*/

import flash.geom.Point;

dynamic class Powerup extends MovieClip {
	
	// Properties
	private var myMomentum:Momentum;
	// start position
	public var startPos:Point;
	// Momentum X and Y
	public var momX:Number;
	public var momY:Number;
	// powerup list associative array
	public var pList:Array;
	// what is my powerup?
	public var myPower:String;
	private var isAlive:Boolean;
	
	// game specific variables
	public var myGC:GameControl;
	public var myCharacter:MovieClip;
	
	// constructor
	public function Powerup()
	{
		// default properties
		this._x = this.startPos.x;
		this._y = this.startPos.y;
		this.isAlive = true;
		
		// set objects to this game
		myGC = _root.gcMain;
		myCharacter = _root.mainChar;
		
		// random momentum
		var randXM:Number = Math.floor(Math.random() * 3) -1;
		var randYM:Number = Math.floor(Math.random() * 3) -1;
		this.myMomentum = new Momentum(randXM, randYM);
		
		// initialize array 
		this.pList = new Array();
		// add all powerups to the list, in order
		this.pList[0] = "speed";
		this.pList[1] = "fire";
		this.pList[2] = "power";
		this.pList[3] = "omnibomb";
		this.pList[4] = "friction";
		this.pList[5] = "reverse";
		this.pList[6] = "thin";
		this.pList[7] = "destroy";
		
		this.randomizePowerup();
	
		this._width = 30;
		this._height = 30;
		
	}	//end constructor
	
	// override EnterFrame
	public function onEnterFrame()
	{
		// do motion hur
		this._x += this.myMomentum.x;
		this._y += this.myMomentum.y;
		
		// stop Powerup from going on infinitely
		verifyBounds();
		
		// check if this Powerup has hit player
		if (this.isAlive)
		{
			checkHit();
		} // end if
		
	} // end enterframe

	
	////////////////////////////////////////////////////
	////	PRIVATE FUNCTIONS
	////////////////////////////////////////////////////	
	private function randomizePowerup():Void
	{
		var randomPowerup:Number;
		randomPowerup = Math.floor(Math.random() * this.pList.length);
		this.gotoAndStop(this.pList[randomPowerup]);
		this.myPower = this.pList[randomPowerup];
	} // end randomize powerup
	
	private function checkHit():Void
	{
		if (this.hitTest(this.myCharacter))
		{
			this.gotoAndPlay("hit");
			this.powerText = this.myPower;
			this.isAlive = false;
			// pass powerup to game control
			this.myGC.hitPowerup(this.myPower);
		} // end if
	} // end checkHit

	private function verifyBounds():Void
	{
		var stayAlive:Boolean = true;
		// watch left side
		stayAlive = (this._x < 0) ? (false) : (stayAlive);
		// watch right side
		stayAlive = (this._x > Stage.width) ? (false) : (stayAlive);
		// watch top
		stayAlive = (this._y < 0) ? (false) : (stayAlive);
		// watch bottom
		stayAlive = (this._y < Stage.height) ? (false) : (stayAlive);
		
		// if offscreen then allow to die
		if(stayeAlive == false) 
		{
			this.removeMovieClip();
		}
	} // end verifyBounds
	
} // end Powerup class