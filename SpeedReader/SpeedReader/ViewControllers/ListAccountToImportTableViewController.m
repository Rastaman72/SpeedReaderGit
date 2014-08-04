//
//  ListAccountToImportTableViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ListAccountToImportTableViewController.h"
#import "ZipFile.h"
#import "ZipException.h"
#import "FileInZipInfo.h"
#import "ZipWriteStream.h"
#import "ZipReadStream.h"
#import "GDataXMLNode.h"

#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ListAccountToImportTableViewController ()

@end

@implementation ListAccountToImportTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.accountList reloadData];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.accountsToImport count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
    if([self.accountsToImport count]!=0)
    {
        UserAccount* account=(self.accountsToImport)[indexPath.row];
        cell.textLabel.text=account;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* filePath=[documentsDirectory stringByAppendingString:@"/"];
    filePath=[filePath stringByAppendingString:[[[tableView cellForRowAtIndexPath:indexPath] textLabel]text]];
    
    
    ZipFile *unzipFile= [[ZipFile alloc] initWithFileName:filePath mode:ZipFileModeUnzip];
    
    NSArray *infos= [unzipFile listFileInZipInfos];
    [unzipFile goToFirstFileInZip];
    for (FileInZipInfo* toExtract in infos) {
        ZipReadStream *read1= [unzipFile readCurrentFileInZip];
        NSMutableData *data1= [[[NSMutableData alloc] initWithLength:256] autorelease];
        int bytesRead1= [read1 readDataWithBuffer:data1];
        
        NSError*error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data1 options:0 error:&error];
        NSLog(@"%@", doc.rootElement);
        
        NSArray *xmlPart = [doc.rootElement elementsForName:@"user"];
        if (xmlPart!=nil) {
            //parse user.xml
            for (GDataXMLElement *xmlElements in xmlPart) {
                NSString *name;
                NSString* image;
                
                // Name
                NSArray *names = [xmlElements elementsForName:@"name"];
                if (names.count > 0) {
                    GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
                    name = firstName.stringValue;
                } else continue;
                
                //Image
                NSArray *images = [xmlElements elementsForName:@"image"];
                if (names.count > 0) {
                    GDataXMLElement *imageName = (GDataXMLElement *) [images objectAtIndex:0];
                    image = imageName.stringValue;
                } else continue;
                
                UserAccount *user = [UserAccount initAccountWithLogin:name andImage:image andPassword:nil];
                SharedData* theDataObject = [self theAppDataObject];
                
                
                bool unique=false;
                for (int i=0; i<[theDataObject.actuallUserList count]; i++) {
                    UserAccount* toTest=[theDataObject.actuallUserList objectAtIndex:i];
                    if([toTest.login isEqualToString:user.login])
                    {
                        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"User already exsist" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alert show];
                        unique=false;
                        theDataObject.importUserList=[[NSMutableArray alloc]init];
                        break;
                    }
                    else
                    {
                        unique=true;
                    }
                }
                if (unique) {
                    //[theDataObject.actuallUserList addObject:user];
                    [theDataObject.importUserList addObject:user];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
        }
        else
            //parse setting.xml
        {
            
        }
        [read1 finishedReading];
        [unzipFile goToNextFileInZip];
        
    }
    
    [unzipFile close];
    
    
    
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)backToListPush:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
