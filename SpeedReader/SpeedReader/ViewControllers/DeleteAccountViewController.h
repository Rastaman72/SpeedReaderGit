//
//  DeleteAccountViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountTable.h"
#import "AppDelegate.h"

@interface DeleteAccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITabBarItem *deleteTabBar;
- (IBAction)deletePush:(id)sender;
@property (weak, nonatomic) IBOutlet AccountTable *accountTable;
@property(nonatomic,retain)NSMutableArray* userList;
@property(nonatomic,strong) SharedData* theDataObject;
@property(nonatomic,assign)int toDelete;
@property (weak, nonatomic) IBOutlet UIButton *deleteAccountDeleteButton;

@end
