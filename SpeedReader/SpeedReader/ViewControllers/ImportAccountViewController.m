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

-(void)viewDidAppear:(BOOL)animated
{
    self.theDataObject = [self theAppDataObject];
    
    if([self.theDataObject.importUserList count]!=0)
    {
    self.importAccountFileLocalizationField.text=[[[self.theDataObject.importUserList valueForKeyPath:@"name"]description] stringByAppendingString:@".zip"];
    self.importAccountLoginField.text=[[self.theDataObject.importUserList valueForKeyPath:@"name"]description];
    self.importAccountName.text=[[self.theDataObject.importUserList valueForKeyPath:@"name"]description];
    [self.importAccountName sizeToFit];
    }
    
    /////FIXIFIXIFIXFIXFIXIFXIF
    //UIImage*image=[UIImage imageWithData: [self.theDataObject.importUserList lastObject]];
   /* NSString* test =[[NSString alloc]initWithData:[self.theDataObject.importUserList lastObject] encoding:NSUTF8StringEncoding];
     self.theDataObject.chooseImage=[UIImage imageWithData:[self.theDataObject.importUserList lastObject]];
    if ( self.theDataObject.chooseImage) {
         [self.importAccountImage setImage: self.theDataObject.chooseImage];
    }*/
   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //    self.theDataObject = [self theAppDataObject];
    //    self.importAccountFileLocalizationField.text=[[self.theDataObject.importUserList firstObject]stringByAppendingString:@".zip"];
    //    self.importAccountLoginField.text=[self.theDataObject.importUserList firstObject];
    //}
    [self cleanView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.theDataObject.importUserList=nil;
    [self cleanView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.importAccountDescription.text=NSLocalizedString(@"Imports account", nil);
    [self.importAccountDescription sizeToFit];
    
    self.importAccountInfo.text=NSLocalizedString(@"Choose file with user settings and click import", nil);
    [self.importAccountInfo sizeToFit];
    self.importAccountFileLocalization.text=NSLocalizedString(@"File", nil);
    [self.importAccountFileLocalization sizeToFit];
    
    [self.importAccountButton setTitle:NSLocalizedString(@"Choose file", nil) forState:UIControlStateNormal];
    [self.importAccountButton sizeToFit];
    self.importAccountLogin.text=NSLocalizedString(@"Account name", nil);
    [self.importAccountLogin sizeToFit];
    self.importAccountPasswordDescription.text=NSLocalizedString(@"Add password ?", nil);
    [self.importAccountPasswordDescription sizeToFit];
    self.importAccountPassword.text=NSLocalizedString(@"Password", nil);
    [self.importAccountPassword sizeToFit];
    self.importAccountRePassword.text=NSLocalizedString(@"Repeat password", nil);
    [self.importAccountRePassword sizeToFit];
    [self.importUserButton setTitle:NSLocalizedString(@"Import account", nil) forState:UIControlStateNormal];
    [self.importUserButton sizeToFit];
    
    
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
    [self.importAccountPasswordCheckBox setOn:NO];
    self.importAccountPasswordField.text=@"";
    self.importAccountRePasswordField.text=@"";
    self.importAccountName.text=@"";
    self.theDataObject = [self theAppDataObject];
    NSString*key=@"image0";
    for (ImageForDB* image in self.theDataObject.imageUser) {
        if([image.imageName isEqualToString:key])
            self.theDataObject.chooseImage=[UIImage imageWithData:image.imageData];
    }
    
    [self.importAccountImage setImage: self.theDataObject.chooseImage];
    [self.importAccountImageTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];

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
    if((self.importAccountFileLocalizationField.text && self.importAccountFileLocalizationField.text.length > 0))
    {
        if (![[self.theDataObject.importUserList valueForKeyPath:@"name"]isEqualToString:self.importAccountLoginField.text]) {
            self.theDataObject.unique=true;
                  NSDate* createAccountDate=[self.theDataObject.importUserList valueForKeyPath:@"date"];
            [self.theDataObject.importUserList removeAllObjects];
            [self.theDataObject.importUserList setObject:self.importAccountLoginField.text forKey:@"name" ];
            [self.theDataObject.importUserList setObject:self.importAccountImage.image forKey:@"image" ];
            [self.theDataObject.importUserList setObject:createAccountDate forKey:@"date"];
            

        }
        
        if(self.theDataObject.unique)
        {
            
            if ([self.importAccountPasswordCheckBox isOn]) {
                
                
                if([self checkPassword])
                {
                    UserAccountForDB *user = [[UserAccountForDB alloc ]initAccountWithLogin:[self.theDataObject.importUserList valueForKeyPath:@"name"] andImage:[self.theDataObject.importUserList valueForKeyPath:@"image"]  andPassword:self.importAccountPasswordField.text withDate:[self.theDataObject.importUserList valueForKeyPath:@"date"]];
                    
                    [self.theDataObject.actuallUserList addObject:user];
                    [self cleanView];
                    
                    self.tabBarController.selectedViewController= [self.tabBarController.viewControllers objectAtIndex:0];
                }else
                {
                    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                                         message:NSLocalizedString(@"You put diffrent password in repeat password field", nil)
                                                                        delegate:nil
                                                               cancelButtonTitle:@"Ok"
                                                               otherButtonTitles:nil];
                    errorAlert.show;
                }
            }
            else
            {
                  UserAccountForDB *user = [[UserAccountForDB alloc ]initAccountWithLogin:[self.theDataObject.importUserList valueForKeyPath:@"name"] andImage:[self.theDataObject.importUserList valueForKeyPath:@"image"]  andPassword:nil withDate:[self.theDataObject.importUserList valueForKeyPath:@"date"]];
                
                [self.theDataObject.actuallUserList addObject:user];
                
                [self cleanView];
                
                self.tabBarController.selectedViewController= [self.tabBarController.viewControllers objectAtIndex:0];
            }
        }
        else
        {
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"User already exsist choose other login or delete exist account", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"First you have to choose file to import", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.theDataObject.imageUser count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"imageCell";
    ImageTableViewCell *cell=(ImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  
    NSString*key=[NSString stringWithFormat: @"image%d", (int)indexPath.row];
     cell.userImage=[UIImage imageWithData:[self.theDataObject.imageUser[indexPath.row]imageData]];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [imgView setImage:cell.userImage];
    [cell addSubview:imgView];
      return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString*key=[NSString stringWithFormat: @"image%d", (int)indexPath.row];
    self.theDataObject.chooseImage=[UIImage imageWithData:[self.theDataObject.imageUser[indexPath.row] imageData]];
  //   self.theDataObject.chooseImage=[self.theDataObject.imageUser objectForKey:key];
    [self.importAccountImage setImage: self.theDataObject.chooseImage];
}

- (IBAction)addPicturePush:(id)sender {
    if (self.picker == nil) {
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading picker";
        
        dispatch_queue_t concurrentQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        
        dispatch_async(concurrentQueue, ^{
            
            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.picker.allowsEditing = NO;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:_picker animated:YES completion:nil];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
        });
        
    }  else {
        [self presentViewController:_picker animated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Adding image to app";
    
    dispatch_queue_t concurrentQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_async(concurrentQueue, ^{
        
        self.theDataObject.chooseImage=fullImage;
        NSString* description =[NSString stringWithFormat:@"image%d",(int)[self.theDataObject.imageUser count]];
        [ImageForDB initAccountWithName:description andImage:fullImage];
        [self.theDataObject createImageUserArray];
        [self.importAccountImageTable reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.importAccountImage setImage:self.theDataObject.chooseImage];
        });
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
