//
//  Feather.h
//  TurtleTower
//
//  Created by X3N0 on 10/30/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DifficultyObstacle.h"


@interface Feather : DifficultyObstacle {

	UIImage *firstFeather;
	UIImage *secondFeather;
}

@property(nonatomic, retain) UIImage *firstFeather;
@property(nonatomic, retain) UIImage *secondFeather;



@end
