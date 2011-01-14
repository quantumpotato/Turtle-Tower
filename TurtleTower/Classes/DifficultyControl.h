//
//  DifficultyObject.h
//  TurtleTower
//
//  Created by X3N0 on 11/16/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DifficultyControl : NSObject {

}

-(float)calculateEffectForLevel:(int)level withMaximum:(int)max;

@end
