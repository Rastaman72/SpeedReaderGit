//
//  ExercisesDispatcherViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesDispatcherViewController.h"

@interface ExercisesDispatcherViewController ()

@end

@implementation ExercisesDispatcherViewController

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
#pragma mark - Navigation
/*-(void)test
{
//    UIViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EXC1"];
//    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"" source:self destination:toViewController];
//
//    [self prepareForSegue:segue sender:self];
//    
    ExercisesData* choosedExercises=(ExercisesData*)self.theDataObject.selectPart;


   
    NSString * storyboardName = @"Main_iPad";
    NSString * viewControllerID = [NSString stringWithFormat:@"EXC%d",choosedExercises.choosedExercises];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController * controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    [self presentViewController:controller animated:YES completion:nil];
    }
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ExercisesData* choosedExercises=(ExercisesData*)self.theDataObject.selectPart;
    switch (choosedExercises.choosedExercises) {
        case 1:
        {
                        Czytanie2WierszeNaRazViewController *LVC = (Czytanie2WierszeNaRazViewController *)segue.destinationViewController;
            break;
            
        }
        case 2:
        {
            ExercisesTwoViewController *LVC = (ExercisesTwoViewController *)segue.destinationViewController;
            break;
            
        }


            
        default:
            break;
    }
//    if([segue.identifier isEqualToString:@"EXC1"]){
//        
//    }
//    else  if([segue.identifier isEqualToString:@"EXC2"]){
//        ExercisesTwoViewController *LVC = (ExercisesTwoViewController *)segue.destinationViewController;
//       
//    }
}



- (IBAction)push:(id)sender {
    [self performSegueWithIdentifier:@"EXC1" sender:self];

}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
@end
