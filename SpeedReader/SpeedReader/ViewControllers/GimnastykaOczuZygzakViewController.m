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
    [self createFrame];
    
    // Do any additional setup after loading the view.
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
    int x=300;
    int y=50;
    int offset=40;
    int offsetX=150;
    int j=0;
    switch ( choose ) {
        case 0:
            [trackPath moveToPoint:P(x-offset, 530)];
             [trackPath addLineToPoint:P(x-offset,y)];
           for (int i=0; i<=11; i++) {
               
               if(i==0) {
                   y+=offset;

                   [trackPath addLineToPoint:P(x+2*offsetX,y)];
               }
               else if(i==11) {
                   y+=offset;
                   [trackPath addLineToPoint:P(x-offset,y)];
               }
               else {
                    if (i%2)
                        j=-1;
                    else
                        j=1;
               y+=offset;
                    [trackPath addLineToPoint:P(x+offsetX+j*offsetX,y)];
               }
               
                
            }
            break;
        case 1:
            [trackPath moveToPoint:P(x+2*offsetX+offset, 530)];
            [trackPath addLineToPoint:P(x+2*offsetX+offset,y)];
           for (int i=0; i<=11; i++) {
                
                if(i==0) {
                    y+=offset;
                    
                    [trackPath addLineToPoint:P(x,y)];
                }
                else if(i==11) {
                    y+=offset;
                    [trackPath addLineToPoint:P(x+2*offsetX+offset,y)];
                }
                else {
                    if (i%2)
                        j=1;
                    else
                        j=-1;
                    y+=offset;
                    [trackPath addLineToPoint:P(x+offsetX+j*offsetX,y)];
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
