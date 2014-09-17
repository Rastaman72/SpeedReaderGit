//
//  DetailStatisticsViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "DetailStatisticsViewController.h"
#import "StatisticsData.h"
@interface DetailStatisticsViewController ()

@end

@implementation DetailStatisticsViewController

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
     [self refreshUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setStatisticsData:(StatisticsData *)statisticsData
{
    if(_statisticsData!=statisticsData)
    {
        _statisticsData=statisticsData;
        [self refreshUI];
        
    }
}

-(void)refreshUI
{
    _detailStatisticsHeader.text=_statisticsData.header;
    // _userImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",_exercisesData.userImage]];
    
    _detailStatisticsDecription.text=_statisticsData.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectedStatistics:(StatisticsData *)newStatistics
{
    [self setStatisticsData:newStatistics];
    if (_popover != nil) {
        [_popover dismissPopoverAnimated:YES];
    }
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Statistic";

    //Set the bar button item as the Nav Bar's leftBarButtonItem
    //[_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    [_navBarItem setLeftBarButtonItem:barButtonItem];
    //Set the bar button item as the Nav Bar's leftBarButtonItem
   // [_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //Remove the barButtonItem.
    [_navBarItem setLeftBarButtonItem:nil animated:YES];
    
    
    //Nil out the pointer to the popover.
    _popover = nil;
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

- (IBAction)logOutPush:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
