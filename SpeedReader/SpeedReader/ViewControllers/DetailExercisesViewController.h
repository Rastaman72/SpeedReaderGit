//
//  DetailExercisesViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExercisesSelectionDelegate.h"
@class ExercisesData;
@interface DetailExercisesViewController : UIViewController<ExercisesSelectionDelegate,UISplitViewControllerDelegate>

@property(nonatomic,retain)ExercisesData* exercisesData;
@property (weak, nonatomic) IBOutlet UIImageView *detailExercisesUserImage;
@property (weak, nonatomic) IBOutlet UITextView *detailExercisesDecription;
@property (weak, nonatomic) IBOutlet UILabel *detailExercisesHeader;

@property (nonatomic, weak) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, strong) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
- (IBAction)logOutPush:(id)sender;
-(void)setExercises:(ExercisesData *)exercises;
@end
