//
//  PatrolBirdRow.m
//  TurtleTower
//
//  Created by X3N0 on 12/6/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "PatrolBirdRow.h"
#import "PatrolBird.h"
#import "OrangeFeather.h"

@implementation PatrolBirdRow

-(id)initWithBird:(Bird *)bird{
	if (self = [super init]){
		self.bird1 = [[PatrolBird alloc] init];
		self.bird1.l = CGPointMake(bird.l.x,bird.l.y);
		self.bird2 = [[PatrolBird alloc] init];
		self.bird2.l = CGPointMake(bird.l.x+320,bird.l.y);
		
		self.bird1.speed = bird.speed;
		self.bird2.speed = bird.speed;
		[self calculateDirection];		
		self.bird1.vel = CGPointMake(self.bird1.speed * self.bird1.direction,0);
		self.bird2.vel = CGPointMake(self.bird2.speed * self.bird2.direction,0);		
	}
	return self;
}

-(Feather *)feather {
	OrangeFeather *feather = [[[OrangeFeather alloc] init] autorelease];
	return feather;
}

@end