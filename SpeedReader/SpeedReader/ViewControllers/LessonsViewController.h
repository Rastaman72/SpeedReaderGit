//
//  LessonsViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewTableViewController.h"
#import "RightViewController.h"

@interface LessonsViewController : UISplitViewController
@property(nonatomic,retain)UINavigationController* left;
@property(nonatomic,retain)LeftViewTableViewController* root;
@property(nonatomic,retain)RightViewController* detail;

@end
