//
//  ExercisesNineViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesNineViewController.h"
#define degreesToRadians(x) (M_PI * x / 180.0)
#define P(x,y) CGPointMake(x, y)
@interface ExercisesNineViewController ()

@end

@implementation ExercisesNineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createFrame];

    
    self.xmlManager=[self theAppDataObject];
    [self.xmlManager getExercisesText];
    self.exercisesNineText.text=self.xmlManager.exercisesText;
    [self.exercisesNineText.layer insertSublayer:self.readFrame atIndex:0];

    UIBezierPath *trackPath = [UIBezierPath bezierPath];
	[trackPath moveToPoint:P(0, self.exercisesNineText.frame.size.height/2)];
	[trackPath addCurveToPoint:P(self.exercisesNineText.frame.size.width, self.exercisesNineText.frame.size.height/2)
				 controlPoint1:P(50, 0)
				 controlPoint2:P(700, 800)];
	[trackPath addCurveToPoint:P(0, self.exercisesNineText.frame.size.height/2)
				 controlPoint1:P(700, 0)
				 controlPoint2:P(50, 800)];
//	[trackPath addCurveToPoint:P(140, 300)
//				 controlPoint1:P(0, 300)
//				 controlPoint2:P(200, 220)];
//	[trackPath addCurveToPoint:P(210, 200)
//				 controlPoint1:P(30, 420)
//				 controlPoint2:P(280, 300)];
//	[trackPath addCurveToPoint:P(70, 110)
//				 controlPoint1:P(110, 80)
//				 controlPoint2:P(110, 80)];
//	[trackPath addCurveToPoint:P(160, 25)
//				 controlPoint1:P(0, 160)
//				 controlPoint2:P(0, 40)];
	
	CAShapeLayer *racetrack = [CAShapeLayer layer];
	racetrack.path = trackPath.CGPath;
	racetrack.strokeColor = [UIColor grayColor].CGColor;
	racetrack.fillColor = [UIColor clearColor].CGColor;
	racetrack.lineWidth = 10.0;
    [racetrack setOpacity:0.5];
	[self.view.layer addSublayer:racetrack];
    
    CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	//car.position = P(self.exercisesNineText.frame.size.width/2, self.exercisesNineText.frame.size.height/2);
	car.contents = (id)([UIImage imageNamed:@"image0.jpg"].CGImage);
	[self.view.layer addSublayer:car];
	
	CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	anim.path = trackPath.CGPath;
	anim.rotationMode = kCAAnimationRotateAuto;
	anim.repeatCount = HUGE_VALF;
	anim.duration = 10.0;
	[car addAnimation:anim forKey:@"race"];
    
    // Do any additional setup after loading the view.
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)createFrame
{
    CGRect Rect = CGRectMake(0, 0, 10, 10);
    
    
    self.readFrame = [CALayer layer];
    [self.readFrame setFrame:Rect];
    [self.readFrame setBounds:Rect];
    
    [self.readFrame setCornerRadius:5.0f];
    [self.readFrame setBackgroundColor:[[UIColor blueColor]CGColor]];
    [self.readFrame setOpacity:0.2f];
    [self.readFrame setBorderColor:[[UIColor blackColor]CGColor]];
    [self.readFrame setBorderWidth:3.0f];
    [self.readFrame setShadowColor:[[UIColor blackColor]CGColor]];
    
    
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
