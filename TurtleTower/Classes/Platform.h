//
//  Platform.h
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ball.h"
#import "Turtle.h"

#define INDEX_WHITE 1
#define INDEX_BLUE 2

#define SPECIAL_CLOUD_WIDTH 35

@protocol PlatformDelegate;


@interface Platform : Ball{
	int direction;
	id <PlatformDelegate> delegate;
	float fadeLeft;
	int fadeReset, fadeDelay;
	BOOL fades;
	int nextHeight;
	int fadeDirection;
	UIView *secondView;
	
}

@property(nonatomic) int nextHeight;
@property(nonatomic,retain) UIView *secondView;
@property(nonatomic) int direction;
@property(nonatomic,assign) id <PlatformDelegate> delegate;
@property(nonatomic) float fadeLeft;
@property(nonatomic) int fadeReset;
@property(nonatomic) int fadeDelay;
@property(nonatomic) BOOL fades;
@property(nonatomic) int fadeDirection;

-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat;
-(void)calculateFade;
-(void)calculateOscillate;
-(void)centerTurtleOnPlatform:(Turtle *)t;

@end

@protocol PlatformDelegate <NSObject>

-(void)landedOnPlat:(Platform *)p firstPlatform:(BOOL)firstPlat;
-(void)climbCloudLanded;
-(void)finishedCloudRise;
-(void)finishedFloat;
-(void)difficultyCloudSelected:(int)diff;
-(void)finishedDifficultyCloudRise;

@end