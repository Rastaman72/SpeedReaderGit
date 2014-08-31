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
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 80.0;
    paragraphStyle.firstLineHeadIndent = 80.0;
    paragraphStyle.tailIndent = -80.0;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:fontSize], NSParagraphStyleAttributeName: paragraphStyle};
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
    // [self.textView.layer insertSublayer:self.readFrameLayer atIndex:0];

    
    self.pickerValueLabel.text=[[[NSNumber alloc]initWithInt:self.pickStyleSlider.value]description];
    self.chooseTrack=self.pickStyleSlider.value;

    self.size = [self.textView.text sizeWithFont:self.textView.font
                               constrainedToSize:self.textView.frame.size
                                   lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = self.size.height / self.textView.font.lineHeight;
    self.maxPosition=self.textView.font.lineHeight*numberOfLines;
    self.actuallOffset=numberOfLines/3;
    
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
            
            for (int i=0; i<=1.5*self.actuallOffset; i++) {
                
                
                [trackPath addLineToPoint:P(self.textView.frame.size.width,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+2*self.textView.font.lineHeight*i)];
                i++;
                [trackPath addLineToPoint:P(0,self.textView.frame.origin.y+1.75*self.textView.font.lineHeight+2*self.textView.font.lineHeight*i)];
                i--;
            }
            break;
            case 1:
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
     NSLog(@"%@",self.view.layer.sublayers );
	[self.view.layer insertSublayer:racetrack atIndex:0];//:racetrack];
    
     NSLog(@"%@",self.view.layer.sublayers );
    CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	//car.position = P(self.exercisesNineText.frame.size.width/2, self.exercisesNineText.frame.size.height/2);
	car.contents = (id)([UIImage imageNamed:@"image0.jpg"].CGImage);
	[self.view.layer addSublayer:car];
	
	CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	anim.path = trackPath.CGPath;
	anim.rotationMode = kCAAnimationRotateAuto;
	anim.repeatCount = HUGE_VALF;
	anim.duration = 100.0;
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
    NSLog(@"%@",self.view.layer.sublayers );
    [[self.view.layer.sublayers lastObject]replaceSublayer:[self.view.layer.sublayers firstObject] with:nil];
    [self createFrame];
    }
@end
