//
//  SetupCloud.h
//  TurtleTower
//
//  Created by X3N0 on 1/20/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Platform.h"

@protocol SetupCloudDelegate

-(void)setupCloudLanded;
-(void)setupCloudFinishedRise;

@end

@interface SetupCloud : Platform {

	id <SetupCloudDelegate> setupDelegate;
}

@property(nonatomic,retain)	id <SetupCloudDelegate> setupDelegate;

@end
