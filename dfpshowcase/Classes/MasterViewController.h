//
// MasterViewController.h
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

// TableViewController displays a list of ad view controllers.
@interface MasterViewController : UITableViewController

// Array to store a list of ad view controllers.
@property (strong, nonatomic) NSArray *controllers;

@end
