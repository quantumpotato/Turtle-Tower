//
//  SetupCloud.m
//  TurtleTower
//
//  Created by X3N0 on 1/20/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "SetupCloud.h"


@implementation SetupCloud
@synthesize setupDelegate;

-(id)init{
	if (self = [super init]){
		self.height = 8;
		self.width = SPECIAL_CLOUD_WIDTH;
		self.view.frame = CGRectMake(0,0,self.width,self.height);
		self.view.backgroundColor = [UIColor whiteColor];
		
	}
	return self;
}

-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat{
	[self.setupDelegate setupCloudLanded];
	self.vel = CGPointMake(0,-5);
}

-(void)move{
	self.l = CombineVel(self.l, self.vel);	
	self.view.center = self.l;
	if (self.l.y < -30){
		self.vel = CGPointZero;
		self.l = CGPointMake(1000, self.l.y);
		[self.setupDelegate setupCloudFinishedRise];	
	}
}	
	

@end
