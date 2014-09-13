//
//  GimnastykaOczuZygzakViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GimnastykaOczuZygzakViewController.h"
#define P(x,y) CGPointMake(x, y)
@interface GimnastykaOczuZygzakViewController ()

@end

@implementation GimnastykaOczuZygzakViewController

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
    self.beginPosition=612;
    self.endPosition=10;
    self.offsetX=200;
    self.offsetY=50;

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
            toChangeGameView.origin.y-=10;
            toChangeGameView.size.height-=200;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeChangeDirectionButton=self.changeDirectionButton.frame;
            toChangeChangeDirectionButton.origin.y-=225;
            [self.changeDirectionButton setFrame:toChangeChangeDirectionButton];
                     self.direction=!self.direction;
            
            self.beginPosition-=204;
            self.endPosition=10;
            self.offsetY-=17;
            [self directionChanged:self];
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeGameView =self.gameView.frame;
            toChangeGameView.origin.y+=10;
            toChangeGameView.size.height+=200;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeChangeDirectionButton=self.changeDirectionButton.frame;
            toChangeChangeDirectionButton.origin.y+=225;
            [self.changeDirectionButton setFrame:toChangeChangeDirectionButton];
            self.beginPosition+=204;
            self.endPosition=10;
            self.offsetY+=17;
            self.direction=!self.direction;
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
    int x=150;
    int tempEnd=self.endPosition;
    int j=0;
    switch ( choose ) {
        case 0:
            [trackPath moveToPoint:P(x-self.offsetY, self.beginPosition)];
             [trackPath addLineToPoint:P(x-self.offsetY,tempEnd)];
           for (int i=0; i<=11; i++) {
               
               if(i==0) {
                   tempEnd+=self.offsetY;

                   [trackPath addLineToPoint:P(x+2*self.offsetX,tempEnd)];
               }
               else if(i==11) {
                   tempEnd+=self.offsetY;
                   [trackPath addLineToPoint:P(x-self.offsetY,tempEnd)];
               }
               else {
                    if (i%2)
                        j=-1;
                    else
                        j=1;
               tempEnd+=self.offsetY;
                    [trackPath addLineToPoint:P(x+self.offsetX+j*self.offsetX,tempEnd)];
               }
               
                
            }
            break;
        case 1:
            [trackPath moveToPoint:P(x+2*self.offsetX+self.offsetY, self.beginPosition)];
            [trackPath addLineToPoint:P(x+2*self.offsetX+self.offsetY,self.offsetY)];
           for (int i=0; i<=11; i++) {
                
                if(i==0) {
                    tempEnd+=self.offsetY;
                    
                    [trackPath addLineToPoint:P(x,tempEnd)];
                }
                else if(i==11) {
                   tempEnd+=self.offsetY;
                    [trackPath addLineToPoint:P(x+2*self.offsetX+self.offsetY,tempEnd)];
                }
                else {
                    if (i%2)
                        j=1;
                    else
                        j=-1;
                    tempEnd+=self.offsetY;
                    [trackPath addLineToPoint:P(x+self.offsetX+j*self.self.offsetX,tempEnd)];
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
