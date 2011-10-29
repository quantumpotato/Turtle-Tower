//
//  PurpleFeather.m
//  TurtleTower
//
//  Created by X3N0 on 3/24/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "PurpleFeather.h"


@implementation PurpleFeather

-(id)init{
	if (self = [super init]){
		self.firstFeather = [UIImage imageNamed:@"featherp1small.png"];
		self.secondFeather = [UIImage imageNamed:@"featherp2small.png"];		
		self.imageView.image = self.firstFeather;
	}
	return self;
}


@end