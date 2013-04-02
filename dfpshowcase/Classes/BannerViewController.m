//
// BannerViewController.m
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import "BannerViewController.h"

@implementation BannerViewController

@synthesize bannerView = bannerView_;

+ (BannerViewController *)createWithAdSizeLabel:(NSString *)adSizeLabel
                                          title:(NSString *)title
                                       rowImage:(UIImage *)image {
  // Retrieve main storyboard object.
  UIStoryboard *storyboard =
      [UIStoryboard storyboardWithName: @"MainStoryboard_iPhone" bundle:nil];
  BannerViewController *bannerController = [storyboard
      instantiateViewControllerWithIdentifier:@"BannerViewController"];
  bannerController.adSizeLabel = adSizeLabel;
  bannerController.title = title;
  bannerController.rowImage = image;
  return bannerController;
}

// Instantiate a new DFPBannerView object, define ad frame dimensions and
// custom targeting, if any. Then, load ad request.
- (void)loadBannerView:(CGSize)bannerSize withAdUnit:adUnitID {
  self.bannerView = [[DFPBannerView alloc] initWithFrame:CGRectMake(
      (self.view.bounds.size.width - bannerSize.width) / 2,
      self.view.bounds.size.height - bannerSize.height,
      bannerSize.width,
      bannerSize.height)];

  // Assign Banner ad unit id defined in AdConstants.h file.
  self.bannerView.adUnitID = adUnitID;
  self.bannerView.delegate = self;
  self.bannerView.rootViewController = self;
  [self.view addSubview:self.bannerView];

  // Load banner with an ad request. No need to clean up self.bannerView since
  // we are using Automatic Reference Counting.
  [self.bannerView loadRequest:[GADRequest request]];
}

// Using viewWillLayoutSubviews instead of viewDidLoad, because at the time
// this method is called, self.view.bounds has the correct reference point
// when taking into consideration the navigation bar.
- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize bannerSize = CGSizeZero;
  NSString *adUnitID = @"";
  // Load the appropriate bannerView.
  if ([self.title isEqualToString:@"Image"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kImageAdUnitID;
  } else if ([self.title isEqualToString:@"AdMob Backfill"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kAdMobAdUnitID;
  } else if ([self.title isEqualToString:@"SDK Mediation"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kMediationAdUnitID;
  } else if ([self.title isEqualToString:@"Text and Image"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kTextImageAdUnitID;
  } else if ([self.title isEqualToString:@"DoubleClick Tag"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kDfaTagAdUnitID;
  } else if ([self.title isEqualToString:@"MRAID Expandable"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kExpAdUnitID;
  } else if ([self.title isEqualToString:@"Mobile Image Carousel"]) {
    bannerSize = GAD_SIZE_300x250;
    adUnitID = kCarouselAdUnitID;
  } else if ([self.title isEqualToString:@"Mobile Image with Google +1"]) {
    bannerSize = GAD_SIZE_300x250;
    adUnitID = kPlusAdUnitID;
  } else if ([self.title isEqualToString:@"Click to Download"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kDownloadAdUnitID;
  } else if ([self.title isEqualToString:@"Click to Call"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kCallAdUnitID;
  } else if ([self.title isEqualToString:@"Click to Map"]) {
    bannerSize = GAD_SIZE_320x50;
    adUnitID = kMapAdUnitID;
  }
  [self loadBannerView:bannerSize withAdUnit:adUnitID];
}

- (void)dealloc {
  bannerView_.delegate = nil;
}

#pragma mark - GADBannerViewDelegate methods

// Called when a banner ad is received.
- (void)adViewDidReceiveAd:(DFPBannerView *)view {
  NSLog(@"Banner ad received");
}

// Called when there is no banner ad to show.
- (void)adView:(DFPBannerView *)view
    didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"Error fetching Bannner ad: %@", [error localizedDescription]);
}

@end

