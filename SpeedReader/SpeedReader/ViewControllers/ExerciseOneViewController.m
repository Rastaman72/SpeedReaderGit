//
//  ExerciseOneViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExerciseOneViewController.h"

@interface ExerciseOneViewController ()

@end

@implementation ExerciseOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)resetView
{
    self.exercisesOneText.text=nil;
    self.exercisesOneText.text=self.xmlManager.exercisesText;
    [self.exercisesOneText setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.exercisesOneSizeSlider.value]];
    [self.exercisesOneText setContentOffset:CGPointZero animated:YES];
    [self.scrollingTimer invalidate];
    self.scrollingTimer = nil;
    self.position=0;
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
    self.exercisesOneText.text=self.xmlManager.exercisesText;
    
    
    float fontSize =[[[[NSNumber alloc]initWithInt:self.exercisesOneSizeSlider.value]description]floatValue];
  
    [self.exercisesOneText setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    
    self.size = [self.exercisesOneText.text sizeWithFont:self.exercisesOneText.font
                                       constrainedToSize:self.exercisesOneText.frame.size
                                           lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = self.size.height / self.exercisesOneText.font.lineHeight;
   
    NSLog(@"%f",self.exercisesOneText.font.lineHeight);
    self.maxPosition=self.exercisesOneText.font.lineHeight*numberOfLines;
    
      self.actuallOffset=self.maxPosition;
    self.position=0;
    
    self.exercisesOneText.scrollEnabled=NO;
   
    
}


- (void) autoscrollTimerFired
{
    NSLog(@"%f",self.exercisesOneText.contentSize.height);
    if(self.position >=self.exercisesOneText.contentSize.height)
     {
     [self.scrollingTimer invalidate];
     self.scrollingTimer = nil;
         return;
     }
    NSLog(@"%f",self.exercisesOneText.contentSize.height);
    
       if (self.position>=self.maxPosition-self.exercisesOneText.font.lineHeight && self.maxPosition<self.exercisesOneText.contentSize.height )
       {
        [self.exercisesOneText setContentOffset:CGPointMake(0, self.maxPosition) animated:YES];
        self.maxPosition+=self.actuallOffset;
          self.done=YES;
    }
    else
    {
        [self createFrame];
        
        if (self.position==0) {
            [[[self exercisesOneText]layer]insertSublayer:self.readFrame atIndex:0];

        }
      
        
   [[[self exercisesOneText]layer]replaceSublayer:[self.exercisesOneText.layer.sublayers objectAtIndex:0] with:self.readFrame];
        
    self.position+=self.exercisesOneText.font.lineHeight*2;
    }
   for (id test in self.exercisesOneText.layer.sublayers) {
        NSLog(@"%@",test);
    }
    
    //}
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

- (void)countMaxPosition {
    CGSize size = [self.exercisesOneText.text sizeWithFont:self.exercisesOneText.font
                                         constrainedToSize:self.exercisesOneText.frame.size
                                             lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.exercisesOneText.font.lineHeight;
    self.maxPosition=self.exercisesOneText.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}


- (IBAction)sizeChanged:(id)sender {
    
    
    
    
     [self resetView];
        [self countMaxPosition];
     [self createFrame];
    if(self.startPush)
    {
    [[[self exercisesOneText]layer]replaceSublayer:[self.exercisesOneText.layer.sublayers objectAtIndex:0] with:nil];
        self.startPush=NO;
    }
}



- (IBAction)timeChanged:(id)sender {
    
    [self.scrollingTimer invalidate];
    self.scrollingTimer = nil;
    
   self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.exercisesOneTimeSlider.value/1000)
                                                          target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
}



-(void)createFrame
{
    CGRect Rect = CGRectMake(0, 5+self.position, self.exercisesOneText.frame.size.width, self.exercisesOneText.font.lineHeight*2);
    
    
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
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.exercisesOneTimeSlider.value/1000)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    }
    else
    {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;

    }
    self.startPush=YES;
}


@end
