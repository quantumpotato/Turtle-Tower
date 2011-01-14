//
//  PatrolBirdController.m
//  TurtleTower
//
//  Created by X3N0 on 11/17/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "PatrolBirdController.h"

@implementation PatrolBirdController
@synthesize patrolBirdControl;

-(void)initSetup{
	self.activeControl = [[DifficultyControl alloc] init];
	self.patrolBirdControl = [[PatrolBirdControl alloc] init];
	self.activeControl = self.patrolBirdControl;
}

-(void)calculateResets{
	if (self.level >= 1 && self.level < 5){
		self.maxEffect++;		
	}
	
	if (self.level >= 70 && self.level < 75){
		self.maxEffect++;	
	}
}

-(float)calculateEffect{
	return [self.activeControl calculateEffectForLevel:self.level withMaximum:self.maxEffect];
}

@end
