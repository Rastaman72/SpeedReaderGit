//
//  AddAccountViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "AddAccountViewController.h"
#import "LoginViewController.h"

@interface AddAccountViewController ()

@end

@implementation AddAccountViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddAccountToLogin"]){
        LoginViewController *LVC = (LoginViewController *)segue.destinationViewController;
        [LVC.userList addObject:_theNewAccount];
    }
}


- (IBAction)addAccountPush:(id)sender {
    if([_addAccountPasswordCheckBox isOn])
    {
        if([_addAccountPasswordField.text isEqualToString:_addAccountRePasswordField.text])
        {
            self.theNewAccount=[UserAccount initAccountWithLogin:_addAccountLoginField.text andImage:nil andPassword:_addAccountPasswordField.text];
        }
    }
    else
        self.theNewAccount=[UserAccount initAccountWithLogin:_addAccountLoginField.text andImage:nil andPassword:nil];
    [self performSegueWithIdentifier:@"AddAccountToLogin" sender:self];
}
@end
