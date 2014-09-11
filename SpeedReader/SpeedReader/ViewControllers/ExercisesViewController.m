//
//  ExercisesViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesViewController.h"

@interface ExercisesViewController ()

@end

@implementation ExercisesViewController

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
    
   
    
     self.theDataObject=[self theAppDataObject];
    // Do any additional setup after loading the view.
    UINavigationController* leftNavC=[self.viewControllers objectAtIndex:0];
    RootExercisesTableViewController* leftVC=(RootExercisesTableViewController*)[leftNavC topViewController];
    DetailExercisesViewController* rightVC=[self.viewControllers objectAtIndex:1];
    
    [rightVC.detailExercisesUserImage setImage:[UIImage imageWithData:self.theDataObject.loginUser.userImage]];
    
    //UWAGA WAZNE
    //if non retina !!!!!!
    
[self setValue:[NSNumber numberWithFloat:255.0] forKey:@"_masterColumnWidth"];
  
    leftVC.delegate=rightVC;
    self.delegate=rightVC;
    ExercisesData* firstExercises=[[leftVC exercises]objectAtIndex:0];
    [rightVC setExercises:firstExercises];

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
