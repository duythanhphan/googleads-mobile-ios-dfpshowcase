//
//  AdViewController.h
//  DfpShowcaseApp
//
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

// Generic view controller for displaying an ad unit using Google AdMob Ads SDK.
@interface AdViewController : UIViewController

// The image to use on the table cell.
@property(strong, nonatomic) UIImage *rowImage;

// A string representation of the ad size for the table cell.
@property(strong, nonatomic) NSString *adSizeLabel;

@end
