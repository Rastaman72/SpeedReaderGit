//
//  GraUkladankaViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GraUkladankaViewController.h"

@interface GraUkladankaViewController ()

@end

@implementation GraUkladankaViewController

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
    self.xmlManager = [self theAppDataObject];
    self.lettersDic=[[NSMutableDictionary alloc]init];
    self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:(int)self.wordLengthSlider.value]description];

    [self createSquare];
    [self getWord];
    [self addObjectToLayer];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
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
   
            CGRect toChangetextGameView= self.gameView.frame;
            toChangetextGameView.origin.y-=50;
             toChangetextGameView.size.height-=100;
            [self.gameView setFrame:toChangetextGameView];
            
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y-=225;
            [self.startButton setFrame:toChangetStartButton];
            
            CGRect toChangetHelpButton= self.helpButton.frame;
            toChangetHelpButton.origin.y-=225;
            [self.helpButton setFrame:toChangetHelpButton];
            
            CGRect toChangetWordLengthView= self.wordLengthView.frame;
            toChangetWordLengthView.origin.y-=225;
            [self.wordLengthView setFrame:toChangetWordLengthView];
            
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangetextGameView= self.gameView.frame;
            toChangetextGameView.origin.y+=225;
            [self.gameView setFrame:toChangetextGameView];
            
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y+=225;
            [self.startButton setFrame:toChangetStartButton];
            
            CGRect toChangetHelpButton= self.helpButton.frame;
            toChangetHelpButton.origin.y+=225;
            [self.helpButton setFrame:toChangetHelpButton];
            
            CGRect toChangetWordLengthView= self.wordLengthView.frame;
            toChangetWordLengthView.origin.y+=225;
            [self.wordLengthView setFrame:toChangetWordLengthView];
            
            
            self.changePosition=NO;
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createSquare
{
    self.actualLetter=0;

    self.word=[[NSString alloc]init];
    self.word=[self.xmlManager getWord:(int)self.wordLengthSlider.value];
    for(int i=0;i<[self.word length];i++)
    {
       
            // CGRect Rect= CGRectMake(0,0, 50, 50);
            CGRect Rect1= CGRectMake(75+i*50,75, 50, 50);
            
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect1];
            [rectangleToAdd setBounds:Rect1];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
            
        
            [self.lettersDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Letter %d",i]];
    }
    
    
}


-(void)getWord
{
    NSMutableArray *allKeys = [[self.lettersDic allKeys] mutableCopy];

        for(int i=0;i<[self.word length];i++)
    {
        CALayer* singleLayer=[self.lettersDic objectForKey:[allKeys objectAtIndex:i]];
        
        //CALayer* singleLayer=[[self.lettersDic objectEnumerator]nextObject];
        CGRect Rect= singleLayer.frame;
        Rect.origin.y+=10;
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect];
        
        unichar utf8char=[self.word characterAtIndex:i];
        
        [label setString:[NSString stringWithCharacters:&utf8char length:1]];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        /* [object setFrame:Rect];
         [object setBounds:Rect];*/
        
        [singleLayer addSublayer:label];
       // [self.lettersDic setObject:singleLayer forKey:[NSString stringWithFormat:@"Letter %d",i]];
         [self.lettersDic setObject:singleLayer forKey:[allKeys objectAtIndex:i]];
    }
}

-(void)addObjectToLayer
{
    NSMutableArray *allKeys = [[self.lettersDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.lettersDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Letter %d",[[words lastObject]intValue]]];
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.actualLetter<[self.word length])
    {
        CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
        for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
        {
            if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
            {
                
              
                NSString* test=[[singleLayer.sublayers firstObject]string];
                if([self.word characterAtIndex:self.actualLetter]==[test characterAtIndex:0])
                {
                    self.actualLetter++;
                    CGRect Rect1= CGRectMake(75+self.actualLetter*50,10, 50, 50);
                    
                    [singleLayer setFrame:Rect1];
                    [singleLayer setBounds:Rect1];
                    [singleLayer setBackgroundColor:[[UIColor greenColor]CGColor]];
                    [singleLayer setOpacity:1.0f];
                    CGRect Rect= singleLayer.frame;
                    Rect.origin.y+=10;
                    [[singleLayer.sublayers firstObject]setFrame:Rect];
                }
            }
        }
    }
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

- (IBAction)lengthChange:(id)sender {
    int value =self.wordLengthSlider.value;
    if (value<4) {
        [self.wordLengthSlider setValue:3 animated:YES];
        self.gameView.layer.sublayers=nil;

        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:3]description];
    }
    else if (value<5) {
         [self.wordLengthSlider setValue:4 animated:YES];
        self.gameView.layer.sublayers=nil;

        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:4]description];
    }
    else if (value<6) {
        [self.wordLengthSlider setValue:5 animated:YES];
        self.gameView.layer.sublayers=nil;
        
        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:5]description];
    }
    else if (value<7) {
        [self.wordLengthSlider setValue:6 animated:YES];
        self.gameView.layer.sublayers=nil;
        
        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:6]description];
    }
    else if (value<8) {
        [self.wordLengthSlider setValue:7 animated:YES];
        self.gameView.layer.sublayers=nil;
        
        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:7]description];
    }
    else if (value<9) {
        [self.wordLengthSlider setValue:8 animated:YES];
        self.gameView.layer.sublayers=nil;
        
        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:8]description];
    }
    else if (value<10) {
        [self.wordLengthSlider setValue:9 animated:YES];
        self.gameView.layer.sublayers=nil;
        
        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:9]description];
    }
    else{
        [self.wordLengthSlider setValue:10 animated:YES];
        self.gameView.layer.sublayers=nil;
        
        self.lettersDic=[[NSMutableDictionary alloc]init];
        [self createSquare];
        [self getWord];
        [self addObjectToLayer];
        self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:10]description];
    }
}
- (IBAction)helpPush:(id)sender {
    if(self.actualLetter<[self.word length])
    {
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        unichar test=[[[singleLayer.sublayers firstObject]string]characterAtIndex:0];
        if(singleLayer.backgroundColor==[[UIColor redColor]CGColor])
        {
        if (test==[self.word characterAtIndex:self.actualLetter])
        {
            
            
           
                self.actualLetter++;
                CGRect Rect1= CGRectMake(75+self.actualLetter*50,10, 50, 50);
                
                [singleLayer setFrame:Rect1];
                [singleLayer setBounds:Rect1];
                [singleLayer setBackgroundColor:[[UIColor greenColor]CGColor]];
                [singleLayer setOpacity:1.0f];
                CGRect Rect= singleLayer.frame;
                Rect.origin.y+=10;
                [[singleLayer.sublayers firstObject]setFrame:Rect];
            break;
        }
        }
    }
    }

}

- (IBAction)startPush:(id)sender {
    self.lettersDic=[[NSMutableDictionary alloc]init];
    self.gameView.layer.sublayers=nil;
    [self createSquare];
    [self getWord];
    [self addObjectToLayer];
    self.wordCountLabel.text=[[[NSNumber alloc]initWithInt:(int)self.wordLengthSlider.value]description];

}
@end
