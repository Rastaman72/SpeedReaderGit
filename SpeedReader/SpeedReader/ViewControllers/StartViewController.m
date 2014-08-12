//
//  StartViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "StartViewController.h"
@interface StartViewController ()

@end

@implementation StartViewController

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
    self.theDataObject=[self theAppDataObject];
    
    self.startViewWelcome.text=NSLocalizedString(@"Welcome", nil);
    [self.startViewWelcome sizeToFit];
    
    self.startViewUserLogin.text=self.theDataObject.loginUser.login;
    [self.startViewUserLogin sizeToFit];
    
    self.startViewTimeDescription.text=NSLocalizedString(@"You are with us form", nil);
    [self.startViewTimeDescription sizeToFit];
    
    NSDate*now=[[NSDate alloc]init];
    
    NSTimeInterval diffrentInSec=[now timeIntervalSinceDate:self.theDataObject.loginUser.timeAdd];
    int numberOfDays =diffrentInSec/86400;
    if(numberOfDays==0)
        numberOfDays=1;
    self.startViewTimeSpend.text=[[[NSNumber alloc]initWithInt:numberOfDays]description];
    [self.startViewTimeSpend sizeToFit];
    
    [self.startViewUserImage setImage:[UIImage imageWithData:self.theDataObject.loginUser.userImage]];
    
    self.startViewPresenterLabel.text=NSLocalizedString(@"Presenter", nil);
    [self.startViewPresenterLabel sizeToFit];
    
    self.startViewLessonLabel.text=NSLocalizedString(@"LessonDescription", nil);
    [self.startViewLessonLabel sizeToFit];
    
    self.startViewExercisesLabel.text=NSLocalizedString(@"ExercisesDescription", nil);
    [self.startViewExercisesLabel sizeToFit];
    
    self.startViewStatsLabel.text=NSLocalizedString(@"StatsDescription", nil);
    [self.startViewStatsLabel sizeToFit];
    
    self.startViewMetronumLabel.text=NSLocalizedString(@"MetronumDescription", nil);
    [self.startViewMetronumLabel sizeToFit];
    
    self.startViewTimerLabel.text=NSLocalizedString(@"TimerDescription", nil);
    [self.startViewTimerLabel sizeToFit];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)logOutPush:(id)sender {
   
        [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)settingsPush:(id)sender {
    self.theDataObject=[self theAppDataObject];
}
- (IBAction)presenterPush:(id)sender {
}
- (IBAction)lessonPush:(id)sender {
    self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:1];
}
- (IBAction)exercisesPush:(id)sender {
    self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:2];

}
- (IBAction)statsPush:(id)sender {
    self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:3];

}
- (IBAction)metronumPush:(id)sender {
    [self performSegueWithIdentifier:@"LoginToMetronum" sender:self];
}
- (IBAction)timerPush:(id)sender {
       [self performSegueWithIdentifier:@"LoginToTimer" sender:self];
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
