//
//  ExercisesNineViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "CzytanieZeWskaznikiemViewController.h"
#define degreesToRadians(x) (M_PI * x / 180.0)
#define P(x,y) CGPointMake(x, y)
@interface CzytanieZeWskaznikiemViewController ()

@end

@implementation CzytanieZeWskaznikiemViewController

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
   
    
   self.xmlManager=[self theAppDataObject];
    [self.xmlManager getExercisesText];
    self.textView.text=self.xmlManager.exercisesText;
   // float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    float fontSize =16;
[self.textView setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    // [self.textView.layer insertSublayer:self.readFrameLayer atIndex:0];

    
    self.pickerValueLabel.text=[[[NSNumber alloc]initWithInt:self.pickStyleSlider.value]description];
    self.chooseTrack=self.pickStyleSlider.value;

    self.size = [self.textView.text sizeWithFont:self.textView.font
                               constrainedToSize:self.textView.frame.size
                                   lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = self.size.height / self.textView.font.lineHeight;
    self.maxPosition=self.textView.font.lineHeight*numberOfLines;
    self.actuallOffset=numberOfLines;
    
    [self createFrame];

    // Do any additional setup after loading the view.
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UIBezierPath *)createPathForPoint
{
    UIBezierPath *trackPath = [UIBezierPath bezierPath];

    switch ( self.chooseTrack) {
        case 0:
            [trackPath moveToPoint:P(self.textView.frame.origin.x, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight)];
            
            for (int i=0; i<=0.6*self.actuallOffset; i++) {
                
                
                [trackPath addLineToPoint:P(self.textView.frame.size.width,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+2*self.textView.font.lineHeight*i)];
                i++;
                [trackPath addLineToPoint:P(0,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+2*self.textView.font.lineHeight*i)];
                i--;
            }
            break;
            case 1:
            [trackPath moveToPoint:P(self.textView.frame.origin.x, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight)];
            
            for (int i=0; i<=0.3*self.actuallOffset; i++) {
                
                
                [trackPath addLineToPoint:P(self.textView.frame.size.width,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)];
                i++;
                [trackPath addLineToPoint:P(0,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)];
                i--;
            }
            break;
        case 2:
            [trackPath moveToPoint:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight)];
            
            for (int i=0; i<=0.3*self.actuallOffset; i++) {
                
                
                [trackPath addLineToPoint:P(self.textView.frame.origin.x,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)];
                i++;
                [trackPath addLineToPoint:P(self.textView.frame.size.width,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)];
                i--;
            }
            break;
        case 3:
            [trackPath moveToPoint:P(self.textView.frame.origin.x, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight)];
            
            for (int i=0; i<=0.3*self.actuallOffset; i++) {
                
                if (i % 2)
                {
                    
                    [trackPath addLineToPoint:P(100,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                    i++;
                    [trackPath addCurveToPoint:P(100, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)
                                 controlPoint1:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*(i-1))
                                 controlPoint2:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                    
                    // [trackPath addLineToPoint:P(0,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                    i--;
                }
                    else
                    {
                        
                        [trackPath addLineToPoint:P(self.textView.frame.size.width-100,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                        i++;
                        [trackPath addCurveToPoint:P(self.textView.frame.size.width-100, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)
                                     controlPoint1:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*(i-1))
                                     controlPoint2:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                        
                        //[trackPath addLineToPoint:P(0,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                        i--;
                    }
                
                /*
                [trackPath addLineToPoint:P(self.textView.frame.size.width,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)];
                */
            }
            break;
        case 4:
            [trackPath moveToPoint:P(self.textView.frame.origin.x, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight)];
            
            for (int i=0; i<=0.6*self.actuallOffset; i++) {
                if(i==0)
                {
                    [trackPath addCurveToPoint:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+2*self.textView.font.lineHeight)
                                 controlPoint1:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight)
                                 controlPoint2:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight)];
                    
                }
                else {
                    if (i % 2)
                    {
                        
                        
                        //i++;
                        [trackPath addCurveToPoint:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)
                                     controlPoint1:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i-3))
                                     controlPoint2:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i+3))];
                        
                        
                        // i--;
                    }
                    else
                    {
                        // i++;
                        [trackPath addCurveToPoint:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)
                                     controlPoint1:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i-3))
                                     controlPoint2:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i+3))];
                        
                       
                        //i--;
                       
                        
                    }
                }
                
                
            }
            break;

        default:
            break;
    }
    
    return trackPath;
}

-(void)createFrame
{
    UIBezierPath *trackPath;
    trackPath = [self createPathForPoint];
	/*
     
     NIESKONCZONOSC
     
     [trackPath moveToPoint:P(0, self.textView.frame.size.height/2)];
     [trackPath addCurveToPoint:P(self.textView.frame.size.width, self.textView.frame.size.height/2)
     controlPoint1:P(50, 0)
     controlPoint2:P(700, 800)];
     [trackPath addCurveToPoint:P(0, self.textView.frame.size.height/2)
     controlPoint1:P(700, 0)
     controlPoint2:P(50, 800)];
     */
    
	CAShapeLayer *racetrack = [CAShapeLayer layer];
	racetrack.path = trackPath.CGPath;
	racetrack.strokeColor = [UIColor grayColor].CGColor;
	racetrack.fillColor = [UIColor clearColor].CGColor;
	racetrack.lineWidth = 5.0;
    [racetrack setOpacity:0.5];
     NSLog(@"%@",self.textView.layer.sublayers );
	
    [self.textView.layer insertSublayer:racetrack atIndex:0];//:racetrack];
    //[self.maskView.layer addSublayer:racetrack];
    
    
    NSLog(@"%@",self.textView.layer.sublayers );

    CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	//car.position = P(self.exercisesNineText.frame.size.width/2, self.exercisesNineText.frame.size.height/2);
	car.contents = (id)([UIImage imageNamed:@"image0.jpg"].CGImage);
	
    
   [self.textView.layer insertSublayer:car atIndex:1];
	// [self.maskView.layer addSublayer:car];
	
    NSLog(@"%@",self.textView.layer.sublayers );

    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	anim.path = trackPath.CGPath;
	anim.rotationMode = kCAAnimationRotateAuto;
	anim.repeatCount = HUGE_VALF;
	anim.duration = 15.0;
	[car addAnimation:anim forKey:@"race"];

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

- (IBAction)pickerChange:(id)sender {
    
    self.pickerValueLabel.text=[[[NSNumber alloc]initWithInt:self.pickStyleSlider.value]description];
    self.chooseTrack=self.pickStyleSlider.value;
    NSLog(@"%@",self.textView.layer.sublayers );

 
     [[self.textView.layer.sublayers objectAtIndex:1] removeAnimationForKey:@"race"];
    [self.textView.layer replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:nil];
   
 [self.textView.layer replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:nil];
    NSLog(@"%@",self.textView.layer.sublayers );

  
    [self createFrame];
    }
@end
