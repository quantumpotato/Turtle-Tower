//
//  PatrolBirdController.h
//  TurtleTower
//
//  Created by X3N0 on 11/17/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DifficultyController.h"
#import "PatrolBirdControl.h"

@interface PatrolBirdController : DifficultyController {
	PatrolBirdControl *patrolBirdControl;
}

@property(nonatomic,retain) PatrolBirdControl *patrolBirdControl;

@end