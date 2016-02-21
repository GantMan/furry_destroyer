/**
*	Menu Class
*	~Created by Gant Laborde
*-------------------------------------------------------------
*	This is to help automate the menu options and settings. DUH.
*/

import mx.transitions.Tween;
import mx.transitions.easing.*;

class Menu {
	
	// Menu Propeties
	var scaleAmount:Number;

	// Menu constructor
	public function Menu() 
	{
		
		// when elastic, scale up 30%
		this.scaleAmount = 30;
		
	} // end constructor
	
	public function makeBig(theMC:MovieClip):Void
	{
		// Find new scale size
		var curScaleX:Number = theMC._xscale;
		var curScaleY:Number = theMC._yscale;
		var newScaleX:Number = curScaleX + this.scaleAmount;
		var newScaleY:Number = curScaleY + this.scaleAmount;
	
		// Do tween
		new Tween(theMC, "_xscale", Elastic.easeOut, curScaleX, newScaleX, 1, true);
		new Tween(theMC, "_yscale", Elastic.easeOut, curScaleY, newScaleY, 1, true);	
	} // end makeBig

	public function makeNormal(theMC:MovieClip, originalScale:Number):Void
	{
		new Tween(theMC, "_xscale", Elastic.easeOut, theMC._xscale, originalScale, 1, true);
		new Tween(theMC, "_yscale", Elastic.easeOut, theMC._yscale, originalScale, 1, true);	
	}// end makeNormal
	
	public function fadeOut(theMC:MovieClip):Void
	{
		new Tween(theMC, "_alpha", null, 100, 0, 1, true); 
	} // end fadeOut
	
	
} // end Menu class