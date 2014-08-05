//
//  MainViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillLayoutSubviews
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
}


- (void)handleOpenURL:(NSURL *)url {
    self.theDataObject = [self theAppDataObject];
    self.theDataObject.urlToFile=[url description];
    self.theDataObject.arrayUrlToFile=[self.theDataObject.urlToFile pathComponents];
    NSRange todeleteRange=NSMakeRange(0, 2);
    [self.theDataObject.arrayUrlToFile removeObjectsInRange:todeleteRange];
    NSString* filePath=[self.theDataObject.arrayUrlToFile componentsJoinedByString:@"/"];
    
    if([self.theDataObject unZipFile:filePath])
    self.selectedViewController=[self.viewControllers objectAtIndex:3];
    else
        self.selectedViewController=[self.viewControllers objectAtIndex:0];
    
    
}



- (void)goToImport
{
    self.theDataObject = [self theAppDataObject];
    self.theDataObject.urlToFile;
}

- (void)viewDidLoad
{
    [self goToImport];
        [super viewDidLoad];
    // Do any additional setup after loading the view.    
}

- (void)didReceiveMemoryWarning
{   
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
