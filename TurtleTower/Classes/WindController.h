//
//  WindController.h
//  TurtleTower
//
//  Created by X3N0 on 11/16/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DifficultyController.h"
#import "WindActiveControl.h"
#import "EarlyGameWindControl.h"
#import "WindInactiveControl.h"

#define WIND_EARLY 0
#define WIND_ACTIVE 1
#define WIND_INACTIVE 2

@interface WindController : DifficultyController {
	EarlyGameWindControl *earlyGameWindControl;
	WindActiveControl *windActiveControl;
	WindInactiveControl *windInactiveControl;
}

@property(nonatomic,retain) EarlyGameWindControl *earlyGameWindControl;
@property(nonatomic,retain) WindActiveControl *windActiveControl;
@property(nonatomic,retain) WindInactiveControl *windInactiveControl;

@end
