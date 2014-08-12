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

@property (nonatomic,strong)NSString* login;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSData *userImage;
@property (strong, nonatomic) SettingsForDB *settings;
@property (nonatomic,strong)NSDate* timeAdd;


-(UserAccountForDB*)initAccountWithLogin : (NSString*)login andImage:(UIImage*)userImage andPassword:(NSString*)userPassword withDate:(NSDate*)startDate;
@end
