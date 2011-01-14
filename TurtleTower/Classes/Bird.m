//
//  Bird.m
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Bird.h"

@implementation Bird
@synthesize turtleloc, delegate, originall;
@synthesize t, disabled;

-(id)init{
	if (self = [super init]){
		self.l = CGPointMake(-5000,-5000);
	}
	return self;
}

-(id)initWithKind:(int)nk{
	if (self = [super init]){
		self.kind = nk;
	}
	return self;
}

-(void)setBirdImage{
}

-(void)animate{
	self.animTick--;
	if (self.animTick <= 0){
		self.animTick = self.animTickReset;
		
		self.animF++;
		if (self.animF > self.animFMax){
			self.animF = 0;	
		}
		[self setBirdImage];		
	}
	self.imageView.center = self.l;	
}

-(void)move{
	self.l = CombineVel(self.l, self.vel);
}

-(void)turtlelanded{
}

-(void)dealloc{
	self.imageView.center = CGPointMake(500,800);
	[self.imageView removeFromSuperview];
	self.imageView = nil;
	[super dealloc];
}


@end