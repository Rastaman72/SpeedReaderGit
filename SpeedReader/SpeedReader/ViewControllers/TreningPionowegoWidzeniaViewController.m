//
//  TreningPionowegoWidzeniaViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "TreningPionowegoWidzeniaViewController.h"

@interface TreningPionowegoWidzeniaViewController ()

@end

@implementation TreningPionowegoWidzeniaViewController

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
    self.objectDic=[[NSMutableDictionary alloc]init];
    self.xmlManager=[self theAppDataObject];
    self.step=2;
    [self createSlider];
    [self createNumber];
    [self addObjectToLayer];
      // Do any additional setup after loading the view.
}

-(void)createSlider
{
    self.numbersOfLinesArray=[[NSMutableArray alloc]init];
    for (int i=3; i<10; i++) {
        [self.numbersOfLinesArray addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numbersOfLinesArray count] - 1);
    self.numbersOfLineSlider.maximumValue = numberOfSteps;
    self.numbersOfLineSlider.minimumValue = 0;
    [self.numbersOfLineSlider setValue:0 animated:YES];
    self.numbersOfLine=[[self.numbersOfLinesArray objectAtIndex:0]integerValue];
    
    // As the slider moves it will continously call the -valueChanged:
    self.numbersOfLineSlider.continuous = NO; // NO makes it call only once you let go
    [ self.numbersOfLineSlider addTarget:self
                               action:@selector(numberOfLinesChange:)
                     forControlEvents:UIControlEventValueChanged];
    
    self.numbersOfLinesCounterLabel.text=[[[NSNumber alloc]initWithInt:self.numbersOfLine ] description];

    
    
}

-(void)createNumber
{
    NSString* textToDisplay=[[NSString alloc]init];
    int bound=self.numbersOfLine/2;
    int actualPosition=3;
    for(int i=0;i<self.numbersOfLine;i++)
    {
        
            CGRect Rect1= CGRectMake(70,30+i*25, 200, 25);
        
         if (i<bound)
             
         {
             
              textToDisplay=[textToDisplay stringByAppendingString:[self.xmlManager getWord:actualPosition]];
             actualPosition+=self.step;
         }
        else if(i==bound)
        {
            if(self.numbersOfLine%2==0)
            {
                actualPosition-=self.step;
                
            }

            textToDisplay=[textToDisplay stringByAppendingString:[self.xmlManager getWord:actualPosition]];
             actualPosition-=self.step;
            
        }
             else
             {
                 
                  textToDisplay=[textToDisplay stringByAppendingString:[self.xmlManager getWord:actualPosition]];
                 actualPosition-=self.step;
             }
        
       
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect1];
        [label setString:textToDisplay];
        textToDisplay=[[NSString alloc]init];
        
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        [self.objectDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i]];
            // [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];
       // }
    }
    
    
}


-(void)addObjectToLayer
{
    NSMutableArray *allKeys = [[self.objectDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.objectDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
    }
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
- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (IBAction)numberOfLinesChange:(id)sender {
    NSUInteger index = (NSUInteger)(self.numbersOfLineSlider.value + 0.5);
    [self.numbersOfLineSlider setValue:index animated:NO];
    NSNumber *number = self.numbersOfLinesArray[index]; // <-- This numeric value you want
    self.numbersOfLine=[number intValue];
    self.numbersOfLinesCounterLabel.text=[number description];
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);

    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    self.xmlManager=[self theAppDataObject];
    self.step=2;
    [self createNumber];
    [self addObjectToLayer];
}
@end
