//
//  InactiveWind.m
//  TurtleTower
//
//  Created by X3N0 on 11/12/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "InactiveWind.h"


@implementation InactiveWind

-(void)tick{
	[super tick];
	if (self.ticksleft <= 0){
		[self.delegate inactiveWindExpired];	
	}
}	


@end