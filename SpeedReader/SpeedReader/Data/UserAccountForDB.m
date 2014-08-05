//
//  UserAccountForDB.m
//  SpeedReader
//
//  Created by LGBS dev on 8/4/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "UserAccountForDB.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@implementation UserAccountForDB

@dynamic login;
@dynamic password;
@dynamic userImage;
@dynamic settings;

-(UserAccountForDB*)initAccountWithLogin : (NSString*)login andImage:(NSString*)userImage andPassword:(NSString*)userPassword
{
    SharedData* theDataObject = [self theAppDataObject];
    NSManagedObjectContext *context =  theDataObject.managedObjectContext;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];

    fetch.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    fetch.predicate = [NSPredicate predicateWithFormat:@"login == %@", login];
    NSArray *array = [context executeFetchRequest:fetch error:nil];
    
    if ([array count] == 0)
    {

    SettingsForDB* userSettings =[NSEntityDescription
                                  insertNewObjectForEntityForName:@"TeacherSettings"
                                  inManagedObjectContext:context];
    userSettings.interface=[[NSNumber alloc]initWithInt:1];
    userSettings.lastUsedText==[[NSNumber alloc]initWithInt:0];
    userSettings.lastLessonDone==[[NSNumber alloc]initWithInt:-1];

    
    UserAccountForDB *newUser = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"User"
                                  inManagedObjectContext:context];
    newUser.login=login;
    if(userPassword!=nil)
        newUser.password=userPassword;
    else
        newUser.password=@"";
    
    if(userImage!=nil)
        newUser.userImage=userImage;
    else
        newUser.userImage=@"";
    
     newUser.settings=userSettings;
    NSError*error;
    [context save:&error];
    return newUser;
    }
    return nil;
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
