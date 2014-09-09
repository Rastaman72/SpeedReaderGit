//
//  TreningPoszerzajacyWidzenieViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "TreningPoszerzajacyWidzenieViewController.h"

@interface TreningPoszerzajacyWidzenieViewController ()

@end

@implementation TreningPoszerzajacyWidzenieViewController

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
    self.mode=self.selectModeSwitch;
    [self createSlider];
    [self createNumber];
    [self addObjectToLayer];
    // Do any additional setup after loading the view.
}


-(void)createSlider
{
    self.numbersOfLinesArray=[[NSMutableArray alloc]init];
    for (int i=1; i<5; i++) {
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
                                  action:@selector(numbersOfLineChange:)
                        forControlEvents:UIControlEventValueChanged];
    
    self.numbersOfLineCounterLabel.text=[[[NSNumber alloc]initWithInt:self.numbersOfLine ] description];
    
    
    self.numbersWordLengthArray=[[NSMutableArray alloc]init];
    for (int i=1; i<11; i++) {
        [self.numbersWordLengthArray addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps1 = ((float)[self.numbersWordLengthArray count] - 1);
    self.wordLengthSlider.maximumValue = numberOfSteps1;
    self.wordLengthSlider.minimumValue = 0;
    [self.wordLengthSlider setValue:0 animated:YES];
    self.wordLength=[[self.numbersWordLengthArray objectAtIndex:0]integerValue];
    
    // As the slider moves it will continously call the -valueChanged:
    self.wordLengthSlider.continuous = NO; // NO makes it call only once you let go
    [ self.wordLengthSlider addTarget:self
                                  action:@selector(wordLengthChange:)
                        forControlEvents:UIControlEventValueChanged];
    
    self.wordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordLength ] description];
}

-(void)createNumber
{
    NSString* textToDisplay=[[NSString alloc]init];
    int bound=self.numbersOfLine;

   // if(self.numbersOfLine==1)
     //   bound=1;
     int upperBound;
    int lowBound = 0;
    int rndValue;
    int actualPosition=0;
    CGRect Rect1;
     NSNumber* numValue;
    if (self.mode) {
        for (int i=0; i<self.numbersOfLine*2; i++) {
            
            for (int j=0; j<self.wordLength; j++) {
                
                
                upperBound=10;
                lowBound=bound/10;
                
                rndValue= lowBound + arc4random() % (upperBound - lowBound);
                numValue=[[NSNumber alloc]initWithInt:rndValue];
                
                
                textToDisplay=[textToDisplay stringByAppendingString:[numValue description]];
            }
            if(i<bound)
            {
                Rect1= CGRectMake(10,30+actualPosition*20, 150, 30);
                actualPosition++;
                
            }
            else if(i==bound)
            {
                actualPosition=0;
                Rect1= CGRectMake(100,30+actualPosition*20, 150, 30);
                actualPosition++;
            }
            else
            {
                Rect1= CGRectMake(100,30+actualPosition*20, 150, 30);
                actualPosition++;
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
            
        }
     }
    
    else{
        for (int i=0; i<self.numbersOfLine*2; i++) {
            
          
            if(self.wordLength<3)
            {
                for (int j=0; j<self.wordLength; j++) {

                upperBound=26;
                lowBound=1;
                
                rndValue= lowBound + arc4random() % (upperBound - lowBound);
                numValue=[[NSNumber alloc]initWithInt:rndValue];
                
                 textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
            }
            }
            
                else
            textToDisplay=[textToDisplay stringByAppendingString:[self.xmlManager getWord:self.wordLength]];
            
                if(i<bound)
                {
                    Rect1= CGRectMake(0,30+actualPosition*20, 150, 30);
                    actualPosition++;
                    
                }
                else if(i==bound)
                {
                    actualPosition=0;
                    Rect1= CGRectMake(70+[textToDisplay length]*5,30+actualPosition*20, 150, 30);
                    actualPosition++;
                }
                else
                {
                    Rect1= CGRectMake(70+[textToDisplay length]*5,30+actualPosition*20, 150, 30);
                    actualPosition++;
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
            
    }
    }
   
    
    
    
    
    
        // [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];
        // }
    

    
    
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

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (IBAction)numbersOfLineChange:(id)sender {
    NSUInteger index = (NSUInteger)(self.numbersOfLineSlider.value + 0.5);
    [self.numbersOfLineSlider setValue:index animated:NO];
    NSNumber *number = self.numbersOfLinesArray[index]; // <-- This numeric value you want
    self.numbersOfLine=[number intValue];
    self.numbersOfLineCounterLabel.text=[number description];
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    self.xmlManager=[self theAppDataObject];
    [self createNumber];
    [self addObjectToLayer];
}


-(IBAction)wordLengthChange:(id)sender
{
    NSUInteger index = (NSUInteger)(self.wordLengthSlider.value + 0.5);
    [self.wordLengthSlider setValue:index animated:NO];
    NSNumber *number = self.numbersWordLengthArray[index]; // <-- This numeric value you want
    self.wordLength=[number intValue];
    self.wordLengthCounterLabel.text=[number description];
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    self.xmlManager=[self theAppDataObject];
    [self createNumber];
    [self addObjectToLayer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addObjectToLayer];
    //self.gameView.layer.sublayers=nil;
    
    
    
}

- (IBAction)startPush:(id)sender {
    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addObjectToLayer];
    
    
    self.moveObjects = [NSTimer scheduledTimerWithTimeInterval:(0.5)
                                                           target:self selector:@selector(startGame) userInfo:nil repeats:YES];
    
    
}

-(void)startGame
{
    self.gameView.layer.sublayers=nil;
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
