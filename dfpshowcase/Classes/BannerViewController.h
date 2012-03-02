//
// BannerViewController.h
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdConstants.h"
#import "GADBannerView.h"

// Generic view controller for displaying an ad unit using Google AdMob Ads SDK.
// Imports GADBannerView class used to display a banner ad.
@interface BannerViewController : UIViewController <GADBannerViewDelegate>

@property (strong, nonatomic) GADBannerView *bannerView;
@property (strong, nonatomic) UIImage *rowImage;
@property (strong, nonatomic) NSString *keyValue;
@property (strong, nonatomic) NSString *adSize;

@end

