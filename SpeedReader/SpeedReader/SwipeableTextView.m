//
//  SwipeableTextView.m
//  SpeedReader
//
//  Created by LGBS dev on 8/26/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SwipeableTextView.h"

@implementation SwipeableTextView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.superview touchesBegan:touches withEvent:event];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    [self.superview touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [self.superview touchesEnded:touches withEvent:event];
}
@end
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
