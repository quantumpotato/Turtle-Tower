//
//  Turtle.h
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ball.h"

#define TSP_TURTLE_STATE_PLATFORM 0
#define TSA_TURTLE_STATE_AIR 1
#define TSJ_TURTLE_AIMING_JUMP 2

#define TSC_NOSCALE 0
#define TSC_SQUASH 1
#define TSC_UNSQUASH 2
#define TSC_GROW 3
#define TSC_UNGROW 4

@interface Turtle : Ball {
	int jump;
	int walking;
	BOOL landedMainCloud;
	float leftedge, rightedge;
	float wscale, hscale;
	int scaleleft, scalestate;
}

@property (nonatomic) BOOL landedMainCloud;
@property (nonatomic) float leftedge;
@property (nonatomic) float rightedge;
@property (nonatomic) int walking;
@property (nonatomic) float hscale;
@property (nonatomic) float wscale;

-(void)tick;
-(void)setSquashState:(int)newstate;


@end
