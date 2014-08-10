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
#import "SettingsForDB.h"
#import "ImageForDB.h"

#import "MBProgressHUD.h"
@interface AppDataObject : NSObject<UIApplicationDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)NSMutableArray* actuallUserList;
@property (nonatomic,strong)NSMutableArray* importUserList;
@property (nonatomic,strong)NSMutableArray* userSettings;
@property (nonatomic,strong)NSMutableArray* imageUser;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,assign) bool unique;
@property (nonatomic,assign) bool correctUnZip;
- (NSString *)applicationDocumentsDirectory;
- (BOOL)unZipFile:(NSString *)filePath;
- (void)createImageUserArray;
@property(nonatomic,strong)NSString*key;
@property(nonatomic,strong)UIImage* chooseImage;
/*-(void)addPicker:(UIViewController*)view;
@property(nonatomic,strong)UIImagePickerController* picker;
@property(nonatomic,strong)UIViewController* tempView;*/


@end
