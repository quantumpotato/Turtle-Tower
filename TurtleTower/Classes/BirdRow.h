//
//  BirdRow.h
//  TurtleTower
//
//  Created by X3N0 on 12/6/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bird.h"
#import "ScrollProtocol.h"
#import "Feather.h"

@interface BirdRow : NSObject <ScrollingProtocol> {
	Bird *bird1;
	Bird *bird2;
	int direction;
	BOOL droppedFeather;
}

@property(nonatomic,retain) Bird *bird1;
@property(nonatomic,retain) Bird *bird2;
@property(nonatomic) int direction;
@property(nonatomic) BOOL droppedFeather;

-(id)initWithBird:(Bird *)bird;

-(void)tick;
-(void)calculateDirection;

-(Feather *)feather;

@end