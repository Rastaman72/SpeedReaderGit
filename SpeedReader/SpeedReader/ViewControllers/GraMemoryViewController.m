//
//  ExercisesNinthteenViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GraMemoryViewController.h"

@interface GraMemoryViewController ()

@end

@implementation GraMemoryViewController

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
    self.horizontalSize=6;
    self.verticalSize=6;
    [self createRandomValue];
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
-(void)createRandomValue
{
    self.randomValueArray=[[NSMutableArray alloc]init];
    for (int i=0; i<(self.horizontalSize*self.verticalSize)/2; i++) {
        [self.randomValueArray addObject: [[NSNumber alloc ]initWithInt:arc4random_uniform(100)]];
    }
   

}

-(void)createNumber
{
    for(int i=0;i<self.horizontalSize;i++)
    {
        for(int j=0;j<self.verticalSize;j++)
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
        [self.numberDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];
       // [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];
        }
    }
    
    
}

-(void)addNumberToObject
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    int i=0;
    int j=0;
    for (NSString *key in allKeys)
    {
       
       
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];

        CALayer* object = [self.numberDic objectForKey: key];
        CGRect Rect= CGRectMake(0,0, 50, 50);

       
       

        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:object.frame];
        [label setString:[NSString stringWithFormat:@"DD%@", [self.randomValueArray objectAtIndex:j]]];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        [object setFrame:Rect];
        [object setBounds:Rect];
        
         [label addSublayer:object];
        [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
//       //        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
//        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
     
        if (i==1) {
            j++;
            i=0;
            continue;
        }
        i++;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.touchCounter==2)
    {
        
        NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
        for (NSString *key in allKeys)
        {
            
            CGRect Rect= CGRectMake(0,0, 50, 50);
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
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
        {
            CATextLayer* object = [self.numberDic objectForKey: self.firstObjectToDelete];

            if(object!=singleLayer)
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
            }
            if(self.touchCounter==2)
            {
                    CATextLayer* layer = [self.gameView.layer valueForKey:self.firstObjectToDelete];
                    CATextLayer* layer1 = [self.gameView.layer valueForKey:self.secondObjectToDelete];

                    if([layer1.string isEqualToString:layer.string]){
                    
                    [layer removeFromSuperlayer];
                    [layer1 removeFromSuperlayer];

                    [self.gameView.layer setValue:nil forKey:self.firstObjectToDelete];
                        [self.gameView.layer setValue:nil forKey:self.secondObjectToDelete];

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


- (IBAction)sizeChange:(id)sender {
    int size=(int)self.sizeSlider.value;
  if(size<16)
  {
      self.choosedSize=12;
      self.horizontalSize=4;
      self.verticalSize=3;
      self.gameView.layer.sublayers=nil;
      self.numberDic=[[NSMutableDictionary alloc]init];
      self.randomValueArray=[[NSMutableArray alloc]init];
      [self createRandomValue];
      [self createNumber];
      [self addNumberToObject];
      [self addObjectToLayer];
      

  }
    else if (size<20)
    {
          self.choosedSize=16;
        self.horizontalSize=4;
        self.verticalSize=4;
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        self.randomValueArray=[[NSMutableArray alloc]init];
        [self createRandomValue];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];

    }
    else if (size<36)
    {
        self.choosedSize=20;
        self.horizontalSize=5;
        self.verticalSize=4;
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        self.randomValueArray=[[NSMutableArray alloc]init];
        [self createRandomValue];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];

    }
    else if (size<64)
    {
        self.choosedSize=36;
        self.horizontalSize=6;
        self.verticalSize=6;
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        self.randomValueArray=[[NSMutableArray alloc]init];
        [self createRandomValue];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];
    }
    else
    {
        self.choosedSize=64;
        self.horizontalSize=8;
        self.verticalSize=8;
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        self.randomValueArray=[[NSMutableArray alloc]init];
        [self createRandomValue];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];
    }
    
}

- (IBAction)sizeDynamic:(id)sender {
}
- (IBAction)startPush:(id)sender {
}
@end
