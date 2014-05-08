//
//  BannerContainer.m
//  OutScore
//
//  Created by Andrés Pesate on 5/7/14.
//  Copyright (c) 2014 ICO Group C.A. All rights reserved.
//

#import "HeaderContainer.h"

@implementation HeaderContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return _scrollView;
    }
    return nil;
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
