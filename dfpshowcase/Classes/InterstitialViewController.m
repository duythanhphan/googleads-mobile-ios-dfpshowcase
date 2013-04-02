//
// InterstitialViewController.m
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import "InterstitialViewController.h"

@implementation InterstitialViewController

@synthesize interstitialView = interstitialView_;

+ (InterstitialViewController *)createWithTitle:(NSString *)title
                                       rowImage:(UIImage *)image {
  // Retrieve main storyboard object.
  UIStoryboard *storyboard =
      [UIStoryboard storyboardWithName: @"MainStoryboard_iPhone" bundle:nil];
  InterstitialViewController *intViewController = [storyboard
      instantiateViewControllerWithIdentifier:@"InterstitialViewController"];
  intViewController.adSizeLabel = @"Full screen";
  intViewController.title = title;
  intViewController.rowImage = image;
  return intViewController;
}

// Child view controllers will use this method to load interstitial view.
// Calls methods to check if ad is ready and load ad request.
- (IBAction)showInterstitial:(UIButton *)sender {
  // Set previous DFPInterstitial object and its delegate to nil.
  self.interstitialView.delegate = nil;
  self.interstitialView = nil;

  // Instantiate a new DFPInterstitial object and define ad unit id.
  self.interstitialView = [[DFPInterstitial alloc] init];
  self.interstitialView.delegate = self;
  // Set the appropriate ad unit ID based on the example.
  if ([self.title isEqualToString:@"Interstitial"]) {
    self.interstitialView.adUnitID = kIntAdUnitID;
  } else if ([self.title isEqualToString:@"Image Animation"]) {
    self.interstitialView.adUnitID = kAnimationAdUnitID;
  } else if ([self.title isEqualToString:
              @"Mobile Interstitial with Autoclose"]) {
    self.interstitialView.adUnitID = kAutocloseAdUnitID;
  } else if ([self.title isEqualToString:@"Video Interstitial"]) {
    self.interstitialView.adUnitID = kVideoAdUnitID;
  }

  // Retrieve GADRequest object and set custom targeting parameters.
  GADRequest *adRequest = [GADRequest request];

  // Load ad request.
  [self.interstitialView loadRequest:adRequest];
  self.showButton.enabled = NO;
}

- (void)dealloc {
  interstitialView_.delegate = nil;
}

#pragma mark - GADInterstitialDelegate methods

// GADInterstitialView delegate method to check if interstitial ad returned.
- (void)interstitialDidReceiveAd:(DFPInterstitial *)interstitial {
  NSLog(@"Interstitial ad received");
  // Show interstitial right away.
  [self.interstitialView presentFromRootViewController:self];

  // Enable "Show Interstitial" button to show ad again after
  // interstitialView has been dismissed.
  self.showButton.enabled = YES;
}

// If there are no interstitial ads to show, display an alert message.
- (void)interstitial:(DFPInterstitial *)interstitial
    didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"Error fetching interstitial ad: %@", [error localizedDescription]);
  UIAlertView *alert =
      [[UIAlertView alloc] initWithTitle:@"GADRequestError"
                                 message:[error localizedDescription]
                                delegate:nil
                       cancelButtonTitle:@"No ad to show"
                       otherButtonTitles:nil];

  [alert show];
  self.showButton.enabled = YES;
}

@end

