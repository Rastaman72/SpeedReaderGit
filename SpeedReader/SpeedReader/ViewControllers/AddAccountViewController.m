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

-(void)viewWillAppear:(BOOL)animated
{
    [self cleanView];
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
        LVC.userList=[[NSMutableArray alloc]init];
        [LVC.userList addObject:_theNewAccount];
    }
}



    /*
     
     TO sie przydza dopeior podczas eksportu
     
     */
    /*
    //create user.xml
   
     */
//}


- (IBAction)addAccountPush:(id)sender {
    if(![self.addAccountLoginField.text isEqualToString:@""])
    {
        if([_addAccountPasswordCheckBox isOn])
        {
            if(![self.addAccountPasswordField.text isEqualToString:@""] && ![self.addAccountRePasswordField.text isEqualToString:@""])
            {
                if([_addAccountPasswordField.text isEqualToString:_addAccountRePasswordField.text])
                {
                    self.theNewAccount=[[UserAccountForDB alloc ]initAccountWithLogin:_addAccountLoginField.text andImage:nil andPassword:_addAccountPasswordField.text];
                }
                else
                {
                    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Password dosen't the same" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                    return;
                }
            }
            else
            {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                     message:@"Field password or repassword cannot be empty"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                errorAlert.show;
                return;
            }
        }
        else
            self.theNewAccount=[[UserAccountForDB alloc] initAccountWithLogin:_addAccountLoginField.text andImage:nil andPassword:nil];
        
        
        
        self.theDataObject = [self theAppDataObject];
        if(self.theNewAccount !=nil)
        {
            [self.theDataObject.actuallUserList addObject:self.theNewAccount];
            self.tabBarController.selectedViewController= [self.tabBarController.viewControllers objectAtIndex:0];
        }
        else
        {
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"User already exsist" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        //Write the file
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Field login cannot be empty"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        errorAlert.show;
    }
}

-(void)cleanView
{
    _addAccountLoginField.text=@"";
    [_addAccountPasswordCheckBox setOn:NO];
    _addAccountPasswordField.text=@"";
    _addAccountRePasswordField.text=@"";
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (IBAction)passwordSet:(id)sender {
    if([self.addAccountPasswordCheckBox isOn])
    {
        self.addAccountPasswordField.enabled=YES;
        self.addAccountRePasswordField.enabled=YES;
    }
    else
    {
        self.addAccountPasswordField.enabled=NO;
        self.addAccountRePasswordField.enabled=NO;
    }
}


@end
