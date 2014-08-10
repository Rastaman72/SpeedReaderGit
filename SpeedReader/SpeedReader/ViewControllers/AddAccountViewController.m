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
    self.addAccountDescription.text=NSLocalizedString(@"Welcome", nil);
    [self.addAccountDescription sizeToFit];
    
    self.addAccountName.text=NSLocalizedString(@"If you want add account, first fill all fields", nil);
    [self.addAccountName sizeToFit];
    
    self.addAccountLogin.text=NSLocalizedString(@"Put your name", nil);
    [self.addAccountLogin sizeToFit];
    
    self.addAccountPasswordDescription.text=NSLocalizedString(@"Add password ?", nil);
    [self.addAccountPasswordDescription sizeToFit];
    
    self.addAccountPassword.text=NSLocalizedString(@"Password", nil);
    [self.addAccountPassword sizeToFit];
    
    self.addAccountRePassword.text=NSLocalizedString(@"Repeat password", nil);
    [self.addAccountRePassword sizeToFit];
    [self.addAccountButton setTitle:NSLocalizedString(@"Create account", nil) forState:UIControlStateNormal];
    [self.addAccountButton sizeToFit];
    // Do any additional setup after loading the view.
      self.theDataObject = [self theAppDataObject];
    self.theDataObject.chooseImage=[UIImage imageWithData:[[self.theDataObject.imageUser objectAtIndex:0]imageData]];
  

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
        [self.addAccountImageTable reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.addAccountImage setImage:self.theDataObject.chooseImage];
        });
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)addAccountPush:(id)sender {
    if(![self.addAccountLoginField.text isEqualToString:@""])
    {
        if([_addAccountPasswordCheckBox isOn])
        {
            if(![self.addAccountPasswordField.text isEqualToString:@""] && ![self.addAccountRePasswordField.text isEqualToString:@""])
            {
                if([_addAccountPasswordField.text isEqualToString:_addAccountRePasswordField.text])
                {
                    self.theNewAccount=[[UserAccountForDB alloc ]initAccountWithLogin:self.addAccountLoginField.text andImage:self.theDataObject.chooseImage andPassword:self.addAccountPasswordField.text];
                }
                else
                {
                    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Passwords don't match", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                    return;
                }
            }
            else
            {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                                     message:NSLocalizedString(@"Fields password and repassword cannot be empty", nil)
                                                                    delegate:nil
                                                           cancelButtonTitle:@"Ok"
                                                           otherButtonTitles:nil];
                errorAlert.show;
                return;
            }
        }
        else
            self.theNewAccount=[[UserAccountForDB alloc] initAccountWithLogin:self.addAccountLoginField.text andImage:self.theDataObject.chooseImage andPassword:nil];
        if(self.theNewAccount !=nil)
        {
            [self.theDataObject.actuallUserList addObject:self.theNewAccount];
            self.tabBarController.selectedViewController= [self.tabBarController.viewControllers objectAtIndex:0];
        }
        else
        {
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"User already exsist", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                             message:NSLocalizedString(@"Field login cannot be empty", nil)
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
   // self.theDataObject = [self theAppDataObject];
    self.theDataObject.key=@"image0";
    for (ImageForDB* image in self.theDataObject.imageUser) {
        if([image.imageName isEqual:@"image0"])
            [self.addAccountImage setImage:[UIImage imageWithData:image.imageData]];
    }
//     self.theDataObject.chooseImage=[self.theDataObject.imageUser objectForKey:self.theDataObject.key];
//    [self.addAccountImage setImage:self.theDataObject.chooseImage];
    [self.addAccountImageTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];

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
    
    ImageTableViewCell *cell=(ImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"imageCell"];
    
    NSString*key=[NSString stringWithFormat: @"image%d", (int)indexPath.row];

    
    cell.userImage=[UIImage imageWithData:[self.theDataObject.imageUser[indexPath.row] imageData]];
    
    for (ImageForDB* image in self.theDataObject.imageUser) {
        if([image.imageName isEqual:@"image0"])
            [self.addAccountImage setImage:[UIImage imageWithData:image.imageData]];
    }
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [imgView setImage:cell.userImage];
    [cell addSubview:imgView];
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString* key=@"image";
//    key=[key stringByAppendingString:[NSString stringWithFormat: @"%d", (int)indexPath.row]];
//    key=[key stringByAppendingString:@".jpg"];
    
    self.theDataObject.key=[NSString stringWithFormat: @"image%d", (int)indexPath.row];
   
    //self.chooseImage=[self.theDataObject.imageUser objectForKey:self.theDataObject.key];
    
    self.theDataObject.chooseImage=[UIImage imageWithData:[self.theDataObject.imageUser[indexPath.row] imageData]];
    
    [self.addAccountImage setImage:self.theDataObject.chooseImage];
    
}


@end
