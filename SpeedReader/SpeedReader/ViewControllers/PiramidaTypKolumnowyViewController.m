//
//  ExercisesTwentyFourViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "PiramidaTypKolumnowyViewController.h"

@interface PiramidaTypKolumnowyViewController ()

@end

@implementation PiramidaTypKolumnowyViewController

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
    self.mode=YES;
    self.positionY=300;
    [self createSlider];
    self.wordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:(int)self.wordLengthSlider.value]description];
    [self create];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
}


-(void)checkOrientataion
{
    [self deviceOrientationDidChange:nil];
}

-(void)createSlider
{
    self.wordLengthArray=[[NSArray alloc]init];
    self.wordLengthArray = @[@(1), @(2), @(3)];
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.wordLengthArray count] - 1);
    self.wordLengthSlider.maximumValue = numberOfSteps;
    self.wordLengthSlider.minimumValue = 0;
    [self.wordLengthSlider setValue:0 animated:YES];
    
    //self.chooseSize=[[self.numberSize objectAtIndex:0]integerValue];
    //    self.chooseSize = [[[NSNumber alloc]initWithInt: [self.numberSize[0]intValue]]intValue];
    //    NSLog(@"%d",[[self.numberSize objectAtIndex:0]intValue]);
    self.actuallSize=[[self.wordLengthArray objectAtIndex:0]intValue];
    // As the slider moves it will continously call the -valueChanged:
    self.wordLengthSlider.continuous = NO; // NO makes it call only once you let go
    [ self.wordLengthSlider addTarget:self
                         action:@selector(sizeChange:)
               forControlEvents:UIControlEventValueChanged];
    self.wordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.actuallSize]description];


    
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    //Obtain current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(orientation==UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight)
    {
        if(!self.changePosition)
        {
            CGRect toChangeTextLabel= self.textLabel.frame;
            toChangeTextLabel.origin.y-=90;
            [self.textLabel setFrame:toChangeTextLabel];
            
            self.positionY-=90;
            
            
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y-=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            CGRect toChangeChangeElements= self.changeElementsButton.frame;
            toChangeChangeElements.origin.y-=225;
            [self.changeElementsButton setFrame:toChangeChangeElements];
            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y-=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];
            
            
            

            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            CGRect toChangeTextLabel= self.textLabel.frame;
            toChangeTextLabel.origin.y+=90;
            [self.textLabel setFrame:toChangeTextLabel];
            

            
            
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y+=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            CGRect toChangeChangeElements= self.changeElementsButton.frame;
            toChangeChangeElements.origin.y+=225;
            [self.changeElementsButton setFrame:toChangeChangeElements];
            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y+=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];
            

             self.positionY+=90;

            
           
            self.changePosition=NO;
        }
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
                        bound=1000;
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
                            numValue=[[NSNumber alloc]initWithInt:rndValue/100];
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
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    self.textLabel.text=textToDisplay;
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.view.frame.size.width/2, self.positionY);
    
}

- (IBAction)sizeChange:(id)sender {
    
    NSUInteger index = (NSUInteger)(self.wordLengthSlider.value + 0.5);
    [self.wordLengthSlider setValue:index animated:NO];
    NSNumber *number = self.wordLengthArray[index]; // <-- This numeric value you want
    self.actuallSize=[number intValue];
    self.wordLengthCounterLabel.text=[number description];

    
    self.textLabel.text=nil;
   self.textLabel.textAlignment=NSTextAlignmentCenter;
    [self.textLabel sizeToFit];

    self.wordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:(int)self.wordLengthSlider.value]description];

    [self create];
}
- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.textLabel.text=nil;
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    [self.textLabel sizeToFit];
   
    [self create];
    
}
- (IBAction)getNewLetters:(id)sender {
    self.textLabel.text=nil;
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    [self.textLabel sizeToFit];
    
    [self create];
}
- (IBAction)changeElements:(id)sender {
}
@end
