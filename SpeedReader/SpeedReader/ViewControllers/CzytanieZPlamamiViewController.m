//
//  CzytanieZPlamamiViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/27/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "CzytanieZPlamamiViewController.h"

@interface CzytanieZPlamamiViewController ()

@end

@implementation CzytanieZPlamamiViewController

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
    self.textView.text=self.xmlManager.exercisesText;
    float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 80.0;
    paragraphStyle.firstLineHeadIndent = 80.0;
    paragraphStyle.tailIndent = -80.0;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:fontSize], NSParagraphStyleAttributeName: paragraphStyle};
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
    float numberOfLines = self.size.height / self.textView.font.lineHeight;
    self.maxPosition=self.textView.font.lineHeight*numberOfLines;
    
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
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
    self.shadowView.layer.sublayers=nil;
    for (int i=0; i<30; i++) {
        
        int toTest=arc4random_uniform(i)*20;
        int x=arc4random_uniform(i)*5;

        int y=arc4random_uniform(i)*6;

        
        if(toTest<self.textView.frame.size.width)
        {
        x=toTest;
        }
        toTest=arc4random_uniform(i)*30;
        if(toTest<self.textView.frame.size.width)
        {
            y=toTest;
        }
        
       
        
        CGRect Rect = CGRectMake(x, y, arc4random_uniform(i)*6, arc4random_uniform(i)*2);
        self.readFrame = [CALayer layer];
        [self.readFrame setFrame:Rect];
        [self.readFrame setBounds:Rect];
        [self.readFrame setCornerRadius:5.0f];
        [self.readFrame setBackgroundColor:[[UIColor blueColor]CGColor]];
        [self.readFrame setOpacity:0.2f];
        [self.readFrame setBorderColor:[[UIColor blackColor]CGColor]];
        [self.readFrame setBorderWidth:3.0f];
        [self.readFrame setShadowColor:[[UIColor blackColor]CGColor]];
        [self.shadowView.layer addSublayer:self.readFrame];
        }
    
    
    
}

- (void)countMaxPosition {
    CGSize size = [self.textView.text sizeWithFont:self.textView.font
                                 constrainedToSize:self.textView.frame.size
                                     lineBreakMode:NSLineBreakByWordWrapping]; // default mode
    float numberOfLines = size.height / self.textView.font.lineHeight;
    self.maxPosition=self.textView.font.lineHeight*numberOfLines;
   
}

- (void)resetView
{
    self.textView.text=nil;
    self.textView.text=self.xmlManager.exercisesText;
  
    [self.textView setContentOffset:CGPointZero animated:YES];
    self.position=0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 80.0;
    paragraphStyle.firstLineHeadIndent = 80.0;
    paragraphStyle.tailIndent = -80.0;
    float fontSize =[[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description]floatValue];
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:fontSize], NSParagraphStyleAttributeName: paragraphStyle};
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.xmlManager.exercisesText attributes:attrsDictionary];
}


- (IBAction)sizeChanged:(id)sender {
    
    [self resetView];
    [self countMaxPosition];
    [self createFrame];
    if(self.startPush) {
      //  [[[self textView]layer]replaceSublayer:[self.textView.layer.sublayers objectAtIndex:0] with:nil];
        self.startPush=NO;
        
        
    }
}

- (IBAction)sizeDynamic:(id)sender {
    self.textSizeDescriptionLabel.text=[[[NSNumber alloc]initWithInt:self.textSizeSlider.value]description];
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

- (IBAction)startPush:(id)sender {
    self.startPush=YES;
}
@end
