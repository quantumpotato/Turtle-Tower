//
//  FloatingWhiteCloud.m
//  TurtleTower
//
//  Created by X3N0 on 10/26/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "FloatingWhiteCloud.h"


@implementation FloatingWhiteCloud

-(void)landedOn:(Turtle *)t{
	
}

-(void)move{
	[super move];
	if (self.l.y <= 460){
		[self.delegate finishedFloat];	
	}
}

@end
