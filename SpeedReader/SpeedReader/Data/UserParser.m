//
//  UserParser.m
//  SpeedReader
//
//  Created by LGBS dev on 7/22/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "UserParser.h"
#import "GDataXMLNode.h"
#import "UserAccount.h"
@implementation UserParser

+ (NSArray *)dataFilePath:(BOOL)forSave {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    return fileList;
    
}

    


+ (NSMutableArray *)loadUser {
    
    NSArray  *fileList = [self dataFilePath:FALSE];
    NSString *userLogin =[[NSString alloc]init];
    NSString *userImage =[[NSString alloc]init];
    NSMutableArray* userList=[[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    

    
    for (NSString *s in fileList)
    {
        NSLog(@"%@", s);
        NSString* docPath=@"/";
        docPath=[docPath stringByAppendingString:s];
        NSString *documentsPath = [[documentsDirectory stringByAppendingString:docPath]
                                   stringByAppendingPathComponent:@"user.xml"];
        if ( ![[NSFileManager defaultManager] fileExistsAtPath:documentsPath ])
        {
            return nil;
        }
        else
        {
            NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:documentsPath];
            NSError *error;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                                   options:0 error:&error];
            if (doc == nil) { return nil; }
            
            NSLog(@"%@", doc.rootElement);
            NSArray* resultNodes = [doc nodesForXPath:@"//data/user" error:&error];
            
            for (GDataXMLElement *resultElement in resultNodes) {
                
                userLogin  = [[[resultElement elementsForName:@"name"]objectAtIndex:0]stringValue];
                userImage = [[[resultElement elementsForName:@"image"]objectAtIndex:0]stringValue];
                
                
            }
            
        }
        UserAccount* newUser=[UserAccount initAccountWithLogin:userLogin andImage:userImage andPassword:nil];
      
        [userList addObject:newUser];

    }
    
    
    
    
            return userList;
    
}


+ (NSData*)saveUser:(UserAccount *)user {
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    
    GDataXMLElement * dataElement = [GDataXMLNode elementWithName:@"data"];
    
    
    GDataXMLElement * userElement =
    [GDataXMLNode elementWithName:@"user"];
    GDataXMLElement * nameElement =
    [GDataXMLNode elementWithName:@"name" stringValue:user.login];
    GDataXMLElement * imageElement =
    [GDataXMLNode elementWithName:@"image" stringValue:user.userImage];
    
    GDataXMLElement * dateElement =
    [GDataXMLNode elementWithName:@"date" stringValue:dateString];
    
   
    [userElement addChild:nameElement];
        [userElement addChild:imageElement];
        [userElement addChild:dateElement];
     [dataElement addChild:userElement];
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]
                                   initWithRootElement:dataElement];
    
    NSData *xmlData = document.XMLData;
    return xmlData;
    
//    
//    NSString *filePath = [self dataFilePath:TRUE];
//    NSLog(@"Saving xml data to %@...", filePath);
//    [xmlData writeToFile:filePath atomically:YES];
//    
}


@end
