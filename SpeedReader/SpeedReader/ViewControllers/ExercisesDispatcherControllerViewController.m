//
//  ExercisesDispatcherControllerViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesDispatcherControllerViewController.h"

@interface ExercisesDispatcherControllerViewController ()

@end

@implementation ExercisesDispatcherControllerViewController

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
-(void)test
{
    self.theDataObject=[self theAppDataObject];
    ExercisesData* choosedExercises=(ExercisesData*)self.theDataObject.selectPart;
    
    
    
    NSString * storyboardName = @"Main_iPad";
    NSString * viewControllerID = [NSString stringWithFormat:@"EXC%d",choosedExercises.choosedExercises];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController * controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    self.theDataObject.dismmisView=YES;

     //ERROR after logout
    
    [self presentViewController:controller animated:YES completion:nil];
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
