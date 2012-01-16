//
//  ActiveWind
//  TurtleTower
//
//  Created by X3N0 on 11/12/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "ActiveWind.h"


@implementation ActiveWind

-(void)tick{
	[super tick];
	if (self.ticksleft <= 0){
		[self.delegate activeWindExpired];	
	}
}	

-(float)windStrengthFromDifficulty:(int)difficulty{
	//logic here	

	int randomWind;
	float activeWind;
	if (difficulty > 1){
		randomWind = arc4random() % difficulty;
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
