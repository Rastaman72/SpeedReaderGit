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
        NSMutableData *data1= [[[NSMutableData alloc] initWithLength:256] autorelease];
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
                
                for (int i=0; i<[self.actuallUserList count]; i++) {
                    UserAccountForDB* toTest=[self.actuallUserList objectAtIndex:i];
                    if([toTest.login isEqualToString:name])
                    {
                        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"User already exsist choose other login or delete exist account" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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
                
                self.importUserList=[[NSMutableArray alloc]init];
                [self.importUserList addObject:name];
                [self.importUserList addObject:image];
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

@end
