//
//  GreenFeather.m
//  TurtleTower
//
//  Created by X3N0 on 3/24/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "GreenFeather.h"


@implementation GreenFeather

-(id)init{
	if (self = [super init]){
		self.firstFeather = [UIImage imageNamed:@"featherg1small.png"];
		self.secondFeather = [UIImage imageNamed:@"featherg2small.png"];		
		self.imageView.image = self.firstFeather;
	}
	return self;
}


@end
