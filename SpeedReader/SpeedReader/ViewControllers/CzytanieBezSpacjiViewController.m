//
//  ExerciseTwoViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/27/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "CzytanieBezSpacjiViewController.h"

@interface CzytanieBezSpacjiViewController ()

@end

@implementation CzytanieBezSpacjiViewController

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
    self.xmlManager=[self theAppDataObject];
    [self.xmlManager getExercisesText];
    [self createText];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
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
            CGRect toChangeTextView= self.textView.frame;
            toChangeTextView.size.height-=10;
            [self.textView setFrame:toChangeTextView];
          
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeTextView= self.textView.frame;
            toChangeTextView.size.height+=10;
            [self.textView setFrame:toChangeTextView];
            
           
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createText
{
    NSString* toFormat=self.xmlManager.exercisesText;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\n ,\"?-!():%;."];
    toFormat = [[toFormat componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    toFormat=[toFormat lowercaseString];
    self.textView.text=toFormat;
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
