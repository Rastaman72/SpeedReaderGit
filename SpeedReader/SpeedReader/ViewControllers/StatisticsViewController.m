//
//  StatisticsViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.theDataObject = [self theAppDataObject];
    // Do any additional setup after loading the view.
    UINavigationController* leftNavC=[self.viewControllers objectAtIndex:0];
    RootStatisticsTableViewController* leftVC=(RootStatisticsTableViewController*)[leftNavC topViewController];
    DetailStatisticsViewController* rightVC=[self.viewControllers objectAtIndex:1];
    [rightVC.detailStatisticsUserImage setImage:[UIImage imageWithData:self.theDataObject.loginUser.userImage]];
    
    leftVC.delegate=rightVC;
    self.delegate=rightVC;
    StatisticsData* firstStatistic=[[leftVC statistics]objectAtIndex:0];
    [rightVC setStatisticsData:firstStatistic];

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
