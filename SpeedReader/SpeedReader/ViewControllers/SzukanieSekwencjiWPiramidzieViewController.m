//
//  ExercisesTwentyNineViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/24/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SzukanieSekwencjiWPiramidzieViewController.h"

@interface SzukanieSekwencjiWPiramidzieViewController ()

@end

@implementation SzukanieSekwencjiWPiramidzieViewController

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
    self.actuallSize=(int)self.sizeSlider.value;
    self.toFind=[[NSString alloc]init];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.sizeSlider.value]description];
    [self create];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)create
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
    
    for(int x=0;x<self.actuallSize;x++)
    {
        if (self.mode)
        {bound=10;
            lowBound=0;
            rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            
            self.toFind=[self.toFind stringByAppendingString:[NSString stringWithFormat:@"%d",[numValue intValue]]];
        }
        else
        {
            bound=26;
            lowBound=1;
            rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            
            self.toFind=[self.toFind stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
        }
    }
    
    textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
    
    for (int i=0; i<10; i++)
    {
        for (int x = 0; x < i * 2; x++)
        {
                    if (self.mode)
                    {
                        
                        if (arc4random_uniform(10) == 5 && x < i * 2 - self.actuallSize)
                        {
                            textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
                            x += self.actuallSize;
                        }
                        bound=10;
                        lowBound=0;
                        rndValue= lowBound + arc4random() % (bound - lowBound);
                        numValue=[[NSNumber alloc]initWithInt:rndValue];
                        
                        textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%d",[numValue intValue]]];
                        
                       
                    }
                    else
                    {
                        if (arc4random_uniform(10)  == 5 && x < i * 2 - self.actuallSize)
                        {
                            textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
                            x += self.actuallSize;
                        }
                        
                        bound=26;
                        lowBound=1;
                        rndValue= lowBound + arc4random() % (bound - lowBound);
                        numValue=[[NSNumber alloc]initWithInt:rndValue];
                        
                        textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
                        
                    }
            }
        
          textToDisplay=[textToDisplay stringByAppendingString:@"\n"];
    }
    
  
    self.textLabel.text=textToDisplay;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.toFind options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:textToDisplay options:0 range:NSMakeRange(0, [textToDisplay length])];
    NSLog(@"Found %i",numberOfMatches);
    
    self.goodAnswer=numberOfMatches-1;

self.textLabel.textAlignment=NSTextAlignmentCenter;
self.textLabel.text=textToDisplay;
[self.textLabel sizeToFit];
self.textLabel.center = CGPointMake(self.view.frame.size.width/2, 300);

}

- (IBAction)sizeChange:(id)sender {
    self.actuallSize=(int)self.sizeSlider.value;
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.sizeSlider.value]description];

    [self create];
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

- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    [self create];
}

- (IBAction)startPush:(id)sender {
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    [self create];
}
@end
