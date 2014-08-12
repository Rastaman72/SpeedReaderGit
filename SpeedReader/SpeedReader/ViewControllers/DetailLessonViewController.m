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
    if(self.lessonData!=lesson)
    {
        self.lessonData=lesson;
        [self refreshUI];
      
    }
}


-(void)refreshUI
{
    self.detailLessonHeader.text=self.lessonData.header;
    
    self.detailLessonDecription.text=self.lessonData.description;
    
    [self.detailLessonDecription setContentOffset:CGPointZero animated:YES];
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectedLesson:(LessonData *)newLesson
{
    [self setLesson:newLesson];
    if (self.popover != nil) {
        [self.popover dismissPopoverAnimated:YES];
    }
}


-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Lessons";
//    self.logOutButton.title =@"Log Out";
//    NSMutableArray* buttons=[[NSMutableArray alloc]init];
//    [buttons addObject:barButtonItem];
//    [buttons addObject:self.logOutButton];
    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    //[self.navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    [self.navBarItem setLeftBarButtonItem:barButtonItem];
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //Remove the barButtonItem.
    [self.navBarItem setLeftBarButtonItem:nil animated:YES];
    
    
    //Nil out the pointer to the popover.
    self.popover = nil;
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
