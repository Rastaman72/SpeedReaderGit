//
//  GimnastykaOczuWazViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GimnastykaOczuWazViewController.h"
#define P(x,y) CGPointMake(x, y)

@interface GimnastykaOczuWazViewController ()

@end

@implementation GimnastykaOczuWazViewController

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
           
            CGRect toChangeGameView =self.gameView.frame;
            toChangeGameView.origin.y-=60;
            toChangeGameView.size.height-=200;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeChangeDirectionButton=self.changeDirectionButton.frame;
            toChangeChangeDirectionButton.origin.y-=225;
            [self.changeDirectionButton setFrame:toChangeChangeDirectionButton];
             [self directionChanged:self];
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            
            CGRect toChangeGameView =self.gameView.frame;
            toChangeGameView.origin.y+=60;
            toChangeGameView.size.height+=200;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeChangeDirectionButton=self.changeDirectionButton.frame;
            toChangeChangeDirectionButton.origin.y+=225;
            [self.changeDirectionButton setFrame:toChangeChangeDirectionButton];
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
   	
    [self.gameView.layer insertSublayer:racetrack atIndex:0];
    
    
    
    CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	//car.position = P(self.exercisesNineText.frame.size.width/2, self.exercisesNineText.frame.size.height/2);
	car.contents = (id)([UIImage imageNamed:@"image0.jpg"].CGImage);
	
    
    [self.gameView.layer insertSublayer:car atIndex:1];
    
	
    
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
    int x=30;
    int y=self.gameView.frame.size.height/4;
    int offset=100;
    int offsetX=100;
    int j=0;
    switch ( choose ) {
        case 0:
            [trackPath moveToPoint:P(x, self.gameView.frame.size.height/4)];
           
            for (int i=1; i<=14; i++) {
                if (i<=7) {
                    
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    x+=offsetX;
                    [trackPath addCurveToPoint:P(x,self.gameView.frame.size.height/4)
                                 controlPoint1:P(x-offsetX,y+j*offset)
                                 controlPoint2:P(x,y+j*offset)];
                }
                
                else{
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    x-=offsetX;
                    [trackPath addCurveToPoint:P(x,self.gameView.frame.size.height/4)
                                 controlPoint1:P(x+offsetX,y+j*offset)
                                 controlPoint2:P(x,y+j*offset)];
                }
                
            }
            break;
        case 1:
            x+=7*offsetX;
            [trackPath moveToPoint:P(x, self.gameView.frame.size.height/4)];
            
            for (int i=1; i<=14; i++) {
                if (i<=7) {
                    
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    x-=offsetX;
                    [trackPath addCurveToPoint:P(x,self.gameView.frame.size.height/4)
                                 controlPoint1:P(x+offsetX,y+j*offset)
                                 controlPoint2:P(x,y+j*offset)];
                }
                
               else{
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    x+=offsetX;
                    [trackPath addCurveToPoint:P(x,self.gameView.frame.size.height/4)
                                 controlPoint1:P(x-offsetX,y+j*offset)
                                 controlPoint2:P(x,y+j*offset)];
                    
                    
                }
                
            }
            break;
        default:
            break;
    }
    
    return trackPath;
}


- (IBAction)directionChanged:(id)sender {
    self.direction=!self.direction;
    
    [self.gameView.layer replaceSublayer:[self.gameView.layer.sublayers objectAtIndex:0] with:nil];
    [[self.gameView.layer.sublayers objectAtIndex:0]removeAllAnimations];
    
    [self.gameView.layer replaceSublayer:[self.gameView.layer.sublayers objectAtIndex:0] with:nil];
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
