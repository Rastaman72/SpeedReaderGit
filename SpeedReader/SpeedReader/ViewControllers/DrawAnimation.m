//
//  DrawAnimation.m
//  SpeedReader
//
//  Created by LGBS dev on 8/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "DrawAnimation.h"

@implementation DrawAnimation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextMoveToPoint(context, 0, self.frame.size.height/2);
    
    CGContextAddCurveToPoint(context, 100, 0, 700, 800, self.frame.size.width, self.frame.size.height/2);
    
    CGContextStrokePath(context);
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
     CGContextMoveToPoint(context, self.frame.size.width, self.frame.size.height/2);
     CGContextAddCurveToPoint(context, 700, 0, 100, 800, 0, self.frame.size.height/2);
    
    CGContextStrokePath(context);
    
    CGContextFillRect(context, CGRectMake(0- 0.5,self.frame.size.height/2- 0.5,10.0,10.0));
   }
    

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
