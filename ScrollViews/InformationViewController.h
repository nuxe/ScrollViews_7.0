//
//  InformationViewController.h
//  ScrollViews
//
//  Created by Kush Agrawal on 8/28/13.
//  Copyright (c) 2013 Autodesk Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Parse/Parse.h>
#import <AVFoundation/AVFoundation.h>
#import <Social/Social.h>


@interface InformationViewController : UIViewController

-(IBAction) goBack;        //Close current exhibit window
-(IBAction) goNext;        //Move to next exhibit window
-(IBAction) facebookShare; //Take and share image on facebook

-(void) setNum:(NSInteger *)newnum;

@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel; 
@property (retain, nonatomic) IBOutlet PFImageView* imageView;  //imageView holds the first image displayed upon tapping an exhibit
@property (retain, nonatomic) IBOutlet UIScrollView *infoScroller;  //infoScroller links to the scroller
@property (weak, nonatomic) IBOutlet UIButton *playButton;  //Play button for audio file
@property NSString *url1;
@property (nonatomic, strong) NSString *objectTouched2;     //String to store ObjectId of object touched by the user

@property NSInteger num;



@end
