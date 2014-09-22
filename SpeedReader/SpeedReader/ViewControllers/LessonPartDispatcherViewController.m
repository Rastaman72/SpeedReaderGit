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

-(void)test1:(int)excNumber params:(NSMutableDictionary*)dicParams
{
    self.theDataObject=[self theAppDataObject];
 //   ExercisesData* choosedExercises=(ExercisesData*)self.theDataObject.selectPart;
    
    //FIX LOAD VIEW
    self.theDataObject.useOtherVersion=NO;
    NSString * storyboardName = @"Main_iPad";
    
    switch (excNumber) {
        case 4:
            excNumber=3;
            self.theDataObject.useOtherVersion=YES;

            break;
            
        case 8:
            excNumber=7;
            self.theDataObject.useOtherVersion=YES;
            
            break;
        
        case 11:
            excNumber=10;
            self.theDataObject.useOtherVersion=YES;

            break;
            
        case 30:
            excNumber=29;
            self.theDataObject.useOtherVersion=YES;
            break;
            
        case 35:
            excNumber=34;
            self.theDataObject.useOtherVersion=YES;
            break;
            
        case 40:
            excNumber=39;
            self.theDataObject.useOtherVersion=YES;
            break;
            
        default:
            break;
    }
    
    
    NSString * viewControllerID = [NSString stringWithFormat:@"EXC%d",excNumber];
     //  NSString * viewControllerID = @"EXC11";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController * controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    self.theDataObject.dismmisView=YES;
    self.theDataObject.paramsForSpecifyExc=[[NSMutableDictionary alloc]initWithDictionary:dicParams copyItems:YES];
    self.theDataObject.excMode=NO;
  //  [self setExcParams:controller params:dicParams excNumber:excNumber];
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
