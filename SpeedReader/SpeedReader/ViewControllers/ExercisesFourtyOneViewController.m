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
    
    [self.exercisesFoutyOneText setFont:[UIFont fontWithName:@"Helvetica Neue" size: fontSize]];
    
    self.size = [self.exercisesFoutyOneText.text sizeWithFont:self.exercisesFoutyOneText.font
                                               constrainedToSize:self.exercisesFoutyOneText.frame.size
                                                   lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    self.numberOfLines = self.size.height / self.exercisesFoutyOneText.font.lineHeight;
    self.exercisesFoutyOneText.userInteractionEnabled=NO;

  
  
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
   /* self.isMaskMoved = !self.isMaskMoved;
    CGFloat width = self.maskView.layer.frame.size.width;
    CGFloat height = self.maskView.layer.frame.size.height;
    
    //Create path that defines the edges of our masking layer
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, width, 0);
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, self.xPos, height);
    if (self.isMaskMoved)
        CGPathAddLineToPoint(path, NULL, (width / 2), height - 30);
    else
        CGPathAddLineToPoint(path, NULL, (width / 2), height);
    CGPathAddLineToPoint(path, NULL, (width / 2) - 30, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    
    //if no mask, create it
    if (!self.maskLayer)
    {
        self.maskLayer = [[CAShapeLayer alloc] init];
        self.maskLayer.frame = self.exercisesFoutyOneText.superview.bounds;
        self.maskLayer.fillColor = [[UIColor blackColor] CGColor];
        self.maskLayer.path = path;
        self.maskView.layer.mask = self.maskLayer;
    }
    //animate our mask to the new path
    else
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
        [anim setFromValue:(id)self.maskLayer.path];
        [anim setToValue:(__bridge id)(path)];
        [anim setDelegate:self];
        [anim setDuration:0.25];
        [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        self.maskLayer.path = path;
        [self.maskLayer addAnimation:anim forKey:@"path"];
    }
    
    CGPathRelease(path);*/
    [self.maskView setBackgroundColor:[UIColor clearColor]];
    [self.maskView.layer replaceSublayer:[self.maskView.layer.sublayers firstObject] with:nil];
    int radius = 50;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.maskView.bounds.size.width, self.maskView.bounds.size.height) cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.xPos-radius, self.yPos-radius, 2.0*radius, 2.0*radius) cornerRadius:radius];
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

- (void)drawCircle
{
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.frame = [[self.exercisesFoutyOneText.layer.sublayers firstObject]bounds];
    mask.fillColor = [[UIColor blackColor] CGColor];
    
    CGFloat width = self.exercisesFoutyOneText.layer.frame.size.width;
    CGFloat height = self.exercisesFoutyOneText.layer.frame.size.height;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, width, 0);
    CGPathAddLineToPoint(path, nil, width, height);
    CGPathAddLineToPoint(path, nil, (width/2) + 5, height);
    CGPathAddLineToPoint(path, nil, width/2, height - 5);
    CGPathAddLineToPoint(path, nil, (width/2) - 5, height);
    CGPathAddLineToPoint(path, nil, 0, height);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    mask.path = path;
    CGPathRelease(path);
    
    [[self.exercisesFoutyOneText.layer.sublayers firstObject]setMask:mask];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    NSLog(@"%@",self.exercisesFoutyOneText.layer.sublayers);
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.exercisesFoutyOneText];

    NSLog(@"%f",P.x);
    
    self.xPos=P.x;
    self.yPos=P.y;
    [self tst];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.exercisesFoutyOneText];
    
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
