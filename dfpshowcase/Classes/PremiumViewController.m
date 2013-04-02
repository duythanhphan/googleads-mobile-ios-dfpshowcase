//
//  PremiumViewController.m
//  DfpShowcaseApp
//
//  Copyright (c) 2013 Google Inc. All rights reserved.
//

#import "AdViewController.h"
#import "BannerViewController.h"
#import "InterstitialViewController.h"
#import "PremiumViewController.h"

@implementation PremiumViewController

@synthesize controllers = controllers_;

- (void)viewDidLoad {
  [super viewDidLoad];

  // Instantiate array to hold view controllers.
  NSMutableArray *array = [[NSMutableArray alloc] init];

  // Create an instance of BannerViewController or InterstitialViewController
  // for each table view cell and define its properties: adsize, title, and
  // row image. Add object to array.
  // Image Carousel Ad.
  BannerViewController *carouselViewController =
      [BannerViewController createWithAdSizeLabel:kMediumRectangleSizeString
          title:@"Mobile Image Carousel"
          rowImage:[UIImage imageNamed:@"ImageAnimation_34x34"]];
  [array addObject:carouselViewController];

  // Image with Google +1 Ad.
  BannerViewController *plusViewController =
      [BannerViewController createWithAdSizeLabel:kMediumRectangleSizeString
          title:@"Mobile Image with Google +1"
          rowImage:[UIImage imageNamed:@"RMInt_34x34"]];
  [array addObject:plusViewController];

  // Mobile Interstitial with Autoclose Ad.
  InterstitialViewController *autocloseViewController =
      [InterstitialViewController
          createWithTitle:@"Mobile Interstitial with Autoclose"
                 rowImage:[UIImage imageNamed:@"RMInt_34x34"]];
  [array addObject:autocloseViewController];

  // Image Animation Ad.
  InterstitialViewController *animationViewController =
      [InterstitialViewController createWithTitle:@"Image Animation"
          rowImage:[UIImage imageNamed:@"ImageAnimation_34x34"]];
  [array addObject:animationViewController];

  // Video Interstitial Ad.
  InterstitialViewController *videoViewController =
      [InterstitialViewController createWithTitle:@"Video Interstitial"
          rowImage:[UIImage imageNamed:@"VideoInt_34x34"]];
  [array addObject:videoViewController];

  // Application Download Ad.
  BannerViewController *downloadViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"Click to Download"
          rowImage:[UIImage imageNamed:@"AppDownload_34x34"]];
  [array addObject:downloadViewController];

  // Click to Call Ad.
  BannerViewController *callViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"Click to Call"
          rowImage:[UIImage imageNamed:@"RMInt_34x34"]];
  [array addObject:callViewController];

  // Click to Map Ad.
  BannerViewController *mapViewController =
      [BannerViewController createWithAdSizeLabel:kBannerSizeString
          title:@"Click to Map"
          rowImage:[UIImage imageNamed:@"RMInt_34x34"]];
  [array addObject:mapViewController];

  self.controllers = array;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  // Return length of controllers array.
  return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *premiumViewCell = @"PremiumViewCell";
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:premiumViewCell];

  if (cell == nil) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleSubtitle
            reuseIdentifier:premiumViewCell];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = [indexPath row];
  AdViewController *nextController = [self.controllers objectAtIndex:row];
  nextController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:nextController animated:YES];
}

@end
