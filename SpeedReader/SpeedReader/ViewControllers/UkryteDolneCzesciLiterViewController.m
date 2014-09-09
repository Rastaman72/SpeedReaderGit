//
//  ExercisesThirtyEigthViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/24/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "UkryteDolneCzesciLiterViewController.h"

@interface UkryteDolneCzesciLiterViewController ()

@end

@implementation UkryteDolneCzesciLiterViewController

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
    self.exerciseTextView.text=self.xmlManager.exercisesText;
    
    
    float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    
    [self.exerciseTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    
    self.exerciseTextViewSize = [self.exerciseTextView.text sizeWithFont:self.exerciseTextView.font
                                       constrainedToSize:self.exerciseTextView.frame.size
                                           lineBreakMode:NSLineBreakByWordWrapping]; // default mode
     self.numberOfLines = self.exerciseTextViewSize.height / self.exerciseTextView.font.lineHeight;
    
    NSLog(@"%f",self.exerciseTextView.font.lineHeight);
    self.maxPosition=self.exerciseTextView.font.lineHeight*self.numberOfLines;
    
    self.actuallOffset=self.maxPosition;
    self.position=0;
    

  
   // self.toRetrieve=self.exercisesThirtyEigthText.layer.sublayers ;
   // [self.toRetrieve addObject:[self.exercisesThirtyEigthText.layer.sublayers firstObject]];
    
    [self createFrame];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)createFrame
{
      self.toRetrieve=[[NSArray alloc]initWithArray:self.exerciseTextView.layer.sublayers];
    int numLines = self.exerciseTextView.contentSize.height / self.exerciseTextView.font.lineHeight;
   
     for(int i=0;i< numLines;i++)
     {
         
          int yPosition=self.exerciseTextView.font.lineHeight+self.position;
         int minus=(self.shadowSizeSlider.value*self.exerciseTextView.font.lineHeight+self.position)-8;
         yPosition-=minus;
         yPosition+=self.position;
         
    CGRect Rect = CGRectMake(0, yPosition, self.exerciseTextView.frame.size.width, self.exerciseTextView.font.lineHeight*self.shadowSizeSlider.value);
    
    
    self.readFrame = [CALayer layer];
    [self.readFrame setFrame:Rect];
    [self.readFrame setBounds:Rect];
    
    [self.readFrame setCornerRadius:5.0f];
    [self.readFrame setBackgroundColor:[[UIColor whiteColor]CGColor]];
    [self.readFrame setOpacity:1.0f];
    [self.readFrame setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.readFrame setBorderWidth:0.1f];
    [self.readFrame setShadowColor:[[UIColor whiteColor]CGColor]];
         self.position+=self.exerciseTextView.font.lineHeight;
         
       NSLog(@"%@",self.exerciseTextView.layer.sublayers);
         [[[self exerciseTextView]layer]insertSublayer:self.readFrame atIndex:i+3];//:self.readFrame];
        
     }
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

- (void)resetView
{
    self.exerciseTextView.text=nil;
    self.exerciseTextView.text=self.xmlManager.exercisesText;
    [self.exerciseTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.textSizeSlider.value]];
    [self.exerciseTextView setContentOffset:CGPointZero animated:YES];

    self.position=0;
}

- (IBAction)shadowChange:(id)sender {
    
    // self.exercisesThirtyEigthText.layer.sublayers = nil;
   

    [self cleanFrame];
    [self resetView];
    
 
    [self createFrame];
}

- (IBAction)sizeChange:(id)sender {
    

    
    [self countMaxPosition];
    [self cleanFrame];
    [self resetView];
    [self createFrame];
}

-(void) cleanFrame
{
    int frameNumber=[self.exerciseTextView.layer.sublayers count];
    NSLog(@"%@",self.exerciseTextView.layer.sublayers);
    
   
    
     // [toRetrieve addObject:[self.exercisesThirtyEigthText.layer.sublayers objectAtIndex:1]];
      //[toRetrieve addObject:[self.exercisesThirtyEigthText.layer.sublayers objectAtIndex:2]];
    
    
    self.exerciseTextView.layer.sublayers=nil;
    
    
    self.exerciseTextView.layer.sublayers=[[NSMutableArray alloc]init];
    //self.exercisesThirtyEigthText.layer.sublayers=self.toRetrieve;
    for (id toAdd in self.toRetrieve) {
        [self.exerciseTextView.layer addSublayer:toAdd];//
    }
  //  [self.exercisesThirtyEigthText.layer addSublayer:[toRetrieve firstObject]];
     //[self.exercisesThirtyEigthText.layer addSublayer:[toRetrieve objectAtIndex:1]];
   //  [self.exercisesThirtyEigthText setContentOffset:CGPointZero animated:YES];
    // [self.exercisesThirtyEigthText.layer addSublayer:[toRetrieve objectAtIndex:2]];
    NSLog(@"%@",self.exerciseTextView.layer.sublayers);
    /*
    for (CALayer* singleLayer in self.exercisesThirtyEigthText.layer.sublayers) {
        if ([singleLayer isKindOfClass:[CALayer class]]) {
            [singleLayer removeFromSuperlayer];
        }
    }
    for (int i=0; i<frameNumber; i++) {
        [[self.exercisesThirtyEigthText.layer.sublayers objectAtIndex:i]replaceSublayer:[self.exercisesThirtyEigthText.layer.sublayers objectAtIndex:i] with:nil];
    }*/
    
}
- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (void)countMaxPosition {
    CGSize size = [self.exerciseTextView.text sizeWithFont:self.exerciseTextView.font
                                         constrainedToSize:self.exerciseTextView.frame.size
                                             lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.exerciseTextView.font.lineHeight;
    int numLines = self.exerciseTextView.contentSize.height / self.exerciseTextView.font.lineHeight;
    self.maxPosition=self.exerciseTextView.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}
@end
