//
//  ExercisesFourtyOneViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/25/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "WidzenieCyklopoweViewController.h"

@interface WidzenieCyklopoweViewController ()

@end

@implementation WidzenieCyklopoweViewController

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
    self.size = [self.exerciseTextView.text sizeWithFont:self.exerciseTextView.font
                                            constrainedToSize:self.exerciseTextView.frame.size
                                                lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    self.numberOfLines = self.size.height / self.exerciseTextView.font.lineHeight;
    self.exerciseTextView.userInteractionEnabled=YES;
    self.exerciseTextView.scrollEnabled=YES;
    self.radius = 50;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 100.0;
    paragraphStyle.firstLineHeadIndent = 100.0;
    paragraphStyle.tailIndent = -100.0;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:fontSize], NSParagraphStyleAttributeName: paragraphStyle};
    self.exerciseTextView.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
    
    [self createMask];
}

-(void)createMask
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.maskView];
    
    NSLog(@"%f",P.x);
    
    self.xPos=P.x;
    self.yPos=P.y;
    
    if(self.yPos<self.maskView.frame.size.height &&
       self.xPos<self.maskView.frame.size.width  &&
       self.yPos>0 &&
       self.xPos>0)
    [self createMask];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.maskView];
    
    self.xPos=P.x;
    self.yPos=P.y;
    
    
    if(self.yPos<self.maskView.frame.size.height &&
       self.xPos<self.maskView.frame.size.width  &&
       self.yPos>0 &&
       self.xPos>0)
    [self createMask];
}

- (IBAction)circleChange:(id)sender
{
    self.radius=self.circleSizeSlider.value;
    [self createMask];
}
- (IBAction)sizeChange:(id)sender
{
    [self countMaxPosition];
    
    [self resetView];
    
}


- (void)resetView
{
    self.exerciseTextView.text=nil;
    self.exerciseTextView.text=self.xmlManager.exercisesText;
    [self.exerciseTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:(int)self.textSizeSlider.value]];
    [self.exerciseTextView setContentOffset:CGPointZero animated:YES];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 100.0;
    paragraphStyle.firstLineHeadIndent = 100.0;
    paragraphStyle.tailIndent = -100.0;
    float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:fontSize], NSParagraphStyleAttributeName: paragraphStyle};
    self.exerciseTextView.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
    
    
    self.position=0;
}

- (void)countMaxPosition {
    CGSize size = [self.exerciseTextView.text sizeWithFont:self.exerciseTextView.font
                                              constrainedToSize:self.exerciseTextView.frame.size
                                                  lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.exerciseTextView.font.lineHeight;
    self.maxPosition=self.exerciseTextView.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}
@end
