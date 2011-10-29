//
//  TurtleTowerAppDelegate.m
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright Rage Creations 2010. All rights reserved.
//

#import "TurtleTowerAppDelegate.h"
#import "TurtleTowerViewController.h"

@implementation TurtleTowerAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
