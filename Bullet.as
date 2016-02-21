/**
*	Bullet Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Handling all the momentum and more for bullets
*	Requires: _root.gcMain:GameControl Class
*				Enemy Class
*/

import flash.geom.Point;

dynamic class Bullet extends MovieClip {
	
	// Bullet Properties
	private var myMomentum:Momentum;
	// start position
	public var startPos:Point;
	// Momentum X and Y
	public var momX:Number;
	public var momY:Number;
	// power of bullet
	public var bullPower:Number;
	// scale bullet physics
	public var bulScale:Number;
	
	// constructor
	public function Bullet()
	{
		// default properties
		this._x = this.startPos.x;
		this._y = this.startPos.y;
		// start with no momentum
		this.myMomentum = new Momentum(0,0);
		this.bullPower = 2 * this.bulScale;
		this._xscale = 100 * this.bulScale;
		this._yscale = 100 * this.bulScale;
	}	//end constructor
	
	// override EnterFrame
	public function onEnterFrame()
	{
		// do motion hur
		this._x += this.myMomentum.x;
		this._y += this.myMomentum.y;
		
		// stop bullet from going on infinitely
		verifyBounds();
		
		// check if this bullet has hit an enemy
		checkHit();
		
	} // end enterframe

	public function trajectory(myAngle:Number, mySpeed:Number):Void
	{
		this.myMomentum.setFromPolar(myAngle, mySpeed);
	} // end trajectory	
	
	
	////////////////////////////////////////////////////
	////	PRIVATE FUNCTIONS
	////////////////////////////////////////////////////	
	private function checkHit():Void
	{
		/*
		var hitWith:Enemy = _root.gcMain.checkEnemHits(this);
		// if collision occurred with an enemy
		if(hitWith != null)
		{
			hitWith.struck(this.bullPower);
			this.play();
		}
		*/
		
		if (_root.gcMain.checkEnemHits(this, this.bullPower))
		{
			// bullet hit an enemy so play
			this.play();
		} // end if
	}

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
	
} // end Bullet class