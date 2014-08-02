//
//  ExportDetailViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExportDetailViewController.h"
#import "ZipFile.h"


#import "ZipException.h"
#import "FileInZipInfo.h"
#import "ZipWriteStream.h"
#import "ZipReadStream.h"

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
{//
    //dodac obsluge dodawania do maila
    //dodac obsluge importowania konta
    //!!!!!!!!!!!!!!
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)selectPush:(id)sender
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
    
    
    for (NSString *s in fileList)
    {
        if([s isEqualToString:_userToExport.login])
        {
            NSLog(@"%@", s);
            NSString* docPath=@"/";
            docPath=[docPath stringByAppendingString:s];
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
            
            
            
            
            
            
            //////////////////
            
            
            ZipFile *toExport =[[ZipFile alloc]initWithFileName:dataPath mode:ZipFileModeCreate];
            ZipWriteStream *stream1= [toExport writeFileInZipWithName:@"user.xml" fileDate:[NSDate dateWithTimeIntervalSinceNow:-86400.0] compressionLevel:ZipCompressionLevelBest];
            [stream1 writeData:userXmlData];
            [stream1 finishedWriting];
            
            
            ZipWriteStream *stream2= [toExport writeFileInZipWithName:@"settings.xml" compressionLevel:ZipCompressionLevelNone];
            [stream2 writeData:settingsXmlData];
            [stream2 finishedWriting];
            [toExport close];
        }
    }
    [[self navigationController]popViewControllerAnimated:YES];
}
@end
