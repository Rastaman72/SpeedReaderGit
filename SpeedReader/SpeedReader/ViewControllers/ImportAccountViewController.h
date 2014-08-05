//
//  ImportAccountViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccountForDB.h"
#import "GDataXMLNode.h"
#import "UserParser.h"
#import "ListAccountToImportTableViewController.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ImportAccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *importAccountFileLocalizationField;
@property (weak, nonatomic) IBOutlet UILabel *importAccountFileLocalization;
@property (weak, nonatomic) IBOutlet UIImageView *importAccountImage;
@property (weak, nonatomic) IBOutlet UILabel *importAccountDescription;
@property (weak, nonatomic) IBOutlet UILabel *importAccountName;
@property (weak, nonatomic) IBOutlet UILabel *importAccountLogin;
@property (weak, nonatomic) IBOutlet UITextField *importAccountLoginField;
@property (weak, nonatomic) IBOutlet UISwitch *importAccountPasswordCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *importAccountPasswordDescription;
@property (weak, nonatomic) IBOutlet UILabel *importAccountPassword;
@property (weak, nonatomic) IBOutlet UITextField *importAccountPasswordField;

@property (weak, nonatomic) IBOutlet UILabel *importAccountRePassword;
@property (weak, nonatomic) IBOutlet UITextField *importAccountRePasswordField;
- (IBAction)passwordSet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *importAccountButton;
- (IBAction)importAccountPush:(id)sender;
- (IBAction)addUserPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addUserButton;
@property(nonatomic,strong)NSMutableArray * userAccounts;

@property(nonatomic,retain)UserAccountForDB* theNewAccount;
@property(nonatomic,strong)SharedData* theDataObject;

- (BOOL)importFromURL:(NSURL *)importURL;
@end
