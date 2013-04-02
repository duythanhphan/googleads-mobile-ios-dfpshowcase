//
// BundledViewController.h
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

// TableViewController which displays a list of ad view controllers for
// basic DFP features.
@interface BundledViewController : UITableViewController

// Array to store a list of ad view controllers.
@property(strong, nonatomic) NSArray *controllers;

@end
