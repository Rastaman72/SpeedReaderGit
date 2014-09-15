//
//  SzukanieZnakowMigawkiViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/15/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SzukanieZnakowMigawkiViewController.h"

@interface SzukanieZnakowMigawkiViewController ()

@end

@implementation SzukanieZnakowMigawkiViewController

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
    self.step=2;
    self.positionY=100;
    self.actuallSize=(int)self.sizeSlider.value;
    self.toFind=[[NSString alloc]init];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.sizeSlider.value]description];
    [self createSlider];
    [self createGoodAnswer];
    [self create];
    [self createButtons];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
}

-(void)checkOrientataion
{
    [self deviceOrientationDidChange:nil];
}

-(void)createGoodAnswer
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* letters=[[NSString alloc]init];
    
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
                self.toFind=[self.toFind stringByAppendingString:[numValue stringValue]];
            }
            else
                
                  self.toFind=[self.toFind stringByAppendingString:letters];
            

}
-(void)createSlider
{
    self.numbersOfLineArray=[[NSArray alloc]init];
    self.numbersOfLineArray = @[@(1), @(2), @(3), @(4), @(5)];
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numbersOfLineArray count] - 1);
    self.numbersOfLineSlider.maximumValue = numberOfSteps;
    self.numbersOfLineSlider.minimumValue = 0;
    [self.numbersOfLineSlider setValue:1 animated:YES];

    self.choosedNumbersOfLine=[[self.numbersOfLineArray objectAtIndex:1]intValue];

    self.numbersOfLineSlider.continuous = NO; // NO makes it call only once you let go
    [ self.numbersOfLineSlider addTarget:self
                         action:@selector(numbersOfLineChange:)
               forControlEvents:UIControlEventValueChanged];
    self.numbersOfLineCounterLabel.text=[[[NSNumber alloc]initWithInt:self.choosedNumbersOfLine]description];
    
    
    
    
    self.numberSizerray=[[NSArray alloc]init];
    self.numberSizerray = @[@(3), @(4), @(5), @(6), @(7)];
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps1 = ((float)[self.numberSizerray count] - 1);
    self.sizeSlider.maximumValue = numberOfSteps1;
    self.sizeSlider.minimumValue = 0;
    [self.sizeSlider setValue:2 animated:YES];
    
    self.choosedSize=[[self.numberSizerray objectAtIndex:2]intValue];
    
    self.sizeSlider.continuous = NO; // NO makes it call only once you let go
    [ self.sizeSlider addTarget:self
                                  action:@selector(sizeChange:)
                        forControlEvents:UIControlEventValueChanged];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.choosedSize]description];
    
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    //Obtain current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(orientation==UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight)
    {
        if(!self.changePosition)
        {
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y-=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y-=225;
            [self.startButton setFrame:toChangeStartButton];
            
            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y-=225;
            [self.sizeView setFrame:toChangeSizeView];
            
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y-=150;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeWordShowTimeView= self.wordShowTimeView.frame;
            toChangeWordShowTimeView.origin.y-=225;
            [self.wordShowTimeView setFrame:toChangeWordShowTimeView];
            
            
            
            
            
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y+=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y+=225;
            [self.startButton setFrame:toChangeStartButton];
            
            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y+=225;
            [self.sizeView setFrame:toChangeSizeView];
            
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y+=150;
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeWordShowTimeView= self.wordShowTimeView.frame;
            toChangeWordShowTimeView.origin.y+=225;
            [self.wordShowTimeView setFrame:toChangeWordShowTimeView];
            

            
            self.changePosition=NO;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createButtons
{
    for (int i=0; i<11; i++) {
        CGRect Rect1= CGRectMake(10+60*i,3*self.gameView.frame.size.height/4, 60, 20);
        //  CGRect Rect = CGRectMake(Rect1.origin.x, Rect1.origin.y+2, 20, 20);
        
        CALayer* rectangleToAdd = [CALayer layer];
        [rectangleToAdd setFrame:Rect1];
        [rectangleToAdd setBounds:Rect1];
        [rectangleToAdd setCornerRadius:5.0f];
        [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
        [rectangleToAdd setOpacity:1.0f];
        
        
        CGRect Rect=rectangleToAdd.frame;
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect];
        if (i==10) {
            [label setString:[NSString stringWithFormat:@"%d+",10]];
        }
        else
            [label setString:[NSString stringWithFormat:@"%d",i]];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        [rectangleToAdd addSublayer:label];
        
        [self.gameView.layer insertSublayer:rectangleToAdd atIndex:i];
        [self.gameView.layer setValue:rectangleToAdd forKeyPath:[NSString stringWithFormat:@"Number %d",i]];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    
    for (CALayer* singleLayer in self.gameView.layer.sublayers)
    {
        
        if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
        {
            
            NSString* choosedAnswer=[[NSString alloc]init];
            choosedAnswer=[[singleLayer.sublayers firstObject]string];
            int answer=[choosedAnswer intValue];
            
            
            int resultInPercent = 100;
            if (self.goodAnswer != answer)
            {
                
                if (self.goodAnswer != 0 && answer!= 0)
                {
                    if (self.goodAnswer < answer)
                    {
                        resultInPercent = (int)(((float)self.goodAnswer / (float)answer) * 100.0f);
                    }
                    else
                    {
                        resultInPercent = (int)(((float)answer / (float)self.goodAnswer) * 100.0f);
                    }
                }
                
                else
                {
                    resultInPercent = 0;
                }
            }
            if (answer == 10 && self.goodAnswer >= 10)
                resultInPercent = 100;
            
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Result" message:[NSString stringWithFormat:@"You get %d %% correct. It was %d times",resultInPercent,self.goodAnswer] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            
        }
    }
    
    
    
    
    
    
}


- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startPush:self];
}

- (void)createObject:(NSString **)textToDisplay_p size:(int)size
{
    NSNumber *numValue;
    int rndValue;
    int lowBound;
    int bound;
    for (int x = 0; x < size; x++)
    {
        if (self.mode)
        {
            
            if (arc4random_uniform(8) == 5)
            {
                *textToDisplay_p=[*textToDisplay_p stringByAppendingString:self.toFind];
                continue;
            }
            
            bound=10;
            lowBound=0;
            rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            
            *textToDisplay_p=[*textToDisplay_p stringByAppendingString:[NSString stringWithFormat:@"%d",[numValue intValue]]];
            
            
        }
        else
        {
            if (arc4random_uniform(8) == 5)
            {
                *textToDisplay_p=[*textToDisplay_p stringByAppendingString:self.toFind];
                continue;
            }
            
            bound=26;
            lowBound=1;
            rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            
            *textToDisplay_p=[*textToDisplay_p stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
            
        }
    }
}

-(void)create
{
   
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
     int bound=self.choosedNumbersOfLine/2;
    int size=self.choosedSize;
   // textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
    
    
        for (int i=0; i<self.choosedNumbersOfLine; i++)
        {
            if (i<bound)
                
            {
                [self createObject:&textToDisplay size:size];

                size+=self.step;
            }

            else if(i==bound)
            {
                
                if(self.choosedNumbersOfLine%2==0)
                {
                    size-=self.step;
                    
                }
                [self createObject:&textToDisplay size:size];
                  size-=self.step;

            }
            
            else
            {
                [self createObject:&textToDisplay size:size];
                size-=self.step;


            }
            
        
     textToDisplay=[textToDisplay stringByAppendingString:@"\n"];
   
   }
    
    
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.toFind options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:textToDisplay options:0 range:NSMakeRange(0, [textToDisplay length])];
    NSLog(@"Found %i",numberOfMatches);
    
    self.goodAnswer=numberOfMatches;
    
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    self.textLabel.text=textToDisplay;
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.gameView.frame.size.width/2, self.positionY);
            
   
}

- (IBAction)sizeChange:(id)sender {
    NSUInteger index = (NSUInteger)(self.sizeSlider.value + 0.5);
    [self.sizeSlider setValue:index animated:NO];
    NSNumber *number = self.numberSizerray[index]; // <-- This numeric value you want
    self.choosedSize=[number intValue];

    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.choosedSize]description];
     [self createGoodAnswer];
    [self create];
}

- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
     [self createGoodAnswer];
    [self create];
}

- (IBAction)startPush:(id)sender {
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
     [self createGoodAnswer];
    [self create];
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    
    
    self.showTableTimer = [NSTimer scheduledTimerWithTimeInterval:(self.wordShowTimeSlider.value/1000)
                                                           target:self selector:@selector(startGame) userInfo:nil repeats:NO];
    

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
-(void)startGame
{
    self.textLabel.text=nil;
   }

- (IBAction)numbersOfLineChange:(id)sender {
    NSUInteger index = (NSUInteger)(self.numbersOfLineSlider.value + 0.5);
    [self.numbersOfLineSlider setValue:index animated:NO];
    NSNumber *number = self.numbersOfLineArray[index]; // <-- This numeric value you want
    self.choosedNumbersOfLine=[number intValue];
    
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    self.numbersOfLineCounterLabel.text=[[[NSNumber alloc]initWithInt:self.choosedNumbersOfLine]description];
   // self.gameView.layer.sublayers=nil;
     [self createGoodAnswer];
    [self create];

 
}
- (IBAction)wordShowTimeView:(id)sender {
    [self.showTableTimer invalidate];
    self.showTableTimer = nil;
    self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowTimeSlider.value]description];

}
@end
