//
//  BirdRow.m
//  TurtleTower
//
//  Created by X3N0 on 12/6/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "BirdRow.h"


@implementation BirdRow
@synthesize bird1, bird2, direction, droppedFeather;

-(void)calculateDirection{
	self.direction = -1;
	NSInteger rand = arc4random() % 2;
	if (rand == 0){
		self.direction = 1;
	}
	
	self.bird1.direction = self.direction;
	self.bird2.direction = self.direction;	
}	

-(id)initWithBird:(Bird *)bird{
	if (self = [super init]){
	}
	return self;
}

-(void)dealloc{
	self.bird1 = nil;
	self.bird2 = nil;
	[super dealloc];
}



-(void)tick{	
	[self.bird1 move];
	[self.bird2 move];
	
	float width = 25;
	
	if (self.bird1.l.x >= (0-width) && self.bird1.l.x < (0+width)){
		self.bird2.l = CGPointMake(self.bird1.l.x+320,self.bird2.l.y);		
	}else if (self.bird1.l.x < (0-width)){
		self.bird1.l = CGPointMake(self.bird1.l.x+320, self.bird1.l.y);
		self.bird2.l = CGPointMake(self.bird1.l.x-320, self.bird1.l.y);
	}else if (self.bird1.l.x < (320+width) && self.bird1.l.x > (320-width)){
		self.bird2.l = CGPointMake(self.bird1.l.x-320,self.bird2.l.y);
	}else if (self.bird1.l.x >= (320+width)){
		self.bird1.l = CGPointMake(self.bird1.l.x-320, self.bird1.l.y);
		self.bird2.l = CGPointMake(self.bird1.l.x+320,self.bird2.l.y);
	}else{
		self.bird2.l = CGPointMake(self.bird1.l.x+320,self.bird1.l.y);	
	}
	
	[self.bird1 animate];
	[self.bird2 animate];
	
}

- (void)scrollWithX:(float)x {
	self.bird1.l = SXOffsetX(self.bird1.l, x);
	self.bird2.l = SXOffsetX(self.bird2.l, x);		
}	

- (void)scrollWithY:(float)y {
	self.bird1.l = SYOffsetY(self.bird1.l, y);
	self.bird2.l = SYOffsetY(self.bird2.l, y);
}

-(Feather *)newFeather {
	return nil;	
}

@end