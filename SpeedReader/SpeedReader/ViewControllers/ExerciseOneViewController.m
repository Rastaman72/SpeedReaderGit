//
//  ExerciseOneViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExerciseOneViewController.h"

@interface ExerciseOneViewController ()

@end

@implementation ExerciseOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
   // [self dismissViewControllerAnimated:NO completion:nil];
[self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.xmlManager=[self theAppDataObject];
    [self.xmlManager getExercisesText];
    self.exercisesOneText.text=self.xmlManager.exercisesText;
    [self.exercisesOneText setFont:[UIFont fontWithName:@"Helvetica Neue" size:18.0f]];
    
    self.position=0;
   
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)sizeChanged:(id)sender {
    
     
   
          /*  NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:self.exercisesOneText.text];
    
        [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 15)];
        
        [aStr addAttribute:NSFontAttributeName value: range:NSMakeRange(0, aStr.length)];
        self.exercisesOneText.attributedText=aStr;
        NSLog(@"%f",self.exercisesOneText.font.lineHeight);*/
    

    [self.exercisesOneText setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.exercisesOneSizeSlider.value]];
    
    
    CGRect Rect = CGRectMake(0, 5+self.position, self.exercisesOneText.frame.size.width, self.exercisesOneText.font.lineHeight*2);
    
    
    CALayer* roundRect = [CALayer layer];
    [roundRect setFrame:Rect];
    [roundRect setBounds:Rect];
    
    [roundRect setCornerRadius:5.0f];
    [roundRect setBackgroundColor:[[UIColor blueColor]CGColor]];
    [roundRect setOpacity:0.2f];
    [roundRect setBorderColor:[[UIColor blackColor]CGColor]];
    [roundRect setBorderWidth:3.0f];
    [roundRect setShadowColor:[[UIColor blackColor]CGColor]];
    /* [roundRect setShadowOffset:CGSizeMake(20.0f, 20.0f)];
     [roundRect setShadowOpacity:1.0f];
     [roundRect setShadowRadius:10.0f];
     */
    [[[self exercisesOneText]layer]addSublayer:roundRect];
    
    [[[self exercisesOneText]layer]replaceSublayer:[self.exercisesOneText.layer.sublayers firstObject] with:roundRect];
    self.position+=self.exercisesOneText.font.lineHeight*2;

}



@end
