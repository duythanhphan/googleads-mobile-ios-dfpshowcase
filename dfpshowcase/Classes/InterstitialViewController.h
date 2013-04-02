//
// InterstitialViewController.h
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdConstants.h"
#import "AdViewController.h"
#import "DFPInterstitial.h"

// Generic view controller for displaying an ad unit using Google AdMob Ads SDK.
// Imports GADInterstitial class used to display an interstitial ad.
@interface InterstitialViewController : AdViewController
    <GADInterstitialDelegate>

// Creates an InterstitialViewController with the provided ad size label,
// title, and image to use in its TableViewCell.
+ (InterstitialViewController *)createWithTitle:(NSString *)title
                                       rowImage:(UIImage *)image;

// The interstitial ad to display.
@property(strong, nonatomic) DFPInterstitial *interstitialView;

// The button to show the interstitial.
@property(strong, nonatomic) IBOutlet UIButton *showButton;

// Display GADInterstitialView on button click
- (IBAction)showInterstitial:(id)sender;

@end

