//
//  AppDelegate.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UserAccount.h"
#import "AppDelegateDataShared.h"
#import "MainViewController.h"
@class SharedData;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) SharedData* theAppDataObject;


@end
