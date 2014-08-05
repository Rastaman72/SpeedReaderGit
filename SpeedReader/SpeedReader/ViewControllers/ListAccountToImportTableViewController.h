//
//  ListAccountToImportTableViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserAccountForDB.h"
@interface ListAccountToImportTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *accountList;
@property(nonatomic,strong) NSMutableArray* accountsToImport;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backToListButton;
- (IBAction)backToListPush:(id)sender;
@end
