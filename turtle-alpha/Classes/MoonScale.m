//
//  MoonScale.m
//  TurtleTower
//
//  Created by X3N0 on 1/13/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "MoonScale.h"


@implementation MoonScale
@synthesize t;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		moon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Moon50.png"]];
		moon.transform = CGAffineTransformMakeScale(.6, .6);
		moon.center = CGPointMake(23,15);
		[self addSubview:moon];
		turtle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"turtlesmallsize1.png"]];
		turtle.center = CGPointMake(20,0);
		turtle.transform = CGAffineTransformMakeScale(.6, .6);
		[self updateProgress:0];
		[self addSubview:turtle];
    }
    return self;
}

-(float)calculatedProgress {
	return self.frame.size.height - (progress * self.frame.size.height);
}

-(void)tick{ 
	turtle.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(.6, .6), CGAffineTransformMakeScale(self.t.wscale * t.facing, self.t.hscale));
}

-(void)updateProgress:(float)newProgress {
	progress = newProgress;
	turtle.center = CGPointMake(turtle.center.x,[self calculatedProgress]);	
}

@end
