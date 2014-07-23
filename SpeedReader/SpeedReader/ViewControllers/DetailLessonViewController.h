//
//  RightViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonSelectionDelegate.h"
@class LessonData;
@interface DetailLessonViewController : UIViewController<LessonSelectionDelegate,UISplitViewControllerDelegate>

@property(nonatomic,retain)LessonData* lesson;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UITextView *decription;
@property (weak, nonatomic) IBOutlet UILabel *header;

@property (nonatomic, weak) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, strong) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
- (IBAction)logOutPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
- (IBAction)settingsPush:(id)sender;

@end
