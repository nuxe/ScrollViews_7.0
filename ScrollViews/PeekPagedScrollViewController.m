//
//  PeekPagedScrollViewController.m
//  ScrollViews
//
//  Created by Kush Agrawal on 8/28/13.
//  Copyright (c) 2013 Autodesk Inc. All rights reserved.
//

#import "PeekPagedScrollViewController.h"
#import "InformationViewController.h"


@interface PeekPagedScrollViewController ()

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) PFImageView *imageView;
@property (nonatomic, strong)NSString *objectTouched;   //Stores ObjectID of exhibit tapped by user

@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

@end

@implementation PeekPagedScrollViewController

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize imageView = _imageView;
@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;
@synthesize objectTouched;


#pragma mark -

- (void)loadVisiblePages {
    
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages we want to load
 //   NSInteger firstPage = page - 1;
   // NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
//for (NSInteger i=0; i<firstPage; i++) {
//        [self purgePage:i];
//    }
    
    for (NSInteger i=0; i<=self.pageImages.count; i++) {
        [self loadPage:i];
    }
    
//    for (NSInteger i=firstPage; i<=lastPage; i++) {
//        [self loadPage:i];
//    }
//
//    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
//        [self purgePage:i];
//    }
}

- (void)loadPage:(NSInteger)page {      //Load an individual page
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame = CGRectInset(frame, 10.0f, 0.0f);
        

        self.imageView = [[PFImageView alloc] init];
        
        self.imageView.file = (PFFile *)[[self.pageImages objectAtIndex:page] objectForKey:@"Image1"];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.frame = frame;
        [self.imageView loadInBackground];

        
        
         [self.scrollView addSubview:self.imageView];
        [self.pageViews replaceObjectAtIndex:page withObject:self.imageView];

        UIButton *newButton = [[UIButton alloc] initWithFrame:frame];
        newButton.tag = page;
        [newButton addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:newButton];
        
    }
}

- (IBAction)buttonClick1:(id)sender{        //Called if an exhibit is touched, records which one is touched and performs Segue "Show Detail"

    UIButton *clicked = (UIButton *)sender;
    self.objectTouched = [[self.pageImages objectAtIndex:clicked.tag] objectId];
 //   NSLog(@"%@", self.objectTouched);

    [self performSegueWithIdentifier:@"Show Detail" sender:sender];
    
    
    

}


- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Exhibits";
    
    //Set background to Untitled.png
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Untitled.png"]]];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];

    //Query parse to get all the exhibit objects
    PFQuery *query = [PFQuery queryWithClassName:@"Exhibits"];
    self.pageImages = query.findObjects;
 //   NSLog(@"%@", self.pageImages);
 
        NSInteger pageCount = self.pageImages.count;
 
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = pageCount;
        
        // Set up the array to hold the views for each page
        self.pageViews = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < pageCount; ++i) {
            [self.pageViews addObject:[NSNull null]];
        }

    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    // Load the initial set of pages that are on screen
    [self loadVisiblePages];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.scrollView = nil;
    self.pageControl = nil;
    self.pageImages = nil;
    self.pageViews = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages which are now on screen
    [self loadVisiblePages];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Show Detail"]) {
        UIButton *clicked = (UIButton *)sender;

        [[segue destinationViewController] setObjectTouched2:self.objectTouched];
        
        [[segue destinationViewController] setNum:clicked.tag];
        
        
        
    }
    
}

@end
