//
//  DifficultyController.h
//  TurtleTower
//
//  Created by X3N0 on 11/16/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DifficultyControl.h"
//Wind controller has active/inactive


@interface DifficultyController : NSObject {
	int level;
	int maxEffect;
	int tickLeft;
	int activeReset;

	float savedEffect;
	int inactiveReset;
	
	DifficultyControl *activeControl;
	
}

@property(nonatomic) int level;
@property(nonatomic) int maxEffect;
@property(nonatomic) int tickLeft;
@property(nonatomic) int activeReset;
@property(nonatomic) int inactiveReset;
@property(nonatomic) float savedEffect;

@property(nonatomic,retain) DifficultyControl *activeControl;

-(float)calculateEffect;
-(void)tick;
-(void)tickExpired:(DifficultyControl *)expiredControl;
-(void)calculateResets;
-(void)gainLevel;
-(void)initSetup;
-(id)initWithTicks:(int)ticks;
-(void)reset;

@end
