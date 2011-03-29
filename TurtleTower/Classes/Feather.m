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
		self.delay = 0;
		self.delayReset = arc4random() % 100;
		self.delayReset+= 40;
        self.delayReset = 20;
		self.direction = -1;
		featherTick = 0;
        featherDelay = 5;
		featherRotate = 0;
		int rotate = arc4random() % 6;
		rotate++;
		featherRotation = rotate * .01;
		self.facing = 1;		
//		int facingChange = arc4random() % 2;
//		if (facingChange == 0) {
//			self.facing = -1;
//		}
	}
	return self;
}


-(id)featherWithBird:(Bird *)bird forLower:(BOOL)lower {
	if (lower) {
		[self changeImageToSecond];
	}
		featherRotation = bird.direction * .01 * bird.speed;
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
//		[self oscillateFeather];
		[self rotateFeather];
    }
}

-(void)rotateFeather {
	featherRotate+= featherRotation;
	if (featherRotate > 2 *M_PI) {
		featherRotate-= 2 *M_PI;	
	}	//	}else if (featherRotate < 0) {
//		featherRotate+= 2*M_PI;	
//	}
	self.imageView.transform = CGAffineTransformMakeRotation(featherRotate);
 	
}

-(void)oscillateFeather {
//facing determines image
	//direction is motion
	//delay is tick	
//	if (self.direction == 1) {
//		if (!self.facing == -1) {
//			featherTick--;	
//			if (featherTick <= 0) {
//				self.facing = 1;
//				featherTick = 0;
//				[self changeImageToFirst];
//			}
//		} else if (!self.facing == 1) {
//			featherTick++;
//			if (featherTick == 100) {
//				self.facing = -1;
//				self.direction = -1;
//			}
//		}
//	} else if (self.direction == -1) {
//		if (!self.facing == 1) {
//			featherTick--;
//			if (featherTick <= 0) {
//				[self changeImageToSecond];	
//				self.facing = -1;
//				featherTick = 0;
//			}
//		}else if (!self.facing == -1) {
//			featherTick++;
//			if (featherTick == 100) {
//				self.facing = 1;
//				self.direction = 1;
//			}
//		}
//	}
	
	if (self.facing == self.direction) {
		featherTick++;	
	} else {
		featherTick--;
	}
	
	self.l = SXOffsetX(self.l, self.direction);
	
	if (featherTick <= 0) {
		self.facing = -self.facing;
		featherTick = 1;
	if (self.facing == 1) {
//			[self changeImageToFirst];
		}else {
//			[self changeImageToSecond];			
		}
	}else if (featherTick >= 45){
		featherTick = 0;
		self.direction = -self.direction;
		if (self.facing == -1) { //Was 1
//			[self changeImageToSecond];
		}else {
//			[self changeImageToFirst];			
		}		
	}
	
	if (self.facing == 1) {
	      self.imageView.transform = CGAffineTransformMakeRotation(-.01 * featherTick);        
	} else if (self.facing == -1) {
	      self.imageView.transform = CGAffineTransformMakeRotation(.01 * featherTick);
	}
	
}

-(void)changeImageToFirst {
	NSLog(@"?");
	self.imageView.image = self.firstFeather;	
}

-(void)changeImageToSecond {
	NSLog(@"!");
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
