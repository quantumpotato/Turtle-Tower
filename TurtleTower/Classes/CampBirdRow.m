//
//  CampBirdRow.m
//  TurtleTower
//
//  Created by X3N0 on 12/8/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "CampBirdRow.h"
#import "CampBird.h"
#import "PurpleFeather.h"

@implementation CampBirdRow

-(id)initWithBird:(Bird *)bird{
	if (self = [super init]){
		self.bird1 = [[CampBird alloc] init];
		self.bird1.l = CGPointMake(bird.l.x,bird.l.y);
//		self.bird2 = [[CampBird alloc] init];
//		self.bird2.l = CGPointMake(bird.l.x+320,bird.l.y);
		
		self.bird1.speed = bird.speed;
		self.bird1.originall = bird.originall;
//		self.bird2.speed = bird.speed;
		[self calculateDirection];		
		self.bird1.vel = CGPointMake(self.bird1.speed * self.bird1.direction,0);
//		self.bird2.vel = CGPointMake(self.bird2.speed * self.bird2.direction,0);		
		
//		self.bird2.oscillateRepeatReset = self.bird1.oscillateRepeatReset;
//		self.bird2.animTickReset = self.bird1.animTickReset;
//		self.bird2.animTick = self.bird1.animTick;
//		self.bird2.direction = self.bird1.direction;
		
	}
	return self;
}


-(void)tick{
	[self.bird1 move];
	[self.bird1 animate];	
}

-(Feather *)feather {
	PurpleFeather *feather = [[[PurpleFeather alloc] init] autorelease];
	return feather;
}

@end