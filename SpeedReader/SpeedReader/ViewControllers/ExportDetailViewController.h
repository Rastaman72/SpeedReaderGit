//
//  ExportDetailViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccountForDB.h"
#import <MessageUI/MessageUI.h>


#import "ZipException.h"
#import "FileInZipInfo.h"
#import "ZipWriteStream.h"
#import "ZipReadStream.h"
#import "ZipFile.h"

#import "UserParser.h"
@interface ExportDetailViewController : UIViewController<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mailExportButton;
- (IBAction)mailPush:(id)sender;
@property(nonatomic,retain)UserAccountForDB* userToExport;

@property(nonatomic,retain) ZipFile* toExportZIP;
@end
