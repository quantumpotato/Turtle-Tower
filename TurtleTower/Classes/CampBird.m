//
//  CampBird.m
//  TurtleTower
//
//  Created by X3N0 on 12/4/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "CampBird.h"


@implementation CampBird

-(id)init{
	if (self = [super init]){
		self.kind = OBS_KIND_CAMP_BIRD;
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purplebirdatry1.png"]];		
		
		self.state = 1;
		int randomState = arc4random() % 2;
		self.animTickReset = 12;
		if (randomState == 1){
			self.state = 2;	
			self.animTickReset = 22;						
		}
		
		self.animF = 0;
		self.animTick = self.animTickReset;
		self.animFMax = 1;
		self.oscillateRepeat = 5;
		self.oscillateRepeatReset = arc4random() % 28;
		self.oscillateRepeatReset+= 25; //15
		self.oscillateValue = 2;		
		
		self.direction = -1;
		int randomPD = arc4random() % 2;
		if (randomPD == 1){
			self.direction = 1;	
		}
		
		self.vel = CGPointMake(0, self.direction * self.oscillateValue);		
	}
	return self;
}

-(void)calculateFacing{
	if (t.l.x < self.l.x){
		self.facing = -1;
	}else if (t.l.x > self.l.x	){
		self.facing = 1;
	}
}

-(void)chargeAhead {
	self.state = 3; //charging
	int chargeDir = -1;
	if (t.l.x > self.l.x){
		chargeDir = 1;
	}
	self.target = CGPointMake(self.l.x + (chargeDir * 10),self.l.y);
	self.vel = GetAngle(self.l, self.target);
	self.vel = MultiplyVel(self.vel, self.speed+2);
}

-(void)move{
	
	if (self.state <= 2){
		
		if (!turtlePassed){
		
			if (self.t.l.y < self.l.y+160){ //120
				turtlePassed = YES;
			}
			
//			if (t.l.y > self.l.y + 120){
			
		if (self.l.x > 320){
			self.l = CGPointMake((self.l.x-320),self.l.y);
//			self.l = CGPointMake(self.l.x - self.speed,self.l.y);
		}else if (self.l.x < 0){
			self.l = CGPointMake(320-(0-self.l.x),self.l.y);
//			self.l = CGPointMake(self.l.x + self.speed,self.l.y);			
		}
			
//		}
		}
	}
	
	if (self.state == 3){
		self.timer++;	
		if (self.timer >= 20*66){
			self.l = SYetY(self.l, 955);
	}
	}else if (self.state == 4){
		self.timer--;
		if (self.timer <= 0){
			self.state = 3;
			self.timer = 0;
			self.target = CGPointMake(self.target.x,t.l.y);
			self.vel = GetAngle(self.l, self.target);
			self.vel = MultiplyVel(self.vel, self.speed + 1.5);
		} else {
			if (self.l.y > 530) {
				self.state = 3;
				self.timer = 0;
				self.target = CGPointMake(self.target.x,t.l.y);
				self.vel = GetAngle(self.l, self.target);
				self.vel = MultiplyVel(self.vel, self.speed + 1.5);				
			}
		}
	}else if (self.state == 1 || self.state == 2){
		self.oscillateRepeat--;
		if (self.oscillateRepeat <= 0){		
			self.oscillateRepeat = self.oscillateRepeatReset;
			self.direction = -self.direction;
		}
		
		if (self.state == 1){
			if (t.l.y <= self.l.y){
				//Camp birds flap wings slow: will delay then charge wherever the turtle was at the time of delaying.
				//Land somewhere, then move.
				//Possibly will charge at the current Turtle's X, old Y?
				[self chargeAhead];
			}
		}
	}
	
	
	
	if (self.state == 1 || self.state == 2) {
		self.vel = CGPointMake(0, self.direction * self.oscillateValue);
	}
	[super move];
}

-(void)turtlelanded{
	if (self.state == 2){ //WAS 1
		if (t.l.y <= self.l.y){
			//Camp birds flap wings fast: will charge immediately, time your landing. Will possibly contain enough
			//Y variance to be out of the way.
					
//			if (self.l.x < -35 || self.l.x > 35){
//				self.state = 1; //WAS 2
//				return;
//			}
			
			self.state = 4; //charging
			self.vel = CGPointZero;
			self.target = t.l;
			int randomDelay = random() % 50;// WAS using Timer
			self.timer = 50+randomDelay;			
		}
	}
	
	
}

-(void)setBirdImage{
	
	[self calculateFacing];
	
	if (self.facing == -1){
		if (self.animF == 0){
			self.imageView.image = [UIImage imageNamed:@"purplebirdatry1.png"];
		}
		if (self.animF == 1){
			self.imageView.image = [UIImage imageNamed:@"purplebirdca.png"];					
		}
	}else if (self.facing == 1){
		if (self.animF == 0){
			self.imageView.image = [UIImage imageNamed:@"purplebirdb.png"];
		}
		if (self.animF == 1){
			self.imageView.image = [UIImage imageNamed:@"purplebirdcb.png"];					
		}
	}			
}	

@end