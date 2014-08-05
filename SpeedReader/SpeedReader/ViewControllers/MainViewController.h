//
//  MainViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface MainViewController : UITabBarController<UITabBarControllerDelegate>
@property(nonatomic,retain)id selectedViewController;
@property(nonatomic,strong)SharedData* theDataObject;
-(void)goToImport;
@end
