//
//  WhiteCloud.m
//  TurtleTower
//
//  Created by X3N0 on 10/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "WhiteCloud.h"


@implementation WhiteCloud

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
	[self.delegate climbCloudLanded];
	self.vel = CGPointMake(0,-5);
}


-(void)move{
	if (self.l.x < 1000){
//	[super move];

			self.l = CombineVel(self.l, self.vel);	
		self.view.center = self.l;
		if (self.l.y < -30){
		self.vel = CGPointZero;
		self.l = CGPointMake(1000, self.l.y);
		[self.delegate finishedCloudRise];	
	}
		}
}

@end