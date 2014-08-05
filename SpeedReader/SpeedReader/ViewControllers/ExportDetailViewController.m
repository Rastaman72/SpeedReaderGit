//
//  ExportDetailViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExportDetailViewController.h"


@interface ExportDetailViewController ()

@end

@implementation ExportDetailViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)selectPush:(id)sender
{
    
    [self createZipFile];

    [[self navigationController]popViewControllerAnimated:YES];
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
    
    
    UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                   initWithTitle:@""
                                   delegate:self
                                   cancelButtonTitle:@"Cancel"
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:@"Export via File Sharing", @"Export via Email", nil] autorelease];
    [actionSheet showInView:self.view];
    
    //[self createZipFile];
    
    

}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == actionSheet.firstOtherButtonIndex + 0) {
         [self createZipFile];
    }
    else if (buttonIndex == actionSheet.firstOtherButtonIndex + 1) {
        [self createZipFile];
    
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath= [documentsDirectory stringByAppendingPathComponent:[self.userToExport.login stringByAppendingString:@".zip"]];
        NSData *data = [NSData dataWithContentsOfFile:writableDBPath];
        
                    MFMailComposeViewController *picker = [[[MFMailComposeViewController alloc] init] autorelease];
                    [picker setSubject:@"My Scary Bug"];
                    [picker addAttachmentData:data mimeType:@"application/zip" fileName:@"speedReader.zip"];
                    [picker setToRecipients:[NSArray array]];
                    [picker setMessageBody:@"Check out this scary bug!  You'll need a copy of ScaryBugs to view this file, then tap and hold to open." isHTML:NO];
                    [picker setMailComposeDelegate:self];
                    [self presentModalViewController:picker animated:YES];
    }
    
    
  
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
		  didFinishWithResult:(MFMailComposeResult)result
						error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}
@end
