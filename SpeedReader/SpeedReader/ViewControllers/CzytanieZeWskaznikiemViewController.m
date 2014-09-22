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
    
    if(self.xmlManager.iOSVersion==7)
    {
        self.textView.selectable=YES;
        self.size7 = [self.textView.text boundingRectWithSize:self.textView.frame.size
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:self.textView.font}
                                                      context:nil];
        self.textView.selectable=NO;
        
        self.size=self.size7.size;
        
    }
    float numberOfLines = self.size.height / self.textView.font.lineHeight;
    self.maxPosition=self.textView.font.lineHeight*numberOfLines;
    self.actuallOffset=numberOfLines;
     [self createSlider];
    [self createFrame];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createSlider
{
    self.numberStyle=[[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        [self.numberStyle addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numberStyle count] - 1);
    self.pickStyleSlider.maximumValue = numberOfSteps;
    self.pickStyleSlider.minimumValue = 0;
    [self.pickStyleSlider setValue:0 animated:YES];
    
    self.chooseTrack=[[self.numberStyle objectAtIndex:0]integerValue];
    // As the slider moves it will continously call the -valueChanged:
    self.pickStyleSlider.continuous = NO; // NO makes it call only once you let go
    [ self.pickStyleSlider addTarget:self
                               action:@selector(pickerChange:)
                     forControlEvents:UIControlEventValueChanged];
    self.pickerValueLabel.text=[[[NSNumber alloc]initWithInt:self.chooseTrack]description];
    

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
            CGRect toChangeTextView= self.textView.frame;
            toChangeTextView.size.height-=225;
            [self.textView setFrame:toChangeTextView];
            
            CGRect toChangepickStyleSlider= self.pickStyleView.frame;
            toChangepickStyleSlider.origin.y-=225;
            [self.pickStyleView setFrame:toChangepickStyleSlider];
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeTextView= self.textView.frame;
            toChangeTextView.size.height+=225;
            [self.textView setFrame:toChangeTextView];
            
          
            
            CGRect toChangepickStyleSlider= self.pickStyleView.frame;
            toChangepickStyleSlider.origin.y+=225;
            [self.pickStyleView setFrame:toChangepickStyleSlider];
            
           
        }
    }
    
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
                    i--;
                }
                    else
                    {
                        
                        [trackPath addLineToPoint:P(self.textView.frame.size.width-100,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                        i++;
                        [trackPath addCurveToPoint:P(self.textView.frame.size.width-100, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)
                                     controlPoint1:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*(i-1))
                                     controlPoint2:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+5*self.textView.font.lineHeight*i)];
                        

                        i--;
                    }
                
                
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
                        
                    
                        [trackPath addCurveToPoint:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)
                                     controlPoint1:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i-3))
                                     controlPoint2:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i+3))];
                       
                    }
                    else
                    {
                        
                        [trackPath addCurveToPoint:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+4*self.textView.font.lineHeight*i)
                                     controlPoint1:P(0, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i-3))
                                     controlPoint2:P(self.textView.frame.size.width, self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+3*self.textView.font.lineHeight*(i+3))];
                   
                       
                        
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
    
	CAShapeLayer *racetrack = [CAShapeLayer layer];
	racetrack.path = trackPath.CGPath;
	racetrack.strokeColor = [UIColor grayColor].CGColor;
	racetrack.fillColor = [UIColor clearColor].CGColor;
	racetrack.lineWidth = 5.0;
    [racetrack setOpacity:0.5];
     NSLog(@"%@",self.textView.layer.sublayers );
	
    [self.textView.layer insertSublayer:racetrack atIndex:0];
    
    NSLog(@"%@",self.textView.layer.sublayers );

    CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	car.contents = (id)([UIImage imageNamed:@"image0.jpg"].CGImage);
	
    
   [self.textView.layer insertSublayer:car atIndex:1];
	
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
    
    NSUInteger index = (NSUInteger)(self.pickStyleSlider.value + 0.5);
    [self.pickStyleSlider setValue:index animated:NO];
    NSNumber *number = self.numberStyle[index]; 
    self.chooseTrack=[number intValue];
    self.pickerValueLabel.text=[number description];

 
     [[self.textView.layer.sublayers objectAtIndex:1] removeAnimationForKey:@"race"];
    [self.textView.layer replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:nil];
   
 [self.textView.layer replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:nil];
    NSLog(@"%@",self.textView.layer.sublayers );

  
    [self createFrame];
    }
@end
