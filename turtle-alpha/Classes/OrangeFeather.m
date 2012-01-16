//
//  OrangeFeather.m
//  TurtleTower
//
//  Created by X3N0 on 3/24/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "OrangeFeather.h"


@implementation OrangeFeather

-(id)init{
	if (self = [super init]){
		self.firstFeather = [UIImage imageNamed:@"feathero1small.png"];
		self.secondFeather = [UIImage imageNamed:@"feathero2small.png"];		
		self.imageView.image = self.firstFeather;
	}
	return self;
}

@end