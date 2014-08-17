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
    self.theDataObject = [self theAppDataObject];

   [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    int a=4;
}

-(void)viewDidAppear:(BOOL)animated
{
    int b=5;
}


- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    
    NSLog(@"%f",self.view.frame.size.width);
    NSLog(@"%f",self.view.frame.size.height);

    
    
    NSLog(@"%f",  self.detailExercisesPartView.frame.size.width);
    
    NSLog(@"%f",  self.detailExercisesPartView.frame.size.height);
    NSLog(@"%f",  self.detailExercisesPartView.frame.origin.x);

    NSLog(@"%f",  self.detailExercisesPartView.frame.origin.y);


    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
   [self.detailExercisesPartView setNeedsDisplay];
            break;
            
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
           // [self.detailExercisesPartView setNeedsDisplay];
         //  [self.detailExercisesPartView setFrame:CGRectMake(self.detailExercisesPartView.frame.origin.x,self.detailExercisesPartView.frame.origin.y,self.view.frame.size.width, self.view.frame.size.height)];
            break;
            
        default:
            break;
    };
}
-(void)setExercises:(ExercisesData *)exercises
{
    if(self.exercisesData!=exercises)
    {
        _exercisesData=exercises;
        [self refreshUI];
        
    }
}

-(void)refreshUI
{
    _detailExercisesHeader.text=_exercisesData.header;
   // _userImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",_exercisesData.userImage]];
    
    _detailExercisesDecription.text=_exercisesData.description;
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
    NSLog(@"%@",self.controller.viewControllers);
   // [(ExercisesDispatcherViewController*)[self.controller.viewControllers firstObject]test];
   
    if(self.theDataObject.dismmisView)
    {
        [[self.controller.viewControllers firstObject] dismissViewControllerAnimated:NO completion:^{
            [self showNew];
        }];
    }
    else
        [(ExercisesDispatcherControllerViewController*)self.controller test];

    
    //[self performSegueWithIdentifier:@"ExercisesToPartView" sender:self];
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

-(void)showNew
{
    [(ExercisesDispatcherControllerViewController*)self.controller test];

}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Exercises";
//    _logOutButton.title =@"Log Out";
//    NSMutableArray* buttons=[[NSMutableArray alloc]init];
//    [buttons addObject:barButtonItem];
//    [buttons addObject:_logOutButton];
    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    //[_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    [_navBarItem setLeftBarButtonItem:barButtonItem];
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@",segue.identifier);
    if([segue.identifier isEqualToString:@"ExercisesToPartView"]){
        self.controller=(ExercisesDispatcherControllerViewController*)segue.destinationViewController;
        
        id test=self.controller.viewControllers;
         id test1=self.controller.view;
       
    }}


- (IBAction)logOutPush:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
