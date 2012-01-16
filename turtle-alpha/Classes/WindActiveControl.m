//
//  WindActiveControl.m
//  TurtleTower
//
//  Created by X3N0 on 11/16/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "WindActiveControl.h"


@implementation WindActiveControl

-(float)calculateEffectForLevel:(int)level withMaximum:(int)max{

	int randomWind;
	float activeWind;
	if (max > 1){
		randomWind = arc4random() % max;
		randomWind++;
	}else{
		randomWind=1;	
	}
	
	activeWind = randomWind * .5 + .5;
	//Randomize wind
	int changeWind = arc4random() % 2;
	if (changeWind == 1){
		activeWind = -activeWind;	
	}
	
	return activeWind;
}

@end
