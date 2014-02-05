//
//  DetailViewController.m
//  ScrollViews
//
//  Created by Kush Agrawal on 8/21/13.
//  Copyright (c) 2013 Autodesk Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController



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
    
	// Do any additional setup after loading the view.
    
    //Set up the map view to be centered around the Autodesk Gallery
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    
    region.center.latitude = 37.794218;
    region.center.longitude = -122.394745;
    region.span.longitudeDelta = 0.03f;
    region.span.latitudeDelta = 0.03f;
    [self.Map123 setRegion:region animated:YES];
    
    //Setup pin to be displayed at Autodesk Gallery
    CLLocation* myLocation = [[CLLocation alloc] initWithLatitude:37.794218 longitude:-122.394745];
    MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
    [newAnnotation setCoordinate:[myLocation coordinate]];
    //Add pin to map
    [newAnnotation setTitle:@"Autodesk Gallery"];
    [self.Map123 addAnnotation:newAnnotation];
    
}

//Tap to open Autodesk Gallery page in facebook, or safari if facebook is not installed
-(IBAction) facebook{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/21708959985"]];
    }
    else{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/autodeskgallery"]];
    }

}
//Tap to open Autodesk Gallery page in twitter, or safari if twitter is not installed
-(IBAction) twitter{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=autodeskgallery"]]; }
    else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/autodeskgallery"]];
    }
}

//Tap to open Autodesk Gallery page in Pinterest, or safari if pinterest is not installed
-(IBAction) pinterest{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"pinterest://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"pinterest://board/autodesk/autodesk-gallery/"]]; }
    else{
        
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://pinterest.com/autodesk/autodesk-gallery/"]];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
