//
//  DifficultyController.m
//  TurtleTower
//
//  Created by X3N0 on 11/16/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "DifficultyController.h"


@implementation DifficultyController

@synthesize level, maxEffect, tickLeft, savedEffect, activeReset, inactiveReset;
@synthesize activeControl;

-(void)initSetup{
//Intended to be overridden	
}

-(void)reset{
	self.level = 1;
	self.tickLeft = 0;
	self.maxEffect = 0;
}

-(id)initWithTicks:(int)ticks{
	if ((self = [super init])){
		[self initSetup];
		[self reset];
		
	}
	return self;
}

-(void)tick{
	self.tickLeft--;
	if (self.tickLeft <= 0){
		[self tickExpired:self.activeControl];	
	}
}

-(float)calculateEffect{
	return [self.activeControl calculateEffectForLevel:self.level withMaximum:self.maxEffect];
}

-(void)calculateResets{
//Override with your own resets	
}

-(void)gainLevel{
	self.level++;
	[self calculateResets];
}

-(void)tickExpired:(DifficultyControl *)expiredControl{
	//Override with your own logic for switching controls
	[self calculateResets];
	 
}

@end
