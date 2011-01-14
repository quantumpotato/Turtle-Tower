//
//  BlueBase.m
//  TurtleTower
//
//  Created by X3N0 on 10/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "BlueBase.h"


@implementation BlueBase


-(id)init{
	if (self = [super init]){
		self.height = 8;
		self.width = 500;
		self.secondView.frame = CGRectZero;
		self.view.frame = CGRectMake(0,0,self.width,self.height);
		self.view.backgroundColor = [UIColor blueColor];
		
	}
	return self;
}

-(void)landedOn{
	
}
-(void)move{
	if (self.l.x < 1000){
		self.l = CombineVel(self.l, self.vel);
	}
	self.view.center = self.l;
//	[super move];
}

@end
