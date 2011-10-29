//
//  PatrolBird.m
//  TurtleTower
//
//  Created by X3N0 on 12/4/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "PatrolBird.h"


@implementation PatrolBird

-(id)init{
	if (self = [super init]){
		self.animF = 0;
		self.animTickReset = 16;
		self.animTick = self.animTickReset;
		self.animFMax = 1;
		self.oscillateValue = 0;
//		self.delayReset = diffPBDelay;
		self.delay = 0;
		self.kind = OBS_KIND_PATROL_BIRD;
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SMbird1a2F.png"]];	
		self.imageView.center = CGPointMake(-5000,-5000);
	}
	return self;
}

-(void)move{
	self.vel = CGPointMake(self.direction * self.speed,0);	
	[super move];
	if (self.l.x < -35 || self.l.x > 355){
	if (self.l.y > self.t.l.y + 15 && self.t.state == TSA_TURTLE_STATE_AIR) {
		self.disabled = YES;
		self.l = CGPointMake(1000,self.l.y + 15);
	}
	}
}

-(void)setBirdImage{
	if (self.direction == -1){
		if (self.animF == 0){
			self.imageView.image = [UIImage imageNamed:@"SMbird1a2F.png"];
		}
		if (self.animF == 1){
			self.imageView.image = [UIImage imageNamed:@"SMBird1b84F.png"];					
		}
	}else if (self.direction == 1){
		if (self.animF == 0){
			self.imageView.image = [UIImage imageNamed:@"SMbird1a2.png"];
		}
		if (self.animF == 1){
			self.imageView.image = [UIImage imageNamed:@"SMbird1b84.png"];					
		}
	}	
}




@end