//
// BundledViewController.m
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import "AdViewController.h"
#import "BannerViewController.h"
#import "BundledViewController.h"
#import "InterstitialViewController.h"

@implementation BundledViewController

@synthesize controllers = controllers_;

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  // Instantiate array to hold view controllers.
  NSMutableArray *array = [[NSMutableArray alloc] init];

  // Create an instance of BannerViewController or InterstitialViewController
  // for each table view cell and define its properties: adsize, title, and
  // row image. Add object to array.
  // Banner Ad.
  BannerViewController *imageViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"Image"
          rowImage:[UIImage imageNamed:@"Banner_34x34"]];
  [array addObject:imageViewController];

  // AdMob Ad.
  BannerViewController *admobViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"AdMob Backfill"
          rowImage:[UIImage imageNamed:@"AdMob_34x34"]];
  [array addObject:admobViewController];

  // AdMob Mediation Ad.
  BannerViewController *mediationViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"SDK Mediation"
          rowImage:[UIImage imageNamed:@"Banner_34x34"]];
  [array addObject:mediationViewController];

  // Text and image ad.
  BannerViewController *textImageViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"Text and Image"
          rowImage:[UIImage imageNamed:@"Banner_34x34"]];
  [array addObject:textImageViewController];

  // DoubleClick Tag ad.
  BannerViewController *dfaTagViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"DoubleClick Tag"
          rowImage:[UIImage imageNamed:@"Banner_34x34"]];
  [array addObject:dfaTagViewController];

  // MRAID Expandable Ad.
  BannerViewController *expViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"MRAID Expandable"
          rowImage:[UIImage imageNamed:@"Expandable_34x34"]];
  [array addObject:expViewController];

  // Interstitial Ad.
  InterstitialViewController *intViewController =
      [InterstitialViewController createWithTitle:@"Interstitial"
          rowImage:[UIImage imageNamed:@"RMInt_34x34"]];
  [array addObject:intViewController];

  self.controllers = array;
}

#pragma mark - Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // There is only one section.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  // Return length of controllers array.
  return [self.controllers count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *bundledViewCell = @"BundledViewCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
      bundledViewCell];

  if (cell == nil) {
    cell = [[UITableViewCell alloc]
        initWithStyle:UITableViewCellStyleSubtitle
        reuseIdentifier:bundledViewCell];
  }

  // Configure the cell.
  NSInteger row = [indexPath row];
  AdViewController *controller = [self.controllers objectAtIndex:row];
  cell.textLabel.text = controller.title;
  cell.detailTextLabel.text = controller.adSizeLabel;
  cell.imageView.image = controller.rowImage;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = [indexPath row];
  AdViewController *nextController = [self.controllers objectAtIndex:row];
  nextController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:nextController animated:YES];
}

@end

