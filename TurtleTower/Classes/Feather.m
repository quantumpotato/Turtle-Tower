//
//  Feather.m
//  TurtleTower
//
//  Created by X3N0 on 10/30/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Feather.h"


@implementation Feather
@synthesize firstFeather, secondFeather;
-(id)init{
	if (self = [super init]){
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,12,50)];
		self.kind = OBS_KIND_FEATHER;
		self.facing = 1;
		self.delay = 0;
		self.delayReset = arc4random() % 100;
		self.delayReset+= 40;
        self.delayReset = 20;
        featherDelay = 5;
	}
	return self;
}

-(void)move {
	self.l = CombineVel(self.l, self.vel);
	self.imageView.center = self.l;
	if (self.delay > self.delayReset * 2 + 15){
		self.delay = 0;
	}	

    featherDelay--;
    if (featherDelay <= 0) {
        featherDelay = 3;
        self.delay++;
        self.imageView.transform = CGAffineTransformMakeRotation(.1 * self.delay);        
    }
    

	if (self.delay < self.delayReset) {
         //Do transforms   

        
		if (self.direction != 1) {
			self.direction = 1;
			[self changeImageToFirst];
		}
	}else {
		if (self.direction != -1) {
			self.direction = -1;
			[self changeImageToSecond];
		}
        if (self.delay > (self.delayReset * 2) + 15) {
            self.delay = 0;
        }
	}
}

-(void)changeImageToFirst {
	self.imageView.image = self.firstFeather;	
}

-(void)changeImageToSecond {
	self.imageView.image = self.secondFeather;	
}

-(void)dealloc {
	self.firstFeather = nil;
	self.secondFeather = nil;
	[super dealloc];
}

-(void)scrollWithX:(float)x {
    [super scrollWithX:x];
    if (self.l.x > 320) {
        self.l = SXOffsetX(self.l, -320);
    }else if (self.l.x < 0) {
        self.l = SXOffsetX(self.l, 320);
    }

}

@end
