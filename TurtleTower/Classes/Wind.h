//
//  Wind.h
//  TurtleTower
//
//  Created by X3N0 on 11/12/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WindDelegate

-(void)activeWindExpired;
-(void)inactiveWindExpired;

@end


@interface Wind : NSObject {
	int ticksleft;
	id <WindDelegate> delegate;
}

@property(nonatomic,assign) int ticksleft;
@property(nonatomic,retain) id <WindDelegate> delegate;

-(void)startWithTicks:(int)ticks;
-(void)tick;
-(float)windStrengthFromDifficulty:(int)difficulty;

@end
