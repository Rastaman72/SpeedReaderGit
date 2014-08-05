//
//  ImportAccountViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ImportAccountViewController.h"

#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ImportAccountViewController ()

@end

@implementation ImportAccountViewController

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
    self.importAccountFileLocalizationField.text=[[self.theDataObject.importUserList firstObject]stringByAppendingString:@".zip"];
    self.importAccountLoginField.text=[self.theDataObject.importUserList firstObject];
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

-(void)importAccountPush:(id)sender
{
    [self performSegueWithIdentifier:@"ImportToListAccount" sender:self];
}

- (void)cleanView {
    self.importAccountFileLocalizationField.text=@"";
    self.importAccountLoginField.text=@"";
    self.importAccountImage=nil;
    [self.importAccountPasswordCheckBox setOn:NO];
    self.importAccountPasswordField.text=@"";
    self.importAccountRePasswordField.text=@"";
}

-(BOOL)checkPassword
{
    NSString* password=self.importAccountPasswordField.text;
    NSString* rePassword=self.importAccountRePasswordField.text;
    
    password=[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    rePassword=[rePassword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return [password isEqualToString:rePassword];

    
}
- (IBAction)addUserPush:(id)sender {
    if ([self.importAccountPasswordCheckBox isOn]) {
    
    
    if([self checkPassword])
    {
       UserAccountForDB *user = [[UserAccountForDB alloc ]initAccountWithLogin:[self.theDataObject.importUserList firstObject] andImage:[self.theDataObject.importUserList lastObject]  andPassword:self.importAccountPasswordField.text];

    [self.theDataObject.actuallUserList addObject:user];
        [self cleanView];
        
        self.tabBarController.selectedViewController= [self.tabBarController.viewControllers objectAtIndex:0];
    }else
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:@"You put diffrent password in repeat password field"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
            errorAlert.show;
        }
    }
    else
    {
        UserAccountForDB *user = [[UserAccountForDB alloc ]initAccountWithLogin:[self.theDataObject.importUserList firstObject] andImage:[self.theDataObject.importUserList lastObject]  andPassword:nil];
        //[theDataObject.actuallUserList addObject:user];

    [self.theDataObject.actuallUserList addObject:user];
    
        [self cleanView];
    
    self.tabBarController.selectedViewController= [self.tabBarController.viewControllers objectAtIndex:0];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ImportToListAccount"]){
        [self loadUsersList];
        ListAccountToImportTableViewController *LACTIVC = (ListAccountToImportTableViewController *)segue.destinationViewController;
        LACTIVC.accountsToImport=[[NSMutableArray alloc]init];
        [LACTIVC.accountsToImport addObjectsFromArray:self.userAccounts];
    }
}

-(void)loadUsersList
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    self.userAccounts=[[NSMutableArray alloc]init];
    for (id toAddUser in fileList) {
        if([toAddUser rangeOfString:@".zip"].location !=NSNotFound)
        {
            [self.userAccounts addObject:toAddUser];
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

- (IBAction)passwordSet:(id)sender {
    if([self.importAccountPasswordCheckBox isOn])
    {
        self.importAccountPasswordField.enabled=YES;
        self.importAccountRePasswordField.enabled=YES;
    }
    else
    {
        self.importAccountPasswordField.enabled=NO;
        self.importAccountRePasswordField.enabled=NO;
    }
}


-(BOOL)importData:(NSData*)zippedData
{
    return true;
}

- (BOOL)importFromURL:(NSURL *)importURL {
    NSData *zippedData = [NSData dataWithContentsOfURL:importURL];
    return [self importData:zippedData];
}


@end
