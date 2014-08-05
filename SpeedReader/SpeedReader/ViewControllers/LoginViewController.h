//
//  LoginViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountTable.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface LoginViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITabBarItem *loginTabBar;
- (IBAction)loginPush:(id)sender;
@property (weak, nonatomic) IBOutlet AccountTable *accountTable;
@property(nonatomic,retain)NSMutableArray* userList;
@property(nonatomic,assign)int chooseUser;
@property(nonatomic,strong)SharedData* theDataObject;
@property(nonatomic,strong)NSString* passwordPutByUser;
@end
