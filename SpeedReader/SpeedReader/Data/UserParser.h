//
//  UserParser.h
//  SpeedReader
//
//  Created by LGBS dev on 7/22/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserAccount;

@interface UserParser : NSObject


+ (UserAccount *)loadUser;
+ (NSData*)saveUser:(UserAccount *)user;
@property(nonatomic,retain)NSString *documentsDirectory;
@end
