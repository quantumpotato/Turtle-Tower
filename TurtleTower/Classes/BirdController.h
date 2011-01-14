//
//  BirdController.h
//  TurtleTower
//
//  Created by X3N0 on 11/19/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatrolBird.h"
#import "CampBird.h"
#import "DivebombBird.h"

@protocol BirdControllerDelegate

-(void)didReceiveBirdForSpawner:(Bird *)bird;
-(void)didReceiveBird:(Bird *)bird;	

@end


@interface BirdController : NSObject {
	int maxPatrolBirds;
	int maxEmptyBird;
	int emptyBird;
	int maxCampBirds;	
	float highestPlatformY;
	int diffPBSpeed, diffPBOscillateValue, diffPBOscillateRate, diffPBDelay;
	int diffVertBirdSpeed;
	int diffVertBirdDelay;
	int diffPBSpeedtick;
	int birdsGenerated;	
	BOOL generated;
	
	id <BirdControllerDelegate> delegate;
	
	int divebombCountdown;
	int divebombCountdownReset;
	int diffDivebombCountdown;
	int diffDivebombBirdSpeed;
	
	int level;
	
	BOOL tright;
	
	int platformWeight, campWeight, emptyWeight;
	
	int forcedEmptyLeft, forcedEmptyReset;
	int maxBirds;
}

@property(nonatomic) BOOL tright;
@property(nonatomic) int level;
@property(nonatomic,retain) id <BirdControllerDelegate> delegate;

@property(nonatomic) int maxPatrolBirds;
@property(nonatomic) int maxEmptyBird;
@property(nonatomic) int emptyBird;
@property(nonatomic) int maxCampBirds;
@property(nonatomic) float highestPlatformY;
@property(nonatomic) int diffPBSpeed;
@property(nonatomic) int diffPBOscillateValue;
@property(nonatomic) int diffPBOscillateRate;
@property(nonatomic) int diffPBDelay;
@property(nonatomic) int diffVertBirdSpeed;
@property(nonatomic) int diffVertBirdDelay;
@property(nonatomic) int diffPBSpeedtick;
@property(nonatomic) int birdsGenerated;
@property(nonatomic) int divebombCountdown;
@property(nonatomic) int divebombCountdownReset;
@property(nonatomic) int diffDivebombCountdown;
@property(nonatomic) int diffDivebombBirdSpeed;

-(void)tick;
-(void)divebombTick;
-(void)gainLevel;
-(void)reset;
-(void)setPlatformBirdSpeed:(Bird *)ob;

-(void)setDifficultyLevel:(int)diffLevel;

@end
