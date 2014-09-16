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
self.originRect=self.detailExercisesPartView.frame;
   [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(deviceOrientationDidChange:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
}

-(void)checkOrientataion
{
    [self deviceOrientationDidChange:nil];
}
- (void)deviceOrientationDidChange:(NSNotification *)notification {
    //Obtain current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
       
    if(orientation==UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight)
    {
        if(!self.changePosition)
        {
            CGRect toChange=self.detailExercisesPartView.frame;
            toChange.origin.y+=60;
            [self.detailExercisesPartView setFrame:toChange];
            self.changePosition=YES;

        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
          //  CGRect toChange=self.detailExercisesPartView.frame;
           // toChange.origin.y-=50;
            [self.detailExercisesPartView setFrame:self.originRect];
            self.changePosition=NO;
        }
    }
    
    
    
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
    int choosedEXC=newExercises.choosedExercises;
     self.theDataObject.useOtherVersion=NO;
    switch (choosedEXC) {
        case 4:
            self.theDataObject.useOtherVersion=YES;
            newExercises=[ExercisesData newExercisesWithName:@"Exercises 3" description:@"Third Exercises" number:3];
            self.theDataObject.selectPart=newExercises;
            break;
            case 11:
            self.theDataObject.useOtherVersion=YES;
            newExercises=[ExercisesData newExercisesWithName:@"Exercises 10" description:@"Tenth Exercises" number:10];
            self.theDataObject.selectPart=newExercises;
              break;
        case 30:
            self.theDataObject.useOtherVersion=YES;
            newExercises=[ExercisesData newExercisesWithName:@"Exercises 29" description:@"TwenthyNine Exercises" number:29];
            self.theDataObject.selectPart=newExercises;
            break;
        case 35:
            self.theDataObject.useOtherVersion=YES;
            newExercises=[ExercisesData newExercisesWithName:@"Exercises 34" description:@"ThirtyFiveExercises" number:34];
            self.theDataObject.selectPart=newExercises;
              break;
            
        case 40:
            self.theDataObject.useOtherVersion=YES;
            newExercises=[ExercisesData newExercisesWithName:@"Exercises 39" description:@"ThirtyFiveExercises" number:39];
            self.theDataObject.selectPart=newExercises;
            break;

        default:
            break;
    }
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
