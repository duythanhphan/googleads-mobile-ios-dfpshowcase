//
// BannerViewController.h
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdConstants.h"
#import "AdViewController.h"
#import "DFPBannerView.h"

// View controller for displaying a banner using Google AdMob Ads SDK.
@interface BannerViewController : AdViewController <GADBannerViewDelegate>

// Creates a BannerViewController with the specified ad size label,
// title, and image to use in its TableViewCell.
+ (BannerViewController *)createWithAdSizeLabel:(NSString *)adSizeLabel
                                          title:(NSString *)title
                                       rowImage:(UIImage *)image;

// The banner view to display.
@property(strong, nonatomic) DFPBannerView *bannerView;

@end

