//
//  ExerciseThreeViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "CzytanieOdTyluViewController.h"

@interface CzytanieOdTyluViewController ()

@end

@implementation CzytanieOdTyluViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)resetView {
    self.textView.text=nil;
    self.textView.text=self.xmlManager.exercisesText;
    [self.textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.textSizeSlider.value]];
    [self.textView setContentOffset:CGPointZero animated:YES];
    [self.scrollingTimer invalidate];
    self.scrollingTimer = nil;
    self.position=0;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [self resetView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.xmlManager=[self theAppDataObject];
    [self.xmlManager getExercisesText];
    self.textView.text=self.xmlManager.exercisesText;
    float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    [self.textView setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    
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
    self.textView.scrollEnabled=NO;
    self.frameSpeedDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.frameSpeedSlider.value]description];
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
    self.numbersOfJumpDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.numbersOfJumpSlider.value]description];
    [self setJump];
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
            CGRect toChangeTextView= self.textView.frame;
            toChangeTextView.size.height-=225;
            [self.textView setFrame:toChangeTextView];
            
            CGRect toChangeframeSpeedView= self.frameSpeedView.frame;
            toChangeframeSpeedView.origin.y-=225;
            [self.frameSpeedView setFrame:toChangeframeSpeedView];
            
            
            
            CGRect toChangetextSizeView= self.textSizeView.frame;
            toChangetextSizeView.origin.y-=225;
            [self.textSizeView setFrame:toChangetextSizeView];
            
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y-=245;
            [self.startButton setFrame:toChangetStartButton];
            
            CGRect toChangenumbersOfJumpView= self.numbersOfJumpView.frame;
            toChangenumbersOfJumpView.origin.y-=225;
            [self.numbersOfJumpView setFrame:toChangenumbersOfJumpView];
            
            
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
            
            
            
            CGRect toChangenumbersOfJumpView= self.numbersOfJumpView.frame;
            toChangenumbersOfJumpView.origin.y+=225;
            [self.numbersOfJumpView setFrame:toChangenumbersOfJumpView];
            
            
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y+=245;
            [self.startButton setFrame:toChangetStartButton];
            [self sizeChanged:self];
            self.changePosition=NO;
        }
    }
    
}

- (void) autoscrollTimerFired {
    if(self.position >=self.textView.contentSize.height) {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
        return;
    }
    
    if (self.position>=self.maxPosition-self.textView.font.lineHeight && self.maxPosition<self.textView.contentSize.height && self.jumpCounter==(int)self.numbersOfJumpSlider.value ) {
        [self.textView setContentOffset:CGPointMake(0, self.maxPosition) animated:YES];
        self.maxPosition+=self.actuallOffset;
        self.done=YES;
    } else {
        [self createFrame];
        if (self.position==0 && self.jumpCounter==1) {
            [[[self textView]layer]insertSublayer:self.readFrame atIndex:0];
            return;
        }
        [[[self textView]layer]replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:self.readFrame];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SharedData*) theAppDataObject {
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
    if(self.startPush)
    {
        [[[self textView]layer]replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:nil];
        self.startPush=NO;
    }
}

- (IBAction)timeChanged:(id)sender {
    [self.scrollingTimer invalidate];
    self.scrollingTimer = nil;
    
    if(self.startPush) {
    self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.frameSpeedSlider.value/1000)
                                                           target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    }
  
}

-(void)createFrame {
    CGRect Rect;
    if (self.jumpCounter<self.numbersOfJumpSlider.value) {
        if(self.resetLine) {
             self.jumpWidth+=self.jumpOffset;
            self.resetLine=NO;
            self.jumpCounter++;
        }
        self.jumpWidth+=self.jumpOffset;
        self.jumpCounter++;
        if(self.xmlManager.useOtherVersion)
        {
             Rect = CGRectMake(self.jumpWidth, 5+self.position, 25, 25);
        }
       
        else
        {
             Rect = CGRectMake(self.textView.frame.size.width-self.jumpWidth, 5+self.position, 25, 25);
        }
    } else {
        self.jumpCounter=0;
        self.jumpWidth=0;
        self.position+=self.textView.font.lineHeight;
        
        if(self.xmlManager.useOtherVersion)
        {
            Rect = CGRectMake(self.jumpOffset, 5+self.position, 25, 25);

        }
        
        else
        {
            Rect = CGRectMake(self.textView.frame.size.width-self.jumpOffset, 5+self.position, 25, 25);

        }
        
              self.resetLine=YES;
    }
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

- (IBAction)startPush:(id)sender {
    if (self.scrollingTimer == nil) {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.frameSpeedSlider.value/1000)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    } else {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
        
    }
    self.startPush=YES;
    self.jumpCounter=0;
    self.jumpWidth=0;
}

- (void)setJump {
    switch ((int)self.numbersOfJumpSlider.value) {
        case 2:
            self.jumpOffset=self.textView.frame.size.width/3;
            break;
        case 3:
            self.jumpOffset=self.textView.frame.size.width/4;
            break;
        default:
            break;
    }
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

- (IBAction)jumpChange:(id)sender {
    [self setJump];
    
}


- (IBAction)speedDynamic:(id)sender {
    self.frameSpeedDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.frameSpeedSlider.value]description];
    
}

- (IBAction)jumpDynamic:(id)sender {
    self.numbersOfJumpDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.numbersOfJumpSlider.value]description];
}

- (IBAction)sizeDynamic:(id)sender {
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
    
}
@end
