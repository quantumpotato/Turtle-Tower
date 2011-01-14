//
//  DifficultyObstacle.m
//  TurtleTower
//
//  Created by X3N0 on 9/28/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "DifficultyObstacle.h"


@implementation DifficultyObstacle
@synthesize kind, direction, speed, delay, minHeightLeft, maxHeightLeft;
@synthesize chanceOfAppearing, delayReset, heightTick;

-(void)setBirdImage{
	
}

-(void)scrollWithY:(float)y{
	self.l = SYOffsetY(self.l, y);	
	NSLog(@"new y: %f",self.l.y);
}

@end
