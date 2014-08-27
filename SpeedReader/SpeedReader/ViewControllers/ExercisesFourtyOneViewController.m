//
//  ExercisesFourtyOneViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/25/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesFourtyOneViewController.h"

@interface ExercisesFourtyOneViewController ()

@end

@implementation ExercisesFourtyOneViewController

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
    self.exercisesFoutyOneText.text=self.xmlManager.exercisesText;
    float fontSize =[[[[NSNumber alloc]initWithInt:self.exercisesFourtyOneSizeSlider.value]description]floatValue];
    
  //  [self.exercisesFoutyOneText setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    
    self.size = [self.exercisesFoutyOneText.text sizeWithFont:self.exercisesFoutyOneText.font
                                               constrainedToSize:self.exercisesFoutyOneText.frame.size
                                                   lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    self.numberOfLines = self.size.height / self.exercisesFoutyOneText.font.lineHeight;
    self.exercisesFoutyOneText.userInteractionEnabled=YES;
    self.exercisesFoutyOneText.scrollEnabled=YES;
self.radius = 50;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 100.0;
   paragraphStyle.firstLineHeadIndent = 100.0;
    paragraphStyle.tailIndent = -100.0;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:fontSize], NSParagraphStyleAttributeName: paragraphStyle};
    self.exercisesFoutyOneText.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];

    //self.exercisesFoutyOneText.textAlignment = NSTextAlignmentCenter;
  
    [self tst];
    //or
    //UIGestureRecognizer *touches = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(touchesAction:)];
    
  //  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
  /*  UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dupa:)];
swipe.delegate = self;
  //  [self.exercisesFoutyOneText.superview addGestureRecognizer:tapGesture];
    [self.exercisesFoutyOneText.superview addGestureRecognizer:swipe];*/
    
    
    //[self createFrame];
    //[self drawCircle];
  //  [self tst];
    // Do any additional setup after loading the view.
}

-(void)tst
{
   
    [self.maskView setBackgroundColor:[UIColor clearColor]];
    [self.maskView.layer replaceSublayer:[self.maskView.layer.sublayers firstObject] with:nil];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.maskView.bounds.size.width, self.maskView.bounds.size.height) cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.xPos-self.radius, self.yPos-self.radius, 2.0*self.radius, 2.0*self.radius) cornerRadius:self.radius];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor grayColor].CGColor;
    fillLayer.opacity = 1.0;
    [self.maskView.layer addSublayer:fillLayer];

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
-(void)createFrame
{
    CGRect Rect = CGRectMake(0, 0, self.exercisesFoutyOneText.frame.size.width, self.exercisesFoutyOneText.contentSize.height );
    
    
    self.readFrame = [CALayer layer];
    [self.readFrame setFrame:Rect];
    [self.readFrame setBounds:Rect];
    
    [self.readFrame setCornerRadius:5.0f];
    [self.readFrame setBackgroundColor:[[UIColor redColor]CGColor]];
    [self.readFrame setOpacity:0.5f];
    [self.readFrame setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.readFrame setBorderWidth:0.1f];
    [self.readFrame setShadowColor:[[UIColor whiteColor]CGColor]];
    [[[self exercisesFoutyOneText]layer]insertSublayer:self.readFrame atIndex:0 ];
    
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    NSLog(@"%@",self.exercisesFoutyOneText.layer.sublayers);
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.maskView];

    NSLog(@"%f",P.x);
    
    self.xPos=P.x;
    self.yPos=P.y;
    [self tst];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.maskView];
    
    NSLog(@"%f",P.x);
    
    self.xPos=P.x;
    self.yPos=P.y;
    [self tst];
}



- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    NSLog(@"%f",point.x);
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (CGRectContainsPoint([[self.exercisesFoutyOneText.layer.sublayers firstObject]frame], point))
        {
            int a=5;
        }
    }
}
- (IBAction)circleChange:(id)sender {
    self.radius=self.exercisesFourtyOneCircleSizeSlider.value;
    [self tst];
}
- (IBAction)sizeChange:(id)sender {
    [self countMaxPosition];
    
    [self resetView];

}


- (void)resetView
{
    self.exercisesFoutyOneText.text=nil;
    self.exercisesFoutyOneText.text=self.xmlManager.exercisesText;
    [self.exercisesFoutyOneText setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.exercisesFourtyOneSizeSlider.value]];
    [self.exercisesFoutyOneText setContentOffset:CGPointZero animated:YES];
 
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 100.0;
    paragraphStyle.firstLineHeadIndent = 100.0;
    paragraphStyle.tailIndent = -100.0;
    float fontSize =[[[[NSNumber alloc]initWithInt:self.exercisesFourtyOneSizeSlider.value]description]floatValue];

    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:fontSize], NSParagraphStyleAttributeName: paragraphStyle};
    self.exercisesFoutyOneText.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
    

    self.position=0;
}

- (void)countMaxPosition {
    CGSize size = [self.exercisesFoutyOneText.text sizeWithFont:self.exercisesFoutyOneText.font
                                                 constrainedToSize:self.exercisesFoutyOneText.frame.size
                                                     lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.exercisesFoutyOneText.font.lineHeight;
    int numLines = self.exercisesFoutyOneText.contentSize.height / self.exercisesFoutyOneText.font.lineHeight;
    self.maxPosition=self.exercisesFoutyOneText.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}
@end
