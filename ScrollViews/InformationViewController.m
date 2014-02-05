//
//  InformationViewController.m
//  ScrollViews
//
//  Created by Kush Agrawal on 8/28/13.
//  Copyright (c) 2013 Autodesk Inc. All rights reserved.
//

#import "InformationViewController.h"
#import "DetailViewController.h"


@interface InformationViewController ()
@property (nonatomic, strong) AVAudioPlayer* player;        //Audio player
@property (nonatomic, strong) PFQuery* query;               //Parse Query object
@property (nonatomic, strong) UIImage* facebookShareImage;  //Image to be shared onto facebook(clicked by user)

@end

@implementation InformationViewController

@synthesize num;
@synthesize imageView; //imageView holds the first image displayed upon tapping an exhibit
@synthesize infoScroller; //infoScroller links to the scroller
@synthesize player = mPlayer;
@synthesize playButton = mPlayingButton;
@synthesize url1;
@synthesize objectTouched2; //String to store ObjectId of object touched by the user
@synthesize query;
@synthesize facebookShareImage;

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
    
    //Setting background to Untitled.png
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Untitled.png"]]];
    [self.infoScroller setBackgroundColor:[UIColor clearColor]];

    //Making query to Parse
    self.query = [PFQuery queryWithClassName:@"Exhibits"];
    [self.query getObjectInBackgroundWithId:objectTouched2 block:^(PFObject *exhibit, NSError *error) {
        //All of this is asynchronous
        // Do something with the returned PFObject.
        
        //Set the size of the infoScroller
        [self.infoScroller setContentSize:CGSizeMake(320, 930)];
        
        //Setting up & loading the first image(Image Parse)
        imageView = [[PFImageView alloc] init];
        imageView.file = (PFFile *)[exhibit objectForKey:@"Image"];
        imageView.frame = CGRectMake(0, 20, 320, 240);
        [imageView loadInBackground];
        [self.infoScroller addSubview:imageView];
        
        //Animating the loading of the image
        [UIView animateWithDuration:2.0 animations:^{
            imageView.alpha = 0;
        }];
        
        [UIView animateWithDuration:2.0 animations:^{
            imageView.alpha = 1;
        }];
        
        //Setting up the label which holds the Information text (Information Parse)
        UILabel *information = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 260, 300)];
        information.numberOfLines=20;
        information.text = [exhibit objectForKey:@"Information"];
        [self.infoScroller addSubview:information];
        
        //Setting up the YouTube video in a UIWebView and clipping,displaying only the video in the UIWebView
        NSString *urlString = [exhibit objectForKey:@"YouTube"];
        NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = yes, width = 320\"/></head><body style=\"background:#00;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"180\"><param name=\"movie\" value=\"http://www.youtube.com/v/%@&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"http://www.youtube.com/v/%@&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"180\"></embed></object></div></body></html>", urlString, urlString];
        UIWebView *videoView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 510, 320, 180)];
        [videoView loadHTMLString:htmlString baseURL:nil];
        videoView.scrollView.scrollEnabled = NO;
        [self.infoScroller addSubview:videoView];
        
        // Potential Web 3D model embedding
        //        UIWebView *tdView = [[UIWebView alloc] initWithFrame:CGRectMake(0,1000, 320, 200)];
        //        NSURL *myURL = [NSURL URLWithString:@"http://threejs.org/examples/canvas_particles_sprites.html"];
        //        NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
        //        tdView.scrollView.scrollEnabled=YES;
        //        [tdView loadRequest:myRequest];
        //        [self.infoScroller addSubview:tdView];
        
        //Setting up the label which holds the Information 2 text (Information2 Parse)
        UILabel *information2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 670, 260, 300)];
        information2.numberOfLines=20;
        information2.text = [exhibit objectForKey:@"Information2"];
        [self.infoScroller addSubview:information2];
        
        //Setting up the url for the Audio file to be played(Audio Parse)
        url1 = [(PFFile *)[exhibit objectForKey:@"Audio"] url];
        
        
    }];
    

    
        
    
    
 
}

//Called when the audio file is to be played
- (IBAction)play:(id)sender {
    
    url1=[url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//Encode your url
    NSURL *url = [NSURL URLWithString:url1];
    NSData *theData = [NSData dataWithContentsOfURL:url];
    self.player = [[AVAudioPlayer alloc] initWithData:theData error:nil];
    [self.player play];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Exit the current exhibit view by either tapping on X or swipping right
-(IBAction) goBack{
    [self dismissModalViewControllerAnimated:YES];
}

//Go onto next exhibit by swiping left
-(IBAction) goNext{
    self.query = [PFQuery queryWithClassName:@"Exhibits"];
    
    if (self.num < query.findObjects.count-1){
        
        [self setNum: self.num+1];
        
        [self setObjectTouched2:[[self.query.findObjects objectAtIndex:self.num] objectId]];
        
        [[self.infoScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self viewDidLoad];
    }
    
}


//Click and share exhibit image onto facebook
-(IBAction) facebookShare{
   
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        
        // image picker needs a delegate,
        [imagePickerController setDelegate:self];
        
        // Place image picker on the screen
        [self presentModalViewController:imagePickerController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *chosenImage =UIImageJPEGRepresentation(image1, 1.0);
    image1 = [UIImage imageWithData:chosenImage];
    [self dismissViewControllerAnimated:YES completion:^(void){
        //write code here
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [fbSheet setInitialText:@"-At the Autodesk Gallery"];
            [fbSheet addURL:[NSURL URLWithString:@"http://usa.autodesk.com/gallery/"]];
            
            
            [fbSheet addImage:image1]; //This is where I try to add my image
            
            [self presentViewController:fbSheet animated:YES completion:nil];
        }
        else if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            [self dismissViewControllerAnimated:NO completion:nil];
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Sorry"
                                      message:@"You can't post to Facebook right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }];

}




-(void) setNum:(NSInteger)newnum{
    num = newnum;
}
@end
