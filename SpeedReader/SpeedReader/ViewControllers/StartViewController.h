//
//  StartViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface StartViewController : UIViewController

//navigation bar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
- (IBAction)logOutPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *settingsBUtton;
- (IBAction)settingsPush:(id)sender;
@property(nonatomic,strong)SharedData* theDataObject;


//view part
@property (weak, nonatomic) IBOutlet UIImageView *startViewUserImage;
@property (weak, nonatomic) IBOutlet UILabel *startViewWelcome;
@property (weak, nonatomic) IBOutlet UILabel *startViewUserLogin;
@property (weak, nonatomic) IBOutlet UILabel *startViewTimeSpend;

@property (weak, nonatomic) IBOutlet UIButton *startViewPresenterButton;
- (IBAction)presenterPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *startViewPresenterLabel;


@property (weak, nonatomic) IBOutlet UIButton *startViewLessonButton;
- (IBAction)lessonPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *startViewLessonLabel;

@property (weak, nonatomic) IBOutlet UIButton *startViewExercisesButton;
- (IBAction)exercisesPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *startViewExercisesLabel;

@property (weak, nonatomic) IBOutlet UIButton *startViewStatsButton;
- (IBAction)statsPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *startViewStatsLabel;

@property (weak, nonatomic) IBOutlet UIButton *startViewMetronumButton;
- (IBAction)metronumPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *startViewMetronumLabel;

@property (weak, nonatomic) IBOutlet UIButton *startViewTimerButton;
- (IBAction)timerPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *startViewTimerLabel;



@end
