//
//  DivebombBirdRow.m
//  TurtleTower
//
//  Created by X3N0 on 12/12/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "DivebombBirdRow.h"
#import "DivebombBird.h"

@implementation DivebombBirdRow

-(id)initWithBird:(Bird *)bird{
	if (self = [super init]){
	self.bird1 = [[DivebombBird alloc] init];
	self.bird1.l = CGPointMake(bird.l.x,bird.l.y);
	self.bird1.speed = bird.speed;
		self.bird1.target = bird.target;
		self.bird1.vel = GetAngle(self.bird1.l, self.bird1.target);
		self.bird1.vel = MultiplyVel(self.bird1.vel, self.bird1.speed);
	}
	return self;
}

-(void)tick{
	[self.bird1 move];
	[self.bird1 animate];	
}

@end