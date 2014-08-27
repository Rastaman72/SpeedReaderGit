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
    
    [self tst];
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
    self.xPos=P.x;
    self.yPos=P.y;
    [self tst];
}

- (IBAction)circleChange:(id)sender
{
    self.radius=self.exercisesFourtyOneCircleSizeSlider.value;
    [self tst];
}
- (IBAction)sizeChange:(id)sender
{
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
    self.maxPosition=self.exercisesFoutyOneText.font.lineHeight*numberOfLines;
    self.actuallOffset=self.maxPosition;
}
@end
