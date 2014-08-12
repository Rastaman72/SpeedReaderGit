//
//  DeleteAccountViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "DeleteAccountViewController.h"
#import "AccountTableCellTableViewCell.h"
#import "UserAccountForDB.h"

#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface DeleteAccountViewController ()

@end

@implementation DeleteAccountViewController

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
    [self.deleteAccountDeleteButton setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateNormal];
    [self.deleteAccountDeleteButton sizeToFit];
    self.toDelete=-1;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.theDataObject = [self theAppDataObject];
    self.userList=[[NSMutableArray alloc]initWithArray:self.theDataObject.actuallUserList];
    [self.accountTable reloadData];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _toDelete=indexPath.row;
}

- (IBAction)deletePush:(id)sender {
    if(self.toDelete!=-1)
    {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Delete", nil)
                                                         message:NSLocalizedString(@"Are you sure ?", nil)
                                                        delegate:self
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:NSLocalizedString(@"Back", nil),nil];
    errorAlert.show;
    }
    else
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"First choose user", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alert cancelButtonIndex])
    {
        
        self.theDataObject = [self theAppDataObject];
        
        NSManagedObjectContext *context = self.theDataObject.managedObjectContext;
        [context deleteObject:[self.theDataObject.actuallUserList objectAtIndex:self.toDelete]];
        NSError* error;
        [context save:&error];
        [self.theDataObject.actuallUserList removeObjectAtIndex:self.toDelete];
        
        
        self.userList=[[NSMutableArray alloc]initWithArray:self.theDataObject.actuallUserList];
        [self.accountTable reloadData];
        self.toDelete=-1;
		
        
    }
}


- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
