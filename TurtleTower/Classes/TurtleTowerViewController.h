//
//  TurtleTowerViewController.h
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright Rage Creations 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "vrvc.h"
#import "Turtle.h"
#import "Bird.h"
#import "Platform.h"
#import "WhiteCloud.h"
#import "BlueBase.h"
#import "Feather.h"
#import "Wind.h"
#import "WindController.h"
#import "BirdController.h"
#import "BirdSpawner.h"
#import "BirdRow.h"
#import "PatrolBirdRow.h"
#import "CampBirdRow.h"
#import "DivebombBirdRow.h"
#import "EasyCloud.h"
#import "MediumCloud.h"
#import "HardCloud.h"
#import "MoonScale.h"
#import "TurtleCarryBird.h"
#import "SetupCloud.h"
#import "StratosphereWarpCloud.h"
#import "MesosphereWarpCloud.h"
#import "ThermosphereWarpCloud.h"

#define CONTROLLER_WIND 0

#define ANIMSCENE_NONE -1
#define ANIMSCENE_TOWERFLY 0
#define ANIMSCENE_POSTDEATH 1

#define ANIMSTATE_TOWER_UP 0
#define ANIMSTATE_PLAT_FALL 1
#define ANIMSTATE_CLOUD_RISE 2


#define state_GAME_STATE_PLAY 1
#define state_GAME_STATE_INTRO 5
#define state_GAME_ANIMATING 7

#define state_INTRO_TURTLE_TALK 0
#define state_INTRO_BIRD_SWOOP 1
#define state_INTRO_BIRD_CARRY 2

@interface TurtleTowerViewController : vrvc <PlatformDelegate, WindDelegate, BirdControllerDelegate, SpawnerBirdDelegate, TurtleGrabbed, SetupCloudDelegate> {
	Turtle *t;	
	Turtle *t2;
	
	MoonScale *ms;
	
	CGPoint wind;
	
	int animscene, animstate, animstatetick;
	
	int scrollingPlatforms; //timer left
	int platformScrollSpeed;
	int newPlatformMinHeight;
	int newPlatformHeight;
	int turtleHeight;
	CGPoint turtleJumpStart;
	
	float maxJumpAimDistance;
	float maxJumpPower;
	
	int baseHeight;

	int jumpScheme;
	
	int lastScore;
	NSString *scoreText;
	
	BOOL colored;
	
	int consecutiveExcellent;
	int difficultyScore;
	int difficultyTickScore;
	
	//Difficulties
	
	int level;
	float diffPlatformWidth, diffPlatformWidthReset, diffPlatformWidthCycles;
	int fades, maxFades, diffFadeDelayReset, emptyFades, maxEmptyFades;
	

	int diffHWind, windless, windlessReset;
	float activeWind;
	
	int diffPlatformOscillate;
	int platformOscillateReset;
	
	int oldHeight;
	int heightGained;
	
	float targetHeight;
	BOOL targetDirectionRight;
	float targetHX;
	
	UILabel *levelLabel;
	UILabel *excellentLabel;
	UILabel *birdLabel;
	UILabel *turtleLabel; //Turtle Soups!
	int leveltick, sublevel, difflevel;
	int landingsInLevel;
	int cloudsLeft, cloudsLeftReset;
	
	int highestPlatformIndex;
	int mostExcellent, turtleSoups, birdsDodged, cMostExcellent;
	int highscore2,highscore3,highscore4;
	int mostExcellent2, mostExcellent3, mostExcellent4;
	UIView *manaView;
	int manaCharge;
	
	UILabel *activeScoring;
	UILabel *fastScoring;
	
	UIView *climbTowerText;
	UIView *upgradeText;
	UIView *scoresText;
	
	int showScoreTimer;
	int fastScoreTimer, fastScoreTimerReset;
	
	int turtleWalking;
	
	int birdRadius;
	int jumpTicksHeld;
	
	int minHeightForScroll, lastMinHeightForScroll;
	
	Platform *p0;
	Platform *p1;
	Platform *p2;
	Platform *p3;	
	
	BOOL scrolledForCurrentPlatform;
	
	int featherCountdown, featherCountdownReset;
	int stagesCleared;
	
	int jumpState;
	
	UIView *targetView;
	
	Bird *newestBird;
	
	BirdController *birdController;
	
	NSString *sphere;
	
	int jumpScrollLeft;
	
	float nextPlatformHeight;
	
	float cloudScrollSpeed;
	
	NSMutableArray *spawners;
	NSMutableArray *birdRows;
	
	int difficultyLevel;
	
	UILabel *easyText;
	UILabel *mediumText;
	
	UILabel *warpText1, *warpText2, *warpText3;
	
	float risingSpeed;
	
	int difficultySelectedStatus;
	
	UILabel *trainingText;
	
	int trainingState;
	
	float lands, totallands;
	
	UIImageView *heartshape1;
	UIImageView *heartshape2;
	
	BOOL mesowarp, thermowarp;
	
	int startinglevel;
}

@property(nonatomic,retain) UILabel *easyText;
@property(nonatomic,retain) UILabel *mediumText;
@property(nonatomic,retain) UILabel *warpText1;
@property(nonatomic,retain) UILabel *warpText2;
@property(nonatomic,retain) UILabel *warpText3;

@property(nonatomic,retain) NSMutableArray *spawners;
@property(nonatomic,retain) NSMutableArray *birdRows;

@property(nonatomic,copy) NSString *sphere;
@property(nonatomic,retain) BirdController *birdController;

@property(nonatomic,retain) Bird *newestBird;

@property(nonatomic,copy) NSString *scoreText;
@property(nonatomic,retain) UILabel *trainingText;

-(void)hideIntroText;
-(void)setupBeginning;
-(void)createIntroTexts;
-(void)showScore;
-(void)eraseAllClouds;
-(void)finishedSlideDown;
-(void)PlatformsLoop;

-(float)calculateCloudSpeedByDifficulty;
-(void)generateTexts;

-(void)setPlatformSpeed:(float)speed;
-(void)setHighPlatformSpeed:(float)speed;
-(void)setLowPlatformSpeed:(float)speed;

-(void)moonTalkEnded;
-(void)swoopEnded;

-(void)showMoonBar;
-(void)hideMoonScale;
-(void)showIntroTexts;

@end