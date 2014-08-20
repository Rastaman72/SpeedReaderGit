//
//  ExercisesSixViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesSevenViewController.h"
#define maxLength 25
#define splitLine 11
@interface ExercisesSevenViewController ()

@end

@implementation ExercisesSevenViewController

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
    NSString* resultText=[NSString stringWithString:[self createSplitText]];
     self.exercisesSevenText.textAlignment = NSTextAlignmentJustified;
    self.exercisesSevenText.text=resultText;
    self.exercisesSevenText.textAlignment = NSTextAlignmentJustified;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)createSplitText
{
    NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[self.xmlManager.exercisesText componentsSeparatedByString:@" "]];
    NSMutableString* resultText=[[NSMutableString alloc]init];
    NSString* tempString=[[NSString alloc]init];
    int lineCounter=0;
    int inSameLine=0;
    int test=50;
   // int separator=self.exercisesSevenText.frame.size.width-500;
    NSString* separatorS=[[NSString alloc]init];
    separatorS=[@"" stringByPaddingToLength:test withString:@" " startingAtIndex:0];
    
    for (NSString* singleWord in words) {
        
        if (lineCounter<splitLine)
        {
            tempString=[tempString stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
            NSLog(@"%d",[tempString length]+[[tempString componentsSeparatedByString:@" "] count]-1);
            if (([tempString length]+[[tempString componentsSeparatedByString:@" "] count]-1)<=maxLength)
            {
                resultText=[resultText stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
            }
            else
            {
                inSameLine++;
                
                if(inSameLine==2)
                {
                    lineCounter++;
                    inSameLine=0;
                    tempString=nil;
                    tempString=[[NSString alloc]init];
                    resultText=[resultText stringByAppendingString:@"\n"];
                    resultText=[resultText stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
                     tempString=[tempString stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
                    
                }
                else
                {
                    resultText=[resultText stringByAppendingString:@" "];//[NSString stringWithFormat:@"%@ ",separatorS]];
                    resultText=[resultText stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
                    tempString=nil;
                    tempString=[[NSString alloc]init];
                    tempString=[tempString stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
                    NSLog(@"%d",[tempString length]+[[tempString componentsSeparatedByString:@" "] count]-1);
                    
                }
            }
        }
        else
        {
             resultText=[resultText stringByAppendingString:[NSString stringWithFormat:@"%@ ",singleWord]];
        }
    }
    
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
