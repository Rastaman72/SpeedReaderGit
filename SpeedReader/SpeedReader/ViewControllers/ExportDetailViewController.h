//
//  ExportDetailViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccount.h"
@interface ExportDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *selectFolder;
- (IBAction)selectPush:(id)sender;
@property(nonatomic,retain)UserAccount* userToExport;
@end