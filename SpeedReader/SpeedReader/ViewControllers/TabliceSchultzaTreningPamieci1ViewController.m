//
//  TabliceSchultzaTreningPamieci1ViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "TabliceSchultzaTreningPamieci1ViewController.h"

@interface TabliceSchultzaTreningPamieci1ViewController ()

@end

@implementation TabliceSchultzaTreningPamieci1ViewController

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
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createSlider];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    self.hideNumber=NO;
    
    NSUInteger index = (NSUInteger)(self.squareSizeSlider.value + 0.5);
    [self.squareSizeSlider setValue:index animated:NO];
    NSNumber *number = self.numbersSquareSize[index]; // <-- This numeric value you want
    self.squareSize=[number intValue];
    NSUInteger index1 = (NSUInteger)(self.wordLengthSlider.value + 0.5);
    [self.wordLengthSlider setValue:index1 animated:NO];
    NSNumber *number1 = self.numbersWordLength[index1]; // <-- This numeric value you want
    self.wordSize=[number1 intValue];

    
    self.squareSizeCounterLabel.text=[number description];
    self.wordLengthCounterLabel.text=[number1 description];
    self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt: self.wordShowSlider.value]description];
    // Do any additional setup after loading the view.
}

-(void)createSlider
{
    self.numbersWordLength=[[NSMutableArray alloc]init];
    for (int i=1; i<4; i++) {
        [self.numbersWordLength addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numbersWordLength count] - 1);
    self.wordLengthSlider.maximumValue = numberOfSteps;
    self.wordLengthSlider.minimumValue = 0;
    [self.wordLengthSlider setValue:0 animated:YES];
    self.wordSize=[[self.numbersWordLength objectAtIndex:0]integerValue];
    
    // As the slider moves it will continously call the -valueChanged:
    self.wordLengthSlider.continuous = NO; // NO makes it call only once you let go
    [ self.wordLengthSlider addTarget:self
                               action:@selector(wordLengthChange:)
                     forControlEvents:UIControlEventValueChanged];
    
    self.numbersSquareSize=[[NSMutableArray alloc]init];
    for (int i=1; i<5; i++) {
        if(i==1)
            [self.numbersSquareSize addObject:[[NSNumber alloc]initWithInt:2]];
else
        [self.numbersSquareSize addObject:[[NSNumber alloc]initWithInt:pow(i, 2)]];
    }
    // slider values go from 0 to the number of values in your numbers array
    numberOfSteps = ((float)[self.numbersSquareSize count] - 1);
    self.squareSizeSlider.maximumValue = numberOfSteps;
    self.squareSizeSlider.minimumValue = 0;
    [self.squareSizeSlider setValue:0 animated:YES];
    
    self.squareSize=[[self.numbersSquareSize objectAtIndex:0]integerValue];
    // As the slider moves it will continously call the -valueChanged:
    self.squareSizeSlider.continuous = NO; // NO makes it call only once you let go
    [ self.squareSizeSlider addTarget:self
                               action:@selector(squareSizeChange:)
                     forControlEvents:UIControlEventValueChanged];
    
    
    
}

-(void)createNumber
{
    for(int i=0;i<sqrt(self.squareSize);i++)
    {
        for(int j=0;j<sqrt(self.squareSize);j++)
        {
            // CGRect Rect= CGRectMake(0,0, 50, 50);
            CGRect Rect1= CGRectMake(30+i*70,30+j*70, 70, 70);
            
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect1];
            [rectangleToAdd setBounds:Rect1];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
            
            /* CATextLayer *label = [[CATextLayer alloc] init];
             [label setFont:@"Helvetica-Bold"];
             [label setFontSize:20];
             [label setFrame:Rect1];
             [label setString:[NSString stringWithFormat:@"DD%d",i*self.horizontalSize+j]];
             [label setAlignmentMode:kCAAlignmentCenter];
             [label setForegroundColor:[[UIColor blackColor] CGColor]];
             [label addSublayer:rectangleToAdd];*/
            [self.numberDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Number %d",i*(int)sqrt(self.squareSize)+j]];
            if(self.squareSize==2)
                break;
            // [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];
        }
    }
    
    
}

-(void)addNumberToObject
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
    NSString* letters=[[NSString alloc]init];
    
    for (int i=0; i<self.squareSize; i++) {
        CALayer* singleLayer=[self.numberDic valueForKey:[NSString stringWithFormat:@"Number %d",i]];
        for (int j=0; j<self.wordSize; j++) {
            
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
            
            if (self.mode) {
                textToDisplay=[textToDisplay stringByAppendingString:[numValue stringValue]];
            }
            else
                
                textToDisplay=[textToDisplay stringByAppendingString:letters];
        }
        
        
        
        
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        CGRect rect= singleLayer.frame;
        rect.origin.x+=5;
        rect.origin.y+=5;
        [label setFrame:rect];
        [label setString:textToDisplay];
        textToDisplay=[[NSString alloc]init];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        
        [singleLayer addSublayer:label];
        [self.numberDic setObject:singleLayer forKey:[NSString stringWithFormat:@"Number %d",i]];
        /* self.textLabel.textAlignment=NSTextAlignmentCenter;
         self.textLabel.text=textToDisplay;
         [self.textLabel sizeToFit];
         self.textLabel.center = CGPointMake(self.view.frame.size.width/2, 300);*/
    }
}

-(void)addObjectToLayer
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.numberDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
    }
}

- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.gameView.layer.sublayers=nil;
    
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
   // [self addObjectToLayer];
    //self.gameView.layer.sublayers=nil;
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    

    
    
}
- (IBAction)squareSizeChange:(id)sender {
    
    NSUInteger index = (NSUInteger)(self.squareSizeSlider.value + 0.5);
    [self.squareSizeSlider setValue:index animated:NO];
    NSNumber *number = self.numbersSquareSize[index]; // <-- This numeric value you want
    self.squareSize=[number intValue];
    
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    

    self.squareSizeCounterLabel.text=[number description];
 
}

- (IBAction)wordLengthChange:(id)sender {
    NSUInteger index = (NSUInteger)(self.wordLengthSlider.value + 0.5);
    [self.wordLengthSlider setValue:index animated:NO];
    NSNumber *number = self.numbersWordLength[index]; // <-- This numeric value you want
    self.wordSize=[number intValue];
    
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    

    self.wordLengthCounterLabel.text=[number description];
  
}

- (IBAction)startPush:(id)sender {
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
   
   
        self.showTableTimer = [NSTimer scheduledTimerWithTimeInterval:(self.wordShowSlider.value/1000)
                                                               target:self selector:@selector(startGame) userInfo:nil repeats:YES];
    
        
}
-(void)startGame
{
    self.gameView.layer.sublayers=nil;
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

- (IBAction)showTimeChange:(id)sender {
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowSlider.value]description];
    

}
- (IBAction)showHidePush:(id)sender {
    self.hideNumber=!self.hideNumber;
    if(   self.hideNumber)
    self.gameView.layer.sublayers=nil;
    else
    [self addObjectToLayer];

}
@end
