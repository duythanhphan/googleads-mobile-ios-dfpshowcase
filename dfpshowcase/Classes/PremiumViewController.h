//
// PremiumViewController.h
// DfpShowcaseApp
//
// Copyright (c) 2013 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

// TableViewController which displays a list of ad view controllers for
// advanced DFP features.
@interface PremiumViewController : UITableViewController

// Array to store a list of ad view controllers.
@property(strong, nonatomic) NSArray *controllers;

@end
