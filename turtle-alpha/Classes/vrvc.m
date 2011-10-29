//
//  vrvc.m
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "vrvc.h"


@implementation vrvc
@synthesize b, db, pl, dpl, obs, fileName;
@synthesize difficultyControllers;
-(void)initializeArrays{
	self.obs = [NSMutableArray array];
	self.b = [NSMutableArray array];
	self.db = [NSMutableArray array];
	self.pl = [NSMutableArray array];
	self.dpl = [NSMutableArray array];
	self.difficultyControllers = [NSMutableArray array];
}

-(void)loop{
	for (Ball *o in self.b){
		[Ball move:o];
	}
}

-(void)resetVision{
	
}

-(void)populateVision{
	[self resetVision];
}

-(void)resetPhysics{
	gamestate = 1;
}

-(void)resetScore{
}
-(void)setupViews{
}

- (void)viewDidLoad {
    [super viewDidLoad];
	UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
	accel.delegate = self;
	accel.updateInterval = kUpdateInterval;	
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
	self.view.backgroundColor = [UIColor blackColor];
	srandom(time(NULL));
	[self resetScore];
	[self setupViews];	
	[self resetPhysics];
	[self initializeArrays];
	[self populateVision];
	
	timer = [[NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(loop) userInfo:nil repeats:YES] retain];
}	

-(void)acceleratedInX:(float)xx Y:(float)yy Z:(float)zz
{
	outx = xx;
	outy = yy;
	outz = zz;
	
	outx = 100.0 - (xx + 1.0) * 100.0, xx;
	outy = 100.0 - (yy + 1.0) * 100.0, zz;
	outz = 100.0 - (zz + 1.0) * 100.0, zz;
	
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
	[self acceleratedInX:acceleration.x Y:acceleration.y Z:acceleration.z];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{		
	UITouch *touch = [touches anyObject];
	gestureStartPoint = [touch locationInView:self.view];

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	currentPosition = [touch locationInView:self.view];
}	

-(NSString *)gameFilePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:self.fileName];
}

-(void)saveScoresToPhone{}
-(void)readScoresFromDictionary:(NSDictionary *)d{}


@end