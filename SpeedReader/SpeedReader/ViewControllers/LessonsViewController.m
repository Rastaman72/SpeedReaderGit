//
//  LessonsViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "LessonsViewController.h"

@interface LessonsViewController ()

@end

@implementation LessonsViewController

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
    self.theDataObject=[self theAppDataObject];
    UINavigationController* leftNavC=[self.viewControllers objectAtIndex:0];
     RootLessonTableViewController* leftVC=(RootLessonTableViewController*)[leftNavC topViewController];
     DetailLessonViewController* rightVC=[self.viewControllers objectAtIndex:1];
    
    [rightVC.detailLessonUserImage setImage:[UIImage imageWithData:self.theDataObject.loginUser.userImage]];
    

     leftVC.delegate=rightVC;
     self.delegate=rightVC;
    LessonData* firstLesson=[[leftVC lessons]objectAtIndex:0];
     [rightVC setLesson:firstLesson];
    
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
