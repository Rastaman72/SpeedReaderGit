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


- (void)saveUser {
    NSError* error;
    
       NSManagedObjectContext *context =  self.theDataObject.managedObjectContext;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    fetch.predicate = [NSPredicate predicateWithFormat:@"login == %@", [[self.theNewAccount valueForKey:@"login"]description]];
    NSArray *array = [context executeFetchRequest:fetch error:nil];
    
    if ([array count] == 0)
    {
       
        SettingsForDB* userSettings =[NSEntityDescription
                                      insertNewObjectForEntityForName:@"TeacherSettings"
                                      inManagedObjectContext:context];
        userSettings.interface=[[NSNumber alloc]initWithInt:1];
        userSettings.lastUsedText==[[NSNumber alloc]initWithInt:0];
        userSettings.lastLessonDone==[[NSNumber alloc]initWithInt:-1];
        
        UserAccountForDB *userInfo = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"User"
                                      inManagedObjectContext:context];
        userInfo.login=self.theNewAccount.login;
        userInfo.userImage=self.theNewAccount.userImage;
        userInfo.password=self.theNewAccount.password;
        userInfo.settings=userSettings;
        
        
//        userInfo.login=[self.theNewAccount valueForKey:@"login"];
//        userInfo.userImage=[self.theNewAccount valueForKey:@"userImage"];
//        userInfo.password=[self.theNewAccount valueForKey:@"password"];
        
        if (![context save:&error])
        {
            
        }
        else
        {
            [self.theDataObject.actuallUserList addObject:userInfo];
        }
    
    
    
    /*
     
     TO sie przydza dopeior podczas eksportu
     
     */
    /*
    //create user.xml
    NSData *user =[UserParser saveUser:_theNewAccount];
   // NSData *user = [_theNewAccount.login dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:_theNewAccount.login];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    
    NSString *filePath = [dataPath stringByAppendingPathComponent:@"user.xml"]; //Add the file name
    [user writeToFile:filePath atomically:YES];
    
    
    //create settings.xml
    [self saveSettings];
     */
}
}


-(void)saveSettings
{
    NSData *user =[UserParser saveSettings];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:_theNewAccount.login];
    NSString *filePath = [dataPath stringByAppendingPathComponent:@"settings.xml"]; //Add the file name
    [user writeToFile:filePath atomically:YES];

    
    
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
    [[self navigationController]popToRootViewControllerAnimated:YES];
    
    self.theDataObject = [self theAppDataObject];
    [self.theDataObject.actuallUserList addObject:self.theNewAccount];
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [delegate.myProperty addObject:_theNewAccount];
//    
    [self saveUser]; //Write the file
   
    self.tabBarController.selectedViewController= [self.tabBarController.viewControllers objectAtIndex:0];
}

-(void)cleanView
{
    _addAccountLoginField.text=@"";
    [_addAccountPasswordCheckBox setOn:NO];
    _addAccountRePasswordField.text=@"";
    _addAccountRePasswordField.text=@"";
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
