//
//  AppDelegateDataShared.h
//  SpeedReader
//
//  Created by LGBS dev on 8/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDataObject;
@protocol AppDelegateDataShared <NSObject>

-(AppDataObject*) theAppDataObject;
@end
