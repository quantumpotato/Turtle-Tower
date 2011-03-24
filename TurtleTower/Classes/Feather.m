//
//  Feather.m
//  TurtleTower
//
//  Created by X3N0 on 10/30/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Feather.h"


@implementation Feather

-(id)init{
	if (self = [super init]){
//		self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];		
//		self.view.backgroundColor = [UIColor orangeColor];
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,8,22)];
		self.imageView.image = [UIImage imageNamed:@"featherp2small.png"];
		self.kind = OBS_KIND_FEATHER;
	}
	return self;
}

-(void)move {
	self.l = CombineVel(self.l, self.vel);
	self.imageView.center = self.l;
}

@end
