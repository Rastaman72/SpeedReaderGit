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
    
    AccountTableCellTableViewCell *cell=(AccountTableCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    
    UserAccountForDB* account=(self.userList)[indexPath.row];
    
    NSString* name=[NSString stringWithFormat:@"%@",account.login];
    //NSString* image=[NSString stringWithFormat:@"%@",account.userImage];
    
    cell.accountLogin.text=name;
    cell.accountImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@",account.userImage]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    AccountTableCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    _toDelete=[[NSString alloc]init];
//    _toDelete = cell.accountLogin.text;
    _toDelete=indexPath.row;
   }

- (IBAction)deletePush:(id)sender {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Delete", nil)
                                                         message:NSLocalizedString(@"Are you sure ?", nil)
                                                        delegate:self
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:NSLocalizedString(@"Back", nil),nil];
    errorAlert.show;
    
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        
        self.theDataObject = [self theAppDataObject];
        
        NSManagedObjectContext *context = self.theDataObject.managedObjectContext;
        [context deleteObject:[self.theDataObject.actuallUserList objectAtIndex:self.toDelete]];
        NSError* error;
        [context save:&error];
        [self.theDataObject.actuallUserList removeObjectAtIndex:self.toDelete];
        
        
        self.userList=[[NSMutableArray alloc]initWithArray:self.theDataObject.actuallUserList];
        [self.accountTable reloadData];
		
        
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
