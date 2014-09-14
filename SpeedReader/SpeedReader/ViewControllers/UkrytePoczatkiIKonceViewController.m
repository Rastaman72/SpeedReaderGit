//
//  UkrytePoczatkiIKonceViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/10/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "UkrytePoczatkiIKonceViewController.h"

@interface UkrytePoczatkiIKonceViewController ()

@end

@implementation UkrytePoczatkiIKonceViewController

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
    self.exerciseTextView.text=self.xmlManager.exercisesText;
    
    /*
    //float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    
    [self.exerciseTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size: 16]];
    */
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 50.0;
    paragraphStyle.firstLineHeadIndent = 50.0;
    paragraphStyle.tailIndent = -50.0;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:16], NSParagraphStyleAttributeName: paragraphStyle};
    self.exerciseTextView.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
    

    
    self.exerciseTextViewSize = [self.exerciseTextView.text sizeWithFont:self.exerciseTextView.font
                                                       constrainedToSize:self.exerciseTextView.frame.size
                                                           lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    
    
   [self createFrame];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
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
            CGRect toChangeExerciseTextView= self.exerciseTextView.frame;
            toChangeExerciseTextView.size.height-=150;
            [self.exerciseTextView setFrame:toChangeExerciseTextView];
            
            CGRect toChangeShadowView= self.shadowView.frame;
            [self.shadowView setFrame:toChangeShadowView];
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y-=225;
            [self.startButton setFrame:toChangeStartButton];
            
            CGRect toChangeShadowSizeView= self.shadowSizeView.frame;
            toChangeShadowSizeView.origin.y-=225;
            [self.shadowSizeView setFrame:toChangeShadowSizeView];
            

            [self cleanFrame];
            [self resetView];
            
            
            [self createFrame];
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            CGRect toChangeExerciseTextView= self.exerciseTextView.frame;
            toChangeExerciseTextView.size.height+=150;
            [self.exerciseTextView setFrame:toChangeExerciseTextView];
            
            CGRect toChangeShadowView= self.shadowView.frame;
           // toChangeShadowView.size.height+=150;
            
           // toChangeShadowView.origin.y+=50;
            [self.shadowView setFrame:toChangeShadowView];
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y+=225;
            [self.startButton setFrame:toChangeStartButton];
            
            CGRect toChangeShadowSizeView= self.shadowSizeView.frame;
            toChangeShadowSizeView.origin.y+=225;
            [self.shadowSizeView setFrame:toChangeShadowSizeView];

            [self cleanFrame];
            [self resetView];
            
            
            [self createFrame];
           
            self.changePosition=NO;
        }
    }
    
}

-(void)createFrame
{
    
       CGRect Rect = CGRectMake(-35, self.exerciseTextView.frame.origin.y, 150*self.shadowSizeSlider.value,self.exerciseTextView.frame.size.height );
       CALayer* shadow = [CALayer layer];
        [shadow setFrame:Rect];
        [shadow setBounds:Rect];
        	
        [shadow setCornerRadius:5.0f];
        [shadow setBackgroundColor:[[UIColor redColor]CGColor]];
        [shadow setOpacity:1.0f];
        [shadow setBorderColor:[[UIColor redColor]CGColor]];
        [shadow setBorderWidth:0.1f];
        [shadow setShadowColor:[[UIColor redColor]CGColor]];
    [self.shadowView.layer addSublayer:shadow];
    
    
    CGRect Rect1 = CGRectMake(self.exerciseTextView.frame.size.width-(150*self.shadowSizeSlider.value+145), 0, 150	*self.shadowSizeSlider.value,self.exerciseTextView.frame.size.height );
    CALayer * shadow1 = [CALayer layer];
    [shadow1 setFrame:Rect1];
    [shadow1 setBounds:Rect1];
    
    [shadow1 setCornerRadius:5.0f];
    [shadow1 setBackgroundColor:[[UIColor redColor]CGColor]];
    [shadow1 setOpacity:1.0f];
    [shadow1 setBorderColor:[[UIColor redColor]CGColor]];
    [shadow1 setBorderWidth:0.1f];
    [shadow1 setShadowColor:[[UIColor redColor]CGColor]];
    [self.shadowView.layer addSublayer:shadow1];

    }


- (void)resetView
{
    self.exerciseTextView.text=nil;
    self.exerciseTextView.text=self.xmlManager.exercisesText;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 50.0;
    paragraphStyle.firstLineHeadIndent = 50.0;
    paragraphStyle.tailIndent = -50.0;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:16], NSParagraphStyleAttributeName: paragraphStyle};
    self.exerciseTextView.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
    
    

    [self.exerciseTextView setContentOffset:CGPointZero animated:YES];
   
}


- (IBAction)shadowChange:(id)sender {
    
    // self.exercisesThirtyEigthText.layer.sublayers = nil;
    
    
    [self cleanFrame];
    [self resetView];
    
    
    [self createFrame];
}


-(void) cleanFrame
{
    self.shadowView.layer.sublayers=nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)startPush:(id)sender {
}
@end
