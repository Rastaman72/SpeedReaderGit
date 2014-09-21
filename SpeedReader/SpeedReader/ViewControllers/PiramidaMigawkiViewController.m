//
//  ExercisesTwentyThreeViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "PiramidaMigawkiViewController.h"

@interface PiramidaMigawkiViewController ()

@end

@implementation PiramidaMigawkiViewController

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
    self.step=2;
    self.actuallLength=3;
    self.xmlManager=[self theAppDataObject];
    
    
    if (self.xmlManager.excMode) {
        
        self.minLength=self.minWordLengthSLider.value;
        self.maxLength=self.maxWordLengthSlider.value;
        self.minWordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.minLength]description];
        self.maxWordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.maxLength]description];
        self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowTimeSlider.value]description];
    }
    else
    {
        
        self.minLength=[[self.xmlManager.paramsForSpecifyExc valueForKey:@"min"]intValue];
        self.maxLength=[[self.xmlManager.paramsForSpecifyExc valueForKey:@"max"]intValue];
        self.wordShowTimeSlider.value=[[self.xmlManager.paramsForSpecifyExc valueForKey:@"interval"]intValue];
        
        
        self.maxWordLengthView.hidden=YES;
        self.minWordLengthView.hidden=YES;
        self.wordShowTimeView.hidden=YES;
        
    }
    
    
   
    
    [self getWord];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    
    
   
      // Do any additional setup after loading the view.
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
            CGRect toChangeWordShowTimeView= self.wordShowTimeView.frame;
            toChangeWordShowTimeView.origin.y-=225;
            [self.wordShowTimeView setFrame:toChangeWordShowTimeView];
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y-=225;
            [self.startButton setFrame:toChangeStartButton];
            
            CGRect toChangMinWordLengthView= self.minWordLengthView.frame;
            toChangMinWordLengthView.origin.y-=225;
            [self.minWordLengthView setFrame:toChangMinWordLengthView];
            
            CGRect toChangeMaxWordLengthView= self.maxWordLengthView.frame;
            toChangeMaxWordLengthView.origin.y-=225;
            [self.maxWordLengthView setFrame:toChangeMaxWordLengthView];
            
            CGRect toChangeExcTextLabel= self.exerciseTextLabel.frame;
            toChangeExcTextLabel.origin.y-=225;
            [self.exerciseTextLabel setFrame:toChangeExcTextLabel];
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeWordShowTimeView= self.wordShowTimeView.frame;
            toChangeWordShowTimeView.origin.y+=225;
            [self.wordShowTimeView setFrame:toChangeWordShowTimeView];
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y+=225;
            [self.startButton setFrame:toChangeStartButton];
            
            CGRect toChangMinWordLengthView= self.minWordLengthView.frame;
            toChangMinWordLengthView.origin.y+=225;
            [self.minWordLengthView setFrame:toChangMinWordLengthView];
            
            CGRect toChangeMaxWordLengthView= self.maxWordLengthView.frame;
            toChangeMaxWordLengthView.origin.y+=225;
            [self.maxWordLengthView setFrame:toChangeMaxWordLengthView];
            
            CGRect toChangeExcTextLabel= self.exerciseTextLabel.frame;
            toChangeExcTextLabel.origin.y+=225;
            [self.exerciseTextLabel setFrame:toChangeExcTextLabel];
            
            self.changePosition=NO;
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getWord
{
    self.actuallWord=[[NSString alloc]init];
    self.actuallWord=[self.xmlManager getWord:self.actuallLength];
    self.actuallLength+=self.step;
    if(self.actuallLength>self.maxLength)
    {
        self.actuallLength=self.minLength;
    }
    self.exerciseTextLabel.text=self.actuallWord;
    [self.exerciseTextLabel sizeToFit];
    
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

- (IBAction)minWordValueChange:(id)sender {
    self.minLength=self.minWordLengthSLider.value;
    self.minWordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.minLength]description];
}

- (IBAction)maxWordValueChange:(id)sender {
    
    self.maxLength=self.maxWordLengthSlider.value;
     self.maxWordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.maxLength]description];
}

- (SharedData*) theAppDataObject;
{
    id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
    SharedData* theDataObject;
    theDataObject = (SharedData*) theDelegate.theAppDataObject;
    return theDataObject;
}
- (IBAction)startPush:(id)sender {
    self.actuallLength=3;
    
    if(self.startPush)
    {
        [self.scrollingTimer invalidate];
        self.scrollingTimer=nil;
        self.startPush=NO;
    }
    else{
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.wordShowTimeSlider.value/1000)
                                                               target:self selector:@selector(getWord) userInfo:nil repeats:YES];
        self.startPush=YES;
    }
    }
}
- (IBAction)wordShowTimeChange:(id)sender {
    if(self.startPush)
    {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.wordShowTimeSlider.value/1000)
                                                               target:self selector:@selector(getWord) userInfo:nil repeats:YES];
        self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowTimeSlider.value]description];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.scrollingTimer invalidate];
    self.scrollingTimer=nil;

}


@end
