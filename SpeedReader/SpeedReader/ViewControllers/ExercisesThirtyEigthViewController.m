//
//  ExercisesThirtyEigthViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/24/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesThirtyEigthViewController.h"

@interface ExercisesThirtyEigthViewController ()

@end

@implementation ExercisesThirtyEigthViewController

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
    self.exercisesThirtyEigthText.text=self.xmlManager.exercisesText;
    
    
    float fontSize =[[[[NSNumber alloc]initWithInt:self.exercisesThirtyEigthSizeSlider.value]description]floatValue];
    
    [self.exercisesThirtyEigthText setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    
    self.size = [self.exercisesThirtyEigthText.text sizeWithFont:self.exercisesThirtyEigthText.font
                                       constrainedToSize:self.exercisesThirtyEigthText.frame.size
                                           lineBreakMode:NSLineBreakByWordWrapping]; // default mode
     self.numberOfLines = self.size.height / self.exercisesThirtyEigthText.font.lineHeight;
    
    NSLog(@"%f",self.exercisesThirtyEigthText.font.lineHeight);
    self.maxPosition=self.exercisesThirtyEigthText.font.lineHeight*self.numberOfLines;
    
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
      self.toRetrieve=[[NSArray alloc]initWithArray:self.exercisesThirtyEigthText.layer.sublayers];
    int numLines = self.exercisesThirtyEigthText.contentSize.height / self.exercisesThirtyEigthText.font.lineHeight;
   
     for(int i=0;i< numLines;i++)
     {
         
          int yPosition=self.exercisesThirtyEigthText.font.lineHeight+self.position;
         int minus=(self.exercisesThirtyEigthShadowSlider.value*self.exercisesThirtyEigthText.font.lineHeight+self.position);
         yPosition-=minus;
         yPosition+=self.position;
         
    CGRect Rect = CGRectMake(0, yPosition, self.exercisesThirtyEigthText.frame.size.width, self.exercisesThirtyEigthText.font.lineHeight*self.exercisesThirtyEigthShadowSlider.value);
    
    
    self.readFrame = [CALayer layer];
    [self.readFrame setFrame:Rect];
    [self.readFrame setBounds:Rect];
    
    [self.readFrame setCornerRadius:5.0f];
    [self.readFrame setBackgroundColor:[[UIColor whiteColor]CGColor]];
    [self.readFrame setOpacity:1.0f];
    [self.readFrame setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.readFrame setBorderWidth:0.1f];
    [self.readFrame setShadowColor:[[UIColor whiteColor]CGColor]];
         self.position+=self.exercisesThirtyEigthText.font.lineHeight;
         
       NSLog(@"%@",self.exercisesThirtyEigthText.layer.sublayers);
         [[[self exercisesThirtyEigthText]layer]insertSublayer:self.readFrame atIndex:i+3];//:self.readFrame];
        
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
    self.exercisesThirtyEigthText.text=nil;
    self.exercisesThirtyEigthText.text=self.xmlManager.exercisesText;
    [self.exercisesThirtyEigthText setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.exercisesThirtyEigthSizeSlider.value]];
    [self.exercisesThirtyEigthText setContentOffset:CGPointZero animated:YES];

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
    int frameNumber=[self.exercisesThirtyEigthText.layer.sublayers count];
    NSLog(@"%@",self.exercisesThirtyEigthText.layer.sublayers);
    
   
    
     // [toRetrieve addObject:[self.exercisesThirtyEigthText.layer.sublayers objectAtIndex:1]];
      //[toRetrieve addObject:[self.exercisesThirtyEigthText.layer.sublayers objectAtIndex:2]];
    
    
    self.exercisesThirtyEigthText.layer.sublayers=nil;
    
    
    self.exercisesThirtyEigthText.layer.sublayers=[[NSMutableArray alloc]init];
    //self.exercisesThirtyEigthText.layer.sublayers=self.toRetrieve;
    for (id toAdd in self.toRetrieve) {
        [self.exercisesThirtyEigthText.layer addSublayer:toAdd];//
    }
  //  [self.exercisesThirtyEigthText.layer addSublayer:[toRetrieve firstObject]];
     //[self.exercisesThirtyEigthText.layer addSublayer:[toRetrieve objectAtIndex:1]];
   //  [self.exercisesThirtyEigthText setContentOffset:CGPointZero animated:YES];
    // [self.exercisesThirtyEigthText.layer addSublayer:[toRetrieve objectAtIndex:2]];
    NSLog(@"%@",self.exercisesThirtyEigthText.layer.sublayers);
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
    CGSize size = [self.exercisesThirtyEigthText.text sizeWithFont:self.exercisesThirtyEigthText.font
                                         constrainedToSize:self.exercisesThirtyEigthText.frame.size
                                             lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.exercisesThirtyEigthText.font.lineHeight;
    int numLines = self.exercisesThirtyEigthText.contentSize.height / self.exercisesThirtyEigthText.font.lineHeight;
    self.maxPosition=self.exercisesThirtyEigthText.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}
@end
