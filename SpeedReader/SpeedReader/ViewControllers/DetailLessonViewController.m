//
//  RightViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "DetailLessonViewController.h"
#import "LessonData.h"
#import "ExercisesData.h"

@interface DetailLessonViewController ()

@end

@implementation DetailLessonViewController
- (IBAction)nextPartPush:(id)sender {
    
    int excNumber=[[self.sortedExcNumber objectAtIndex:1]intValue];
    NSString* excId=[(SingleExc*)[self.listOfExercises valueForKey:[NSString stringWithFormat:@"%d",excNumber]]excId];
    NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[excId componentsSeparatedByString:@"-"]];
    
 excNumber=[[words lastObject]intValue];
    [(LessonPartDispatcherViewController*)self.lessonPart test1:excNumber];
}

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
    self.theDataObject=[self theAppDataObject];
    self.listOfExercises=[[NSMutableDictionary alloc]init];
    self.dictionaryOfParams=[[NSMutableDictionary alloc]init];
   // NSString * language
    self.theDataObject.choosedLanguage= [[[NSLocale preferredLanguages] objectAtIndex:0]uppercaseString];

    [self refreshUI];
    [super viewDidLoad];

        // Do any additional setup after loading the view.
}

-(void)setLesson:(LessonData *)lesson
{
    if(self.lessonData!=lesson)
        
    {
        self.lessonData=lesson;
        [self setLessonParts];
        [self refreshUI];
      
    }
}

-(void)setLessonParts
{
    NSString *filePath = [self dataFilePath:FALSE];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0 error:&error];
   // if (doc == nil) { return nil; }
   NSString* createNode=[NSString stringWithFormat:@"//lesson[nr=\"%d\"]/exercises",self.lessonData.number];
    
    
    NSArray* resultNodes = [doc nodesForXPath:createNode error:&error];
    NSMutableArray* exercise=[[NSMutableArray alloc]init];
    for (GDataXMLElement *resultElement in resultNodes) {
        
       NSLog(@"%@", resultElement);
         exercise  = [resultElement elementsForName:@"exercise"];
        for (GDataXMLElement *singleExc in exercise) {
              NSLog(@"%@", singleExc);
             NSArray *singleParts = [singleExc children];
            NSString* excId=[[NSString alloc]init];
            int excOrder = 0;
            int excTime = 0;
            if(self.lessonData.number!=0)
            {
            for(GDataXMLElement* partsOfExc in singleParts)
            {
                NSLog(@"%@", partsOfExc);
                
                

                
                    
                    if([partsOfExc.name isEqualToString:@"id"])
                    {
                        excId=partsOfExc.XMLString;
                    }
                    else if([partsOfExc.name isEqualToString:@"order"])
                    {
                     
                        
                        NSString *stringWithoutSpaces = [partsOfExc.XMLString
                                                         stringByReplacingOccurrencesOfString:@"<order>" withString:@""];
                        NSString* tempOrder = [stringWithoutSpaces
                                 stringByReplacingOccurrencesOfString:@"</order>" withString:@""];
                        
                         excOrder=[tempOrder intValue];
                    }
                    else if([partsOfExc.name isEqualToString:@"time"])
                    {
                        excTime=[partsOfExc.XMLString intValue];
                    }
                    else
                    {
                        [self.dictionaryOfParams setObject:partsOfExc.XMLString forKey:partsOfExc.name];
                    }

                  
                    
                }
                
               excId=[self translateExcIdToExcStoryboard:excId];
                
                SingleExc* newExc=[SingleExc createExc:excId order:excOrder time:excTime params:self.dictionaryOfParams];
                [self.listOfExercises setObject:newExc forKey:[NSString stringWithFormat:@"%d",excOrder]];
                self.dictionaryOfParams=[[NSMutableDictionary alloc]init];

            }
                     }
    }

    NSMutableArray *allKeys = [[self.listOfExercises allKeys] mutableCopy];
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
     self.sortedExcNumber=[allKeys sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
 
}


-(NSString*)translateExcIdToExcStoryboard:(NSString*)excId
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"excParserIMP" ofType:@"xml"];
    
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0 error:&error];
    // if (doc == nil) { return nil; }
    NSString* createNode=@"//exercises/exercise";
    NSArray* resultNodes = [doc nodesForXPath:createNode error:&error];
    
    for (GDataXMLElement* singleEXC in resultNodes) {
                NSArray *singleParts = [singleEXC children];
         for (GDataXMLElement* singlePart in singleParts) {
            if ([singlePart.XMLString rangeOfString:excId].location != NSNotFound) {
                NSString *stringWithoutSpaces = [[[singleParts objectAtIndex:1]XMLString]
                                                 stringByReplacingOccurrencesOfString:@"<exc>" withString:@""];
                excId = [stringWithoutSpaces
                                                 stringByReplacingOccurrencesOfString:@"</exc>" withString:@""];
            }
    }
    }
    
    return excId;
}
- (NSString *)dataFilePath:(BOOL)forSave {
    return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"lessons%@",self.theDataObject.choosedLanguage] ofType:@"xml"];
}

-(void)refreshUI
{
    self.detailLessonHeader.text=self.lessonData.header;
    
    self.detailLessonDecription.text=self.lessonData.description;
    
    [self.detailLessonDecription setContentOffset:CGPointZero animated:YES];
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
-(void)selectedLesson:(LessonData *)newLesson
{
    [self setLesson:newLesson];
    if (self.popover != nil) {
        [self.popover dismissPopoverAnimated:YES];
    }
}


-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Lessons";

    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    //[self.navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    [self.navBarItem setLeftBarButtonItem:barButtonItem];
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //Remove the barButtonItem.
    [self.navBarItem setLeftBarButtonItem:nil animated:YES];
    
    
    //Nil out the pointer to the popover.
    self.popover = nil;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@",segue.identifier);
    if([segue.identifier isEqualToString:@"LessonTOPart"]){
        self.lessonPart=(LessonPartDispatcherViewController*)segue.destinationViewController;
        
        /*id test=self.controller.viewControllers;
        id test1=self.controller.view;*/
        
    }}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logOutPush:(id)sender {
  
        [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
