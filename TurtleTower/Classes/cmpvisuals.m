//
//  cmpvisuals.m
//  TurtleTower
//
//  Created by X3N0 on 10/7/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "cmpvisuals.h"


UILabel * makelabelat(CGRect rect){
	UILabel *makelabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x-rect.size.width/2,rect.origin.y-rect.size.height/2,rect.size.width,rect.size.height)];
	makelabel.backgroundColor = [UIColor clearColor];
	makelabel.textColor = [UIColor whiteColor];
	makelabel.font = [UIFont systemFontOfSize:16];
	makelabel.textAlignment = UITextAlignmentCenter;
	return [makelabel autorelease];
}
