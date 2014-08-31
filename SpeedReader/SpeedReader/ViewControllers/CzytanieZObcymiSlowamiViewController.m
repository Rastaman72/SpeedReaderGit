//
//  ExercisesFiveViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/18/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "CzytanieZObcymiSlowamiViewController.h"
#define lowNumber 3
#define upNumber 10
@interface CzytanieZObcymiSlowamiViewController ()

@end

@implementation CzytanieZObcymiSlowamiViewController

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
    //self.exercisesFiveText.text=self.xmlManager.exercisesText;
    //[self.xmlManager getExercisesWords];
    // Do any additional setup after loading the
    NSString* resultText=[NSString stringWithString:[self putRandomWord]];
    self.textView.text=resultText;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableString*)putRandomWord
{
    NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[self.xmlManager.exercisesText componentsSeparatedByString:@" "]];
    NSMutableString* resultText=[[NSMutableString alloc]init];
    for (NSString* singleWord in words) {
        resultText=[resultText stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
        
        int r = arc4random() % 6;
        if (r==3) {
            
        int rndValue = lowNumber + arc4random() % (upNumber - lowNumber);
        NSString* test=[self.xmlManager getWord:rndValue];
        
         resultText=[resultText stringByAppendingString:[NSString stringWithFormat:@"%@ ",test]];
        }
    }
    NSLog(@"%@",resultText);
    return resultText ;
   
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

- (IBAction)startPush:(id)sender {
}
@end
