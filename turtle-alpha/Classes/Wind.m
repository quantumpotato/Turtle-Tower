//
//  Wind.m
//  TurtleTower
//
//  Created by X3N0 on 11/12/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Wind.h"


@implementation Wind
@synthesize ticksleft, delegate;

-(void)startWithTicks:(int)ticks{
	self.ticksleft = ticks;
}
	
-(void)tick{
	self.ticksleft--;
}
-(float)windStrengthFromDifficulty:(int)difficulty{
	return 0;
}

@end