//
//  GimnastykaOczu8IViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/1/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GimnastykaOczu8IViewController.h"
#define P(x,y) CGPointMake(x, y)
@interface GimnastykaOczu8IViewController ()

@end

@implementation GimnastykaOczu8IViewController

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
    self.firstControlPoint=-100;
    self.secondControlPoint=700;
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
            self.secondControlPoint-=100;
            [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];
            [[self.view.layer.sublayers objectAtIndex:0]removeAllAnimations];
            
            [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];

            [self createFrame];
            
            CGRect toChangeDirectionButton= self.changeDirectionButton.frame;
            toChangeDirectionButton.origin.y-=225;
            [self.changeDirectionButton setFrame:toChangeDirectionButton];
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
             self.beginPoint+=100;
            self.firstControlPoint+=100;
            self.secondControlPoint+=100;
            [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];
            [[self.view.layer.sublayers objectAtIndex:0]removeAllAnimations];
            
            [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];

          [self createFrame];
            CGRect toChangeDirectionButton= self.changeDirectionButton.frame;
            toChangeDirectionButton.origin.y+=225;
            [self.changeDirectionButton setFrame:toChangeDirectionButton];

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
            [trackPath addCurveToPoint:P(self.view.frame.size.width, self.beginPoint)
                         controlPoint1:P(self.view.frame.size.width*0.1, self.firstControlPoint)
                         controlPoint2:P(self.view.frame.size.width*0.9, self.secondControlPoint)];
            [trackPath addCurveToPoint:P(0, self.beginPoint)
                         controlPoint1:P(self.view.frame.size.width*0.9, self.firstControlPoint)
                         controlPoint2:P(self.view.frame.size.width*0.1, self.secondControlPoint)];
            break;
        case 1:
            [trackPath moveToPoint:P(self.view.frame.size.width, self.beginPoint)];
            [trackPath addCurveToPoint:P(0, self.beginPoint)
                         controlPoint1:P(self.view.frame.size.width*0.9, self.secondControlPoint)
                         controlPoint2:P(self.view.frame.size.width*0.1, self.firstControlPoint)];
            [trackPath addCurveToPoint:P(self.view.frame.size.width, self.beginPoint)
                         controlPoint1:P(self.view.frame.size.width*0.1, self.secondControlPoint)
                         controlPoint2:P(self.view.frame.size.width*0.9, self.firstControlPoint)];
           
            break;
                default:
            break;
    }
    
    return trackPath;
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

- (IBAction)directionChanged:(id)sender {
    self.direction=!self.direction;

    [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];
        [[self.view.layer.sublayers objectAtIndex:0]removeAllAnimations];
    
    [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:0] with:nil];
    [self createFrame];
}
@end
