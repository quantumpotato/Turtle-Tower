//
//  Turtle.m
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Turtle.h"

@implementation Turtle
@synthesize landedMainCloud, leftedge, rightedge, walking;

-(id)init{
	if (self = [super init]){
		self.jumpLeft = 0;
		self.jumpLeftReset = 12; //15
		self.jumpPower = 8; //8
		self.walkSpeed = 15;
		self.walking =0;
		self.facing = 1;
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"turtlesmallsize1.png"]];
		self.imageView.center = CGPointMake(500,500);
		wscale = 1;
		hscale = 1;
		scalestate = TSC_NOSCALE;
	}
	return self;
}

-(void)setSquashState:(int)newstate {
	if (newstate == TSC_GROW || newstate == TSC_SQUASH){
		wscale = 1;
		hscale = 1;
	}
	scalestate = newstate;
	if (newstate == TSC_GROW){
		scaleleft = 9;
	}else if (newstate == TSC_SQUASH || newstate == TSC_UNSQUASH){
		scaleleft = 4;
	}else if (newstate == TSC_UNGROW) {
		scaleleft = 8;	
	}
}

-(void)tick {
	
	if (fabsf(self.vel.x > 0)){
		if (self.vel.x < 0){
			self.facing = -1;
		}else {
			self.facing = 1;
		}
	}
	
	if (scalestate != TSC_NOSCALE) {
		scaleleft--;
		switch (scalestate) {
			case TSC_GROW:
				hscale += .07;
				if (scaleleft == 0) {
					//					scalestate = TSC_NOSCALE;
					[self setSquashState:TSC_UNGROW];
				}
				break;
			case TSC_UNGROW:
				hscale -= .04;
				if (scaleleft == 0) {			
					[self setSquashState:TSC_NOSCALE];
					wscale = 1;
					hscale = 1;
				}
			case TSC_SQUASH:
				hscale-= .05;
				wscale+= .015;
				if (scaleleft == 0) {			
					[self setSquashState:TSC_UNSQUASH];
				}				
				break;
			case TSC_UNSQUASH:
				hscale+= .05;
				wscale-= .015;	
				if (scaleleft == 0) {			
					[self setSquashState:TSC_NOSCALE];
					wscale = 1;
					hscale = 1;
				}
				break;
			default:
				break;
		}
		
		self.imageView.transform = CGAffineTransformMakeScale(wscale * self.facing, hscale);
	}
}

@end