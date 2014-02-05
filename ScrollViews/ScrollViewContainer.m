//
//  ScrollViewContainer.m
//  ScrollViews
//
//  Created by Kush Agrawal on 8/28/13.
//  Copyright (c) 2013 Autodesk Inc. All rights reserved.
//

#import "ScrollViewContainer.h"

@implementation ScrollViewContainer

@synthesize scrollView = _scrollView;
//@synthesize mapView = _mapView;
#pragma mark -

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return _scrollView;
    }
    return view;
}

@end
