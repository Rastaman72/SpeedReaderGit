//
//  DetailExercisesViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "DetailExercisesViewController.h"
#import "ExercisesData.h"

@interface DetailExercisesViewController ()

@end

@implementation DetailExercisesViewController

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

-(void)setExercises:(ExercisesData *)exercises
{
    if(_exercisesData!=exercises)
    {
        _exercisesData=exercises;
        [self refreshUI];
        
    }
}

-(void)refreshUI
{
    _header.text=_exercisesData.header;
   // _userImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",_exercisesData.userImage]];
    
    _decription.text=_exercisesData.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)selectedExercises:(ExercisesData *)newExercises
{
    [self setExercises:newExercises];
    if (_popover != nil) {
        [_popover dismissPopoverAnimated:YES];
    }
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Exercises";
    _logOutButton.title =@"Log Out";
    NSMutableArray* buttons=[[NSMutableArray alloc]init];
    [buttons addObject:barButtonItem];
    [buttons addObject:_logOutButton];
    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    //[_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    [_navBarItem setLeftBarButtonItems:buttons];
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    //[_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
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
