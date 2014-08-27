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
    // Do any additional setup after loading the view.
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
