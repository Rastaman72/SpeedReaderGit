//
//  GimnastykaOczuOkragViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/1/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GimnastykaOczuOkragViewController.h"
#define P(x,y) CGPointMake(x, y)
@interface GimnastykaOczuOkragViewController ()

@end

@implementation GimnastykaOczuOkragViewController

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
    self.beginPoint=300;
    self.firstControlPoint=300;
    self.secondControlPoint=600;
     [self createFrame];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
}


-(void)checkOrientataion
{
    [self deviceOrientationDidChange:nil];
}


- (void)deviceOrientationDidChange:(NSNotification *)notification {
    //Obtain current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(orientation==UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight)
    {
        if(!self.changePosition)
        {
            
            self.beginPoint-=100;
            self.firstControlPoint-=100;
            self.secondControlPoint-=200;
            CGRect toChangetStartButton= self.changeDirectionButton.frame;
            toChangetStartButton.origin.y-=225;
            [self.changeDirectionButton setFrame:toChangetStartButton];
            
                [self directionChanged:self];  
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            self.beginPoint+=100;
            self.firstControlPoint+=100;
            self.secondControlPoint+=200;
            CGRect toChangetStartButton= self.changeDirectionButton.frame;
            toChangetStartButton.origin.y+=225;
            [self.changeDirectionButton setFrame:toChangetStartButton];
            [self directionChanged:self];
            self.changePosition=NO;
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createFrame
{
    UIBezierPath *trackPath;
    trackPath = [self createPathForPoint];
    
	CAShapeLayer *racetrack = [CAShapeLayer layer];
	racetrack.path = trackPath.CGPath;
	racetrack.strokeColor = [UIColor grayColor].CGColor;
	racetrack.fillColor = [UIColor clearColor].CGColor;
	racetrack.lineWidth = 5.0;
    [racetrack setOpacity:0.5];
   	
    [self.view.layer insertSublayer:racetrack atIndex:0];
    
    
    
    CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	//car.position = P(self.exercisesNineText.frame.size.width/2, self.exercisesNineText.frame.size.height/2);
	car.contents = (id)([UIImage imageNamed:@"image0.jpg"].CGImage);
	
    
    [self.view.layer insertSublayer:car atIndex:1];
    
	
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	anim.path = trackPath.CGPath;
    if (self.direction) {
        anim.rotationMode = kCAAnimationRotateAuto;
        
    }
    else
        anim.rotationMode = kCAAnimationRotateAutoReverse;
    
    anim.repeatCount = HUGE_VALF;
	anim.duration = 5.0;
	[car addAnimation:anim forKey:@"race"];
}

- (UIBezierPath *)createPathForPoint
{
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    int choose=self.direction;
    switch ( choose ) {
        case 0:
            [trackPath moveToPoint:P(0, self.beginPoint)];
            [trackPath addCurveToPoint:P(self.view.frame.size.width, self.firstControlPoint)
                         controlPoint1:P(0, 0)
                         controlPoint2:P(self.view.frame.size.width, 0)];
            [trackPath addCurveToPoint:P(0, self.beginPoint)
                         controlPoint1:P(self.view.frame.size.width, self.secondControlPoint)
                         controlPoint2:P(0, self.secondControlPoint)];
            break;
        case 1:
            [trackPath moveToPoint:P(self.view.frame.size.width, self.beginPoint)];
            [trackPath addCurveToPoint:P(0, self.beginPoint)
                         controlPoint1:P(self.view.frame.size.width, 0)
                         controlPoint2:P(0, 0)];
            [trackPath addCurveToPoint:P(self.view.frame.size.width, self.firstControlPoint)
                         controlPoint1:P(0, self.secondControlPoint)
                         controlPoint2:P(self.view.frame.size.width, self.secondControlPoint)];
            
            break;
        default:
            break;
    }
    
    return trackPath;
}


- (IBAction)directionChanged:(id)sender {
    self.direction=!self.direction;
    
    [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];
    [[self.view.layer.sublayers objectAtIndex:0]removeAllAnimations];
    
    [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];
    [self createFrame];
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
