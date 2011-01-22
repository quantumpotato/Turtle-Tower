//
//  ThermosphereWarpCloud.m
//  TurtleTower
//
//  Created by X3N0 on 1/22/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "ThermosphereWarpCloud.h"


@implementation ThermosphereWarpCloud


-(id)init {
	if (self = [super init]) {
		self.width = 40;
		self.height = 10;
		self.view.backgroundColor = [UIColor whiteColor];
	}
	return self;
}


-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat {
	[self.delegate landedOnThermosphereCloud];	
}

@end
