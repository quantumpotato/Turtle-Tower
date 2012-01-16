//
//  ScrollProtocol.h
//  TurtleTower
//
//  Created by X3N0 on 12/7/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ScrollingProtocol
@optional
-(void)scrollWithX:(float)x;
-(void)scrollWithY:(float)y;
@end