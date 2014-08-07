//
//  AddAccountViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "UserParser.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
#import "UserAccountForDB.h"
@interface AddAccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *addAccountImage;
@property (weak, nonatomic) IBOutlet UILabel *addAccountDescription;
@property (weak, nonatomic) IBOutlet UILabel *addAccountName;
@property (weak, nonatomic) IBOutlet UILabel *addAccountLogin;
@property (weak, nonatomic) IBOutlet UITextField *addAccountLoginField;
@property (weak, nonatomic) IBOutlet UISwitch *addAccountPasswordCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *addAccountPasswordDescription;
@property (weak, nonatomic) IBOutlet UILabel *addAccountPassword;
@property (weak, nonatomic) IBOutlet UITextField *addAccountPasswordField;

@property (weak, nonatomic) IBOutlet UILabel *addAccountRePassword;
@property (weak, nonatomic) IBOutlet UITextField *addAccountRePasswordField;
@property (weak, nonatomic) IBOutlet UIButton *addAccountButton;
- (IBAction)addAccountPush:(id)sender;

- (IBAction)passwordSet:(id)sender;
@property(nonatomic,retain)UserAccountForDB* theNewAccount;
@property(nonatomic,strong)SharedData* theDataObject;
@end
