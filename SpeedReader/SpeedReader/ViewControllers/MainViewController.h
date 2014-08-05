//
//  MainViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZipFile.h"
#import "ZipException.h"
#import "FileInZipInfo.h"
#import "ZipWriteStream.h"
#import "ZipReadStream.h"
#import "GDataXMLNode.h"

#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface MainViewController : UITabBarController<UITabBarControllerDelegate>
@property(nonatomic,retain)id selectedViewController;
@property(nonatomic,strong)SharedData* theDataObject;
-(void)goToImport;
- (void)handleOpenURL:(NSURL *)url;
@end
