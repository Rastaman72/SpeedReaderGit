//
//  UserAccount.m
//  SpeedReader
//
//  Created by LGBS dev on 7/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount

+(UserAccount*)initAccountWithLogin : (NSString*)login andImage:(NSString*)userImage andPassword:(NSString*)userPassword
{
    UserAccount* newUser=[[UserAccount alloc]init];
    newUser.login=login;
    if(![userPassword isEqualToString:@""])
        newUser.password=userPassword;
    newUser.userImage=userImage;
    return newUser;
}
@end
