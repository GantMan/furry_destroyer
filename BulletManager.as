/**
*	BulletManager Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Handling all the bullets
*/

import flash.geom.Point;

dynamic class BulletManager extends MovieClip {
	
	// Properties
	public var fireSpeed:Number;
	public var firePercent:Number;
	public var bulletSpeed:Number;
	public var bulCost:Number;
	public var jitter:Number;
	
	private var bulletCount:Number;
	private var fireSound:Sound;
	
	// constructor
	public function BulletManager()
	{
		// initialize defaults
		this.fireSpeed = 5;
		this.firePercent = 100;
		this.bulletSpeed = 10;
		this.bulletCount = 0;
		this.bulCost = 15;
		this.jitter = 0;
		
		this.fireSound = new Sound(this);
		this.fireSound.attachSound("pulse_id");
	}	//end constructor
	
	public function onEnterFrame()
	{
		
		// cap off at 100%
		if (this.firePercent > 100)
		{
			this.firePercent = 100;
		}
		else
		{
			this.firePercent++;
		}// end if
		
	} // end onEnterFrame
	
	// fire a bullet from current point, at current angle
	public function fire(curPos, curRot):Void
	{
		// verify bullet is ready to fire
		var isOK:Boolean = true;
		// verify wait for bullets
		isOK = ((this.bulletCount % this.fireSpeed) == 0) ? (isOK) : (false);
		// verify monitor is not empty
		isOK = (this.firePercent > 1) ? (isOK) : (false);
		
		if (isOK)
		{
			this.fireSound.start();
			var newDepth:Number = _root.getNextHighestDepth();
			var bulletName:String = "bul" + newDepth;
			// instantiate bullet
			_root.attachMovie("Bullet", bulletName, newDepth, {startPos:curPos, bulScale:_root.bulBam});
	
			var calcJitter:Number = (Math.random() * this.jitter) - Math.floor(this.jitter / 2);
	
			// give bullet velocity
			with(eval("_root." + bulletName))
			{
				trajectory(curRot + calcJitter, this.bulletSpeed);
			} // end with		
			
			// register a fire in the bar
			registerFire();
		} // end if

		// up bullets
		this.bulletCount++;
		
	} // end fire
	
	public function ready():Void
	{
		// get bullets ready
		this.bulletCount = 0;
	} // end ready
	
	public function omniBomb(curPos:Point):Void
	{
		var nextRot:Number = 0;
		for (var bulID:Number = 0; bulID < 10; bulID++)
		{
			nextRot += 36;
			var newDepth:Number = _root.getNextHighestDepth();
			var bulletName:String = "omni" + newDepth;
			// instantiate bullet
			_root.attachMovie("Bullet", bulletName, newDepth, {startPos:curPos, bulScale:3});
		
			// give bullet velocity
			with(eval("_root." + bulletName))
			{
				trajectory(nextRot, 5);
			} // end with		
		} // end for loop

	} // end omniBomb
	
	////////////////////////////////////////////////////
	////	PRIVATE FUNCTIONS
	////////////////////////////////////////////////////
	private function registerFire():Void
	{
		this.firePercent -= this.bulCost;
		
		// sync with graph
		if (this.firePercent > 0)
		{
			this.gotoAndPlay(this.firePercent);
		} 
		else
		{
			this.gotoAndPlay("empty");
		} // end if

	} // end registerFire
	
} // end BulletManager class