//
//  GimnastykaOczuPilaViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/1/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GimnastykaOczuPilaViewController.h"
#define P(x,y) CGPointMake(x, y)
@interface GimnastykaOczuPilaViewController ()

@end

@implementation GimnastykaOczuPilaViewController

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
    self.beginPoint=350;
    self.firstControlPoint=300;
    self.secondControlPoint=400;
    self.stepInside=100;
    self.stepY=200;
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
           
            CGRect toChangeframeSpeedView= self.changeDirectionButton.frame;
            toChangeframeSpeedView.origin.y-=225;
            [self.changeDirectionButton setFrame:toChangeframeSpeedView];
            
            
            CGRect toChangeGameView =self.gameView.frame;
            toChangeGameView.origin.y-=50;
                toChangeGameView.size.height-=100;
            [self.gameView setFrame:toChangeGameView];
            
            self.beginPoint-=100;
            self.firstControlPoint-=80;
            self.secondControlPoint-=120;
            self.stepInside-=30;
            self.stepY-=50;
            
            [self directionChanged:self];
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeframeSpeedView= self.changeDirectionButton.frame;
            toChangeframeSpeedView.origin.y+=225;
            [self.changeDirectionButton setFrame:toChangeframeSpeedView];
            
            
            CGRect toChangeGameView =self.gameView.frame;
            toChangeGameView.origin.y+=50;
            toChangeGameView.size.height+=100;
            [self.gameView setFrame:toChangeGameView];

            self.beginPoint+=100;
            self.firstControlPoint+=80;
            self.secondControlPoint+=120;
            self.stepInside+=30;
            self.stepY+=50;
            

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
    int x=50;
    int y=self.stepY;
    int offset=50;
    int j=0;
    switch ( choose ) {
        case 0:
            [trackPath moveToPoint:P(x, self.beginPoint)];
            [trackPath addLineToPoint:P(x,self.firstControlPoint)];
            
            for (int i=1; i<=30; i++) {
                if (i<=14) {
                    
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    x+=offset;
                    [trackPath addLineToPoint:P(x,y+j*self.stepInside)];
                    
                } else if(i==15){
                    [trackPath addLineToPoint:P(x,self.secondControlPoint)];
                    
                }
                else if(i==30)
                {
                    [trackPath addLineToPoint:P(x,self.beginPoint)];
                    
                }
                else {
                    x-=offset;
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    [trackPath addLineToPoint:P(x,y+ self.firstControlPoint+j*self.stepInside)];
                    
                }
                
            }
            break;
        case 1:
            x+=14*offset;
            [trackPath moveToPoint:P(x, self.beginPoint)];
            [trackPath addLineToPoint:P(x,self.firstControlPoint)];
            
            for (int i=1; i<=30; i++) {
                if (i<=14) {
                    
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    x-=offset;
                    [trackPath addLineToPoint:P(x,y+j*self.stepInside)];
                    
                } else if(i==15){
                    [trackPath addLineToPoint:P(x,self.secondControlPoint)];
                    
                }
                else if(i==30)
                {
                   
                    [trackPath addLineToPoint:P(x,self.beginPoint)];
                 
                }
                else {
                    x+=offset;
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    [trackPath addLineToPoint:P(x,y+ self.firstControlPoint+j*self.stepInside)];
                    
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
