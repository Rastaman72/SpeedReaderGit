//
//  LoginViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountTable.h"
#import "AppDelegate.h"

@interface LoginViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITabBarItem *loginTabBar;
- (IBAction)loginPush:(id)sender;
@property (weak, nonatomic) IBOutlet AccountTable *accountTable;
@property(nonatomic,retain)NSMutableArray* userList;

@end
