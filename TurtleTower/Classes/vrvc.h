//
//  vrvc.h
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#define kAccelerationThreshold		1.0
#define kUpdateInterval			(1.0f/33.0f)
#define kUserFileName @"TurtleTower.plist"

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "DifficultyObstacle.h"
#import "cmpvisuals.h"

@interface vrvc : UIViewController <UIAccelerometerDelegate> {
	NSMutableArray *b;
	NSMutableArray *db;
	NSMutableArray *pl;
	NSMutableArray *dpl;
	
	NSMutableArray *obs;
	
	NSTimer *timer;
	
	int gamestate;

	float gravacm;
	
	CGPoint gestureStartPoint;
	CGPoint currentPosition;
	
	NSString *fileName;
	
	int score;
	int highscore;
	int combo;
	int bestcombo;
	double aca, acb, acc, bb;
	double ac, bc;
	double outx, outy, outz, ap, bp, xcal, ycal;	
	UILabel *scoreLabel;
	
	CGPoint tangle2, tangle;
	float ftangle;
	
	UIImageView *background;
	
	NSMutableArray *difficultyControllers;
}

@property(nonatomic,copy) NSString *fileName;
@property(nonatomic,retain) NSMutableArray *obs;
@property(nonatomic,retain) NSMutableArray *b;
@property(nonatomic,retain) NSMutableArray *db;
@property(nonatomic,retain) NSMutableArray *pl;
@property(nonatomic,retain) NSMutableArray *dpl;

@property(nonatomic,retain) NSMutableArray *difficultyControllers;

-(void)initializeArrays;
-(void)resetPhysics;
-(void)populateVision;
-(void)loop;
-(void)resetScore;
-(void)setupViews;
-(void)saveScoresToPhone;
-(void)readScoresFromDictionary:(NSDictionary *)d;

-(NSString *)gameFilePath;

@end
