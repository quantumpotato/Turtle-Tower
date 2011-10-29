//
//  DifficultyObstacle.h
//  TurtleTower
//
//  Created by X3N0 on 9/28/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ball.h"
#import "ScrollProtocol.h"

#define OBS_KIND_PATROL_BIRD 0
#define OBS_KIND_CAMP_BIRD 1
//Set to left or right
//Charge instantly at platform
//Delay then charge above
//Delay then charge platform
#define OBS_KIND_DIVEBOMB_BIRD 2
#define OBS_KIND_FEATHER 3

@interface DifficultyObstacle : Ball <ScrollingProtocol> {
	int kind;
	int direction;
	int minHeightLeft;
	int maxHeightLeft;
	float chanceOfAppearing;
	float speed; //Patrol birds flight, camp bird's && divebomb bird's charge speed, 
	int delay; //Patrol birds pause, camp bird's delay before deciding to charge at one of 2 points 
				 //Divebomb bird's wait for centered on turtle before charging (higher is difficult)
	int delayReset;
	int heightTick;
}

@property(nonatomic) int kind;
@property(nonatomic) int direction;
@property(nonatomic) int minHeightLeft;
@property(nonatomic) int maxHeightLeft;
@property(nonatomic) float chanceOfAppearing;

@property(nonatomic) float speed;
@property(nonatomic) int delay;
@property(nonatomic) int delayReset;
@property(nonatomic) int heightTick;

-(void)setBirdImage;

@end
