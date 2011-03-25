//
//  Feather.m
//  TurtleTower
//
//  Created by X3N0 on 10/30/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Feather.h"


@implementation Feather
@synthesize firstFeather, secondFeather;
-(id)init{
	if (self = [super init]){
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,8,22)];
		self.kind = OBS_KIND_FEATHER;
		self.facing = 1;
		self.delay = 0;
	}
	return self;
}

-(void)move {
	self.l = CombineVel(self.l, self.vel);
	self.imageView.center = self.l;
	self.facing++;
}

-(void)dealloc {
	self.firstFeather = nil;
	self.secondFeather = nil;
	[super dealloc];
}

@end
