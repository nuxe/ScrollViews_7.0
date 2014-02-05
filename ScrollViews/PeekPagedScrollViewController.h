//
//  PeekPagedScrollViewController.h
//  ScrollViews
//
//  Created by Kush Agrawal on 8/28/13.
//  Copyright (c) 2013 Autodesk Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeekPagedScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;


@end
