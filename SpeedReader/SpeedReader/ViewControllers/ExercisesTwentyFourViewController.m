//
//  ExercisesTwentyFourViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesTwentyFourViewController.h"

@interface ExercisesTwentyFourViewController ()

@end

@implementation ExercisesTwentyFourViewController

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
    self.mode=NO;
    self.actuallSize=1;
    [self create];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)create
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* strValue=[[NSString alloc]init];
    NSString* strBreak;
    NSString* textToDisplay=[[NSString alloc]init];
    NSString* letters=[[NSString alloc]init];
   
    for (int i=0; i<10; i++) {
        for (int j=0; j<3; j++)
        {
            
            switch (self.actuallSize)
            {
                case 1:
                    
                    if(self.mode)
                    {
                        bound=10;
                        lowBound=bound/10;
                    }
                    else
                    {
                        bound=26;
                        lowBound=1;
                    }
                    rndValue= lowBound + arc4random() % (bound - lowBound);
                    numValue=[[NSNumber alloc]initWithInt:rndValue];
                    
                    letters=[NSString stringWithFormat:@"%c",[numValue intValue]+96];
                    
                    break;
                case 2:
                    //if (self.mode) {
                    if(self.mode)
                    {
                        bound=100;
                        lowBound=bound/10;
                    }
                    else
                    {
                        bound=26;
                        lowBound=1;
                    }
                   
                    rndValue = lowBound + arc4random() % (bound - lowBound);
                    numValue=[[NSNumber alloc]initWithInt:rndValue];
                    letters=[NSString stringWithFormat:@"%c",[numValue intValue]+96];
                    if (j==1) {
                        numValue=[[NSNumber alloc]initWithInt:rndValue/10];
                    }
                    else
                    {
                        rndValue = lowBound + arc4random() % (bound - lowBound);
                        numValue=[[NSNumber alloc]initWithInt:rndValue];
                        letters=[letters stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
                    }
                   // }
                    // strValue=[NSString stringWithUTF8String:(char)[numValue intValue]];
                    break;
                case 3:
                    if(self.mode)
                    {
                        bound=100;
                        lowBound=bound/10;
                    }
                    
                    else
                    {
                        bound=26;
                        lowBound=1;
                    }
                    int rndValue = lowBound + arc4random() % (bound - lowBound);
                         numValue=[[NSNumber alloc]initWithInt:rndValue];
                        letters=[NSString stringWithFormat:@"%c",[numValue intValue]+96];

                        if (j==1) {
                            numValue=[[NSNumber alloc]initWithInt:rndValue/10];
                        }
                        else
                        {
                            int rndValue = lowBound + arc4random() % (bound - lowBound);
                            numValue=[[NSNumber alloc]initWithInt:rndValue];
                             letters=[letters stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
                            rndValue = lowBound + arc4random() % (bound - lowBound);
                            numValue=[[NSNumber alloc]initWithInt:rndValue];
                            letters=[letters stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
                        }
                    
                    //strValue=[NSString stringWithUTF8String:(char)[numValue intValue]];
                    break;
                    
                default:
                    break;
                    
            }
            
            if (self.mode) {
            textToDisplay=[textToDisplay stringByAppendingString:[numValue stringValue]];
            }
            else
                
                textToDisplay=[textToDisplay stringByAppendingString:letters];
            
            if (j!=2) {
                strBreak=[@"" stringByPaddingToLength:i+3 withString:@" " startingAtIndex:0];
                textToDisplay=[textToDisplay stringByAppendingString:strBreak];
            }
            if (j==2) {
                textToDisplay=[textToDisplay stringByAppendingString:@"\n"];
                textToDisplay=[textToDisplay stringByAppendingString:@"\n"];
                
            }
        }
    }
    self.exercisesTwentyFourText.textAlignment=NSTextAlignmentCenter;
    self.exercisesTwentyFourText.text=textToDisplay;
    [self.exercisesTwentyFourText sizeToFit];
    self.exercisesTwentyFourText.center = CGPointMake(self.view.frame.size.width/2, 300);
    
}

- (IBAction)sizeChange:(id)sender {
    self.actuallSize=(int)self.exercisesTwentyFourSlider.value;
    self.exercisesTwentyFourText.text=nil;
     [self.exercisesTwentyFourText sizeToFit];
    [self create];
}
@end
