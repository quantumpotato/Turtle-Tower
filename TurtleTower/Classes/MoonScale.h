//
//  MoonScale.h
//  TurtleTower
//
//  Created by X3N0 on 1/13/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MoonScale : UIView {

	float progress;
	float height;
	UIImageView *moon;
	UIImageView *turtle;
}


-(void)updateProgress:(float)newProgress;

@end
