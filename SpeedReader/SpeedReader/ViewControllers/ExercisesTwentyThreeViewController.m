//
//  ExercisesTwentyThreeViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesTwentyThreeViewController.h"

@interface ExercisesTwentyThreeViewController ()

@end

@implementation ExercisesTwentyThreeViewController

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
    self.minLength=self.exercisesTwentyThreeMinValueSLider.value;
    
    self.maxLength=self.exercisesTwentyThreeMaxValue.value;
    
    [self getWord];
    
    
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(0.5)
                                                               target:self selector:@selector(getWord) userInfo:nil repeats:YES];
    }
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
    self.exercisesTwentyThreeText.text=self.actuallWord;
    [self.exercisesTwentyThreeText sizeToFit];
    
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

- (IBAction)minValueCHange:(id)sender {
    self.minLength=self.exercisesTwentyThreeMinValueSLider.value;
}

- (IBAction)maxValueChange:(id)sender {
    
    self.maxLength=self.exercisesTwentyThreeMaxValue.value;
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
