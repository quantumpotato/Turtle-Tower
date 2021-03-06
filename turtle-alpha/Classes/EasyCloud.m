	//
//  EasyCloud.m
//  TurtleTower
//
//  Created by X3N0 on 12/25/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "EasyCloud.h"


@implementation EasyCloud

-(id)init {
	if (self = [super init]) {
		self.width = 40;
		self.height = 10;
		self.view.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

-(void)move {
	self.view.center = self.l;
}

-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat {
	[self.delegate difficultyCloudSelected:0 cloud:self];	
}

@end