/**
*	LevelManager Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Manages the different levels for the game control
*/

class LevelManager {
	
	// Propeties
	public var currentLevel:Number;
	
	private var levels:Array;
	
	// Velocity constructor
	public function LevelManager()
	{
		
		// initialize
		this.currentLevel = 1;			// start on level 1
		_root.currentLevel = 1;			// for outside scenes
		this.setLevels();
		
	} // end constructor
	
	//////////////////////////////////////////////// Accessors
	// get current level simultaneous enemy count
	public function get curESimul():Number
	{
		return this.levels[0].sameTimeEnemies;
	}
	
	// get current level simultaneous enemy count
	public function get curDelayMax():Number
	{
		return this.levels[0].eDelayMax;
	}
	
	// get current level max enemies
	public function get curTotalEnemies():Number
	{
		return this.levels[0].totalEnemies;
	}
	
	//////////////////////////////////////////////// Mutators

	
	////////////////////////////////////////////////////
	////	PRIVATE METHODS
	////////////////////////////////////////////////////
	public function checkLevelStatus(gameControl:MovieClip):Void
	{
		
		/****************************************
		* 	Variables for LEVEL calculations
		*****************************************/

		// calculate number of enemies killed
		var enemKills = _root.enemiesDestroyed;
		
		/****************************************\
		* 	Game Logic							 
		*****************************************/
		// check if level is over
		if (enemKills == this.levels[0].totalEnemies)
		{
			
			// Attempt to go to next level and display it
			if(this.levelUp(gameControl))
			{
				gameControl.clearLevelData();
				gameControl.displayLevel();
			}
			else	// we're out of levels
			{
				_root.gotoAndPlay("youWin");
			} // end if
			
		} // end if

	} // end checkLevelStatus
	
	private function levelUp():Boolean
	{
		// pull off first index
		this.levels.shift();
		// move level counter up
		this.currentLevel++;
		_root.currentLevel = this.currentLevel;
		
		// more levels?
		return (this.levels.length != 0);
	}
	
	private function setLevels():Void
	{
		// make levels
		this.levels = Array();			// all levels array
		// level 1
		var level1:Level = new Level(3, 1, 1);
		this.levels.push(level1);
		// level 2
		var level2:Level = new Level(9, 2, 4);
		this.levels.push(level2);
		// level 3
		var level3:Level = new Level(10, 4, 5);
		this.levels.push(level3);
		// level 4
		var level4:Level = new Level(10, 4, 1);
		this.levels.push(level4);
		// level 5
		var level5:Level = new Level(15, 5, 1);
		this.levels.push(level5);
		// level 6
		var level6:Level = new Level(15, 6, 3);
		this.levels.push(level6);
		// level 7
		var level7:Level = new Level(16, 7, 1);
		this.levels.push(level7);
		// level 8
		var level8:Level = new Level(20, 8, 1);
		this.levels.push(level8);
		// level 9
		var level9:Level = new Level(20, 10, 1);
		this.levels.push(level9);
		// level 10
		var level10:Level = new Level(25, 10, 1);
		this.levels.push(level10);
	} // end setLevels

	
} // end class


