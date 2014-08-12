//
//  DetailStatisticsViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticsSelectionDelegate.h"
@class StatisticsData;
@interface DetailStatisticsViewController : UIViewController<StatisticsSelectionDelegate,UISplitViewControllerDelegate>

@property(nonatomic,retain)StatisticsData* statisticsData;
@property (weak, nonatomic) IBOutlet UIImageView *detailStatisticsUserImage;
@property (weak, nonatomic) IBOutlet UITextView *detailStatisticsDecription;
@property (weak, nonatomic) IBOutlet UILabel *detailStatisticsHeader;

@property (nonatomic, weak) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, strong) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;

- (IBAction)logOutPush:(id)sender;
@end
