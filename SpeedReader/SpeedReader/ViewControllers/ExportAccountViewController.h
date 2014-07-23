//
//  ExportAccountViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountTable.h"
#import "AppDelegate.h"
#import "ExportDetailViewController.h"

#import "GDataXMLNode.h"
@interface ExportAccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITabBarItem *exportTabBar;
- (IBAction)exportPush:(id)sender;
@property (weak, nonatomic) IBOutlet AccountTable *accountTable;
@property(nonatomic,retain)NSMutableArray* userList;
@property(nonatomic,retain)AppDelegate *delegate;
@property(nonatomic,assign)int toExport;
@end
