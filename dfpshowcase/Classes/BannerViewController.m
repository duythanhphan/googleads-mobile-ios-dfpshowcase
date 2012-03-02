//
// BannerViewController.m
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import "BannerViewController.h"

@implementation BannerViewController

@synthesize adSize = adSize_;
@synthesize bannerView = bannerView_;
@synthesize keyValue = keyValue_;
@synthesize rowImage = rowImage_;

// Load background image since ad unit doesn't take up the full screen.
// Fix starting position at (0,45) due to the height of the navigation bar.
- (void)loadBackgroundImage {
  UIImage *img = [UIImage imageNamed:@"background_320x365.jpg"];
  UIImageView *bgImageView = [[UIImageView alloc] initWithImage:img];
  bgImageView.frame = CGRectMake(0, 45, 320, 365);
  [self.view addSubview:bgImageView];
}

// Instantiate a new GADBannerView object, define ad frame dimensions and
// custom targeting, if any. Then, load ad request.
- (void)loadBannerView:(NSInteger)adWidth height:(NSInteger)adHeight {
  self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(
      0.0,
      self.view.frame.size.height - adHeight,
      adWidth,
      adHeight)];

  // Assign Banner ad unit id defined in AdConstants.h file.
  self.bannerView.adUnitID = kBannerAdUnitID;

  // Define root viewcontroller to return user to.
  self.bannerView.rootViewController = self;
  [self.view addSubview:self.bannerView];

  // Retrieve GADRequest object and set custom targeting parameters.
  GADRequest *adRequest = [GADRequest request];

  // Set custom (keyword) targeting and load ad request.
  if (self.keyValue) {
    adRequest.additionalParameters =
        [NSDictionary dictionaryWithObjectsAndKeys:
            self.keyValue, kKey,
            nil];
  }

  // No need to clean up self.bannerView since we are using
  // Automatic Reference Counting.
  [self.bannerView loadRequest:adRequest];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Check to see if the ad you are trying to load is an interstitial.
  // If it is not, then load bannerView.
  if ([self.keyValue rangeOfString:@"interstitial"].location == NSNotFound) {
    // If ad type is image animation, don't load the background image.
    if ([self.keyValue isEqualToString:@"imageanimation"]) {
      [self loadBannerView:kImageAnimationSize.width
                    height:kImageAnimationSize.height];
    } else {
      [self loadBackgroundImage];
      [self loadBannerView:GAD_SIZE_320x50.width
                    height:GAD_SIZE_320x50.height];
    }
  }
}

// GADBannerView delegate method; called when a banner ad is received.
- (void)adViewDidReceiveAd:(GADBannerView *)view {
  NSLog(@"Banner ad received");
}

// GADBannerView delegate method; called when there is no banner ad to show.
- (void)adView:(GADBannerView *)view
    didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"Error fetching Bannner ad: %@", [error localizedDescription]);
}

- (void)viewDidUnload {
  self.bannerView = nil;
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
    (UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations.
  // This application only supports upright portrait orientation.
  if ([[UIDevice currentDevice] userInterfaceIdiom] ==
      UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return NO;
  }
}

@end

