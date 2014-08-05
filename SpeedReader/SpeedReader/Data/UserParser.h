//
//  UserParser.h
//  SpeedReader
//
//  Created by LGBS dev on 7/22/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserAccountForDB;

@interface UserParser : NSObject


+ (UserAccountForDB *)loadUser;
+ (NSData*)saveUser:(UserAccountForDB *)user;
+ (NSData*)saveSettings;
@property(nonatomic,retain)NSString *documentsDirectory;
@end
