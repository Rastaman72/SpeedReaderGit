//
//  LessonPartDispatcherViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "LessonPartDispatcherViewController.h"

@interface LessonPartDispatcherViewController ()

@end

@implementation LessonPartDispatcherViewController

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

-(void)test1
{
    self.theDataObject=[self theAppDataObject];
    ExercisesData* choosedExercises=(ExercisesData*)self.theDataObject.selectPart;
    
    
    
    NSString * storyboardName1 = @"Main_iPad";
    NSString * viewControllerID1 = [NSString stringWithFormat:@"EXC%d",1];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName1 bundle:nil];
    UIViewController * controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID1];
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
