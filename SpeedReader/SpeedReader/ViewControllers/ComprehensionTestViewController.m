//
//  ComprehensionTestViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ComprehensionTestViewController.h"

@interface ComprehensionTestViewController ()

@end

@implementation ComprehensionTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)getCleanText:(GDataXMLElement *)singleElement
{
    NSString *stringWithoutBeginMark = [singleElement.XMLString
                                        stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<%@>",singleElement.name] withString:@""];
    NSString* cleanText = [stringWithoutBeginMark
                           stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"</%@>",singleElement.name] withString:@""];
    return cleanText;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createObjects];
    self.unTouch=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
}

-(void)createObjects
{
    self.theDataObject = [self theAppDataObject];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"tests%@",self.theDataObject.choosedLanguage] ofType:@"xml"];
    
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0 error:&error];
    // if (doc == nil) { return nil; }
    NSString* createNode=[NSString stringWithFormat:@"//test[nr=\"%d\"]/questions",self.theDataObject.selectLesson];
    NSArray* resultNodes = [doc nodesForXPath:createNode error:&error];
    self.answerDictionary=[[NSMutableDictionary alloc]init];
    
    NSArray *singleParts = [[resultNodes firstObject]children];
    int j=0;
    int yPos=10;
    
    for (GDataXMLElement* singleElement in singleParts) {
        j++;
        NSArray *question = [singleElement elementsForName:@"q"];
        NSArray* answer1 = [singleElement elementsForName:@"a1"];
        NSArray* answer2 = [singleElement elementsForName:@"a2"];
        NSArray* answer3 = [singleElement elementsForName:@"a3"];
        
        
        NSString *cleanQuestion;
        cleanQuestion = [self getCleanText:[question firstObject]];
        NSString *cleanAnswer1;
        cleanAnswer1 = [self getCleanText:[answer1 firstObject]];
        NSString *cleanAnswer2;
        cleanAnswer2 = [self getCleanText:[answer2 firstObject]];
        NSString *cleanAnswer3;
        cleanAnswer3 = [self getCleanText:[answer3 firstObject]];
        int step=25;
        for (int i=0; i<4; i++) {
            
            CGRect Rect = CGRectMake(0, yPos+i*step, 700, 20);
            CATextLayer *label = [[CATextLayer alloc] init];
            [label setFont:@"Courier"];
            [label setFontSize:14];
            [label setFrame:Rect];
            switch (i) {
                case 0:
                    [label setString:cleanQuestion];
                    
                    break;
                case 1:
                    [label setString:cleanAnswer1];
                    break;
                case 2:
                    [label setString:cleanAnswer2];
                    break;
                case 3:
                    [label setString:cleanAnswer3];
                    break;
                    
                default:
                    break;
            }
            [label setAlignmentMode:kCAAlignmentCenter];
            [label setForegroundColor:[[UIColor blackColor] CGColor]];
            label.wrapped = YES;
            [self.gameView.layer addSublayer:label];
            [self.answerDictionary setObject:label forKey:[NSString stringWithFormat:@"ANS%d.%d",j,i]];
            if(i==0)
                yPos+=10;
        }
        yPos+=110;
    }
}

-(void)checkOrientataion
{
    [self deviceOrientationDidChange:nil];
}

//TO FINISH


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
        {
            for (NSString* singleAnswer in self.answerDictionary) {
                if([self.unTouch count]==0)
                {
                    NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[singleAnswer componentsSeparatedByString:@"."]];
                    NSString*key=[words firstObject];
                    [self.unTouch addObject:key];
                    continue;
                }
                else
                {
                    for (NSString* unTouch in self.unTouch) {
                        if ([singleAnswer rangeOfString:unTouch].location !=NSNotFound) {
                            CATextLayer* toTest=[self.answerDictionary valueForKey:singleAnswer];
                            if (toTest == singleLayer) {
                                NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[singleAnswer componentsSeparatedByString:@"."]];
                                NSString*key=[words firstObject];
                                [self.unTouch addObject:key];
                            }
                            
                        }
                    }
                    
                    
                }
            }
            [singleLayer setBackgroundColor:[[UIColor yellowColor]CGColor]];
            
        }
    }
    
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    //Obtain current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(orientation==UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight)
    {
        if(!self.changePosition)
        {
            
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y-=10;
            [self.gameView setFrame:toChangeGameView];
            self.gameView.layer.sublayers=nil;
            [self createObjects];
            
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y+=10;
            [self.gameView setFrame:toChangeGameView];
            self.gameView.layer.sublayers=nil;
            // [self createObjects];
            
            self.changePosition=NO;
        }
    }
    
}
- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
