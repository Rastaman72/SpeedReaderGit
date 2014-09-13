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
@dynamic timeAdd;

-(UserAccountForDB*)initAccountWithLogin : (NSString*)login andImage:(UIImage*)userImage andPassword:(NSString*)userPassword withDate:(NSDate*)startDate
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
    userSettings.interface=[[[NSNumber alloc]initWithInt:1]intValue];
    userSettings.lastUsedText=[[[NSNumber alloc]initWithInt:0]intValue];
    userSettings.lastLessonDone=[[[NSNumber alloc]initWithInt:-1]intValue];

    
    UserAccountForDB *newUser = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"User"
                                  inManagedObjectContext:context];
    newUser.login=login;
    if(userPassword!=nil)
        newUser.password=userPassword;
    else
        newUser.password=@"";
    
    if(userImage!=nil)
    {
        NSData *imageData=UIImageJPEGRepresentation(userImage, 1.0);
        newUser.userImage=imageData;
    }
        else
        newUser.userImage=nil;
    //    [[NSNumber alloc]initWithFloat:[NSDate dateWithTimeIntervalSinceNow:-86400.0]];
       
        if(!startDate)
        {
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
        NSDate *dateAdd = [calendar dateFromComponents:components];
        
        newUser.timeAdd=dateAdd;
        }
        else
            newUser.timeAdd=startDate;
        
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
