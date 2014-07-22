
//
//  UserAccount.h
//  SpeedReader
//
//  Created by LGBS dev on 7/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface UserAccount : NSObject
@property (nonatomic,retain)NSString* login;
@property (retain, nonatomic) NSString *password;
@property (retain, nonatomic) NSString *userImage;

+(UserAccount*)initAccountWithLogin : (NSString*)login andImage:(NSString*)userImage andPassword:(NSString*)userPassword;
@end
