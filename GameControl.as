/**
*	GameControl Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	The Levels and Spawning Control
*	Requires: 	Enemy Class 
*				FlashTimer Class
*/

import flash.geom.Point;

dynamic class GameControl extends MovieClip {
	
	// Properties
	private var enemList:Array;
	private var powerupFrequency:Number;	// how often should powerups occur?
	
	// Objects
	private var levelManager:LevelManager;
	private var myTimer:FlashTimer;
	private var enemyFactory:Array;
	private var mainGuy:Object;

	
	// constructor
	public function GameControl()
	{
		
		// default settings
		this.enemList = new Array();	// to keep track of all spawned enemies
		this.enemyFactory = Array();	
		this.powerupFrequency = .4;		// create powerups only (x * 100)% of the time
		
		
		// prepare objects
		this.levelManager = new LevelManager();
		this.myTimer = new FlashTimer();
		this.mainGuy = _root.astroControl;
		// start fresh
		this.flushEnemies();
		
	}	//end constructor
	
	function onEnterFrame()
	{
		// first see if the player got hit
		this.playerHitCheck();
		
		this.myTimer.runTimeCheck();
		// see if there needs to be a level change
		this.levelManager.checkLevelStatus(this);
		// ignore enemy factory when displaying level screen
		if (this._alpha != 100)
		{
			// create enemies as needed
			this.eFactoryUpdate();
		} // end if
		
		// update enemy count box	
		_root.eCount.enemsLeft = this.enemyCount();
		
		_root.mc_powered._alpha = (this.myTimer.numRunners() == 0) ? (0) : (100);
	} // end
	
	
	// create an enemy outside of the Stage and allow it to start attacking.
	public function spawnEnemy():Void
	{
			// instantiate Enemy
			var newDepth:Number = _root.getNextHighestDepth();
			var enemyName:String = "enemy" + newDepth;
			// increase speed per level
			var speedPerLevel:Number = .996 - ((this.levelManager.currentLevel/1000))
			// instantiate Enemy class
			_root.attachMovie("furryEnemy", enemyName, newDepth, {eSpeed:speedPerLevel});
	
			this.enemList.push(enemyName);
			var spawnPoint:Point = getRandomSpawnPoint();
			// randomly place enemy
			with(eval("_root." + enemyName))
			{
				// set spawn location
				eLocation = spawnPoint;
			} // end with		
			
	} // end spawnEnemy
	
	// generate powerup on the board
	public function generatePowerup(startingPoint:Point):Void
	{
		// instantiate powerup
		var newDepth:Number = _root.getNextHighestDepth();
		var instanceName:String = "pUp" + newDepth;
		// instantiate Enemy class
		_root.attachMovie("Powerup", instanceName, newDepth, {startPos:startingPoint});
	
	} // end generatePowerup
	
	public function startGame():Void
	{
		this.displayLevel();
	} // end startGame
	
	public function hitPowerup(doPowerup:String):Void
	{

		switch(doPowerup)
		{
			case "speed":
				// Speed up the player
				this.myTimer.timeTask("_root.astroControl.jetForce", 7, 3000);
				break;
			case "fire":
				// increase fire rate
				this.myTimer.timeTask("_root.bulletMon.bulCost", 3, 5000);
				break;
			case "power":
				// increse firepower and splash damage
				this.myTimer.timeTask("_root.bulBam", 3, 5000);
				break;
			case "omnibomb":
				// drop the omnibomb bullet
				var curPos:Point = new Point(_root.mainChar._x, _root.mainChar._y);
				_root.bulletMon.omniBomb(curPos);
				break;
			case "friction":
				// reduce friction
				this.myTimer.timeTask("_root.astroControl.friction", .7, 7000);
				break;
			case "reverse":
				// reverse jets for the player
				this.myTimer.timeTask("_root.astroControl.jetForce", (-1 * _root.astroControl.jetForce), 5000);
				break;
			case "thin":
				// make player thin
				this.myTimer.timeTask("_root.mainChar._xscale", 1, 8500);
				break;
			case "destroy":
				// destroy all current enemies
				this.screenWipe()
				break;
		}
	} // end hitPowerup
	
	public function randomPowerup(eLocation:Point)
	{
		if(Math.random() < this.powerupFrequency)
		{
			_root.gcMain.generatePowerup(eLocation);
		} // end if
	} // end randomPowerup
	
	////////////////////////////////////////////////////
	////	PRIVATE METHODS
	////////////////////////////////////////////////////

	// verify the player has not been hit.
	private function playerHitCheck():Void
	{
		var icount:Number;
		var curEnemy:Enemy;
		for (icount = 0; icount < this.enemList.length; icount++)
		{
			curEnemy = eval("_root." + this.enemList[icount]);
			
			// if enemy has hit given object		
			if(curEnemy.hitTest(_root.mainChar._x, _root.mainChar._y, true))
			{
				
				_root.astroControl.health -= 15;
				// see if player is dead
				if ((_root.astroControl.health <= 0) && (_root.astroControl.isAlive == true))
				{
					// YOU DIED!
					this.killPlayer();
				} // end if
			} // end if
			
		} // end for
		
	} // end playerHitCheck
	
	// death
	private function killPlayer():Void
	{
		this.screenHide();
		_root.astroControl.isAlive = false;
 		_root.mainChar.iCharacter.gotoAndPlay("dead");
		this.enemyFactory = new Array();
		this.clearLevelData();	
	}

	// destroy all enemies
	private function screenWipe():Void
	{
		for (var myCount:Number = 0; myCount < this.enemList.length; myCount++)
		{
			var curName:String = String(this.enemList[myCount]);
			_root[curName].struck(1000);
		} // end for
	} // end screenWipe
	
	// hide all enemies
	private function screenHide():Void
	{
		for (var myCount:Number = 0; myCount < this.enemList.length; myCount++)
		{
			var curName:String = String(this.enemList[myCount]);
			_root[curName]._alpha = 0;
			//_root[curName].isAlive = false;
		} // end for
	} // end screenHide
	
	private function enemyCount():Number
	{
		// calculate and return enemy count
		return (this.levelManager.curTotalEnemies - _root.enemiesDestroyed);
	} // enemyCount
	
	private function eFactoryUpdate():Void
	{
		// calculate number of enemies that exist
		var spawnedEnemies:Number = this.enemList.length - _root.enemiesDestroyed;
		// calculate number of enemies that are in production
		var enemyProduction = this.enemyFactory.length;
		
		// see if current number of enemies is sufficient
		if ((spawnedEnemies + enemyProduction) != this.levelManager.curESimul)
		{
			// Check if enemy limit for this level has been reached.
			if ((this.enemList.length + enemyProduction) < this.levelManager.curTotalEnemies)
			{
				// only generate if alive
				if (_root.astroControl.isAlive == true)
				{
					// We're good so put an enemy into production
					var timeCoefficient:Number = 1000;
					var birthday:Number = getTimer() + (Math.random() * timeCoefficient * this.levelManager.curDelayMax);
					this.enemyFactory.push(birthday);
				}
			} // end if
		} // end if
		
		// check enemy factory if an enemy is ready for spawning
		var factoryCheck:Array = new Array();
		for (var x:Number = 0; x < this.enemyFactory.length; x++)
		{
			// if an enemy has reached it's birthday
			var currentDate:Number = this.enemyFactory[x];
			if(currentDate < getTimer())
			{
				this.spawnEnemy();
			}
			else
			{
				factoryCheck.push(currentDate);
			} // end if
		} // end for looop
		
		// keep only the enemies yet to be born.
		this.enemyFactory = factoryCheck;

	} // end eFactory Update function
	
	// destroy enemylist for a clean start
	private function flushEnemies():Void
	{
		_root.enemiesDestroyed = 0;
		this.enemList = new Array();
	} // end flushEnemies

	private function clearLevelData():Void
	{
		this.flushEnemies();
		this.myTimer.runFlush();
	}
	
	private function displayLevel():Void
	{
		this._alpha = 100;
		this.gotoAndPlay(1);
		this.myLevel = this.levelManager.currentLevel;
		
	} // end displayLevel
	
	// spawn off screen
	private function getRandomSpawnPoint():Point
	{
		var sizeBuffer:Number = 300;
		var spawnPoint:Point = new Point();
		// choose offscreen side 1 of 4
		var mySide:Number = Math.ceil(Math.random() * 4);
		switch(mySide)
		{
			case 1:	// left
					spawnPoint.x = 0;
					spawnPoint.y = Stage.height * Math.random();
					break;
			case 2: // right
					spawnPoint.x = Stage.width + sizeBuffer;
					spawnPoint.y = Stage.height * Math.random();			
					break;
			case 3: // top
					spawnPoint.x = Stage.width * Math.random();
					spawnPoint.y = 0;			
					break;
			case 4: // bottom
					spawnPoint.x = Stage.width * Math.random();
					spawnPoint.y = Stage.height + sizeBuffer;			
					break;
			
		} // end switch
		
		return spawnPoint;
	} // end getRandomSpawnPoint()
	
	// check for collisions
	private function checkEnemHits(original:MovieClip, bullPower:Number):Boolean
	{
		// check if given object has hit an enemy.
		var collision:Boolean = false;
		var icount:Number;
		var curEnemy:Enemy;
		for (icount = 0; icount < this.enemList.length; icount++)
		{
			curEnemy = eval("_root." + this.enemList[icount]);
			
			// if enemy has hit given object		
			if(curEnemy.hitTest(original))
			{
				collision = true;
				curEnemy.struck(bullPower);
			} // end if
			
		} // end for
		
		// return if the bullet has hit any enemies
		return collision;
		
	} // end checkEnemHits
	
		
} // end GameControl class