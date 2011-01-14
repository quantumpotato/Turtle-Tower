//
//  BirdSpawner.m
//  TurtleTower
//
//  Created by X3N0 on 12/1/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "BirdSpawner.h"


@implementation BirdSpawner
@synthesize l, kind, direction, speed, timerleft, timerreset;
@synthesize delegate, spawnerBird;

-(int)calculateTimerBySpeed:(float)birdSpeed{
	return fabsf( 320 / (fabsf(birdSpeed)));
}

-(id)initWithBird:(Bird *)bird{
	if (self = [super init]){
		self.kind = bird.kind;
		
		self.direction = -1;
		int randomPD = arc4random() % 2;
		if (randomPD == 1){
			self.direction = 1;	
		}
		self.speed = bird.speed;
			
		if (self.direction == 1 ){
			self.l = CGPointMake(-(320*3)+bird.l.x, bird.l.y);
		}else{
			self.l = CGPointMake(320+(320*3)+bird.l.x, bird.l.y);	
		}

		self.timerreset = [self calculateTimerBySpeed:self.speed];

		self.timerleft = 3;
	}
	return self;
}

-(void)tick{
	self.timerleft--;
	if (self.timerleft < 0){
		self.timerleft = self.timerreset;
		PatrolBird *bird = [[PatrolBird alloc] init];
		bird.direction = self.direction;
		bird.speed = self.speed;
		bird.l = self.l;
		[self.delegate didReceiveSpawnerBird:bird];
		[bird release];
	}
		
}

@end
