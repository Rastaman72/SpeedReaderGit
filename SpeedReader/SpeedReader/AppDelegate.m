//
//  AppDelegate.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "AppDelegate.h"
#import "RootLessonTableViewController.h" 
#import "DetailLessonViewController.h"
#import "LessonsViewController.h"
#import "UserParser.h"

#import "AppDelegateDataShared.h"
#import "SharedData.h" 
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self deleteZipFile];
    self.theAppDataObject = [[SharedData alloc] init];
    self.theAppDataObject.actuallUserList=[[NSMutableArray alloc]init];
    self.theAppDataObject.importUserList=[[NSMutableArray alloc]init];
    // Override point for customization after application launch.
   
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1.title = [NSString stringWithFormat:NSLocalizedString(@"Login", nil)];
    tabBarItem2.title = [NSString stringWithFormat:NSLocalizedString(@"Add", nil)];
    tabBarItem3.title = [NSString stringWithFormat:NSLocalizedString(@"Delete", nil)];
    tabBarItem4.title = [NSString stringWithFormat:NSLocalizedString(@"Import", nil)];
    tabBarItem5.title = [NSString stringWithFormat:NSLocalizedString(@"Export", nil)];
   
    

    SharedData* theDataObject = [self theAppDataObject];
    theDataObject.actuallUserList=[[NSMutableArray alloc]init];
    theDataObject.actuallUserList=[NSMutableArray arrayWithArray:[UserParser loadUser]];
    
  
    
     return YES;
}



- (void)deleteZipFile
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    for (NSString* toDelete in fileList) {
        if([toDelete rangeOfString:@".zip"].location !=NSNotFound)
        {
          
            NSString* pathToFile = [documentsDirectory stringByAppendingString:@"/"];
            pathToFile=[pathToFile stringByAppendingString:toDelete];
            [[NSFileManager defaultManager] removeItemAtPath:pathToFile  error:&error];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self deleteZipFile];
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
