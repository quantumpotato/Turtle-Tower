//
//  TurtleTowerAppDelegate.h
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright Rage Creations 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TurtleTowerViewController;

@interface TurtleTowerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TurtleTowerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TurtleTowerViewController *viewController;

@end

