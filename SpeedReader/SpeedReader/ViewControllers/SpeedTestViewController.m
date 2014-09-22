//
//  SpeedTestViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SpeedTestViewController.h"

@interface SpeedTestViewController ()

@end

@implementation SpeedTestViewController

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
self.theDataObject = [self theAppDataObject];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"tests%@",self.theDataObject.choosedLanguage] ofType:@"xml"];
    
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0 error:&error];
    // if (doc == nil) { return nil; }
    NSString* createNode=[NSString stringWithFormat:@"//test[nr=\"%d\"]",self.theDataObject.selectLesson];
    NSArray* resultNodes = [doc nodesForXPath:createNode error:&error];
    
 NSArray *singleParts = [[resultNodes firstObject]children];
    
    for (GDataXMLElement* singleElement in singleParts) {
        if ([singleElement.name isEqualToString:@"text"]) {
            
            NSString *stringWithoutBeginMark = [singleElement.XMLString
                                             stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<%@>",singleElement.name] withString:@""];
            NSString* cleanText = [stringWithoutBeginMark
                                     stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"</%@>",singleElement.name] withString:@""];
            self.textView.text=cleanText;
             [self.textView setContentOffset:CGPointZero animated:YES];
        }
    }

    // Do any additional setup after loading the view.
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
