//
//  TurtleCarryBird.m
//  TurtleTower
//
//  Created by X3N0 on 1/16/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "TurtleCarryBird.h"


@implementation TurtleCarryBird
@synthesize turtleGrabbedDelegate;

-(void)move {
	[super move];
	if (self.l.y < self.t.l.y - 30) {
		[self.turtleGrabbedDelegate grabbedTurtle:self];
	}
	if (self.l.y < -50) {
		[self.turtleGrabbedDelegate finishedTurtleOffScreen];	
		self.l = CGPointMake(1000, 1000);
		self.vel = CGPointZero;
		self.delegate = nil;
	}
}


@end
