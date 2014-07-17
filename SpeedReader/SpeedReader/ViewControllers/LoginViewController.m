//
//  LoginViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "LoginViewController.h"
#import "LessonsViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
   /* if ([segue.identifier isEqualToString:@"LoginToLesson"]) {
              LessonsViewController  *LVC = (LessonsViewController *)segue.destinationViewController;
        LVC.left=[LVC.viewControllers objectAtIndex:0];
        LVC.root=(LeftViewTableViewController*)[LVC.left topViewController];
        LVC.detail=[LVC.viewControllers objectAtIndex:1];
        LessonData* firstLesson=[[LVC.root lessons]objectAtIndex:0];
        [LVC.detail setLesson:firstLesson];
    }*/

}


- (IBAction)loginPush:(id)sender {
       [self dismissViewControllerAnimated:YES completion:nil];

}
@end
