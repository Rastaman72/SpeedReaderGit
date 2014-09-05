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
    self.minLength=self.minWordLengthSLider.value;
    self.maxLength=self.maxWordLengthSlider.value;
    
    self.minWordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.minLength]description];
     self.maxWordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.maxLength]description];
    self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowTimeSlider.value]description];
    
    [self getWord];
    
    
   
    /*else
     {
     [self.scrollingTimer invalidate];
     self.scrollingTimer = nil;
     
     }
     self.startPush=YES;*/
    
    // Do any additional setup after loading the view.
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
}

- (IBAction)maxWordValueChange:(id)sender {
    
    self.maxLength=self.maxWordLengthSlider.value;
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
@end
