//
//  ExercisesNinthteenViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesNinthteenViewController.h"

@interface ExercisesNinthteenViewController ()

@end

@implementation ExercisesNinthteenViewController

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
    self.keyToDelete=[[NSMutableDictionary alloc]init];
    self.touchCounter=0;
    [self createNumber];
    [self addNumberToLayer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNumber
{
    for(int i=0;i<4;i++)
    {
        
        CGRect Rect= CGRectMake(0,0, 100, 100);
        CGRect Rect1= CGRectMake(75+i*120,75, 100, 100);
        
        CALayer* rectangleToAdd = [CALayer layer];
        [rectangleToAdd setFrame:Rect];
        [rectangleToAdd setBounds:Rect];
        [rectangleToAdd setCornerRadius:5.0f];
        [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
        [rectangleToAdd setOpacity:1.0f];
        [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
        [rectangleToAdd setBorderWidth:10.0f];
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect1];
        if(i==3)
        {
            self.change=YES;
            i=0;
        }
        [label setString:[NSString stringWithFormat:@"DD%d",i]];
        if(i==0 && self.change)
        {
            self.change=NO;
            i=3;
        }
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        [label addSublayer:rectangleToAdd];
        [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i]];
        
    }
    
    
}

-(void)addNumberToLayer
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.numberDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.view.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        [self.view.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.touchCounter==2)
    {
        
        NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
        for (NSString *key in allKeys)
        {
            
            CGRect Rect= CGRectMake(0,0, 100, 100);
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect];
            [rectangleToAdd setBounds:Rect];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
            
            CATextLayer* object = [self.numberDic objectForKey: key];
              NSLog(@"%@",object.sublayers );
            if([object.sublayers objectAtIndex:0]==nil)
            [object addSublayer:rectangleToAdd];
             NSLog(@"%@",object.sublayers );
        }
        self.touchCounter=0;
    
    }
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.view];
    for (CATextLayer* singleLayer in self.view.layer.sublayers)
    {
        if ([singleLayer containsPoint:[self.view.layer convertPoint:P toLayer:singleLayer]])
        {
            NSLog(@"%@",singleLayer.sublayers );
            [singleLayer replaceSublayer:[singleLayer.sublayers objectAtIndex:0] with:nil];
            NSLog(@"%@",singleLayer.sublayers );
            self.touchCounter++;
           
            
            NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
            for (NSString *key in allKeys)
            {
                
                CATextLayer* object = [self.numberDic objectForKey: key];
                if(object==singleLayer && (self.touchCounter==1 || self.touchCounter==2))
                {
                    if(self.firstObjectToDelete)
                        self.secondObjectToDelete=key;
                    else
                        self.firstObjectToDelete=key;
                }
                
            }
            
            if(self.touchCounter==2)
            {
                    CATextLayer* layer = [self.view.layer valueForKey:self.firstObjectToDelete];
                    CATextLayer* layer1 = [self.view.layer valueForKey:self.secondObjectToDelete];

                    if([layer1.string isEqualToString:layer.string]){
                    
                    [layer removeFromSuperlayer];
                    [layer1 removeFromSuperlayer];

                    [self.view.layer setValue:nil forKey:self.firstObjectToDelete];
                        [self.view.layer setValue:nil forKey:self.secondObjectToDelete];

                    [self.numberDic removeObjectForKey:self.firstObjectToDelete];
                          [self.numberDic removeObjectForKey:self.secondObjectToDelete];

                }
                self.firstObjectToDelete=nil;
                self.secondObjectToDelete=nil;

            }
            
        
         break;}
    
    
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

@end
