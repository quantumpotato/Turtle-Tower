//
//  BirdController.m
//  TurtleTower
//
//  Created by X3N0 on 11/19/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "BirdController.h"


@implementation BirdController
@synthesize level, maxPatrolBirds,
maxEmptyBird,
emptyBird,
maxCampBirds,	
highestPlatformY,
 diffPBSpeed, diffPBOscillateValue, diffPBOscillateRate, diffPBDelay,
 diffVertBirdSpeed,
 diffVertBirdDelay,
 diffPBSpeedtick,
birdsGenerated,
delegate,
divebombCountdown, divebombCountdownReset, diffDivebombCountdown, diffDivebombBirdSpeed;
@synthesize tright;

-(void)reset{
	
	forcedEmptyLeft = 8;
	maxBirds = 0;
	
	emptyWeight = 3;
	platformWeight = 1;
	campWeight = 0;
	
	self.level = 1;
	self.diffPBSpeed = 1;
	self.diffPBOscillateValue = 0;
	self.diffPBOscillateRate = 0;
	self.diffPBDelay = 50;
	self.diffPBSpeedtick = 0;
	self.diffVertBirdSpeed = 0; //CHANGE TO 0
	self.diffVertBirdDelay = 5;
	self.birdsGenerated = 0;
	self.maxEmptyBird = 2;
	self.emptyBird = 0;
	self.maxPatrolBirds = 1;
	self.maxCampBirds = 0; //Should be 0
	self.divebombCountdown = 0;
	self.divebombCountdownReset = ((20-diffDivebombCountdown) * 50);	
	self.diffDivebombCountdown = 0;
	self.diffDivebombBirdSpeed = 3;
}	

-(id)init{
	if (self = [super init]){
		[self reset];
	}
	return self;
}

-(void)setPlatformBirdSpeed:(Bird *)ob{
	int diffrandom;
	float floatedDiff;
	if (self.diffPBSpeed > 0){
		diffrandom = arc4random() % self.diffPBSpeed;
		floatedDiff = diffrandom * .75;
	}
	
	//else{
	//	diffrandom = 0;
	//}
	ob.speed = floatedDiff + 2;
}

-(void)setCampBirdSpeed:(Bird *)ob{
	int diffrandom;
	if (diffVertBirdSpeed > 0){
		diffrandom = random() % diffVertBirdSpeed;
	}else{
		diffrandom = 0;
	}
	ob.speed = diffrandom + 4;
	ob.delay = random() % 6;
	ob.delay = ob.delay + 8;
}

-(void)setDivebombBirdSpeed:(Bird *)bird{
	int diffrandom;
	if (diffDivebombBirdSpeed > 0){
		diffrandom = arc4random() % diffDivebombBirdSpeed;	
	}else{
		diffrandom = 0;	
	}
	bird.speed = diffrandom + 3;
}

-(void)makePatrolBird{
	generated = YES;
	self.birdsGenerated++;
	PatrolBird *ob = [[PatrolBird alloc] init];
	ob.state = 1;
	int random2 = arc4random() % 20;
	random2 += 50;
	int random3 = arc4random() % 320;
//	random2 = 0;
		
ob.l = CGPointMake(random3,self.highestPlatformY-random2);
//	ob.l = CGPointMake(random3,230);	
	[self setPlatformBirdSpeed:ob];
	ob.vel = CGPointMake(ob.direction * ob.speed,0);
		
	self.emptyBird = 0;		
	[self.delegate didReceiveBirdForSpawner:ob];
	[ob release];	
}

-(void)makeCampBird{
	birdsGenerated++;			
	CampBird *ob = [[CampBird alloc] init];
	int random3 = arc4random() % 320;
	ob.l = CGPointMake(random3,self.highestPlatformY);
	ob.originall = ob.l;
	ob.target = CGPointMake(ob.l.x,ob.l.y+40);
	
	[self setCampBirdSpeed:ob];
	[self.delegate didReceiveBirdForSpawner:ob];
	[ob release];
	
	self.emptyBird = 0;	
}

-(void)makeDivebombBird{
	Bird *bird = [[Bird alloc] initWithKind:OBS_KIND_DIVEBOMB_BIRD];
	bird.state = 1;
	
	int random2 = arc4random() % 20;
	random2 += 30;
	int random3 = arc4random() % 320;
	bird.l = CGPointMake(random3,self.highestPlatformY-random2);
	bird.facing = -1;
	
	[self setDivebombBirdSpeed:bird];
	
	int targetYOffset = arc4random() % 16;
	targetYOffset+= 3;
	int randomDirectionSwitch = arc4random() % 2;
	CGPoint target;
	if (randomDirectionSwitch == 1){
		bird.facing = 1;
		target = CGPointMake(320,bird.l.y+fabsf(targetYOffset));
	}else{
		target = CGPointMake(0,bird.l.y+fabsf(targetYOffset));
	}
      	
	bird.target = target;
	bird.vel = GetAngle(bird.l, bird.target);
	bird.vel = MultiplyVel(bird.vel, bird.speed);
	
	bird.animF = 0;
	bird.animTickReset = 40;
	bird.animTick = bird.animTickReset;
	bird.animFMax = 1;
	bird.oscillateValue = 0;
	bird.delayReset = diffPBDelay;
	bird.delay = 0;
	[self.delegate didReceiveBirdForSpawner:bird];
	[bird release];	
}


-(void)checkForPatrolGenerate{
	int rnd = arc4random() % 3;
	if (birdsGenerated < maxPatrolBirds){
		if (rnd >= 2 || self.emptyBird >= self.maxEmptyBird){
			[self makePatrolBird];
//			[self makeCampBird];
		}else{
			self.birdsGenerated = 0;
			self.emptyBird++;	
		}
	}else{
		self.birdsGenerated = 0;
		self.emptyBird++;
	}
}

-(void)checkForCampGenerate{
	if (!generated){	
		int vertRandom = random() % 7;
		if (self.birdsGenerated < self.maxCampBirds || self.emptyBird > self.maxEmptyBird){
			if (vertRandom >= 4){
			[self makeCampBird];	
			}else{	
				self.birdsGenerated = 0;
				self.emptyBird++;
			}
		}else{
			self.birdsGenerated = 0;
			self.emptyBird++;
		}
	}	
}

-(void)checkForBirdGeneration {
	
	if (forcedEmptyLeft > 0){
		forcedEmptyLeft--;
		return;
	}
	
	int birdRandomizer = emptyWeight + platformWeight + campWeight;
	int random = arc4random() % birdRandomizer;
	random++;
	int result = 0; //empty bird
	if (random < birdRandomizer){
		result = 1; //platform bird
	}
	if (random > emptyWeight + platformWeight){
		result = 2;
	}
	
	if (result == 0){
		return;
	}
	
	if (result == 1){
		[self makePatrolBird];	
	}
	
	if (result == 2){
		[self makeCampBird];
	}
	
	if (self.birdsGenerated >= maxBirds){
		forcedEmptyLeft = forcedEmptyReset;
	}
	
}

-(void)tick{
	generated = NO;
	//score
	[self checkForBirdGeneration];
}

-(void)setDifficultyLevel:(int)diffLevel{
	switch (diffLevel) {
		case 0:
			forcedEmptyReset = 3;
			emptyWeight = 11;
			break;
		case 1:
			forcedEmptyReset = 2;
			emptyWeight = 8;			
			break;
		case 2:
			forcedEmptyReset = 1;			
			emptyWeight = 5;			
			break;
		case 3:
			forcedEmptyReset = 1;			
			emptyWeight = 3;			
			break;

		default:
			break;
	}
}

-(void)gainLevel{
	self.level++;
	
	if (self.level == 2){
		campWeight = 2;
	}
	
	if (self.level == 2 || self.level == 3){
 		
		[self makeCampBird];
	}
	
	if (self.level > 0 && self.level <= 10){
			platformWeight++;
	}
	
	if (self.level >=4 && self.level < 14){
		campWeight++;
	}
	
	if (self.level > 0 && self.level <= 5){
		self.diffPBSpeed++;
		self.maxPatrolBirds++;		
	}else if (self.level >= 5 && self.level <= 9){
		self.diffVertBirdSpeed++;
		self.maxCampBirds++;
	}else if (level >= 15 && level <= 19){
		diffDivebombBirdSpeed++;
		diffDivebombCountdown++;
		divebombCountdownReset = ((32-(diffDivebombCountdown*2)) * 50);		
	}
	
}

-(void)divebombTick{
	if (self.level >= 15){
		self.divebombCountdown--;
	
		if (self.divebombCountdown <= 0){
			self.divebombCountdown = self.divebombCountdownReset;
			[self makeDivebombBird];

		}
	}
}

@end
