//
//  ImageForDB.h
//  SpeedReader
//
//  Created by LGBS dev on 8/10/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ImageForDB : NSManagedObject
@property (nonatomic,strong)NSString* imageName;
@property (strong, nonatomic) NSMutableData* imageData;
+(ImageForDB*)initAccountWithName : (NSString*)name andImage:(UIImage*)userImage;
@end
