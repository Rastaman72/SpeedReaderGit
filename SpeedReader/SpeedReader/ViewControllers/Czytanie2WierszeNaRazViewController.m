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
    float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    [self.textView setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    self.size = [self.textView.text sizeWithFont:self.textView.font
                                       constrainedToSize:self.textView.frame.size
                                           lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = self.size.height / self.textView.font.lineHeight;
    self.maxPosition=self.textView.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
    self.position=0;
    self.textView.scrollEnabled=NO;
    
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
    
    self.frameSpeedDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.frameSpeedSlider.value]description];
}


-(void)createFrame
{
    CGRect Rect = CGRectMake(0, 5+self.position, self.textView.frame.size.width, self.textView.font.lineHeight*2);
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
        self.position+=self.textView.font.lineHeight*2;
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
@end
