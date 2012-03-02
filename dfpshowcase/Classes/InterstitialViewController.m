//
// InterstitialViewController.m
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import "InterstitialViewController.h"

@implementation InterstitialViewController

@synthesize adSize = adSize_;
@synthesize interstitialView = interstitialView_;
@synthesize keyValue = keyValue_;
@synthesize rowImage = rowImage_;
@synthesize showButton = showButton_;

// GADInterstitialView delegate method to check if interstitial ad returned.
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
  // Show interstitial ad only if it's ready
  if ([self.interstitialView isReady]) {
    [self.interstitialView presentFromRootViewController:self];

    // Enable "Show Interstitial" button to show ad again after
    // interstitialView has been dismissed.
    self.showButton.enabled = YES;
  }
}

// Child view controllers will use this method to load interstitial view.
// Calls methods to check if ad is ready and load ad request.
- (IBAction)showInterstitial:(id)sender {
  // Instantiate a new GADInterstitial object and define ad unit id.
  if (!self.interstitialView) {
    self.interstitialView = [[GADInterstitial alloc] init];
    self.interstitialView.delegate = self;
    self.interstitialView.adUnitID = kInterstitialAdUnitID;
  }

  // Retrieve GADRequest object and set custom targeting parameters.
  GADRequest *adRequest = [GADRequest request];
  if(self.keyValue) {
    adRequest.additionalParameters =
        [NSDictionary dictionaryWithObjectsAndKeys:
            self.keyValue, kKey,
            nil];
  }

  // Load ad request.
  [self.interstitialView loadRequest:adRequest];
  self.showButton.enabled = NO;
}

// If there are no interstitial ads to show, display an alert message.
- (void)interstitial:(GADInterstitial *)interstitial
    didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"Error fetching interstitial ad:%@", [error localizedDescription]);
  UIAlertView *alert = [[UIAlertView alloc]
      initWithTitle:@"GADRequestError"
      message:[error localizedDescription]
      delegate:nil
      cancelButtonTitle:@"No ad to show"
      otherButtonTitles:nil];

  [alert show];
  self.showButton.enabled = YES;
}

// interstitialView is meant to load only once. If you want to enable
// subsequent loads using showButton, nullify the existing interstitialView
// object after user dismisses the interstitial screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
  self.interstitialView.delegate = nil;
  self.interstitialView = nil;
}

- (void)viewDidUnload {
  self.interstitialView = nil;
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

