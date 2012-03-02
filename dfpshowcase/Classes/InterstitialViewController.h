//
// InterstitialViewController.h
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdConstants.h"
#import "GADInterstitial.h"

// Generic view controller for displaying an ad unit using Google AdMob Ads SDK.
// Imports GADInterstitial class used to display an interstitial ad.
@interface InterstitialViewController : UIViewController
    <GADInterstitialDelegate>

@property (strong, nonatomic) NSString *adSize;
@property (strong, nonatomic) GADInterstitial *interstitialView;
@property (strong, nonatomic) NSString *keyValue;
@property (strong, nonatomic) UIImage *rowImage;
@property (strong, nonatomic) IBOutlet UIButton *showButton;

// Display GADInterstitialView on button click
- (IBAction)showInterstitial:(id)sender;

@end

