//
//  ExercisesFifthteenViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesFifthteenViewController.h"

@interface ExercisesFifthteenViewController ()

@end

@implementation ExercisesFifthteenViewController

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
    [self createFrame];
    [self addFrameToView];
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(500/1000)
                                                               target:self selector:@selector(resizeRectangular) userInfo:nil repeats:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createFrame
{
    int width=400;
    int heigth =100;
    int midX=(self.view.frame.size.width -width)*0.5f;
    int midY=(self.view.frame.size.height -heigth)*0.5f;
    
    CGRect Rect = CGRectMake(midX,midY, width, 100);
    
    
    self.firstRectangular = [CALayer layer];
    [self.firstRectangular setFrame:Rect];
    [self.firstRectangular setBounds:Rect];
    
    [self.firstRectangular setCornerRadius:5.0f];
    [self.firstRectangular setBackgroundColor:[[UIColor redColor]CGColor]];
    [self.firstRectangular setOpacity:0.2f];
    [self.firstRectangular setBorderColor:[[UIColor redColor]CGColor]];
    [self.firstRectangular setBorderWidth:3.0f];
    
    
    width=width*0.5f;
    heigth=heigth*0.5f;
    midX=(self.view.frame.size.width -width)*0.5f;
     midY=(self.view.frame.size.height -heigth)*0.5f;

    CGRect Rect1 = CGRectMake(midX,midY, width, heigth);
    
    
    self.secondRectangular = [CALayer layer];
    [self.secondRectangular setFrame:Rect1];
    [self.secondRectangular setBounds:Rect1];
    
    [self.secondRectangular setCornerRadius:5.0f];
    [self.secondRectangular setBackgroundColor:[[UIColor blueColor]CGColor]];
    [self.secondRectangular setOpacity:0.2f];
    [self.secondRectangular setBorderColor:[[UIColor blueColor]CGColor]];
    [self.secondRectangular setBorderWidth:3.0f];
    
    width=width*0.5f;
    heigth=heigth*0.5f;
    midX=(self.view.frame.size.width -width)*0.5f;
    midY=(self.view.frame.size.height -heigth)*0.5f;

    
    CGRect Rect2 = CGRectMake(midX,midY, width,heigth);
    
    
    self.thirdRectangular = [CALayer layer];
    [self.thirdRectangular setFrame:Rect2];
    [self.thirdRectangular setBounds:Rect2];
    
    [self.thirdRectangular setCornerRadius:5.0f];
    [self.thirdRectangular setBackgroundColor:[[UIColor yellowColor]CGColor]];
    [self.thirdRectangular setOpacity:0.2f];
    [self.thirdRectangular setBorderColor:[[UIColor yellowColor]CGColor]];
    [self.thirdRectangular setBorderWidth:3.0f];
    //[self.firstRectangular setShadowColor:[[UIColor blackColor]CGColor]];
    

    }

-(void)addFrameToView
{
    [self.view.layer addSublayer:self.firstRectangular];
     [self.view.layer addSublayer:self.secondRectangular];
     [self.view.layer addSublayer:self.thirdRectangular];

}

-(void)resizeRectangular
{
    
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

@end
