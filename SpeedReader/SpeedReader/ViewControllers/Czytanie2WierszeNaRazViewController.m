//
//  ExerciseOneViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "Czytanie2WierszeNaRazViewController.h"

@interface Czytanie2WierszeNaRazViewController ()

@end

@implementation Czytanie2WierszeNaRazViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [self resetView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.xmlManager=[self theAppDataObject];
    [self.xmlManager getExercisesText];
    self.textView.text=self.xmlManager.exercisesText;
   
    NSLog(@"%@",self.textView.font.familyName);
    NSLog(@"%f",self.textView.frame.size.width);
    float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
     UIFont *fontText = [UIFont fontWithName:@"Helvetica Neue"  size:fontSize];
    [self.textView setFont:fontText];
    NSLog(@"%@",self.textView.font.familyName);
    NSLog(@"%f",self.textView.frame.size.width);
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
    self.actuallOffset=self.maxPosition;
    self.position=0;
    //ios77777777
   
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
    
    self.frameSpeedDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.frameSpeedSlider.value]description];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
}

-(void)checkOrientataion
{
    [self deviceOrientationDidChange:nil];
}
-(void)createFrame
{
    CGRect Rect = CGRectMake(0, 8+self.position, self.textView.frame.size.width, self.textView.font.lineHeight*2);
    self.readFrame = [CALayer layer];
    [self.readFrame setFrame:Rect];
    [self.readFrame setBounds:Rect];
    [self.readFrame setCornerRadius:5.0f];
    [self.readFrame setBackgroundColor:[[UIColor blueColor]CGColor]];
    [self.readFrame setOpacity:0.2f];
    [self.readFrame setBorderColor:[[UIColor blackColor]CGColor]];
    [self.readFrame setBorderWidth:3.0f];
    [self.readFrame setShadowColor:[[UIColor blackColor]CGColor]];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetView
{
    self.textView.text=nil;
    self.textView.text=self.xmlManager.exercisesText;
    [self.textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.textSizeSlider.value]];
    [self.textView setContentOffset:CGPointZero animated:YES];
    [self.scrollingTimer invalidate];
    self.scrollingTimer = nil;
    self.position=0;
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
    self.frameSpeedDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.frameSpeedSlider.value]description];
    
}

- (void) autoscrollTimerFired
{
    if(self.position >=self.textView.contentSize.height) {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
        return;
    }
    
    if (self.position>=self.maxPosition-self.textView.font.lineHeight && self.maxPosition<self.textView.contentSize.height ) {
        [self.textView setContentOffset:CGPointMake(0, self.maxPosition) animated:YES];
        
        self.maxPosition+=self.actuallOffset;
        self.done=YES;
    } else {
        [self createFrame];
        
        if (self.position==0) {
            [[[self textView]layer]insertSublayer:self.readFrame atIndex:0];
        }
        
        [[[self textView]layer]replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:self.readFrame];
      /*  if (self.xmlManager.iOSVersion==7) {
            self.position+=self.textView.font.lineHeight*2;
        }
        else
        {*/
            self.position+=self.textView.font.lineHeight*2;
        //}
    }
}



- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (void)countMaxPosition {
    CGSize size = [self.textView.text sizeWithFont:self.textView.font
                                         constrainedToSize:self.textView.frame.size
                                             lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.textView.font.lineHeight;
    self.maxPosition=self.textView.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}

- (IBAction)sizeChanged:(id)sender {

     [self resetView];
        [self countMaxPosition];
     [self createFrame];
    if(self.startPush) {
    [[[self textView]layer]replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:nil];
        self.startPush=NO;
        
     
    }
}

- (IBAction)sizeDynamic:(id)sender {
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
}

- (IBAction)timeChanged:(id)sender {
    
    [self.scrollingTimer invalidate];
    self.scrollingTimer = nil;
    if(self.startPush) {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.frameSpeedSlider.value/1000)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
        //self.startPush=NO;
    }
    
}

- (IBAction)timeDynamic:(id)sender {
    self.frameSpeedDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.frameSpeedSlider.value]description];

}

- (IBAction)startPush:(id)sender {
    if (self.scrollingTimer == nil) {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.frameSpeedSlider.value/1000)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    } else {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
    }
    self.startPush=YES;
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
            
            CGRect toChangeframeSpeedView= self.frameSpeedView.frame;
            toChangeframeSpeedView.origin.y-=225;
            [self.frameSpeedView setFrame:toChangeframeSpeedView];
            
            
            
            CGRect toChangetextSizeView= self.textSizeView.frame;
            toChangetextSizeView.origin.y-=225;
            [self.textSizeView setFrame:toChangetextSizeView];
            
            CGRect toChangetStartButton= self.startButtron.frame;
            toChangetStartButton.origin.y-=225;
            [self.startButtron setFrame:toChangetStartButton];
            
            [self sizeChanged:self];
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
            
            CGRect toChangeframeSpeedView= self.frameSpeedView.frame;
            toChangeframeSpeedView.origin.y+=225;
            [self.frameSpeedView setFrame:toChangeframeSpeedView];
            
            
            
            CGRect toChangetextSizeView= self.textSizeView.frame;
            toChangetextSizeView.origin.y+=225;
            [self.textSizeView setFrame:toChangetextSizeView];
            
            CGRect toChangetStartButton= self.startButtron.frame;
            toChangetStartButton.origin.y+=225;
            [self.startButtron setFrame:toChangetStartButton];
           [self sizeChanged:self];
            self.changePosition=NO;
        }
    }
    
  }
@end
