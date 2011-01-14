//
//  MediumCloud.m
//  TurtleTower
//
//  Created by X3N0 on 12/25/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "MediumCloud.h"


@implementation MediumCloud

-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat {
	[self.delegate difficultyCloudSelected:1];	
}

@end
