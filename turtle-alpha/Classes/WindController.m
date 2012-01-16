//
//  WindController.m
//  TurtleTower
//
//  Created by X3N0 on 11/16/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "WindController.h"


@implementation WindController
@synthesize windActiveControl, earlyGameWindControl, windInactiveControl;

-(void)initSetup{
	self.activeControl = [[DifficultyControl alloc] init];
	self.windActiveControl = [[WindActiveControl alloc] init];
	self.earlyGameWindControl = [[EarlyGameWindControl alloc] init];
	[self reset];
}	

-(void)reset{
	[super reset];
	self.activeControl = self.earlyGameWindControl;
	self.activeReset = 5;  
	self.inactiveReset = 6;
}

-(void)activateWind{
	self.activeControl = self.windActiveControl;	
	self.tickLeft = self.activeReset;
	self.savedEffect = [self.activeControl calculateEffectForLevel:self.level withMaximum:self.maxEffect];
}

-(void)calculateResets{
	if (self.level >= 25 && self.level < 30){
		if (level == 25){
		[self activateWind];
		}		
		self.maxEffect++;	
	}
	
	if (self.level >= 70 && self.level < 75){
		self.inactiveReset--;	
	}
}

-(void)tickExpired:(DifficultyControl *)expiredControl{
	if ([expiredControl isKindOfClass:[self.windActiveControl class]]){
		if (self.inactiveReset > 0){
			self.activeControl = self.windInactiveControl;
			self.tickLeft = self.inactiveReset;
		}else{
			[self activateWind];	
		}
		return;
	}else if ([expiredControl isKindOfClass:[self.windInactiveControl class]]){
		[self activateWind];
	}
}

-(float)calculateEffect{
	return self.savedEffect;
}

-(void)dealloc {
	self.activeControl = nil;
	self.windActiveControl = nil;
	self.earlyGameWindControl = nil;
	[super dealloc];
}

@end