//Try a Landed object!

//
//  Platform.m
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Platform.h"


@implementation Platform
@synthesize direction, delegate, fadeLeft,fadeReset,fadeDelay,fades,fadeDirection;
@synthesize secondView, nextHeight;

-(id)init{
	if (self = [super init]){
		self.view = [[UIView alloc] initWithFrame:CGRectMake(1000,1000,10,10)];
		float color = 60.0/255.0;
		self.view.backgroundColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
		self.view.center = CGPointMake(500,5900);
		self.secondView = [[UIView alloc] initWithFrame:CGRectMake(1000,1000,10,10)];
		self.secondView.center = CGPointMake(500,5900);
		self.secondView.backgroundColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
		self.landed = 0;
		self.l = CGPointMake(-1000, -1000);
//		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TurtleTowerPlatform.png"]];

	}
	return self;
}

-(void)centerTurtleOnPlatform:(Turtle *)t{
	t.state = TSP_TURTLE_STATE_PLATFORM;
	t.vel = CGPointZero;
	t.lastl = t.l;
	float turtleX = t.l.x;
	t.l = SYOffsetY(self.l, -(t.height+self.height-5));
	t.l = SXetX(t.l, turtleX);
	t.l = CGPointMake(fabsf(t.l.x), fabsf(t.l.y));
	t.imageView.center = t.l;
	
}	

-(void)move{
	//Clouds past 1000 we don't move
	if (self.l.x < 1000){
		self.l = CombineVel(self.l, self.vel);	
		self.secondView.center = CombineVel(self.secondView.center, self.vel);
	}
	
	if (self.l.x >= (0-self.width) && self.l.x < (0+self.width)){
		self.secondView.center = CGPointMake(self.l.x+320,self.l.y);
	}else if (self.l.x < (0-self.width)){
		self.l = CGPointMake(self.l.x+320, self.l.y);
		self.secondView.center = CGPointMake(self.l.x-320, self.l.y);
	}else if (self.l.x < (320+self.width) && self.l.x > (320-self.width)){
		self.secondView.center = CGPointMake(self.l.x-320,self.l.y);
	}else if (self.l.x >= (320+self.width)){
		self.l = CGPointMake(self.l.x-320, self.l.y);
		self.secondView.center = CGPointMake(self.l.x+320,self.l.y);
	}else{
		self.secondView.center = CGPointMake(self.l.x+320,self.l.y);	
	}
	
	self.view.center = self.l;
	
}

-(void)landedOn:(Turtle *)t firstPlatform:(BOOL)firstPlat{
	//Landed logic
		//If we haven't been landed on before,
			//Tell our delegate we're landed, pass in our object
//	[self centerTurtleOnPlatform:t];
	self.vel = CGPointMake(0,0);
	self.fades = NO;
	self.view.alpha = 1;
	
	[self.delegate landedOnPlat:self firstPlatform:firstPlat];
}

-(void)calculateFade{
	if (self.fades == YES){
		if (self.fadeDelay > 0){
			self.fadeDelay--;
		}
		if (self.fadeDelay <= 0){
			self.fadeLeft+= self.fadeDirection;
		}
		if (self.fadeLeft <= 0){
			self.fadeDirection = 1;
		}
		if (self.fadeLeft > 100){
			self.fadeLeft = 100;
			self.fadeDirection = -1;
			self.fadeDelay = self.fadeReset;
		}		
		
		self.view.alpha = self.fadeLeft / 100;
		self.secondView.alpha = self.fadeLeft / 100;
		if (self.fadeLeft < 20){
			self.view.alpha = 0;	
			self.secondView.alpha = 0;
		}
	}	
}

-(void)calculateOscillate{
	if (self.direction != 0){
		self.l = SYOffsetY(self.l,self.oscillateValue * self.direction);
		self.oscillateRepeat--;
		if (self.oscillateRepeat <= 0){
			self.oscillateRepeat = self.oscillateRepeatReset;
			self.direction = -self.direction;
		}
	}
}

@end
