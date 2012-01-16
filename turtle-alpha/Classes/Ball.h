//
//  Ball.h
//  MovementOne
//
//  Created by X3N0 on 9/21/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

//Target could be an id or ball pointer to another object.

#import <Foundation/Foundation.h>
#import "cmpgames.h"

#define KIND_UNDERSTANDING 0
#define KIND_LIFE 1
#define KIND_DEATH 2
#define KIND_OBSTACLE 3

#define ID_UNDERSTANDING 0
#define ID_LIFE 1
#define ID_DEATH 2
#define ID_OBSTACLE 3

#define BONUS_THRUST_OFF 0
#define BONUS_THRUST_ON 1

#define ORANGE_RELOAD 0
#define ORANGE_ACTIVE 1

@interface Ball : NSObject {
	int k;
	CGPoint l, vel, thrust;
	int targetID;
	float brake, maxMomentum, accel;
	float strength, maxStrength;
	float weight, radius;
	NSString *image;
	int boosting;
	float boostStrength;
	float boostType;
	CGPoint boostTarget;
	CGPoint target;
	int pursuitStyle;
	
	int bonusThrust;
	float bonusThrustStrength;
	float boostRadius;
	float recoveryRate;
	
	int state;
	
	CGPoint lastl;
	UIImageView *imageView;
	UIView *view;
	float height;
	float width;
	
	int jumpLeft;
	int jumpLeftReset;
	float jumpPower;
	
	int walkDir;
	float walkSpeed;
	int platform;
	int landed;
	
	int animF, animTick, animTickReset, animFMax;
	
	int timer;
	int facing;
	
	int oscillateValue;
	int oscillateRepeat;
	int oscillateRepeatReset;	
	
}

@property(nonatomic) int timer;
@property(nonatomic) int facing;

@property(nonatomic) int animF;
@property(nonatomic) int animTick;
@property(nonatomic) int animTickReset;
@property(nonatomic) int animFMax;
@property(nonatomic) int landed;
@property(nonatomic) int platform;
@property(nonatomic) float walkSpeed;
@property(nonatomic) int walkDir;
@property(nonatomic) float jumpPower;
@property(nonatomic) int jumpLeft;
@property(nonatomic) int jumpLeftReset;
@property(nonatomic	) float height;
@property(nonatomic) float width;

@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) UIView *view;

@property(nonatomic) int k;
@property(nonatomic) CGPoint l;
@property(nonatomic) CGPoint vel;
@property(nonatomic) CGPoint thrust;
@property(nonatomic) int targetID;
@property(nonatomic) float brake;
@property(nonatomic) float maxMomentum;
@property(nonatomic) float accel;
@property(nonatomic) float strength;
@property(nonatomic) float maxStrength;
@property(nonatomic) float weight;
@property(nonatomic) float radius;
@property(nonatomic,copy) NSString *image;
@property(nonatomic) int boosting;
@property(nonatomic) float boostStrength;
@property(nonatomic) float boostType;
@property(nonatomic) CGPoint boostTarget;
@property(nonatomic) CGPoint target;
@property(nonatomic) int pursuitStyle;
@property(nonatomic) int bonusThrust;
@property(nonatomic) float bonusThrustStrength;
@property(nonatomic) float boostRadius;
@property(nonatomic) float recoveryRate;
@property(nonatomic) int state;
@property(nonatomic) CGPoint lastl;
@property(nonatomic) int oscillateValue;
@property(nonatomic) int oscillateRepeat;
@property(nonatomic) int oscillateRepeatReset;

+(Ball *)generateLife;
+(Ball *)generateDeath;
+(Ball *)generateObstacle;
+(Ball *)showUnderstanding;

+(Ball *)useBoost:(Ball *)ball;
+(Ball *)pursue:(Ball *)ball;
+(Ball *)recover:(Ball *)ball;
+(Ball *)move:(Ball *)ball;

-(void)move:(Ball *)ball;
-(void)move;

-(void)animate;

@end