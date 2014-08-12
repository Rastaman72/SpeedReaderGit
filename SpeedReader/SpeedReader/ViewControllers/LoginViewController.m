//
//  LoginViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "LoginViewController.h"
#import "LessonsViewController.h"
#import "AccountTableCellTableViewCell.h"
#import "UserAccountForDB.h"


@interface LoginViewController ()

@end

@implementation LoginViewController



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
    self.theDataObject = [self theAppDataObject];
    
  
    
    NSManagedObjectContext *context =  self.theDataObject.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    self.userList=[self.theDataObject.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.theDataObject.actuallUserList=[[NSMutableArray alloc]initWithArray:self.userList];
    [self.accountTable reloadData];
    self.chooseUser=-1;
}
- (void)viewDidLoad
{

    
    
    [super viewDidLoad];
    [self.loginViewLoginButton setTitle:NSLocalizedString(@"Login", nil)forState:UIControlStateNormal];
        // Do any additional setup after loading the view.
    

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.userList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AccountCell";
    AccountTableCellTableViewCell *cell=(AccountTableCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UserAccountForDB* account=(self.userList)[indexPath.row];
    
    NSString* name=[NSString stringWithFormat:@"%@",account.login];
    //NSString* image=[NSString stringWithFormat:@"%@",account.userImage];
    
    cell.accountLogin.text=name;
    [cell.accountLogin sizeToFit];
    UIImage* image=[UIImage imageWithData:account.userImage];
    [cell.accountImage setImage:image];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.theDataObject.loginUser=[self.theDataObject.actuallUserList objectAtIndex:indexPath.row];
    self.chooseUser=indexPath.row;
}

- (IBAction)loginPush:(id)sender {
    if (self.chooseUser==-1) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"First choose user", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if(![[[self.theDataObject.actuallUserList objectAtIndex:self.chooseUser]password]isEqualToString:@""])
        {
        UIAlertView* putPassword=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Security", nil) message:NSLocalizedString(@"Put password please", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Login", nil) otherButtonTitles:NSLocalizedString(@"Back", nil), nil];
        
        putPassword.alertViewStyle = UIAlertViewStylePlainTextInput;
        [putPassword show];
        }
        else
              [self performSegueWithIdentifier:@"LoginToLesson" sender:self];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.chooseUser!=-1)
    {
    if (buttonIndex == alertView.cancelButtonIndex) {
        UITextField *passwordField = [alertView textFieldAtIndex:0];
        if([[[self.theDataObject.actuallUserList objectAtIndex:self.chooseUser]password]isEqualToString:passwordField.text])
        {
            [self performSegueWithIdentifier:@"LoginToLesson" sender:self];

           }
        else
        {
            UIAlertView* putPassword=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Security", nil) message:NSLocalizedString(@"You put bad password", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            
            [putPassword show];
        }
    }
    }
}
- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
