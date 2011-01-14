//Wind needs to save its calculations
//Birds need dynamic ones


//shop (2,2+exit), scroll down
//shop views
//scores: no scroll, just pop OF

//meter at bottom
//mana builds up every game
//6 icons
//Gold Items
//Feather (float available) (active)
//Rocket (kill birds) (cost mana)
//Shield (protects) (cost mana)
//Extra Life (ressurect!) (active)
//Green Items
//Weather Tower: Disable wind for 15 platforms (High Score: XXXXXXX
//Gravity Stabilizer: Disable rotation for 15 platforms (Total Score: XXXXXX
//Fast Mana: Double mana gain (Most excellent: 30)
//Game loads:
//White platform left: TOWER
//Gold platform center: POWER UP
//Green platform right: SCORES
//mana at bottom
//High score lower left top
//Most excellent lower left bottom
//Birds dodged lower left top
//Turtle Soups lower right bottom (deaths)
//Landing on a cloud takes it off screen
//Populate clouds, then pull them down
//Move bottom cloud up from bottom with Turtle on it.


//TurtleTower title at top
//Test camp birds
//Stalk bird

//Target Y
//Lowers with l.y
//=plat.l.y + 1
//Activate when turtle breaches , 

//Camp birds flap wings fast: will charge immediately, time your landing. Will always contain enough
//Y variance to be out of the way.
//Camp birds flap wings slow: will delay then charge wherever the turtle was at the time of delaying.
//Land somewhere, then move.
//Possibly will charge at the current Turtle's X, old Y?

//Game components
//Patrol bird
//Camp bird
//Stalk bird
//Platforms

//Difficulty modifiers
//All modifiers are range of MAX - using random number min-max.
//Maxspeed increases A2-6,B2-6,C2-6 (where A-C are game components)
//Patrol bird oscillation A2-6
//Levels have horizontal wind A1-3
//Stalk bird wait time A1-4
//Levels have vertical wind A1-3
//*7 * 5 = 35 levels, * 50 platforms = 1750 platforms! fair bit of jumping.
//Rotate screen on platform land A1-6 and increase max rotation. Switch direction at max rotation
//Now at 2000 platforms! //Take a highscore here.

//

//Catherine notes: 
//Shoot bird
//Show Level	

//Score lower, Best Score
//Birds

//Best (x# consec Excellent!)

//Neko notes:
//Bird tracks X then drops stone
//Spikes on platforms
//Patrolling a platform spaceship
//Slinky hops platforms

//Difficulty: 70->20 (every 500, repeat for moving platform speed). LV above score
//Challenge: Number of birds, speed of birds, bird repeat rate(?)
//Challenge: Platform movement speed

//Score 500: first bird activates, set height repeat

//Speed of birds cycles every 80 levels, then adds new bird

//50 levels finished:
//Bird type 2
//Moving platform
//Wind

//
//  TurtleTowerViewController.m
//  TurtleTower
//
//  Created by X3N0 on 9/23/10.
//  Copyright Rage Creations 2010. All rights reserved.
//

//Achievements
//Score total
//Platforms climbed
//Consec Excellent
//Birds dodged (when the bird gets dealloced)	

#import "TurtleTowerViewController.h"

@implementation TurtleTowerViewController
@synthesize scoreText, newestBird;
@synthesize birdController, sphere;
@synthesize spawners, birdRows;
@synthesize easyText, mediumText, trainingText;

-(void)initializeArrays{
	[super initializeArrays];
	self.spawners = [NSMutableArray array];
	self.birdRows = [NSMutableArray array];
}

-(void)scrollPlatforms{
	scrollingPlatforms = 100;
}

-(void)showScore{
	if (gamestate == 1){
		excellentLabel.text = [NSString stringWithFormat:@"Most Excellent: %d",cMostExcellent];
		turtleLabel.text = @"";
		birdLabel.text = @"";
		
		if (consecutiveExcellent <= 1){
			activeScoring.text = [NSString stringWithFormat:@"%@ +%d",scoreText, lastScore];	
		}else{
			activeScoring.text = [NSString stringWithFormat:@"%@ x %d +%d",scoreText, consecutiveExcellent, lastScore];		
		}
		
		if (lastScore <= 20){
			activeScoring.textColor = [UIColor redColor];
		}
		if (lastScore >20 && lastScore <= 40){
			activeScoring.textColor = [UIColor orangeColor];
		}
		if (lastScore > 40 && lastScore <= 60){
			activeScoring.textColor = [UIColor yellowColor];
		}
		if (lastScore > 60 && lastScore <= 80){
			activeScoring.textColor = [UIColor purpleColor];
		}
		if (lastScore > 80 && lastScore <= 95){
			activeScoring.textColor = [UIColor greenColor];
		}
		if (lastScore > 95){
			activeScoring.textColor = [UIColor whiteColor];
		}
	}	
	if (gamestate == 5){
		levelLabel.text = @"";
		scoreLabel.text = [NSString stringWithFormat:@"High Score: %d",highscore];	
		excellentLabel.text = [NSString stringWithFormat:@"Most Excellent: %d",mostExcellent];
		turtleLabel.text = [NSString stringWithFormat:@"Turtle Soup: %d",turtleSoups];
		birdLabel.text = [NSString	stringWithFormat:@"Birds Dodged: %d",birdsDodged];
	}
}

-(void)calculateSphere{
	if (level <= 12){
		self.sphere = @"Stratosphere";
	}else if (level > 12 && level <= 25){
		self.sphere = @"Mesosphere";
	}else if (level > 25 && level <= 37){
		self.sphere = @"Thermosphere";
	}else if (level > 37 && level <= 50){
		self.sphere = @"Exposphere";
	}else if (level > 50 && level <= 62){
		self.sphere = @"Space";
	}else if (level > 62 && level <= 75){
		self.sphere = @"Outer Space";
	}else if (level > 75 && level <= 87){
		self.sphere = @"Deep Space";
	}else if (level > 87 && level <= 100){
		self.sphere = @"Lunar Space";
	}
}

-(void)showLevelLabel{
	levelLabel.text = [NSString stringWithFormat:@"%@: Level %d-%d",self.sphere,level,leveltick];
}

-(Platform *)highestPlatform{
	int height = 480;
	Platform *returnP = [[[Platform alloc] init] autorelease];
	for (int i = 0; i < [self.pl count]; i++){
		Platform *p = (Platform*)[self.pl objectAtIndex:i];
		if (p.l.y < height && p.l.x < 1000){
			height = p.l.y;
			returnP = p;	
			highestPlatformIndex = i;
		}
	}
	return returnP;
}

-(Platform *)lowestPlatform{
	int height = 0;
	Platform *returnP = [[[Platform alloc] init] autorelease];
	for (int i = 0; i < [self.pl count]; i++){
		Platform *p = (Platform*)[self.pl objectAtIndex:i];
		if (p.l.y > height && p.l.y < 520 && p.l.x < 1000){
			height = p.l.y;
			returnP = p;	
		}
	}
	return returnP;
}

-(void)resetPlatforms{
	for (int i = 0; i < [self.pl count]; i++) {
		Platform *p = (Platform *)[self.pl objectAtIndex:i];
		if (p.platform != 200){
			p.width = diffPlatformWidth;
			p.view.frame = CGRectMake(0,0,diffPlatformWidth*2,16);
			p.view.center = p.l;
			p.imageView.center = p.l;
			p.landed = 0;
			p.view.backgroundColor = [UIColor darkGrayColor];
		}
	}	
}

-(void)setPlatformSize:(Platform *)plat{
	plat.height = 12-stagesCleared; //originally 8
	plat.width = diffPlatformWidth;
}

-(void)drawPlat:(Platform *)plat{
	plat.view.frame = CGRectMake(0,0,plat.width*2,plat.height*2);
	plat.secondView.frame = CGRectMake(0,0,plat.width*2,plat.height*2);
	[self.pl addObject:plat];
	//	[self.view addSubview:((Platform *)[self.pl objectAtIndex:[self.pl count]-1]).view];	
	[self.view insertSubview:((Platform *)[self.pl objectAtIndex:[self.pl count]-1]).view belowSubview:t.imageView];
	[self.view insertSubview:((Platform *)[self.pl objectAtIndex:[self.pl count]-1]).secondView belowSubview:t.imageView];
	plat.view.center = plat.l;		
	plat.imageView.center = plat.l;	
}

-(void)setFadeForPlatform:(Platform *)plat{
	plat.fades = YES;
	plat.fadeReset = 100 - (diffFadeDelayReset * 10);
	plat.fadeDelay = plat.fadeDelay;
	plat.fadeLeft = 100;
	plat.fadeDirection = -1;
	//	NSLog(@"Fades: %d, fadeReset: %d",plat.fades,plat.fadeReset);
	emptyFades = 0;
}

-(void)checkFadeSetForPlat:(Platform *)plat{
	if (level >= 15){
		int randomFade = arc4random() % 4;
		BOOL generated = NO;
		if (fades < maxFades){
			if (randomFade >= 3){
				fades++;
				generated = YES;
				[self setFadeForPlatform:plat];
			}
		}
		if (generated == NO){
			emptyFades++;	
			if (emptyFades > maxEmptyFades){
				generated = YES;
				[self setFadeForPlatform:plat];
				fades = 1;
			}
		}
		if (generated == NO){
			fades = 0;	
		}
	}
}

-(void)setPlatformOscillate:(Platform *)plat{
	if (level >= 25){
		int oscillateDirection = -1;
		int randomOscillateChange = arc4random() % 2;
		if (randomOscillateChange == 1){
			oscillateDirection = 1;	
		}
		plat.direction = oscillateDirection;
		int oscillateValue = arc4random() % diffPlatformOscillate;
		oscillateValue++;
		plat.oscillateValue = oscillateValue;
		int repeat = arc4random() % 20;
		plat.oscillateRepeatReset = repeat + 15;
		plat.oscillateRepeat = plat.oscillateRepeatReset;
	}
}

-(void)generatePlatform{
	Platform *highestPlat = [self highestPlatform];
	
	int xl = random() % 250;
	int yl = random() % newPlatformHeight;
	yl+= newPlatformMinHeight;
	Platform *plat = [[Platform alloc] init];
	
	plat.delegate = self;
	plat.platform = highestPlatformIndex+1;
	if (![highestPlat isKindOfClass:[NSNull class]]){
		plat.l = CGPointMake(xl+70,highestPlat.l.y-yl);
		self.birdController.highestPlatformY = plat.l.y;	
	}else{
		plat.l = CGPointMake(xl+70,-300+yl);	
		self.birdController.highestPlatformY = plat.l.y;
	}
	plat.secondView.center = CGPointMake(plat.l.x+320,plat.l.y);
	plat.width = diffPlatformWidth;
	
	
	[self setPlatformOscillate:plat];
	
	[self setPlatformSize:plat];
	[self drawPlat:plat];
	[self checkFadeSetForPlat:plat];
	
	[plat release];
	
}

-(void)generatePlatformAt:(int)newY{
	[self generatePlatform];
	Platform *p = (Platform *)[self.pl objectAtIndex:[self.pl count]-1];
	p.l = SYetY(p.l, newY);
	p.view.center = p.l;		
	p.imageView.center = p.l;		
}

-(void)centerTurtleAtPlatform:(Platform *)p{
	t.l = SYOffsetY(p.l, -(turtleHeight+p.height));
	t.l = SYetY(p.l, p.l.y-(turtleHeight+p.height));
	t.lastl = t.l;
}

-(void)positionTurtleAtLowestPlatform{
	Platform *p = [self lowestPlatform];
	p.landed = 1;
	[self centerTurtleAtPlatform:p];	
}

-(void)positionTurtleAtFirstPlatform{
	Platform *p = [self highestPlatform];
	p.landed = 1;
	t.l = SYOffsetY(p.l, -(turtleHeight+p.height));
	t.lastl = t.l;
}

-(void)generateFirstPlatform{
	int xl = random() % 270;
	//	int yl = random() % newPlatformHeight+newPlatformMinHeight;
	Platform *plat = [[Platform alloc] init];
	plat.platform = 0;
	plat.l = CGPointMake(xl,350);
	[self drawPlat:plat];
}

-(void)checklevel{
	
	NSLog(@"Level: %d sublevel: %d",level,sublevel);
	
	if (level >= 15 && level <= 19){
		maxFades++;
		diffFadeDelayReset++;
	}
	if (level >= 20 && level <= 24){
		diffHWind++;
		if (level == 20){
			
			windlessReset = 5;
		}
	}
	
	if (level >= 25 && level <= 29){
		diffPlatformOscillate++;	
	}
}

-(void)activateWind{
	int randomWind;
	if (diffHWind > 1){
		randomWind = arc4random() % diffHWind;
		randomWind++;
	}else{
		randomWind=1;	
	}
	
	activeWind = randomWind * .5 + .5;
	//Randomize wind
	int changeWind = arc4random() % 2;
	if (changeWind == 1){
		activeWind = -activeWind;	
	}
}


-(void)increaseLevel{
	level++;
	leveltick = 0;	
	if (cloudScrollSpeed < 10){
		cloudScrollSpeed+= .08;
	}
	[self calculateSphere];
	
	for (DifficultyController *dc in self.difficultyControllers){
		[dc gainLevel];
	}
	
	[self.birdController gainLevel];
}

-(void)calculatePlatformDifficulty{
	diffPlatformWidth--;
	if (diffPlatformWidth == 70-diffPlatformWidthCycles){
		diffPlatformWidthCycles++;
		diffPlatformWidth = diffPlatformWidthReset - diffPlatformWidthCycles * 1;
		if (diffPlatformWidth < 50){
			diffPlatformWidth = 50;	
		}
	}		
}

-(void)calculateDifficulty{
	
	leveltick++;
	//	if (cloudScrollSpeed < 10){
	//		cloudScrollSpeed += .02; //.1
	//	}
	if (leveltick == landingsInLevel){ //14
		[self increaseLevel];
	}
	
	[self showLevelLabel];
	
	DifficultyController *wc = [self.difficultyControllers objectAtIndex:CONTROLLER_WIND];
	activeWind = [wc calculateEffect];
	
	
	[self calculatePlatformDifficulty];
}

-(void)colorPlatform:(Platform *)p withScore:(int)accuracy{
	
	if (accuracy <= 20){
		p.view.backgroundColor = [UIColor redColor];	
		p.secondView.backgroundColor = [UIColor redColor];
	}
	if (accuracy >20 && accuracy <= 40){
		p.view.backgroundColor = [UIColor orangeColor];	
		p.secondView.backgroundColor = [UIColor orangeColor];
	}
	if (accuracy > 40 && accuracy <= 60){
		p.view.backgroundColor = [UIColor yellowColor];	
		p.secondView.backgroundColor = [UIColor yellowColor];
	}
	if (accuracy > 60 && accuracy <= 80){
		p.view.backgroundColor = [UIColor purpleColor];	
		p.secondView.backgroundColor = [UIColor purpleColor];
	}
	if (accuracy > 80 && accuracy <= 95){
		p.view.backgroundColor = [UIColor greenColor];	
		p.secondView.backgroundColor = [UIColor greenColor];
	}
	if (accuracy > 95){
		p.view.backgroundColor = [UIColor whiteColor];	
		p.secondView.backgroundColor = [UIColor whiteColor];
	}
}

-(void)showBeginningPlatforms{
	diffPlatformWidth = 35;
	
	WhiteCloud *wc = [[WhiteCloud alloc] init];
	wc.l = CGPointMake(70,230);
	wc.delegate = self;
	[self drawPlat:wc];
	wc.secondView.center = CGPointMake(1000,500);	
	[self.pl addObject:wc];
	[wc release];
	
	BlueBase *basePlat = [[BlueBase alloc] init];
	basePlat.l = CGPointMake(160,350);
	basePlat.delegate = self;
	[self drawPlat:basePlat];
	basePlat.secondView.center = CGPointMake(1000,500);
	[self.pl addObject:basePlat];
	
	[basePlat release];
	
}

-(void)startTowerSequence{
	animscene = ANIMSCENE_TOWERFLY;
	animstate = ANIMSTATE_TOWER_UP;
	gamestate = state_GAME_ANIMATING;
	diffPlatformWidth = 70;
	//turtle and platform go up offscreen, then warp them to bottom
	//generate multiple platforms
	//scroll platforms down
	//scroll turtle and platform up
	//display how-to text
	//start game
}

-(void)calcTrainingText {
	if (trainingState > 0) {
		trainingState++;
		self.trainingText.center = CGPointMake(t.l.x, t.l.y-40);
		
		if (trainingState <= 2){
			
			self.trainingText.text = @"Moon Turtle waits for you!";
		} else 	if (trainingState <= 4){
			self.trainingText.text = @"Land central to clouds for points!";
		}else 	if (trainingState <= 6){
			self.trainingText.text = @"Avoid hungry birds!";
		}else if (trainingState == 7) {
			trainingState = 0;
			self.trainingText.center = CGPointMake(500,500);
		}
	}
}

-(void)landedOnPlatform:(Platform *)p firstPlatform:(BOOL)firstPlat{	
	if (gamestate == 1){
	[self calcTrainingText];
	}
	t.landedMainCloud = firstPlat;
	
	[p landedOn:t firstPlatform:firstPlat];
	t.platform = p.platform;
	[p centerTurtleOnPlatform:t];	
	
	for (int i = 0; i < [self.birdRows count]; i++) {
		BirdRow *br = (BirdRow *)[self.birdRows objectAtIndex:i];
		if (br.bird1.kind == OBS_KIND_CAMP_BIRD){
			[br.bird1 turtlelanded];
		}
	}
}


-(void)scrollEverythingWithX:(float)x{
	if (gamestate == 1){
		for (int i = 0; i < [self.pl count]; i++){
			Platform *p = (Platform*)[self.pl objectAtIndex:i];
			p.l = CGPointMake(p.l.x+x,p.l.y);
		}
		for (int i = 0; i < [self.obs count]; i++){
			DifficultyObstacle *o = (DifficultyObstacle *)[self.obs objectAtIndex:i];
			o.l = CGPointMake(o.l.x+x,o.l.y);
			
		}
		for (int i = 0; i < [self.birdRows count]; i++) {
			BirdRow *br = (BirdRow *)[self.birdRows objectAtIndex:i];
			[br scrollWithX:x];
		}
	}
	
}


-(void)scrollEverythingWithY:(float)y{
	for (Ball *ball in self.b){
		ball.l = IYncreaseY(ball.l, y);
	}
	for (int i = 0; i < [self.birdRows count]; i++) {
		BirdRow *br = (BirdRow *)[self.birdRows objectAtIndex:i];
		[br scrollWithY:y];
	}
	
	for (int i = 0; i < [self.pl count]; i++){
		Platform *p = (Platform*)[self.pl objectAtIndex:i];
		p.l = IYncreaseY(p.l, y);
	}
}

-(void)setDifficulties{
	NSLog(@"Setting diff: %d", difficultyLevel);
	switch (difficultyLevel) {
		case 0:
			diffPlatformWidthReset = 136; //120
			cloudScrollSpeed = 1.5;
			break;
		case 1:
			diffPlatformWidthReset = 110;
			cloudScrollSpeed = 2.7;			
			break;
		case 2:
			diffPlatformWidthReset = 84;
			cloudScrollSpeed = 4;			
			break;
		case 3:
			diffPlatformWidthReset = 58;	
			cloudScrollSpeed = 5;			
			break;		
		default:
			break;
	}
	
	[self.birdController setDifficultyLevel:difficultyLevel];
	
	diffPlatformWidthCycles = 0;
	diffPlatformWidth = diffPlatformWidthReset;			
	
	
}

-(void)resetDifficulty{
	self.sphere = @"Stratosphere";
	difficultySelectedStatus = -1;
	cloudScrollSpeed = 3;
	landingsInLevel = 25; //25, 14;
	leveltick = 0;	
	sublevel = 0;	
	difficultyTickScore = 0;
	level = 1;
	//	[self showLevelLabel];
	diffPlatformWidthReset = 136; //120
	diffPlatformWidthCycles = 0;
	diffPlatformWidth = diffPlatformWidthReset;
	
	
	diffFadeDelayReset = 0;
	
	emptyFades = 0;
	maxEmptyFades = 4;
	
	diffHWind = 4; //0
	activeWind = 0;
	diffPlatformOscillate = 5;
	platformOscillateReset = 15;
	stagesCleared = 0;
	
	featherCountdown = 20;
	featherCountdownReset = 50;
	level = 1;
	fades = 0;
	maxFades = 0;
	maxFades = 0;
	
	fastScoreTimerReset = 50;
	cloudsLeftReset = 4;
	cloudsLeft = cloudsLeftReset;
	
	sublevel = 0;
	windless = 0;
	windlessReset = 5;
	difficultyLevel = 0;
	[self setDifficulties];
}

-(void)killplatforms{
	for (int i = 0; i < [self.pl count]; i++) {
		Platform *p = (Platform *)[self.pl objectAtIndex:i];
		p.l = CGPointMake(5000,5000);
		p.view.center = p.l;
		[self.pl removeObjectAtIndex:i];
	}	
	
}


-(void)resetScore{
	trainingState = 1;
	consecutiveExcellent = 0;
	cMostExcellent = 0;
	lastScore = 0;
	score = 0;
	level = 1;
	difficultyScore = 0;
	[self saveScoresToPhone];
	[self resetDifficulty];
	[self showScore];
}

-(void)removeAllBirdRows{
	for (int i = 0; i < [self.birdRows count]; i++){
		BirdRow *br = (BirdRow *)[self.birdRows objectAtIndex:i];
		br.bird1.l = CGPointMake(160,800);
		br.bird2.l = CGPointMake(160,800);
	}
}

-(void)killTurtle{
	self.trainingText.center = CGPointMake(500,500);
	t.l = SYetY(t.l,0);
	t.vel = CGPointMake(0,1);
	t.state = TSP_TURTLE_STATE_PLATFORM;
	turtleSoups++;
	scoreText = @"Died!";
	if (score > highscore){
		highscore = score;
	}
	
	[self eraseAllClouds];
	[self removeAllBirdRows];
	
	[self hideMoonScale];
	
	[self showBeginningPlatforms];
	[self centerTurtleAtPlatform:[self lowestPlatform]];
	gamestate = 5;
	[self showScore];
	
	[self.birdController reset];
	
	[self resetScore];
	
	//t.l = SYetY(t.l, -200);
	///	gamestate = state_GAME_ANIMATING;
	//	animscene = ANIMSCENE_POSTDEATH;
	//	animstate = ANIMSTATE_CLOUD_RISE;
	//	animstatetick = 48;
	//	
	
}

-(void)scrollForTurtleJump{
	t.jumpLeft--;
	t.l = CombineVel(t.l, t.vel);
	if (t.jumpLeft == 0){
		t.vel = SYetY(t.vel, 2);	
	}
}


-(void)setAccelerometerForPlatform{
	ap = -((outx)/100); 
	t.walkDir = 0;
	
	//	t.walkDir = 0;
	if (ap > .02){
		t.walkDir = 1;		
	}
	if (ap < -.02){
		t.walkDir = -1;		
	}
	
	if (ap > .06){
		t.walkDir = 2;		
	}
	if (ap < -.06){
		t.walkDir = -2;		
	}
	
	if (ap > .14){
		t.walkDir = 4;		
	}
	if (ap < -.14){
		t.walkDir = -4;		
	}
	
	if (ap > .2){
		t.walkDir = 6;		
	}
	if (ap < -.2){
		t.walkDir = -6;		
	}
	
	t.walkDir = 3;
}

-(void)turtleStatePlatform{
	int distance = baseHeight - t.l.y;
	
	[self.birdController divebombTick];	
	
	if (t.walking != 0) {
		float walkDist = 0;
		if (t.l.x+(t.walking * t.walkSpeed) < t.rightedge && t.l.x+(t.walking * t.walkSpeed) > t.leftedge) {
			walkDist = t.walking * t.walkSpeed;
		} else {
			if (t.walking > 0 && t.rightedge > t.l.x + 1) {
				walkDist = t.rightedge-t.l.x-6;	
			} else if (t.walking < 0 && t.leftedge < t.l.x - 1) {
				walkDist = t.l.x-t.leftedge+6;
			}
		}
		if (walkDist != 0) {
			t.leftedge-= t.walking;
			t.rightedge-= t.walking;
			[self scrollEverythingWithX:-t.walking];
		}
		
	}
	
	
	for (int i = 0; i < 10; i++){
		if (distance > 1){
			[self scrollEverythingWithY:1];	
			distance = baseHeight - t.l.y;			
			t.l = SYOffsetY(t.l, 1);
		}	
	}
	
	if (distance > 0){
		[self scrollEverythingWithY:1];	
		t.l = SYOffsetY(t.l, 1);
	}
}

-(void)turtleFalling{
	for (int i = 0; i < [self.pl count]; i++){
		Platform *p = (Platform*)[self.pl objectAtIndex:i];
		if (t.lastl.y <= p.l.y-p.height){
			if (t.l.y >= p.l.y-p.height){
				int whichPlat = 0;
				if (fabsf(t.l.x-p.l.x) <= p.width){
					whichPlat = 1;
				}else if (fabsf(t.l.x-p.secondView.center.x) <= p.width){
					whichPlat = 2;
				}
				
				
				if (whichPlat > 0){
					BOOL platformLandable = NO;
					
					if (p.fades == NO){
						platformLandable = YES;
					}else if (p.fades == YES){
						if (p.fadeLeft >= 20){
							platformLandable = YES;
						}
					}
					if (platformLandable == YES){
						if (whichPlat == 1){
							[self landedOnPlatform:p firstPlatform:YES];
						}else{
							[self landedOnPlatform:p firstPlatform:NO];	
						}
					}
				}	
			}
		}
	}
	
	
	if (t.l.y > 480){
		//gameover
		if (gamestate == 1){
			[self killTurtle];
		}
	}
}	

-(void)turtleStateAir{
	t.l = SXOffsetX(t.l, activeWind);
	
	[self scrollEverythingWithX:-t.vel.x];
	
	t.lastl = t.l;
	if (t.jumpLeft > 0){
		[self scrollForTurtleJump];
	}
	
	if (jumpScheme == 1){
		if (t.vel.y < 0 && t.jumpLeft == 0){
			t.vel = CGPointMake(t.vel.x,t.vel.y+
								((0-t.vel.y)*gravacm));			
		}
	}
	
	if (t.vel.y >= 0){
		t.vel = CGPointMake( t.vel.x, t.vel.y +
							(   t.vel.y * gravacm));
	}
	
	if (t.vel.y < 0){
		t.vel = SYOffsetY(t.vel, (0-t.vel.y)*gravacm);
		if (gamestate == 1){
			if (t.l.y < baseHeight - 30){
				[self scrollEverythingWithY:-t.vel.y];
				t.l = SYOffsetY(t.l,-t.vel.y);		
			}
		}
	}
	
	if (t.vel.y > -2 && t.vel.y < 2){
		t.vel = SYetY(t.vel, 2);	
	}
	
	//Move turtle with wind
	if (gamestate == 1){
		t.l = CombineVel(t.l, CGPointMake(0,t.vel.y));
	} else {
		t.l = CombineVel(t.l, t.vel);
	}
	
	if (t.vel.y >= 0){		
		[self turtleFalling];
	}
	
	if (t.l.x> 290 && t.vel.x > 0){
		t.l = SXetX(t.l, 290);	
		t.vel = SXetX(t.vel, 0);
		
	}
	if (t.l.x < 30 && t.vel.x < 0){
		t.l = SXetX(t.l, 30);	
		t.vel = SXetX(t.vel, 0);
	}
	
	
	if (t.l.x> 320){
		t.l = SXetX(t.l, 320);
	}
	if (t.l.x < 0){
		t.l = SXetX(t.l, 0);	
	}
}	

-(void)TurtleLoop{
	[t tick];
	[self setAccelerometerForPlatform];
	
	if (gamestate == 60 && t.state == TSP_TURTLE_STATE_PLATFORM){
		t.vel = CGPointMake(0,risingSpeed);
		t.l = CombineVel(t.l, t.vel);
	}else if (gamestate == 20){
		t.vel = CGPointMake(0,-10);
		t.l = CombineVel(t.l, t.vel);
		climbTowerText.center = CGPointMake(climbTowerText.center.x,climbTowerText.center.y+20);
		upgradeText.center = CGPointMake(upgradeText.center.x,upgradeText.center.y+20);
		scoresText.center = CGPointMake(scoresText.center.x,scoresText.center.y+20);		
		//		Platform *p = (Platform *)[self.pl objectAtIndex:INDEX_BLUE];
		//		p.vel = CGPointMake(0, 2);
	}else if (gamestate == 40){
		t.vel = CGPointMake(0,-1);
		t.l = CombineVel(t.l, t.vel);
	}
	
	if (t.state == TSP_TURTLE_STATE_PLATFORM){
		if (gamestate == 1){
			[self turtleStatePlatform];
		}		
	}else if (t.state == TSA_TURTLE_STATE_AIR){
		[self turtleStateAir];
	}
	
	t.imageView.center = t.l;
}	

-(void)vanishCloudAtIndex:(int)i{
	Platform *p = (Platform *)[self.pl objectAtIndex:i];
	p.vel = CGPointZero;
	p.l = CGPointMake(1600, 10000+i);
	p.view.center = CGPointMake(160,10000+i);
	p.secondView.center =CGPointMake(160,10000+i);
	p.imageView.center = CGPointMake(1000,10000);
	p.imageView.center = CGPointMake(-1000,0);
	[self.pl removeObjectAtIndex:i];
}

-(float)calculateCloudSpeedByDifficulty{
	float speed = cloudScrollSpeed;
	if (difficultyLevel == 2){
		int random = arc4random() % 5;
		speed += random * .2;
		speed = -speed;
	} else if (difficultyLevel == 3){
		int random = arc4random() % 8;
		speed += random * .2;
	}
	
	if (difficultyLevel > 0){
		int reverse = arc4random() % 2;
		if (reverse == 0) {
			speed = -speed;	
		}
	}
	
	return speed;
}

-(void)PlatformsLoop{
	if (gamestate > 1){
		if (gamestate == 30){
			Platform *p = [self lowestPlatform];
			if (p.l.y >= 460){
				[self finishedSlideDown];	
			}
		}else if (gamestate == 40){
			Platform *p = [self lowestPlatform];
			if (p.l.y <= 480){
				[self finishedFloat];	
			}
		}else if (gamestate == 50){
			Platform *wc = (Platform *)[self.pl objectAtIndex:INDEX_WHITE];
			if (wc.l.y<= 260){
				gamestate = 5;
			}
		}
	}
	
	for (int i = 0; i < [self.pl count]; i++){
		Platform *p = (Platform*)[self.pl objectAtIndex:i];
		if ([p isKindOfClass:[Platform class]]) {
			[p move];
			if (gamestate == 21) {
				if (p.width < 100 && p.l.y > 230) {
					gamestate = 5;	
					[self setPlatformSpeed:0];
				}
			}
		}
		
		if (gamestate == 1){	
			if (p.landed == 0){
				[p calculateFade];
				//	[p calculateOscillate];
				
				if (p.maxStrength == 0){
					p.vel = CGPointMake([self calculateCloudSpeedByDifficulty],0);
					p.maxStrength = 1;
				}
			}
			if (p.l.y > 479 && p.l.x < 1000){
				[self vanishCloudAtIndex:i];
			}			
		}
	}	
}


-(void)resetPhysics{
	[super resetPhysics];	
	newPlatformMinHeight = 75;
	newPlatformHeight = 50;
	turtleHeight = 13; //20
	t.height = turtleHeight;
	maxJumpAimDistance = 80;
	maxJumpPower = 23;
	gravacm = .15;
	baseHeight = 375;
	jumpScheme = 7; //Was 5
	birdRadius = 35;
	[self resetScore];
}

-(void)calculateNextPlatformHeightFromHeight:(float)height{
	float platformDifference = 500;
	for (Platform *p in self.pl){
		if (p.l.y <height){
			if (height - p.l.y < platformDifference){
				platformDifference = height - p.l.y;
			}
		}
	}
	nextPlatformHeight = platformDifference;
}

-(void)checkForBirdRemoval{
	NSMutableArray *indexes = [NSMutableArray array];
	for (int i = 0; i < [self.obs count]; i++){
		Bird *ob = (Bird *)[self.obs objectAtIndex:i];
		BOOL deleteBird = NO;
		if (ob.l.x > t.l.x + (320*5) && ob.vel.x > 0){
			deleteBird = YES;	
		}else if (ob.l.x < t.l.x - (320*5) && ob.vel.x < 0){
			deleteBird = YES;	
		}
		
		if (deleteBird){
			[indexes addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	
	for (NSString *is in indexes){
		Bird *delb = (Bird *)[self.obs objectAtIndex:[is intValue]];
		delb.imageView.center = CGPointMake(5000,500);
		delb.view.center = CGPointMake(5000,500);
		if (gamestate == 1 && delb.kind < 3){
			birdsDodged++;
		}
		[self.obs removeObjectAtIndex:[is intValue]];
	}
}

-(void)ObstacleLoop{
	for (int i = 0; i < [self.obs count]; i++) {
		DifficultyObstacle *ob = (DifficultyObstacle *)[self.obs objectAtIndex:i];
		[ob move];
		[ob animate];
		//Maybe?
		
		if (ob.kind == OBS_KIND_FEATHER){
			ob.vel = SXetX(ob.vel, activeWind);
			[ob move];
			ob.view.center = ob.l;
		}
	}
	
	if (gamestate == 1){
		[self checkForBirdRemoval];
	}
	
}


-(void)animatePlatformFall{
	for (int i = 0; i < [self.pl count]; i++){
		Platform *p = (Platform *)[self.pl objectAtIndex:i];
		//		if (p.platform != 100 && p.l.y < 480){
		p.l = SYOffsetY(p.l, 5);
		//		}
	}
	Platform *lp = [self lowestPlatform];
	if (lp.l.y < 480 && lp.l.y >= baseHeight - 40){
		[self generatePlatformAt:500];
		Platform *p = (Platform *)[self.pl objectAtIndex:[self.pl count]-1];
		p.landed = 1;
		p.l = SXetX(p.l, 160);
		p.platform = 50;
		p.view.backgroundColor = [UIColor whiteColor];
		t.l = SYOffsetY(p.l, -turtleHeight);
		animstate = ANIMSTATE_CLOUD_RISE;	
		
	}
}

-(void)resetStartingPlatforms{	
	diffPlatformWidth = 200;
	p0.l = CGPointMake(160,350);
	p0.platform = 0;
	p0.view.backgroundColor = [UIColor blueColor];
	//	[self drawPlat:p0];
	
	diffPlatformWidth = 35;
	p1.l = CGPointMake(70,230);
	p1.platform = 1;
	p1.view.backgroundColor = [UIColor whiteColor];
	//	[self drawPlat:p1];
	
	climbTowerText.frame = CGRectMake(40,200,60,20);
	upgradeText.frame = CGRectMake(130,200,60,20);
	scoresText.frame = CGRectMake(230,200,60,20);
}	

-(void)dropFeather{
	Feather *feather = [[Feather alloc] init];
	//	int xl = arc4random() % 160;
	//	xl+= 30;
	//	int yl = arc4random() % 100;
	feather.l = CGPointMake(self.newestBird.l.x,self.newestBird.l.y);
	feather.view.center = feather.l;
	int featherSpeed = arc4random() % 3;
	feather.vel = CGPointMake(activeWind,featherSpeed+2);
	[self.obs addObject:feather];
	[self.view addSubview:feather.view];
	[feather release];
}

-(void)FeatherLoop{
	featherCountdown--;
	if (featherCountdown <= 0){
		featherCountdown = featherCountdownReset;
		///		for (int i = 0; i < 5; i++){
		[self dropFeather];
		//	}
	}
}

-(void)ScoreLabelLoop{
	if (showScoreTimer > 0){
		activeScoring.center = SYOffsetY(activeScoring.center, -1);
		//fastScoring.center = SYOffsetY(fastScoring.center, -1);
		showScoreTimer--;	
		if (showScoreTimer <= 0){
			activeScoring.center = CGPointMake(1000,300);
			//	fastScoring.center = CGPointMake(1000,300);
		}
	}
	
	if (fastScoreTimer > 0){
		if (t.state == TSP_TURTLE_STATE_PLATFORM){
			fastScoreTimer--;
		}
	}
}

-(void)SpawnerLoop{
	for (int i = 0; i < [self.spawners count]; i++){
		BirdSpawner *spawner = (BirdSpawner *)[self.spawners objectAtIndex:i];
		[spawner tick];	
		
		if (spawner.l.y > 500) {
			[self.spawners removeObjectAtIndex:i];	
		}
	}
	
}

-(void)removeOffscreenBirds{
	for (int i = 0; i < [self.birdRows count]; i++) {
		BirdRow *br = (BirdRow *)[self.birdRows objectAtIndex:i];
		if (br.bird1.l.y > 500){
			br.bird1.imageView.center = CGPointMake(500,800);
			br.bird2.imageView.center = CGPointMake(500,800);			
			br.bird1 = nil;
			br.bird2 = nil;
			[self.birdRows removeObjectAtIndex:i];
			return;
		}
	}
}

-(void)BirdRowLoop{
	for (int i = 0; i < [self.birdRows count]; i++) {
		BirdRow *br = (BirdRow *)[self.birdRows objectAtIndex:i];
		[br tick];
		if (GetDist(br.bird1.l, t.l) < 35) {
			if (t.l.y > br.bird1.l.y - 20 || t.state == TSA_TURTLE_STATE_AIR){
				[self killTurtle];
			}
		}
		if (br.bird1.kind == OBS_KIND_PATROL_BIRD){
			if (t.l.y > br.bird2.l.y - 20 || t.state == TSA_TURTLE_STATE_AIR){
				if (GetDist(br.bird2.l, t.l) < 35) {
					[self killTurtle];
				}
			}
		}
	}	
	
	[self removeOffscreenBirds];
}

-(void)TextLoop {
	if (gamestate == 60) {
		easyText.center = SYOffsetY(easyText.center, risingSpeed);
		mediumText.center = SYOffsetY(mediumText.center, risingSpeed);		
	}
}

-(void)loop{
	[super loop];
	[self ScoreLabelLoop];
	[self TurtleLoop];
	[self PlatformsLoop];
	[self ObstacleLoop];
	[self BirdRowLoop];
	[self TextLoop];
	//	[self SpawnerLoop];
	//	if (gamestate == 1){[self FeatherLoop];}	
}

-(void)hideIntroText{
	climbTowerText.center = CGPointMake(1000,0);
	upgradeText.center = CGPointMake(1000,0);
	scoresText.center = CGPointMake(1000,0);
	[climbTowerText release];
	[upgradeText release];
	[scoresText release];
}

-(void)populateGame{
	gamestate = 1;
	
	[self hideIntroText];
	
	[self generateFirstPlatform];
	[self positionTurtleAtFirstPlatform];
	
	for (int i = 0; i < 20; i++){
		[self generatePlatform];
	}
	
}

-(void)showMana{
	manaView.frame = CGRectMake(0,470,manaCharge,10);
	manaView.center = CGPointMake(160,470);
	if (manaCharge < 320){
		manaView.backgroundColor = [UIColor greenColor];	
	}else{
		manaView.backgroundColor = [UIColor yellowColor];
	}
}

-(void)swoopEnded {
	animscene = state_INTRO_BIRD_CARRY;	
}

-(void)moonTalkEnded {
	animscene = state_INTRO_BIRD_SWOOP;
	//generate swooping bird
}

-(void)setupBeginning{
	gamestate = 5; //5
//	gamestate = 6;
	animscene = state_INTRO_TURTLE_TALK;
	animstatetick = 60; //Talking about moon
	
	[self showBeginningPlatforms];
	[self showScore];
	manaCharge = 150;
	//	[self showMana];
	[self createIntroTexts];
	[self positionTurtleAtLowestPlatform];
	[self saveScoresToPhone];
	
	NSString *dataPath = [self gameFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
		NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:[self gameFilePath]];
		[self readScoresFromDictionary:d];
	}
}

-(void)setupDifficultyControllers{
	WindController *wc = [[WindController alloc] initWithTicks:0];
	[self.difficultyControllers addObject:wc];
	[wc release];
	
	self.birdController = [[BirdController alloc] init];
	self.birdController.delegate = self;
}

-(void)populateVision{
	[super populateVision];
	[self resetDifficulty];
	[self setupDifficultyControllers];
	[self setupBeginning];
}

-(void)turtleJump:(CGPoint)jumpAngle :(float)power{
	t.state = TSA_TURTLE_STATE_AIR;
	t.jumpLeft = t.jumpLeftReset;
}

-(void)turtleJump{
	t.state = TSA_TURTLE_STATE_AIR;
	t.jumpLeft = t.jumpLeftReset;	
	t.lastl = SYOffsetY(t.lastl, 10);
}

-(void)createIntroTexts{
	climbTowerText = [[[UIView alloc] initWithFrame:CGRectMake(40,200,60,20)] retain];
	climbTowerText.backgroundColor = [UIColor clearColor];
	
	UILabel *climbLabel = makelabelat(CGRectMake(30,0,60,20));
	climbLabel.text = @"CLIMB";
	[climbTowerText addSubview:climbLabel];
	[self.view addSubview:climbTowerText];
	
	upgradeText = [[[UIView alloc] initWithFrame:CGRectMake(130,200,60,20)] retain];
	upgradeText.backgroundColor = [UIColor clearColor];
	
	UILabel *upgradeLabel = makelabelat(CGRectMake(30,0,60,20));
	upgradeLabel.text = @"SHOP";
	upgradeLabel.textColor = [UIColor yellowColor];
	[upgradeText addSubview:upgradeLabel];
	[self.view addSubview:upgradeText];
	
	scoresText = [[[UIView alloc] initWithFrame:CGRectMake(230,200,60,20)] retain];;
	scoresText.backgroundColor = [UIColor clearColor];
	
	UILabel *scoresLabel = makelabelat(CGRectMake(20,0,80,20));
	scoresLabel.text = @"SCORES";
	scoresLabel.textColor = [UIColor greenColor];
	[scoresText addSubview:scoresLabel];
	[self.view addSubview:scoresText];
}

-(void)showMoonBar {
	ms.frame = CGRectMake(280,30,40,400);	
}

-(void)hideMoonScale {
	ms.frame = CGRectMake(1000, 1000, 40, 400);
}

-(void)setupViews{
	//	background = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,480)] retain];
	//	background.frame = CGRectMake(0,-35,320,480);
	//	background.alpha = 1;
	//	background.image = [UIImage imageNamed:@"subliminallycochlear3204601.png"];
	//	[self.view addSubview:background];
	
	t = [[Turtle alloc] init];
	[self.view addSubview:t.imageView];	
	
	t2 = [[Turtle alloc] init];
	[self.view addSubview:t.imageView];
	
	ms = [[MoonScale alloc] initWithFrame:CGRectMake(280,30,40,400)];
	[self.view addSubview:ms];
	[ms updateProgress:.38];
	[self hideMoonScale];
	
	
	levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10,200,20)];
	levelLabel.backgroundColor = [UIColor clearColor];
	levelLabel.textColor = [UIColor whiteColor];
	levelLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	levelLabel.textAlignment = UITextAlignmentLeft;
	levelLabel.text = @"Level: 1";
	[self.view addSubview:levelLabel];
	
	scoreLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0,425,160,20)] retain];
	scoreLabel.textAlignment = UITextAlignmentLeft;
	scoreLabel.backgroundColor = [UIColor clearColor];
	scoreLabel.textColor = [UIColor whiteColor];
	scoreLabel.font = [UIFont systemFontOfSize:12];
	[self.view addSubview:scoreLabel];
	
	birdLabel = [[[UILabel alloc] initWithFrame:CGRectMake(200,425,120,20)] retain];
	birdLabel.backgroundColor = [UIColor clearColor];
	birdLabel.textColor = [UIColor whiteColor];
	birdLabel.font = [UIFont systemFontOfSize:12];
	birdLabel.textAlignment = UITextAlignmentRight;
	[self.view addSubview:birdLabel];
	birdLabel.text = @"bird";
	
	turtleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(160,445,160,20)] retain];
	turtleLabel.backgroundColor = [UIColor clearColor];
	turtleLabel.textColor = [UIColor whiteColor];
	turtleLabel.font = [UIFont systemFontOfSize:12];
	turtleLabel.textAlignment = UITextAlignmentRight;
	[self.view addSubview:turtleLabel];
	turtleLabel.text = @"turtle";
	
	excellentLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0,445,160,20)] retain];
	excellentLabel.backgroundColor = [UIColor clearColor];
	excellentLabel.textColor = [UIColor whiteColor];
	excellentLabel.font = [UIFont systemFontOfSize:12];
	excellentLabel.textAlignment = UITextAlignmentLeft;
	[self.view addSubview:excellentLabel];
	excellentLabel.text = @"excellent";
	
	manaView = [[[UIView alloc] initWithFrame:CGRectMake(0,450,320,0)] retain];
	manaView.backgroundColor = [UIColor greenColor];
	[self.view addSubview:manaView];
	
	activeScoring = [[[UILabel alloc] initWithFrame:CGRectMake(0,0,scoreLabel.frame.size.width,scoreLabel.frame.size.height+5)] retain];
	activeScoring.font = [UIFont fontWithName:@"Helvetica" size:14];
	activeScoring.backgroundColor = [UIColor clearColor];
	activeScoring.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:activeScoring];
	
	activeScoring.center = CGPointMake(10000,5);
}

-(void)setupbackground{
	background = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,480)] retain];
	background.frame = CGRectMake(0,-35,320,480);
	background.alpha = 1;
	background.image = [UIImage imageNamed:@"subliminallycochlear3204601.png"];
	[self.view addSubview:background];
}	

- (void) applicationWillTerminate:(UIApplication*)application{
	[self saveScoresToPhone];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self saveScoresToPhone];
}

-(void)viewDidLoad{
	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(applicationWillTerminate:)
												 name:UIApplicationWillTerminateNotification 
											   object:app];
	[self generateTexts];
	self.easyText.center = CGPointMake(1000, 1000);
	self.mediumText.center = CGPointMake(1000, 1000);	
	scoreText = @"Start!";
	self.fileName = @"TurtleTower.plist";
	
	NSString *dataPath = [self gameFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
		NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:[self gameFilePath]];
		[self readScoresFromDictionary:d];
	}
	
	[super viewDidLoad];
}

-(void)setTurtleJumpAngle:(CGPoint)target{
	t.state = TSA_TURTLE_STATE_AIR;
	t.jumpLeft = t.jumpLeftReset;
	t.vel = GetAngle(t.l, target);
	t.vel = MultiplyVel(t.vel, t.jumpPower);
}

-(void)calculateTurtleJumpImpulse:(CGPoint)target{
	//	if (target.y > t.l.y - 60){
	//		target = SYetY(target, t.l.y-60);
	//	}
	
	[t setSquashState:TSC_GROW];
	
	if (target.x > t.l.x){
		self.birdController.tright = YES;
	}else{
		self.birdController.tright = NO;
	}
	
	float platformDifference = 500;
	for (Platform *p in self.pl){
		if (p.l.y < t.l.y){
			if (t.l.y - p.l.y < platformDifference){
				platformDifference = t.l.y - p.l.y;
			}
		}
	}
	
	if (target.y > t.l.y - platformDifference - 100){
		target = SYetY(target, t.l.y-platformDifference-100);	
	}
	
	float dist = GetDist(CGPointMake(target.x,t.l.y), target);
	if (dist > 300){dist = 300;}
	//	float middleX = (target.x+t.l.x)/2;
	target = CGPointMake(target.x,target.y-(fabsf(target.y-t.l.y)));
	dist = dist / 7;
	t.vel = GetAngle(t.l, target);
	t.vel = MultiplyVel(t.vel, dist);
	t.state = TSA_TURTLE_STATE_AIR;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
	
	if (gamestate == 20) {
		gamestate = 21;
		t.vel = CGPointMake(0, 8);
		t.l = CGPointMake(t.l.x,t.l.y+20);
		t.state = TSA_TURTLE_STATE_AIR;
		[self setHighPlatformSpeed:8];
		//		[self setLowPlatformSpeed:-2];
		return;
	}
	
	if (gamestate == 60 && t.state == TSP_TURTLE_STATE_PLATFORM && difficultySelectedStatus == -1){
		float dist = 80;
		float hdist = -110;
		if (difficultyLevel == 0 && gestureStartPoint.x <= 120){
			[self calculateTurtleJumpImpulse:CGPointMake(t.l.x - dist,t.l.y+hdist)];
		}
		if (difficultyLevel == 1 && gestureStartPoint.x > 120 && gestureStartPoint.x < 200) {
			[self calculateTurtleJumpImpulse:CGPointMake(t.l.x + dist,t.l.y+hdist)];		
		}
		
		if (difficultyLevel == 0 && gestureStartPoint.x > t.l.x - 40 && gestureStartPoint.x < t.l.x + 40 && gestureStartPoint.y > t.l.x - 60 && gestureStartPoint.y < t.l.y + 100){
			[self difficultyCloudSelected:0];	
		}
	}	else {
		if (jumpScheme == 0){
			if (t.state == TSP_TURTLE_STATE_PLATFORM){
				if (gestureStartPoint.y < t.l.y){
					[self turtleJump];
				}
			}
		}else if (jumpScheme == 1){
			if (t.state == TSP_TURTLE_STATE_PLATFORM){
				if (gestureStartPoint.y < t.l.y){			
					[self setTurtleJumpAngle:gestureStartPoint];	
				}
			}
		}else if (jumpScheme == 5){
			if (t.state == TSA_TURTLE_STATE_AIR){
				t.jumpLeft = 1;
			}
			if (t.state == TSP_TURTLE_STATE_PLATFORM){
				jumpState = 1;	
			}
		}else if (jumpScheme == 6) {
			if (t.state == TSA_TURTLE_STATE_AIR && t.jumpLeft> 0){
				t.jumpLeft = 1;
			}else{		
				t.jumpLeft = t.jumpLeftReset;
				t.vel = GetAngle(t.l, gestureStartPoint);
				t.vel = MultiplyVel(t.vel, t.jumpPower);
				t.state = TSA_TURTLE_STATE_AIR;
			}
		}else if (jumpScheme == 7){
			if (t.state == TSP_TURTLE_STATE_PLATFORM){
				if (gamestate == 1 || gamestate == 5){
					if (gestureStartPoint.y < t.l.y - 10) {
						[self calculateTurtleJumpImpulse:gestureStartPoint];	
						t.walking = 0;
					} else if (gestureStartPoint.y >= t.l.y){
						
						if (gestureStartPoint.x > t.l.x) {
							t.walking= 1;
						} else {
							t.walking = -1;	
						}					
					}
				}
			}else{
				if (gamestate != 60) {
					t.vel = SYOffsetY(t.vel, 5);	
				}
			}
		}
	}
}

-(void)AimWing0: (UIView *)ww :(CGPoint)pt{
	tangle2 = GetAngle(ww.center, pt);
	tangle = CGPointMake(tangle2.x,tangle2.y);
	ftangle = atan2( tangle2.y, tangle2.x );	
	ww.transform = CGAffineTransformMakeRotation(ftangle + 1.57);
	//	ww.transform = CGAffineTransformConcat( CGAffineTransformMakeScale(4, 4), CGAffineTransformMakeRotation(ftangle + 1.57));		
}

-(void)turtleJumps{
	currentPosition = CGPointMake(currentPosition.x,currentPosition.y-70);
	CGPoint angle = GetAngle(gestureStartPoint, currentPosition);
	
	distvar2 = GetDist(gestureStartPoint, CGPointMake(currentPosition.x,currentPosition.y+70));
	distvar2+= 15;
	if (distvar2 < 35){
		distvar2 = 35;
	}
	if (distvar2 > 160){
		distvar2 = 160;
	}
	
	distvar2 = distvar2 / 13;
	
	angle = MultiplyVel(angle, t.jumpPower);
	
	t.vel = angle;
	t.jumpLeft = fabsf(distvar2);
	t.state = TSA_TURTLE_STATE_AIR;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesMoved:touches withEvent:event];
	if (jumpScheme == 0){
		if (t.state == TSJ_TURTLE_AIMING_JUMP){
			if (GetDist(currentPosition, turtleJumpStart) > maxJumpAimDistance){
				[self turtleJump: GetAngle(turtleJumpStart, currentPosition) : GetDist(currentPosition, turtleJumpStart) / maxJumpAimDistance ];
			}
		}
	}
	if (jumpScheme == 5 && t.state == TSP_TURTLE_STATE_PLATFORM){
		if (GetDist(gestureStartPoint, currentPosition) > 160 && currentPosition.y < t.l.y){
			[self turtleJumps];	
		}
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesEnded:touches withEvent:event];
	//		[self turtleJump: GetAngle(turtleJumpStart, currentPosition) : GetDist(currentPosition, turtleJumpStart) / maxJumpAimDistance ];
	UITouch *touch = [touches anyObject];
	currentPosition = [touch locationInView:self.view];
	
	turtleWalking = 0;
	
	if (jumpScheme == 5 && t.state == TSP_TURTLE_STATE_PLATFORM && currentPosition.y < t.l.y){
		[self turtleJumps];	
	}
	
	if (t.state == TSP_TURTLE_STATE_PLATFORM) {
		t.walking = 0;	
	}
	
	currentPosition = CGPointMake(160,-3000);
}

-(void)readScoresFromDictionary:(NSDictionary *)d{
	highscore = [[d objectForKey:@"highscore"] intValue];
	mostExcellent = [[d objectForKey:@"mostexcellent"] intValue];
	turtleSoups = [[d objectForKey:@"turtlesoups"] intValue];
	birdsDodged = [[d objectForKey:@"birdsdodged"] intValue];
	NSLog(@"score: %d mostExcellent: %d, turtleSoups: %d, birdsDodged: %d",highscore,mostExcellent,
		  turtleSoups,birdsDodged);
	
}


-(void)saveScoresToPhone{
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSString stringWithFormat:@"%d",highscore], @"highscore",
						  [NSString stringWithFormat:@"%d",mostExcellent], @"mostexcellent",
						  [NSString stringWithFormat:@"%d",turtleSoups], @"turtlesoups",
						  [NSString stringWithFormat:@"%d",birdsDodged], @"birdsdodged",
						  nil];
	[data writeToFile:[self gameFilePath] atomically:YES];
	
}

-(void)calculateFastScoring{
	if (fastScoreTimer > 0){
		fastScoring.center = CGPointMake(t.l.x,t.l.y+16);	
		fastScoring.textColor = scoreLabel.textColor;
		fastScoring.text = [NSString stringWithFormat:@"Fast +%d",fastScoreTimer];
		score+= fastScoreTimer;
	}
}

-(void)updateScoreText{
	if (lastScore <= 20){
		self.scoreText = @"Barely!";
	}
	if (lastScore >20 && lastScore <= 40){
		self.scoreText = @"OK";
	}
	if (lastScore > 40 && lastScore <= 60){
		self.scoreText = @"Decent";
	}
	if (lastScore > 60 && lastScore <= 80){
		self.scoreText = @"Good";
	}
	if (lastScore > 80 && lastScore <= 95){
		self.scoreText = @"Fantastic";
	}
	if (lastScore > 95){
		self.scoreText = @"Excellent!";
		if (lastScore == 100){
			self.scoreText = @"Perfect!";
		}
		consecutiveExcellent++;
		if (consecutiveExcellent > cMostExcellent){
			cMostExcellent = consecutiveExcellent;
		}
		
		if (consecutiveExcellent > mostExcellent){
			mostExcellent = consecutiveExcellent;
		}
	}else{
		consecutiveExcellent = 0;	
	}
	difficultyScore+= lastScore;
	difficultyTickScore+= lastScore;
	
	showScoreTimer = 50;
	activeScoring.center = CGPointMake(t.l.x,t.l.y);
	if (t.l.x < 80){
		activeScoring.center = SXetX(activeScoring.center, 80);
	}
	if (t.l.x > 320-80){
		activeScoring.center = SXetX(activeScoring.center, 320-80);
	}
	scoreLabel.text = [NSString stringWithFormat:@"Score: %d",score];
}	

-(void)generatePlatformsCount:(int)newPlatforms{
	for (int i = [self.pl count]; i < newPlatforms; i++) {
		[self generatePlatform];				
	}
}

-(void)setTurtleOnPlatform:(Platform *)p{
	t.state = TSP_TURTLE_STATE_PLATFORM;
	t.vel = CGPointZero;
	t.lastl = t.l;
	float turtleX = t.l.x;
	t.l = SYOffsetY(p.l, -(turtleHeight+p.height));
	t.l = SXetX(t.l, turtleX);
}

-(void)colourPlatformsForHeight {
	for (Platform *p in self.pl) {
		if (p.landed == 0 && p.l.y < t.l.y){
			if (p.l.y > t.l.y - 200) {	
				float colour = 110.0/255.0;
				p.view.backgroundColor = [UIColor colorWithRed:colour green:colour blue:colour alpha:1]; //[UIColor lightGrayColor];
				p.secondView.backgroundColor = [UIColor colorWithRed:colour green:colour blue:colour alpha:1];// [UIColor lightGrayColor];			
			}
		}
	}
}

-(void)landedOnPlat:(Platform *)p firstPlatform:(BOOL)firstPlat{
	[t setSquashState:TSC_SQUASH];
	if (gamestate == 1 && p.landed == 0){
		
		if (firstPlat == YES){
			t.leftedge = p.view.frame.origin.x + t.width+12;
			t.rightedge = p.view.frame.origin.x+p.view.frame.size.width-t.width-9;
		} else {
			t.leftedge = p.secondView.frame.origin.x;
			t.rightedge = p.secondView.frame.origin.x+p.secondView.frame.size.width;
		}
		
		
		[self colourPlatformsForHeight];
		
		self.birdController.highestPlatformY = ((Platform *)[self highestPlatform]).l.y-35;
		[self.birdController tick];
		
		
		int landingAccuracy = 100;
		
		if (firstPlat){
			if (fabsf(t.l.x-p.l.x) > 0){
				landingAccuracy = fabsf(((t.l.x-p.l.x) / p.width)*100);
				landingAccuracy = 100-landingAccuracy;
			}
		}else{
			if (fabsf(t.l.x-p.secondView.center.x) > 0){
				landingAccuracy = fabsf(((t.l.x-p.secondView.center.x) / p.width)*100);
				landingAccuracy = 100-landingAccuracy;
			}	
		}
		
		[self setTurtleOnPlatform:p];
		
		lastScore = landingAccuracy;
		[self colorPlatform:p withScore:landingAccuracy];		
		score+= landingAccuracy;	
		
		fastScoreTimer = fastScoreTimerReset;
		
		[self updateScoreText];		
		if (landingAccuracy > 95){
			score+= landingAccuracy * consecutiveExcellent;
			lastScore = landingAccuracy * consecutiveExcellent;
		}
		
		[self showScore];	
		
		if (p.landed == 0){
			[self generatePlatform];
			p.landed = 1;	
		}
		
		if ([self.pl count] < 10){
			[self generatePlatformsCount:10];
		}
		[self calculateDifficulty];
	}	
}

-(void)climbCloudLanded{
	//Update display
	gamestate = 20;
	t.state = 20;
	t.vel = CGPointMake(0,-5);
}

-(void)eraseActiveClouds{
	for (int i = 0; i < [self.pl count]; i++) {
		Platform *p = (Platform *)[self.pl objectAtIndex:i];
		p.vel = CGPointZero;
		p.view.center = CGPointMake(1000, 10000);
		//		p.secondView.center = CGPointMake(1000, 10000);
		p.imageView.center = CGPointMake(1000,10000);
	}	
	for (int i = 0; i < [self.pl count]; i++) {	
		Platform *p = (Platform *)[self.pl objectAtIndex:i];
		if (p.l.x < 1000){
			p.view.center = CGPointMake(1000, 0);
			//p.secondView.center =CGPointMake(1000, 0);
			p.imageView.center = CGPointMake(-1000,0);
			[self.pl removeObjectAtIndex:i];
		}
	}
	
	t.platform = 0;
}

-(void)eraseAllClouds{
	for (int i = 0; i < [self.pl count]; i++) {
		Platform *p = (Platform *)[self.pl objectAtIndex:i];
		p.vel = CGPointZero;
		p.l = CGPointMake(1600, 10000+i);
		p.view.center = CGPointMake(160,10000+i);
		p.secondView.center =CGPointMake(160,10000+i);
		p.imageView.center = CGPointMake(1000,10000);
		p.imageView.center = CGPointMake(-1000,0);
	}
	
	int eraseTotal = [self.pl count];
	for (int i = 0; i < eraseTotal; i++) {
		[self.pl removeObjectAtIndex:0];
	}
	
	t.platform = 0;
}


-(void)drawClouds{
	//Erase our active (<-1000) clouds
	[self eraseAllClouds];
	[self generatePlatformAt:-100];
	//Generate 15 platforms
	[self generatePlatformsCount:15];
	self.easyText.center = CGPointMake(1000, 1000);
	self.mediumText.center = CGPointMake(1000, 1000);	
	gamestate = 30;
	
	for (int i = 0; i < [self.pl count]; i++){
		Platform *p = (Platform *)[self.pl objectAtIndex:i];
		p.vel = CGPointMake(0,5);	
		
	}
}	

-(void)finishedDifficultyCloudRise {
	[self drawClouds];	
	[self colourPlatformsForHeight];
}


-(void)generateTexts {
	self.easyText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,30)];
	self.easyText.backgroundColor = [UIColor clearColor];
	self.easyText.textColor = [UIColor whiteColor];
	self.easyText.text = @"Easy";
	self.easyText.textAlignment = UITextAlignmentCenter;
	
	[self.view addSubview:self.easyText];
	
	self.mediumText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,30)];
	self.mediumText.backgroundColor = [UIColor clearColor];
	self.mediumText.textColor = [UIColor whiteColor];
	self.mediumText.text = @"Medium";
	self.mediumText.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:self.mediumText];
	
	self.trainingText = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 320, 26)];
	self.trainingText.backgroundColor = [UIColor clearColor];
	self.trainingText.textColor = [UIColor whiteColor];
	self.trainingText.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:self.trainingText];
	
}	


-(void)finishedCloudRise{
	[self resetDifficulty];	
	[self eraseAllClouds];	
	
	gamestate = 60;
	t.state = TSP_TURTLE_STATE_PLATFORM;
	t.l = SXetX(t.l, 160);
	EasyCloud *ec = [[EasyCloud alloc] init];
	ec.delegate = self;
	[self drawPlat:ec];
	ec.l = CGPointMake(160,480);
	risingSpeed = -3;
	ec.vel = CGPointMake(0,risingSpeed);
	[self setTurtleOnPlatform:ec];
	
	self.easyText.center = CGPointMake(ec.l.x, ec.l.y + 40);
	[ec release];
	
	
	MediumCloud *mc = [[MediumCloud alloc] init];
	mc.delegate = self;
	[self drawPlat:mc];	
	mc.l = CGPointMake(60,481);
	mc.vel = CGPointMake(0,risingSpeed);
	self.mediumText.center = CGPointMake(mc.l.x, mc.l.y + 40);
	[mc release];
}


-(void)finishedFloat{
	gamestate = 1;
	[self showMoonBar];
	[self showScore];
	[self showLevelLabel];
	scoreLabel.text = @"Start!";
	Platform *p = [self lowestPlatform];
	p.vel = CGPointZero;
	self.trainingText.center = CGPointMake(t.l.x, t.l.y-50);
	self.trainingText.text = @"Moon Turtle waits for you!";
}

-(void)finishedSlideDown{
	t.state = TSP_TURTLE_STATE_PLATFORM;
	[self generatePlatformAt:490];
	Platform *p = [self lowestPlatform];
	p.vel = CGPointMake(0,-1);
	p.l = SXetX(p.l, 160);
	p.view.backgroundColor = [UIColor whiteColor];
	[self centerTurtleAtPlatform:p];	
	p.landed = 1;
	gamestate = 40;
}


#pragma mark WindDelegate
-(void)activeWindExpired{
}
-(void)inactiveWindExpired{
}

-(void)activateBirdRow:(BirdRow *)br{
	[self.view addSubview:br.bird1.imageView];
	
	br.bird1.turtleloc = t.l;
	if (br.bird1.kind == OBS_KIND_PATROL_BIRD) {
		br.bird1.t = t;		
		br.bird2.t = t;
		[self.view addSubview:br.bird2.imageView];	
	}
	
	if (br.bird1.kind == OBS_KIND_CAMP_BIRD) {
		CampBird *bird = (CampBird *)br.bird1;
		bird.t = t;
	}
	
	[self.birdRows addObject:br];	
}

-(void)didReceiveBirdForSpawner:(Bird *)bird{
	//	BirdSpawner *spawner = [[BirdSpawner alloc] initWithBird:bird];
	//	spawner.delegate = self;
	//	[self.spawners addObject:spawner];
	//	[spawner release];	
	if (bird.kind == OBS_KIND_PATROL_BIRD) {
		PatrolBirdRow *br = [[PatrolBirdRow alloc] initWithBird:bird];
		[self activateBirdRow:br];
	} else if (bird.kind == OBS_KIND_CAMP_BIRD) {
		CampBirdRow *br = [[CampBirdRow alloc] initWithBird:bird];
		br.bird1.target = t.l;
		br.bird2.target = t.l;	
		[self activateBirdRow:br];
	} else if (bird.kind == OBS_KIND_DIVEBOMB_BIRD) {
		DivebombBirdRow *br = [[DivebombBirdRow alloc] initWithBird:bird];
		[self activateBirdRow:br];
	}
}


-(void)didReceiveBird:(Bird *)bird{
	[self.obs addObject:bird];
	[self.view addSubview:bird.imageView];	
}

-(void)didReceiveSpawnerBird:(Bird *)bird{
	[self.obs addObject:bird];
	[self.view addSubview:bird.imageView];
}

-(void)setPlatformSpeed:(float)speed{
	for (Platform *p in self.pl) {
		p.vel = CGPointMake(0,speed);	
	}
}

-(void)setHighPlatformSpeed:(float)speed {
	for (Platform *p in self.pl) {
		if (p.l.y < 230) {
			p.vel = CGPointMake(0,speed);	
		}
	}	
}


-(void)setLowPlatformSpeed:(float)speed {
	for (Platform *p in self.pl) {
		if (p.l.y > 230) {
			p.vel = CGPointMake(0,speed);	
		}
	}	
}

-(void)difficultyCloudSelected:(int)diff {
	if (difficultySelectedStatus == -1) {
		difficultySelectedStatus = 0;
		difficultyLevel = diff;
		[self setDifficulties];
		risingSpeed = -12;
		
		[self setPlatformSpeed:risingSpeed];
		
		difficultySelectedStatus = 1;	
	}
}


@end	