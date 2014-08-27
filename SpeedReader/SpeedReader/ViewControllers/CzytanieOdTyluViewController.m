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

- (void)resetView
{
    self.exercisesThreeText.text=nil;
    self.exercisesThreeText.text=self.xmlManager.exercisesText;
    [self.exercisesThreeText setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.exercisesThreeSizeSlider.value]];
    [self.exercisesThreeText setContentOffset:CGPointZero animated:YES];
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
    self.exercisesThreeText.text=self.xmlManager.exercisesText;
    
    
    float fontSize =[[[[NSNumber alloc]initWithInt:self.exercisesThreeSizeSlider.value]description]floatValue];
    
    [self.exercisesThreeText setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    
    self.size = [self.exercisesThreeText.text sizeWithFont:self.exercisesThreeText.font
                                       constrainedToSize:self.exercisesThreeText.frame.size
                                           lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = self.size.height / self.exercisesThreeText.font.lineHeight;
    

    self.maxPosition=self.exercisesThreeText.font.lineHeight*numberOfLines;
    
    self.actuallOffset=self.maxPosition;
    self.position=0;
    
    self.exercisesThreeText.scrollEnabled=NO;
    [self setJump];
    
    
}


- (void) autoscrollTimerFired
{
       if(self.position >=self.exercisesThreeText.contentSize.height)
    {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
        return;
    }
    
    if (self.position>=self.maxPosition-self.exercisesThreeText.font.lineHeight && self.maxPosition<self.exercisesThreeText.contentSize.height && self.jumpCounter==(int)self.exercisesThreeJumpSlider.value )
    {
        //[[[self exercisesThreeText]layer]replaceSublayer:[self.exercisesThreeText.layer.sublayers objectAtIndex:0] with:nil];
        [self.exercisesThreeText setContentOffset:CGPointMake(0, self.maxPosition) animated:YES];
        self.maxPosition+=self.actuallOffset;
        self.done=YES;
    }
    else
    {
        [self createFrame];
        
        if (self.position==0 && self.jumpCounter==1) {
            [[[self exercisesThreeText]layer]insertSublayer:self.readFrame atIndex:0];
            return;
        }
        
       // [[[self exercisesThreeText]layer]addSublayer:self.readFrame];
        [[[self exercisesThreeText]layer]replaceSublayer:[self.exercisesThreeText.layer.sublayers objectAtIndex:0] with:self.readFrame];
        
        //self.position+=self.exercisesThreeText.font.lineHeight;
    }
    
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
    CGSize size = [self.exercisesThreeText.text sizeWithFont:self.exercisesThreeText.font
                                         constrainedToSize:self.exercisesThreeText.frame.size
                                             lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.exercisesThreeText.font.lineHeight;
    self.maxPosition=self.exercisesThreeText.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}


- (IBAction)sizeChanged:(id)sender {
    
    [self resetView];
    [self countMaxPosition];
    [self createFrame];
    if(self.startPush)
    {
        [[[self exercisesThreeText]layer]replaceSublayer:[self.exercisesThreeText.layer.sublayers objectAtIndex:0] with:nil];
        self.startPush=NO;
    }
}



- (IBAction)timeChanged:(id)sender {
    
    [self.scrollingTimer invalidate];
    self.scrollingTimer = nil;
    
    if(self.startPush)
    {
    self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.exercisesThreeTimeSlider.value/1000)
                                                           target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    }
   // self.jumpCounter=0;
}



-(void)createFrame
{
    
    
    
    
    
    NSLog(@"%f",self.exercisesThreeText.frame.size.width);
    
    CGRect Rect ;
    if (self.jumpCounter<self.exercisesThreeJumpSlider.value)
    {
        if(self.resetLine)
        {
             self.jumpWidth+=self.jumpOffset;
            self.resetLine=NO;
            self.jumpCounter++;
        }
        
        self.jumpWidth+=self.jumpOffset;
        self.jumpCounter++;
        Rect = CGRectMake(self.exercisesThreeText.frame.size.width-self.jumpWidth, 5+self.position, 25, 25);
    }
    else
    {
        self.jumpCounter=0;
        self.jumpWidth=0;
        self.position+=self.exercisesThreeText.font.lineHeight;
        Rect = CGRectMake(self.exercisesThreeText.frame.size.width-self.jumpOffset, 5+self.position, 25, 25);
        //self.jumpWidth+=self.jumpOffset;
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
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.exercisesThreeTimeSlider.value/1000)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    }
    else
    {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
        
    }
    self.startPush=YES;
    self.jumpCounter=0;
    self.jumpWidth=0;
}

- (void)setJump
{
    NSLog(@"%f",self.exercisesThreeText.frame.size.width);
    switch ((int)self.exercisesThreeJumpSlider.value)
    {
        case 2:
             self.jumpOffset=self.exercisesThreeText.frame.size.width/3;
          // =self.jumpWidth;
            break;
        case 3:
            self.jumpOffset=self.exercisesThreeText.frame.size.width/4;
            //self.jumpOffset=self.jumpWidth;
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

- (IBAction)jumpChange:(id)sender
{
    [self setJump];
    
}


@end
