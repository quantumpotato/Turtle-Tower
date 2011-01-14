//
//  BirdSpawner.h
//  TurtleTower
//
//  Created by X3N0 on 12/1/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatrolBird.h"

@protocol SpawnerBirdDelegate

-(void)didReceiveSpawnerBird:(Bird *)bird;

@end


@interface BirdSpawner : NSObject {
	CGPoint l;
	int direction;
	float speed;
	int timerleft;
	int timerreset;
	int kind;
	id <SpawnerBirdDelegate> delegate;
	Bird *spawnerBird;
}

@property(nonatomic,retain) Bird *spawnerBird;
@property(nonatomic,retain) id <SpawnerBirdDelegate> delegate;
@property(nonatomic) int kind;
@property(nonatomic) CGPoint l;
@property(nonatomic) int direction;
@property(nonatomic) float speed;
@property(nonatomic) int timerleft;
@property(nonatomic) int timerreset;

-(id)initWithBird:(Bird *)bird;
-(void)tick;

@end