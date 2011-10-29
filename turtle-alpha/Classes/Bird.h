//
//  Bird.h
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DifficultyObstacle.h"
#import "Turtle.h"
#import "cmpgames.h"

@protocol BirdDelegate

-(CGPoint)turtlelocation;

@end


@interface Bird : DifficultyObstacle {
	CGPoint turtleloc;
	id <BirdDelegate> delegate;
	CGPoint originall;
		Turtle *t;
	BOOL disabled;	
}

@property(nonatomic) BOOL disabled;
@property(nonatomic) CGPoint turtleloc;
@property(nonatomic,retain) id <BirdDelegate> delegate;
@property(nonatomic) CGPoint originall;
@property(nonatomic,retain) Turtle *t;

-(id)initWithKind:(int)nk;
-(void)setBirdImage;
-(void)move;
-(void)turtlelanded;


@end