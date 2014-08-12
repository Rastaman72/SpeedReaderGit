//
//  AppDataObject.m
//  SpeedReader
//
//  Created by LGBS dev on 8/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "AppDataObject.h"

@implementation AppDataObject

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil] ;
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent:@"SpeedTest.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (BOOL)unZipFile:(NSString *)filePath
{
    ZipFile *unzipFile= [[ZipFile alloc] initWithFileName:filePath mode:ZipFileModeUnzip];
    
    NSArray *infos= [unzipFile listFileInZipInfos];
    [unzipFile goToFirstFileInZip];
    for (FileInZipInfo* toExtract in infos) {
        ZipReadStream *read1= [unzipFile readCurrentFileInZip];
        NSMutableData *data1= [[[NSMutableData alloc] initWithLength:1024] autorelease];
        int bytesRead1= [read1 readDataWithBuffer:data1];
        
        NSError*error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data1 options:0 error:&error];
        NSLog(@"%@", doc.rootElement);
        
        NSArray *xmlPart = [doc.rootElement elementsForName:@"user"];
        if (xmlPart!=nil)
        {
            //parse user.xml
            for (GDataXMLElement *xmlElements in xmlPart) {
                NSString *name;
                NSDate* dateAdd;
                dateAdd=[[NSDate alloc]init];
                
                // Name
                NSArray *names = [xmlElements elementsForName:@"name"];
                if (names.count > 0) {
                    GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
                    name = firstName.stringValue;
                } else continue;
                
                //Date
                NSArray *images = [xmlElements elementsForName:@"date"];
                if (names.count > 0) {
                    GDataXMLElement *imageName = (GDataXMLElement *) [images objectAtIndex:0];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString*test=imageName.stringValue;
                    dateAdd =  [dateFormatter dateFromString: test];
                } else continue;
                
                for (int i=0; i<[self.actuallUserList count]; i++) {
                    UserAccountForDB* toTest=[self.actuallUserList objectAtIndex:i];
                    if([toTest.login isEqualToString:name])
                    {
                        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"User already exsist choose other login or delete exist account", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alert show];
                        self.unique=false;
                    }
                    else
                    {
                        self.unique=true;
                    }
                }
                if([self.actuallUserList count]==0)
                    self.unique=true;
                
                self.importUserList=[[NSMutableDictionary alloc]init];
                [self.importUserList setObject:name forKey:@"name"];
                [self.importUserList setObject:dateAdd forKey:@"date"];
               // [self.importUserList addObject:name];
                //[self.importUserList addObject:image];
                self.correctUnZip=TRUE;
            }
        }
        else
            
            //parse setting.xml
        {
            NSArray *xmlPart = [doc.rootElement elementsForName:@"teacher"];
            for (GDataXMLElement *xmlElements in xmlPart) {
                NSString *interface;
                NSString* lastUsedText;
                NSString* lastLessonDone;
                
                // interface
                NSArray *interfaceA = [xmlElements elementsForName:@"interface"];
                if (interfaceA.count > 0) {
                    GDataXMLElement *firstInterface = (GDataXMLElement *) [interfaceA objectAtIndex:0];
                    interface = firstInterface.stringValue;
                } else continue;
                
                //lastUsedText
                NSArray *lastUsedTextA = [xmlElements elementsForName:@"lastUsedText"];
                if (lastUsedTextA.count > 0) {
                    GDataXMLElement *lastUsedTextXML = (GDataXMLElement *) [lastUsedTextA objectAtIndex:0];
                    lastUsedText = lastUsedTextXML.stringValue;
                } else continue;
                
                //lastLessonDone
                NSArray *lastLessonDoneA = [xmlElements elementsForName:@"lastLessonDone"];
                if (lastLessonDoneA.count > 0) {
                    GDataXMLElement *lastLessonDoneXML = (GDataXMLElement *) [lastLessonDoneA objectAtIndex:0];
                    lastLessonDone = lastLessonDoneXML.stringValue;
                } else continue;
                
                self.userSettings=[[NSMutableArray alloc]init];
                [self.userSettings addObject:interface];
                [self.userSettings addObject:lastUsedText];
                [self.userSettings addObject:lastLessonDone];
                self.correctUnZip=TRUE;
           }
        }
        [read1 finishedReading];
        [unzipFile goToNextFileInZip];
        
    }
    
    [unzipFile close];
    return self.correctUnZip;
}
-(void)createImageUserArray
{
    NSManagedObjectContext *context =  self.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"UserImage" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
      self.imageUser=[[NSMutableArray alloc]init];
    NSMutableArray* dbImage=[self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([dbImage count]==0) {
      
        
        [ImageForDB initAccountWithName:@"image0" andImage:[UIImage imageNamed:@"image0.jpg"]];
        [ImageForDB initAccountWithName:@"image1" andImage:[UIImage imageNamed:@"image1.jpg"]];
        [ImageForDB initAccountWithName:@"image2" andImage:[UIImage imageNamed:@"image2.jpg"]];
        [ImageForDB initAccountWithName:@"image3" andImage:[UIImage imageNamed:@"image3.jpg"]];
        
       /* [self.imageUser setObject:[[ImageForDB alloc]initAccountWithName:@"image0" andImage:[UIImage imageNamed:@"image0.jpg"] ] forKey:@"image0"];
        [self.imageUser setObject:[[ImageForDB alloc]initAccountWithName:@"image1" andImage:[UIImage imageNamed:@"image1.jpg"] ] forKey:@"image1"];
        [self.imageUser setObject:[[ImageForDB alloc]initAccountWithName:@"image2" andImage:[UIImage imageNamed:@"image2.jpg"] ] forKey:@"image2"];
        [self.imageUser setObject:[[ImageForDB alloc]initAccountWithName:@"image3" andImage:[UIImage imageNamed:@"image3.jpg"] ] forKey:@"image3"];
        */
        self.imageUser=[self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    }
    else
    {
        
        self.imageUser=dbImage;
    }
    
    
    
}/*
-(void)addPicker:(UIViewController*)view
{
    self.tempView=view;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tempView.view animated:YES];
    hud.labelText = @"Loading picker";
    
    dispatch_queue_t concurrentQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_async(concurrentQueue, ^{
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [view presentViewController:self.picker animated:YES completion:nil];
            [MBProgressHUD hideHUDForView:self.tempView.view animated:YES];
        });
        
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.tempView dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tempView.view animated:YES];
    hud.labelText = @"Adding image to app";
    
    dispatch_queue_t concurrentQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_async(concurrentQueue, ^{
        
        self.chooseImage=fullImage;
        NSString* description =[NSString stringWithFormat:@"image%d",(int)[self.imageUser count]];
        [ImageForDB initAccountWithName:description andImage:fullImage];
        [self createImageUserArray];
        //[self.tempView.addAccountImageTable reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.tempView.view animated:YES];
            //[self.addAccountImage setImage:self.theDataObject.chooseImage];
        });
    });
    [self.tempView dismissViewControllerAnimated:YES completion:nil];
}*/


@end
