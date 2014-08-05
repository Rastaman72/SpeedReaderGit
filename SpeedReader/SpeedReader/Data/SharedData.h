//
//  SharedData.h
//  SpeedReader
//
//  Created by LGBS dev on 8/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "AppDataObject.h"
#import "UserAccountForDB.h"
@interface SharedData : AppDataObject


@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,strong)NSString* urlToFile;
@property (nonatomic,strong)NSMutableArray* arrayUrlToFile;


@end
