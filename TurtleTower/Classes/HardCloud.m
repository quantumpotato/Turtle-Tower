//
//  HardCloud.m
//  TurtleTower
//
//  Created by X3N0 on 12/25/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "HardCloud.h"


@implementation HardCloud

-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat {
	[self.delegate difficultyCloudSelected:2];	
}

@end
