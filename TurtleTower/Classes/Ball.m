//
//  Ball.m
//  MovementOne
//
//  Created by X3N0 on 9/21/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "Ball.h"

//Maybe do: max boost
//Maybe do: boost resets on new boost; boost fades out instead of vanishing


@implementation Ball

@synthesize l, k, vel, targetID, brake, thrust, maxMomentum, accel, strength, weight, image, radius;
@synthesize boosting, boostStrength, boostType, boostTarget, target, pursuitStyle;
@synthesize bonusThrust, bonusThrustStrength, boostRadius, recoveryRate, maxStrength, state;
@synthesize lastl, imageView, view, height, width, jumpLeft, jumpLeftReset, jumpPower, walkDir, walkSpeed, platform;
@synthesize landed, timer;
@synthesize animF, animTick, animTickReset, animFMax, facing;
@synthesize oscillateValue, oscillateRepeat, oscillateRepeatReset;

-(void)clear:(Ball *)ball{
	ball.k = -1;
	ball.l = CGPointMake(5000, 5000);
	ball.vel = CGPointZero;
	ball.targetID = -1;
	ball.brake = 0;
	ball.maxMomentum = 0;	
	ball.thrust = CGPointZero;
	ball.accel = 0;
	ball.strength = 0;
	ball.maxStrength = 0;
	ball.weight = 1;
	ball.radius = 0;
	ball.boosting = 0;
	ball.boostStrength = 0;
	ball.boostType = 0;
	ball.boostTarget = ball.l;
	ball.target = CGPointZero;
	ball.pursuitStyle = 0;
	ball.bonusThrust = BONUS_THRUST_OFF;
	ball.bonusThrustStrength = 0;
	ball.boostRadius = -1;
	ball.recoveryRate = 0;
	ball.state = 0;
	ball.height = 0;
	ball.width = 0;
	ball.jumpLeft = 0;
	ball.jumpLeftReset = 0;
	ball.jumpPower = 0;
	ball.walkDir = 0;
	ball.walkSpeed = 0;
	ball.platform = -1;
	ball.landed = 0;
	ball.animF = 0;
	ball.animTick = 0;
	ball.animFMax = 0;
	ball.animTickReset = 0;
	ball.facing = 0;
}

+(Ball *)generateLife{
	Ball *ball = [[Ball alloc] init];	
	ball.k = KIND_LIFE;
	ball.l = CGPointMake(-30,-30);
	ball.targetID = KIND_UNDERSTANDING;
	ball.brake = 4;
	ball.accel = .43;
	ball.maxMomentum = 7; //7;
	ball.strength = 100;
	ball.maxStrength = 100;
	ball.image = @"greenblot.png";
	ball.radius = 10;
	ball.boostType = 1;
	ball.boostStrength = 2;
	ball.pursuitStyle = 2;
	ball.bonusThrustStrength = 7;
	ball.boostRadius = 60;
	ball.recoveryRate = .083;
	return [ball autorelease];
}

+(Ball *)generateDeath{
	Ball *ball = [[Ball alloc] init];	
	ball.k = KIND_DEATH;
	ball.l = CGPointMake(160,500); 
	ball.targetID = KIND_LIFE;
	ball.brake = 2;
	ball.accel = 1.5;
	ball.maxMomentum = 11;
	ball.strength = 4;
	ball.image = @"redtriangle.png";
	ball.radius = 4;
	ball.pursuitStyle = 1;
	return [ball autorelease];	
}

+(Ball *)generateObstacle{
	Ball *ball = [[Ball alloc] init];	
	ball.l = CGPointMake(5000,230);
	ball.k = KIND_OBSTACLE;
	ball.maxMomentum = 999;
	ball.image = @"orangediamond.png";
	ball.radius = 10;
	return [ball autorelease];		
}

+(Ball *)showUnderstanding{
	Ball *ball = [[[Ball alloc] init] autorelease];	
	ball.k = KIND_UNDERSTANDING;
	ball.image = @"whitedot.png";
	return ball;		
}

+(Ball *)useBoost:(Ball *)ball{
	if (ball.boosting > 0){
	CGPoint boostAngle = GetAngle(ball.l, ball.boostTarget);
	boostAngle = MultiplyVel(boostAngle, ball.boostStrength);
	ball.l = CombineVel(ball.l, boostAngle);
	}
	return ball;
}

+(Ball *)recover:(Ball *)ball{
	if (ball.recoveryRate > 0){
		if (ball.strength < ball.maxStrength){
			ball.strength+= ball.recoveryRate;	
		}
	}
	return ball;
}

+(Ball *)pursue:(Ball *)ball{
		CGPoint thrust = GetAngle(ball.l, ball.target);
	if (ball.pursuitStyle == 1){

		CGPoint modthrust = MultiplyVel(thrust, ball.accel);
		ball.vel = CombineVel(ball.vel, modthrust);

		if (ball.vel.x < -ball.maxMomentum){
			ball.vel = CGPointMake(-ball.maxMomentum,ball.vel.y);
		}
		if (ball.vel.x > ball.maxMomentum){
			ball.vel = CGPointMake(ball.maxMomentum,ball.vel.y);
		}
		if (ball.vel.y < -ball.maxMomentum){
			ball.vel = CGPointMake(ball.vel.x,-ball.maxMomentum);
		}
		if (ball.vel.y > ball.maxMomentum){
			ball.vel = CGPointMake(ball.vel.x,ball.maxMomentum);
		}
		
		if (ball.vel.x < 0 && ball.target.x > ball.l.x){
			ball.vel = CGPointMake(ball.vel.x+ball.brake,ball.vel.y);	
		}

		if (ball.vel.x > 0 && ball.target.x < ball.l.x){
			ball.vel = CGPointMake(ball.vel.x-ball.brake,ball.vel.y);	
		}
		
		if (ball.vel.y < 0 && ball.target.y > ball.l.y){
			ball.vel = CGPointMake(ball.vel.x,ball.vel.y+ball.brake);	
		}

		if (ball.vel.y > 0 && ball.target.y < ball.l.y){
			ball.vel = CGPointMake(ball.vel.x,ball.vel.y-ball.brake);	
		}
	}	
	
	if (ball.pursuitStyle == 2){
		if (ball.target.x > ball.l.x){	
			if (-2 < ball.vel.x < 2){
				ball.vel = CGPointMake(ball.vel.x+2,ball.vel.y);
			}
			if (ball.vel.x > 0){
				ball.vel = CGPointMake(ball.vel.x + (ball.vel.x*thrust.x*ball.accel),ball.vel.y);
			}
			if (ball.vel.x < 0){
				ball.vel = CGPointMake(ball.vel.x+ball.brake, ball.vel.y);
			}
			if (ball.vel.x > ball.maxMomentum){
				ball.vel = CGPointMake(ball.maxMomentum, ball.vel.y);
			}
		}
		if (ball.target.x < ball.l.x){	
			if (-2 < ball.vel.x < 2){
				ball.vel = CGPointMake(ball.vel.x-2,ball.vel.y);
			}
			if (ball.vel.x < 0){
				ball.vel = CGPointMake(ball.vel.x - (ball.vel.x*thrust.x*ball.accel),ball.vel.y);
			}
			if (ball.vel.x > 0){
				ball.vel = CGPointMake(ball.vel.x-ball.brake, ball.vel.y);
			}
			if (ball.vel.x < -ball.maxMomentum){
				ball.vel = CGPointMake(-ball.maxMomentum, ball.vel.y);
			}
		}

		if (ball.target.y > ball.l.y){	
			if (-2 < ball.vel.y < 2){
				ball.vel = CGPointMake(ball.vel.x,ball.vel.y+2);
			}
			if (ball.vel.y > 0){
				ball.vel = CGPointMake(ball.vel.x, ball.vel.y + (ball.vel.y*thrust.y*ball.accel));
			}
			if (ball.vel.y < 0){
				ball.vel = CGPointMake(ball.vel.x,ball.vel.y+ball.brake);
			}
			if (ball.vel.y > ball.maxMomentum){
				ball.vel = CGPointMake(ball.vel.x,ball.maxMomentum);
			}
		}
		if (ball.target.y < ball.l.y){	
			if (-2 < ball.vel.y < 2){
				ball.vel = CGPointMake(ball.vel.x,ball.vel.y-2);
			}
			if (ball.vel.y < 0){
				ball.vel = CGPointMake(ball.vel.x, ball.vel.y - (ball.vel.y*thrust.y*ball.accel));
			}
			if (ball.vel.y > 0){
				ball.vel = CGPointMake(ball.vel.x,ball.vel.y-ball.brake);
			}
			if (ball.vel.y < -ball.maxMomentum){
				ball.vel = CGPointMake(ball.vel.x,-ball.maxMomentum);
			}
		}
	}
	
	if (ball.bonusThrust == BONUS_THRUST_ON){				
		ball.vel = CombineVel(ball.vel, MultiplyVel(thrust, ball.bonusThrustStrength));
	}
	return ball;
}

-(void)move:(Ball *)ball{
	ball.l = CombineVel(ball.l, ball.vel);		
}
+(Ball *)move:(Ball *)ball{
	ball.l = CombineVel(ball.l, ball.vel);		
	return ball;
}

-(void)animate{	
}

-(void)move{
	self.l = CombineVel(self.l, self.vel);	
}

@end