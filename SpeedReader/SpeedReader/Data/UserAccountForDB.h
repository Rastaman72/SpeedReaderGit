//
//  UserAccountForDB.h
//  SpeedReader
//
//  Created by LGBS dev on 8/4/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SettingsForDB.h"
@interface UserAccountForDB : NSManagedObject

@property (nonatomic,retain)NSString* login;
@property (retain, nonatomic) NSString *password;
@property (retain, nonatomic) NSString *userImage;
@property (retain, nonatomic) SettingsForDB *settings;


@end
