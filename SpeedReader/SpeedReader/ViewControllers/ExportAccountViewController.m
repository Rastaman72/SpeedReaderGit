//
//  ExportAccountViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExportAccountViewController.h"
#import "AccountTableCellTableViewCell.h"
#import "UserAccountForDB.h"
@interface ExportAccountViewController ()

@end

@implementation ExportAccountViewController

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

    self.userList=[[NSMutableArray alloc]initWithArray:self.theDataObject.actuallUserList];
    [self.accountTable reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.exportAccountButton setTitle:NSLocalizedString(@"Export account", nil) forState:UIControlStateNormal];
    [self.exportAccountButton sizeToFit];
    self.toExport=-1;
    // Do any additional setup after loading the view.
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
    _toExport=indexPath.row;
    self.userToExport=[self.userList objectAtIndex:_toExport];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"exportDetail"]){
        ExportDetailViewController *EDVC = (ExportDetailViewController *)segue.destinationViewController;
        
        
    }
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}





- (void)createZipFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString* folderName=self.userToExport.login;
    folderName=[folderName stringByAppendingString:@".zip"];
    NSString *dataPath = [docsPath stringByAppendingPathComponent:folderName];
    NSData *userXmlData=[[NSData alloc]init];
    NSData *settingsXmlData=[[NSData alloc]init];
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:docsPath error:nil];
    
    
    NSString* docPath=@"/";
    docPath=[docPath stringByAppendingString:self.userToExport.login];
    [self createUserXML:self.userToExport];
    [self createSettingsXML:self.userToExport];
    
    NSString *userDocumentsPath = [[docsPath stringByAppendingString:docPath]
                                   stringByAppendingPathComponent:@"user.xml"];
    NSString *settingsDocumentsPath = [[docsPath stringByAppendingString:docPath]
                                       stringByAppendingPathComponent:@"settings.xml"];
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:userDocumentsPath ])
    {
    }
    else
    {
        userXmlData = [[NSMutableData alloc] initWithContentsOfFile:userDocumentsPath];
        settingsXmlData=[[NSMutableData alloc] initWithContentsOfFile:settingsDocumentsPath];
    }
    
    
    
    self.toExportZIP =[[ZipFile alloc]initWithFileName:dataPath mode:ZipFileModeCreate];
    ZipWriteStream *stream1= [self.toExportZIP writeFileInZipWithName:@"user.xml" fileDate:[NSDate dateWithTimeIntervalSinceNow:-86400.0] compressionLevel:ZipCompressionLevelBest];
    [stream1 writeData:userXmlData];
    [stream1 finishedWriting];
    
    
    ZipWriteStream *stream2= [self.toExportZIP writeFileInZipWithName:@"settings.xml" compressionLevel:ZipCompressionLevelNone];
    [stream2 writeData:settingsXmlData];
    [stream2 finishedWriting];
    [self.toExportZIP close];
}




-(void)createUserXML:(UserAccountForDB*)toExport
{
    NSError* error;
    NSData *user =[UserParser saveUser:toExport];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:toExport.login];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    
    NSString *filePath = [dataPath stringByAppendingPathComponent:@"user.xml"]; //Add the file name
    [user writeToFile:filePath atomically:YES];
    
}

-(void)createSettingsXML:(UserAccountForDB*)toExport
{
    NSData *user =[UserParser saveSettings];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:toExport.login];
    NSString *filePath = [dataPath stringByAppendingPathComponent:@"settings.xml"]; //Add the file name
    [user writeToFile:filePath atomically:YES];
}

- (IBAction)mailPush:(id)sender {
    if ( self.toExport!=-1) {
    
    UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                   initWithTitle:@""
                                   delegate:self
                                   cancelButtonTitle:@"Cancel"
                                   destructiveButtonTitle:nil
                                   otherButtonTitles: NSLocalizedString(@"Export via File Sharing", nil),NSLocalizedString(@"Export via Email", nil), nil] autorelease];
    [actionSheet showInView:self.view];
    }
    else
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"First choose user", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
//    if(self.toExport!=-1)
//    {
    
//            [self performSegueWithIdentifier:@"exportDetail" sender:self];
//        }
    
    
    
    if (buttonIndex == actionSheet.firstOtherButtonIndex + 0) {
        [self createZipFile];
        self.toExport=-1;
    }
    else if (buttonIndex == actionSheet.firstOtherButtonIndex + 1) {
        [self createZipFile];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath= [documentsDirectory stringByAppendingPathComponent:[self.userToExport.login stringByAppendingString:@".zip"]];
        NSData *data = [NSData dataWithContentsOfFile:writableDBPath];
        
        MFMailComposeViewController *picker = [[[MFMailComposeViewController alloc] init] autorelease];
        [picker setSubject:@"User Account"];
        [picker addAttachmentData:data mimeType:@"application/zip" fileName:@"speedReader.zip"];
        [picker setToRecipients:[NSArray array]];
        [picker setMessageBody:@"Account" isHTML:NO];
        [picker setMailComposeDelegate:self];
        [self presentModalViewController:picker animated:YES];
         self.toExport=-1;
    }

    
    
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
		  didFinishWithResult:(MFMailComposeResult)result
						error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}

@end
