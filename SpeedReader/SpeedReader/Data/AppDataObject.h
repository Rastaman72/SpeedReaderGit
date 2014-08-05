//
//  AppDataObject.h
//  SpeedReader
//
//  Created by LGBS dev on 8/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ZipException.h"
#import "FileInZipInfo.h"
#import "ZipWriteStream.h"
#import "ZipReadStream.h"
#import "ZipFile.h"
#import "GDataXMLNode.h"

#import "UserAccountForDB.h"
@interface AppDataObject : NSObject<UIApplicationDelegate>
@property(nonatomic,strong)NSMutableArray* actuallUserList;
@property (nonatomic,strong)NSMutableArray* importUserList;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSString *)applicationDocumentsDirectory;
- (void)unZipFile:(NSString *)filePath;
@end
