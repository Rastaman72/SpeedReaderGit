//
//  GraRiseViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GraRiseViewController.h"

@interface GraRiseViewController ()

@end

@implementation GraRiseViewController

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
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.touchCounter=0;
    self.nextNumber=1;
    self.wrongChooseCounter=0;
    self.lineSize=5;
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNumber
{
    for(int i=0;i<self.lineSize;i++)
    {
        for(int j=0;j<self.lineSize;j++)
        {
            // CGRect Rect= CGRectMake(0,0, 50, 50);
            CGRect Rect1= CGRectMake(75+i*50,75+j*50, 50, 50);
            
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect1];
            [rectangleToAdd setBounds:Rect1];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
            
            /* CATextLayer *label = [[CATextLayer alloc] init];
             [label setFont:@"Helvetica-Bold"];
             [label setFontSize:20];
             [label setFrame:Rect1];
             [label setString:[NSString stringWithFormat:@"DD%d",i*self.horizontalSize+j]];
             [label setAlignmentMode:kCAAlignmentCenter];
             [label setForegroundColor:[[UIColor blackColor] CGColor]];
             [label addSublayer:rectangleToAdd];*/
            [self.numberDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Number %d",i*self.lineSize+j]];
            // [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];
        }
    }
    
    
}
-(void)addNumberToObject
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    int i=0;
   
    for (NSString *key in allKeys)
    {
        
        
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        
        CALayer* object = [self.numberDic objectForKey: key];
        CGRect Rect= object.frame;
        Rect.origin.y+=10;
        
        
        i++;
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect];
        [label setString:[NSString stringWithFormat:@"%d",i]];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
       /* [object setFrame:Rect];
        [object setBounds:Rect];*/
        
        [object addSublayer:label];
        [self.numberDic setObject:object forKey:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
        //       //        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        //        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
        
    }
}

-(void)addObjectToLayer
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.numberDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
    }
}


- (IBAction)sizeChange:(id)sender {
    int size=(int)self.sizeSlider.value;
    if(size<25)
    {
        self.choosedSize=16;
        self.lineSize=4;
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];
         [self.sizeSlider setValue:16 animated:NO];
        
        
    }
    else if (size<36)
    {
        self.choosedSize=25;
        self.lineSize=5;
        [self.sizeSlider setValue:25 animated:NO];
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];
        
    }
        else
    {
        self.choosedSize=36;
        self.lineSize=6;
        [self.sizeSlider setValue:36 animated:NO];
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
        {
            
            if([[[singleLayer.sublayers firstObject]string] isEqualToString:[NSString stringWithFormat:@"%d",self.nextNumber]])
            {
                NSLog(@"%@",singleLayer.sublayers );
                [singleLayer replaceSublayer:[singleLayer.sublayers objectAtIndex:0] with:nil];
                NSLog(@"%@",singleLayer.sublayers );
                
                CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
                flash.fromValue = [NSNumber numberWithFloat:0.0];
                flash.toValue = [NSNumber numberWithFloat:1.0];
                flash.duration = 0.5;
                flash.delegate=self;// 1 second
                flash.removedOnCompletion = YES;
               // flash.autoreverses = YES;    // Back
                
                [singleLayer addAnimation:flash forKey:@"flashAnimation"];
                self.touchCounter++;
                self.nextNumber++;
                
                }
           else
                self.wrongChooseCounter++;
        }
    }
    
            
        
        
   
    
}

//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    for (CATextLayer* singleLayer in self.gameView.layer.sublayers) {
//        [singleLayer removeAnimationForKey:@"flashAnimation"];
//    }
//    
//}
- (IBAction)sizeDynamic:(id)sender {
}
- (IBAction)startPush:(id)sender {
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
