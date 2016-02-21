/**
*	Level Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	Contains varients per level
*/

class Level {
	
	// Propeties
	private var enemysTotal:Number;
	private var simulEnemys:Number;
	private var enemDelayMax:Number		// Max number of seconds bw spawns
	
	// constructor
	public function Level(eTotal:Number, eSimul:Number, eDelayMax:Number)
	{
		// initialize
		this.totalEnemies = eTotal;
		this.sameTimeEnemys = eSimul;
		this.enemDelayMax = eDelayMax;
		
	} // end constructor
	
	// accessors & mutators
	public function set sameTimeEnemys (concurrent:Number):Void
	{
		// check if concurrent is bigger than total and adjust
		concurrent = (concurrent <= this.enemysTotal) ? (concurrent) : (this.enemysTotal);
		this.simulEnemys = concurrent;
	} // end set of simulEnemys
	public function get sameTimeEnemies():Number
	{
		return this.simulEnemys;
	} // end get of simulEnemys
	
	public function set eDelayMax(eDelay:Number):Void
	{
		this.enemDelayMax = eDelay;
	}
	
	public function get eDelayMax():Number
	{
		return this.enemDelayMax;
	}
	
	public function set totalEnemies(total:Number):Void
	{
		this.enemysTotal = total;
	} // end set of enemysTotal
	public function get totalEnemies():Number
	{
		return this.enemysTotal;
	} // end get of enemysTotal
	
} // end Level class


