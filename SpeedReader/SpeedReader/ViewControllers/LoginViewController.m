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
    
        // Do any additional setup after loading the view.
    
//    UserAccount* test=[UserAccount initAccountWithLogin:@"Test1" andImage:@"Test1"];
//    [_userList addObject:test];
  
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
    
    AccountTableCellTableViewCell *cell=(AccountTableCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    
    UserAccountForDB* account=(self.userList)[indexPath.row];
    
    NSString* name=[NSString stringWithFormat:@"%@",account.login];
    //NSString* image=[NSString stringWithFormat:@"%@",account.userImage];
    
    cell.accountLogin.text=name;
    cell.accountImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@",account.userImage]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.chooseUser=indexPath.row;
}

- (IBAction)loginPush:(id)sender {
    if (self.chooseUser==-1) {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"First choose user" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if(![[[self.theDataObject.actuallUserList objectAtIndex:self.chooseUser]password]isEqualToString:@""])
        {
        UIAlertView* putPassword=[[UIAlertView alloc]initWithTitle:@"Security" message:@"Put password please" delegate:self cancelButtonTitle:@"Login" otherButtonTitles:@"Back", nil];
        
        putPassword.alertViewStyle = UIAlertViewStylePlainTextInput;
        [putPassword show];
        }
        else
              [self performSegueWithIdentifier:@"LoginToLesson" sender:self];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        UITextField *passwordField = [alertView textFieldAtIndex:0];
        if([[[self.theDataObject.actuallUserList objectAtIndex:self.chooseUser]password]isEqualToString:passwordField.text])
        {
            [self performSegueWithIdentifier:@"LoginToLesson" sender:self];

           }
        else
        {
            UIAlertView* putPassword=[[UIAlertView alloc]initWithTitle:@"Security" message:@"You put bad password" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            
            [putPassword show];
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
