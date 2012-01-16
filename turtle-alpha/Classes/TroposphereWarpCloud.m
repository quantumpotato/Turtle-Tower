//
//  StratosphereWarpCloud.m
//  TurtleTower
//
//  Created by X3N0 on 1/22/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "TroposphereWarpCloud.h"


@implementation TroposphereWarpCloud

-(id)init {
	if (self = [super init]) {
		self.width = 40;
		self.height = 10;
		self.view.backgroundColor = [UIColor whiteColor];
		
	}
	return self;
}

-(void)move {
//	self.secondView.center = CGPointMake(1000, -1000);
}

-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat {
	[self.delegate landedOnTroposphereCloud];	
}

@end