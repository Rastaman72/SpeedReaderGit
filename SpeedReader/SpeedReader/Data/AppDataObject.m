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
        
        self.imageUser=[self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
    }
    else
    {
        
        self.imageUser=dbImage;
    }
    
    
    
}


- (NSString *)dataFilePath:(NSString*)fileName {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
}

-(void)getExercisesText
{
    NSError*error;
    NSString *filePath = [self dataFilePath:@"exerciseTextsPL"];
    NSData* excXml=[NSData dataWithContentsOfFile:filePath];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:excXml options:0 error:&error];
    NSArray *xmlPart = [doc.rootElement elementsForName:@"texts"];
    
    for (GDataXMLElement *xmlElements in xmlPart) {
        NSArray *names = [xmlElements elementsForName:@"text"];
        self.allTextInApp=[[NSMutableArray alloc]initWithArray:names];
        if (names.count > 0) {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            self.exercisesText=[[[firstName elementsForName:@"body"]firstObject]stringValue];
            self.lastUsedText=[[[[firstName elementsForName:@"id"]firstObject]stringValue]intValue];
        } else continue;
    }
}


-(void)getExercisesWords
{
    NSError*error;
    NSString *filePath = [self dataFilePath:@"wordsPL"];
    NSData* excXml=[NSData dataWithContentsOfFile:filePath];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:excXml options:0 error:&error];
    //NSArray *xmlPart = [doc.rootElement elementsForName:@"word"];
    
    //int wordCounter=3;
    for (int i=3; i<=19; i++)
    {
        
        
        NSString*path=[NSString stringWithFormat:@"//word[@length=\"%d\"]",i];
        NSArray *xmlPart1=[doc nodesForXPath:path error:&error];
        switch (i) {
            case 3:
            {
                self.allWords3InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 4:
            {
                self.allWords4InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 5:
            {
                self.allWords5InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 6:
            {
                self.allWords6InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 7:
            {
                self.allWords7InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 8:
            {
                self.allWords8InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 9:
            {
                self.allWords9InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 10:
            {
                self.allWords10InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
                
            }
                break;
            case 11:
                
            {
                self.allWords11InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 12:
            {
                self.allWords12InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 13:
            {
                self.allWords13InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 14:
            {
                self.allWords14InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
            case 15:
            {
                self.allWords15InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            } break;
            case 16:
            {
                self.allWords16InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            } break;
            case 17:
            {
                self.allWords17InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 18:
            {
                self.allWords18InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
            case 19:
            {
                self.allWords19InApp=[[NSMutableArray alloc]initWithArray:xmlPart1 copyItems:YES];
            }
                break;
                
            default:
                break;
        }
    }
    //NSLog(@"%@",xmlPart1);
    
    //self.allWordsInApp=[[NSMutableArray alloc]init];
    /* for (GDataXMLElement *xmlElements in xmlPart) {
     //    NSLog(@"%@",[xmlElements stringValue]);
     [self.allWordsInApp addObject:[xmlElements stringValue]];
     //        NSArray *names = [xmlElements elementsForName:@"text"];
     //        self.allTextInApp=[[NSMutableArray alloc]initWithArray:names];
     //        if (names.count > 0) {
     //            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
     //            self.exercisesText=[[[firstName elementsForName:@"body"]firstObject]stringValue];
     //            self.lastUsedText=[[[[firstName elementsForName:@"id"]firstObject]stringValue]intValue];
     //        } else continue;
     }*/
}
-(NSString*)getWord:(int)length
{
    // length=4;
    //NSMutableArray* wordsArray=[[NSMutableArray alloc]init];
    switch (length) {
        case 3:
            NSLog(@"%@",[self.allWords3InApp[arc4random() % [self.allWords3InApp count]]stringValue]);
            return [self.allWords3InApp[arc4random() % [self.allWords3InApp count]]stringValue];
            
            break;
        case 4:
        {
            NSLog(@"%@",[self.allWords4InApp[arc4random() % [self.allWords4InApp count]]stringValue]);
            return [self.allWords4InApp[arc4random() % [self.allWords4InApp count]]stringValue];
            break;
        }
        case 5:
            NSLog(@"%@",[self.allWords5InApp[arc4random() % [self.allWords5InApp count]]stringValue]);
            
            return [self.allWords5InApp[arc4random() % [self.allWords5InApp count]]stringValue];
            break;
        case 6:
            NSLog(@"%@",[self.allWords6InApp[arc4random() % [self.allWords6InApp count]]stringValue]);
            
            return [self.allWords6InApp[arc4random() % [self.allWords6InApp count]]stringValue];
            break;
        case 7:
            NSLog(@"%@",[self.allWords7InApp[arc4random() % [self.allWords7InApp count]]stringValue]);
            
            return [self.allWords7InApp[arc4random() % [self.allWords7InApp count]]stringValue];
            break;
        case 8:
            NSLog(@"%@",[self.allWords8InApp[arc4random() % [self.allWords8InApp count]]stringValue]);
            
            return [self.allWords8InApp[arc4random() % [self.allWords8InApp count]]stringValue];
            break;
        case 9:
            NSLog(@"%@",[self.allWords9InApp[arc4random() % [self.allWords9InApp count]]stringValue]);
            
            return [self.allWords9InApp[arc4random() % [self.allWords9InApp count]]stringValue];
            break;
        case 10:
            NSLog(@"%@",[self.allWords10InApp[arc4random() % [self.allWords10InApp count]]stringValue]);
            
            return [self.allWords10InApp[arc4random() % [self.allWords10InApp count]]stringValue];
            break;
        case 11:
            NSLog(@"%@",[self.allWords11InApp[arc4random() % [self.allWords11InApp count]]stringValue]);
            
            return [self.allWords11InApp[arc4random() % [self.allWords11InApp count]]stringValue];
            break;
        case 12:
            NSLog(@"%@",[self.allWords12InApp[arc4random() % [self.allWords12InApp count]]stringValue]);
            
            return [self.allWords12InApp[arc4random() % [self.allWords12InApp count]]stringValue];
            break;
        case 13:
            NSLog(@"%@",[self.allWords13InApp[arc4random() % [self.allWords13InApp count]]stringValue]);
            
            return [self.allWords13InApp[arc4random() % [self.allWords13InApp count]]stringValue];
            break;
        case 14:
            NSLog(@"%@",[self.allWords14InApp[arc4random() % [self.allWords14InApp count]]stringValue]);
            
            return [self.allWords14InApp[arc4random() % [self.allWords14InApp count]]stringValue];
            break;
        case 15:
            NSLog(@"%@",[self.allWords15InApp[arc4random() % [self.allWords15InApp count]]stringValue]);
            
            return [self.allWords15InApp[arc4random() % [self.allWords15InApp count]]stringValue];
            break;
        case 16:
            NSLog(@"%@",[self.allWords16InApp[arc4random() % [self.allWords16InApp count]]stringValue]);
            
            return [self.allWords16InApp[arc4random() % [self.allWords16InApp count]]stringValue];
            break;
        case 17:
            NSLog(@"%@",[self.allWords17InApp[arc4random() % [self.allWords17InApp count]]stringValue]);
            
            return [self.allWords17InApp[arc4random() % [self.allWords17InApp count]]stringValue];
            break;
        case 18:
            NSLog(@"%@",[self.allWords18InApp[arc4random() % [self.allWords18InApp count]]stringValue]);
            
            return [self.allWords18InApp[arc4random() % [self.allWords18InApp count]]stringValue];
            break;
        case 19:
            NSLog(@"%@",[self.allWords19InApp[arc4random() % [self.allWords19InApp count]]stringValue]);
            
            return [self.allWords19InApp[arc4random() % [self.allWords19InApp count]]stringValue];
            break;
            
        case 20:
            NSLog(@"%@",[self.allWords9InApp[arc4random() % [self.allWords9InApp count]]stringValue]);
            
            return [NSString stringWithFormat:@"%@ %@",[self.allWords9InApp[arc4random() % [self.allWords9InApp count]]stringValue],[self.allWords10InApp[arc4random() % [self.allWords10InApp count]]stringValue]];
            break;
            
        case 21:
            return [NSString stringWithFormat:@"%@ %@",[self.allWords9InApp[arc4random() % [self.allWords9InApp count]]stringValue],[self.allWords11InApp[arc4random() % [self.allWords11InApp count]]stringValue]];
            break;
            
        case 22:
            return [NSString stringWithFormat:@"%@ %@ %@",[self.allWords7InApp[arc4random() % [self.allWords7InApp count]]stringValue],[self.allWords5InApp[arc4random() % [self.allWords5InApp count]]stringValue],[self.allWords8InApp[arc4random() % [self.allWords8InApp count]]stringValue]];
            break;
            
        case 23:
            return [NSString stringWithFormat:@"%@ %@ %@",[self.allWords7InApp[arc4random() % [self.allWords7InApp count]]stringValue],[self.allWords5InApp[arc4random() % [self.allWords5InApp count]]stringValue],[self.allWords9InApp[arc4random() % [self.allWords9InApp count]]stringValue]];
            break;
            
            
        default:
            break;
    }
    
    return nil;
}
@end
