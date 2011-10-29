//
//  TurtleCarryBird.h
//  TurtleTower
//
//  Created by X3N0 on 1/16/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DivebombBird.h"

@protocol TurtleGrabbed

-(void)grabbedTurtle:(Bird *)bird;
-(void)finishedTurtleOffScreen;

@end


@interface TurtleCarryBird : DivebombBird {

	id <TurtleGrabbed> turtleGrabbedDelegate;
}

@property(nonatomic,retain) id <TurtleGrabbed> turtleGrabbedDelegate;

@end
