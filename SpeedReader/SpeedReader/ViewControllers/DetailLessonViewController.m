//
//  RightViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "DetailLessonViewController.h"
#import "LessonData.h"
@interface DetailLessonViewController ()

@end

@implementation DetailLessonViewController

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

-(void)setLesson:(LessonData *)lesson
{
    if(_lesson!=lesson)
    {
        _lesson=lesson;
        [self refreshUI];
      
    }
}


-(void)refreshUI
{
    _header.text=_lesson.header;
    _userImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",_lesson.userImage]];

    _decription.text=_lesson.description;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectedLesson:(LessonData *)newLesson
{
    [self setLesson:newLesson];
    if (_popover != nil) {
        [_popover dismissPopoverAnimated:YES];
    }
}


-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Lessons     ";
    _logOutButton.title =@"Log Out";
    NSMutableArray* buttons=[[NSMutableArray alloc]init];
    [buttons addObject:barButtonItem];
    [buttons addObject:_logOutButton];
    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    //[_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    [_navBarItem setLeftBarButtonItems:buttons];
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
- (IBAction)settingsPush:(id)sender {
}
@end
