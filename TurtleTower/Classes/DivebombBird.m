//
//  DivebombBird.m
//  TurtleTower
//
//  Created by X3N0 on 12/4/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "DivebombBird.h"


@implementation DivebombBird

-(id)init{
	if (self = [super init]){
		self.kind = OBS_KIND_DIVEBOMB_BIRD;
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenbirdcb.png"]];
		self.imageView.frame = CGRectMake(0, 0, 84,70);
	}
	return self;
}

-(void)move{
	if (self.l.x > 300 && self.vel.x > 0){
		self.vel = CGPointMake(-self.vel.x,self.vel.y);
		self.facing = -1;
	}else if (self.l.x < 20 && self.vel.x < 0){
		self.vel = CGPointMake(-self.vel.x,self.vel.y);
		self.facing = 1;
	}
			  
	[super move];
}

-(void)setBirdImage{
	if (self.facing == 1){
		if (self.animF == 0){
			self.imageView.image = [UIImage imageNamed:@"greenbirda.png"];
		}
		if (self.animF == 1){
			self.imageView.image = [UIImage imageNamed:@"greenbirdca.png"];					
		}
	}else if (self.facing == -1){
		if (self.animF == 0){
			self.imageView.image = [UIImage imageNamed:@"greenbirdb.png"];
		}
		if (self.animF == 1){
			self.imageView.image = [UIImage imageNamed:@"greenbirdcb.png"];			
		}
	}
}

-(void)scrollWithY:(float)y{
	[super scrollWithY:y];
}

@end