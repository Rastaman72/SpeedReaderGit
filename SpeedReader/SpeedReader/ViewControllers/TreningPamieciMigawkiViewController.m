//
//  TreningPamieciMigawkiViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/8/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "TreningPamieciMigawkiViewController.h"

@interface TreningPamieciMigawkiViewController ()

@end

@implementation TreningPamieciMigawkiViewController

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
     self.xmlManager=[self theAppDataObject];
    [self createSlider];
   //[self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
   
    
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
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
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
         
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y-=25;
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y-=225;
            [self.setModeView setFrame:toChangeSetModeView];

            
            
            CGRect toChangeWordShowTimeView= self.wordShowTImeView.frame;
            toChangeWordShowTimeView.origin.y-=225;
            [self.wordShowTImeView setFrame:toChangeWordShowTimeView];

            
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y-=225;
            [self.startButton setFrame:toChangeStartButton];

            
            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y-=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];

            
            
            CGRect toChangeSquareSizeView= self.squareSizeView.frame;
            toChangeSquareSizeView.origin.y-=225;
            [self.squareSizeView setFrame:toChangeSquareSizeView];

            
            
            
       
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y+=25;
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y+=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            
            
            CGRect toChangeWordShowTimeView= self.wordShowTImeView.frame;
            toChangeWordShowTimeView.origin.y+=225;
            [self.wordShowTImeView setFrame:toChangeWordShowTimeView];
            
            
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y+=225;
            [self.startButton setFrame:toChangeStartButton];
            
            
            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y+=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];
            
            
            
            CGRect toChangeSquareSizeView= self.squareSizeView.frame;
            toChangeSquareSizeView.origin.y+=225;
            [self.squareSizeView setFrame:toChangeSquareSizeView];
        
            self.changePosition=NO;
        }
    }
    
}
-(void)createSlider
{
    self.numbersWordLength=[[NSMutableArray alloc]init];
    for (int i=3; i<24; i++) {
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
    for (int i=1; i<6; i++) {
        
            [self.numbersSquareSize addObject:[[NSNumber alloc]initWithInt:i]];
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
            CGRect Rect1= CGRectMake(30+i*70,30+j*70, 500, 70);
            
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
    CGRect Rect1;

    
    if (self.mode) {
        for (int i=0; i<self.squareSize; i++) {
            
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
                
                
                textToDisplay=[textToDisplay stringByAppendingString:[numValue description]];
        }
                Rect1= CGRectMake(50,30+i*20, 500, 30);
                
                CATextLayer *label = [[CATextLayer alloc] init];
                [label setFont:@"Helvetica-Bold"];
                [label setFontSize:20];
                [label setFrame:Rect1];
                [label setString:textToDisplay];
                textToDisplay=[[NSString alloc]init];
                [label setAlignmentMode:kCAAlignmentCenter];
                [label setForegroundColor:[[UIColor blackColor] CGColor]];
                
                
                [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i]];

            }
        }
    //}
    else{
        for (int i=0; i<self.squareSize; i++) {
            
            
            textToDisplay=[textToDisplay stringByAppendingString:[self.xmlManager getWord:self.wordSize]];

        Rect1= CGRectMake(50,30+i*20, 500, 30);
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect1];
        [label setString:textToDisplay];
        textToDisplay=[[NSString alloc]init];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        
        [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i]];
    }
    }
    
   
    
    
    
    
    
    
        /* self.textLabel.textAlignment=NSTextAlignmentCenter;
         self.textLabel.text=textToDisplay;
         [self.textLabel sizeToFit];
         self.textLabel.center = CGPointMake(self.view.frame.size.width/2, 300);*/
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
  //  [self createNumber];
    [self addNumberToObject];
     [self addObjectToLayer];
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
    //[self createNumber];
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
    //[self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    
    
    self.wordLengthCounterLabel.text=[number description];
    
}

- (IBAction)startPush:(id)sender {
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    //[self createNumber];
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

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (IBAction)showTimeChange:(id)sender {
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowSlider.value]description];
    
    
}

@end