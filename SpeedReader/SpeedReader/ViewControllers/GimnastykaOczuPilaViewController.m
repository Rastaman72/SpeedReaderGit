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
    int x=50;
    int y=200;
    int offset=40;
    int j=0;
    switch ( choose ) {
        case 0:
            [trackPath moveToPoint:P(x, 350)];
            [trackPath addLineToPoint:P(x,300)];
            
            for (int i=1; i<=30; i++) {
                if (i<=14) {
                    
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    x+=offset;
                    [trackPath addLineToPoint:P(x,y+j*100)];
                    
                } else if(i==15){
                    [trackPath addLineToPoint:P(x,400)];
                    
                }
                else if(i==30)
                {
                    [trackPath addLineToPoint:P(x,350)];
                    
                }
                else {
                    x-=offset;
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    [trackPath addLineToPoint:P(x,y+300+j*100)];
                    
                }
                
            }
            break;
        case 1:
            x+=14*offset;
            [trackPath moveToPoint:P(x, 350)];
            [trackPath addLineToPoint:P(x,300)];
            
            for (int i=1; i<=30; i++) {
                if (i<=14) {
                    
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    x-=offset;
                    [trackPath addLineToPoint:P(x,y+j*100)];
                    
                } else if(i==15){
                    [trackPath addLineToPoint:P(x,400)];
                    
                }
                else if(i==30)
                {
                   
                    [trackPath addLineToPoint:P(x,350)];
                 
                }
                else {
                    x+=offset;
                    if (i%2)
                        j=-1;
                    else
                        j=1;
                    
                    [trackPath addLineToPoint:P(x,y+300+j*100)];
                    
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
