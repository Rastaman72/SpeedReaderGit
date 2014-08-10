//
//  ImageForDB.m
//  SpeedReader
//
//  Created by LGBS dev on 8/10/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ImageForDB.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@implementation ImageForDB

@dynamic imageName;
@dynamic imageData;


//finish it important

+(ImageForDB*)initAccountWithName : (NSString*)name andImage:(UIImage*)userImage
{
    SharedData* theDataObject = [self theAppDataObject];
    NSManagedObjectContext *context =  theDataObject.managedObjectContext;
   // NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
        ImageForDB *newUser = [NSEntityDescription
                                     insertNewObjectForEntityForName:@"UserImage"
                                     inManagedObjectContext:context];
        newUser.imageName=name;
    
        NSData *imageData=UIImageJPEGRepresentation(userImage, 1.0);
        newUser.imageData=imageData;
        NSError*error;
        [context save:&error];
        return newUser;
    
    return nil;
}

+ (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
