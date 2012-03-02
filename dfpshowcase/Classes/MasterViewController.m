//
// MasterViewController.m
// DFP Showcase App
//
// Copyright (c) 2011 Google Inc. All rights reserved.
//

#import "BannerViewController.h"
#import "InterstitialViewController.h"
#import "MasterViewController.h"

@implementation MasterViewController

@synthesize controllers = controllers_;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  // Set title for tableview.
  self.title = @"DFP Mobile Ads";

  // Instantiate array to hold view controllers.
  NSMutableArray *array = [[NSMutableArray alloc] init];

  // Retrieve main storyboard object.
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
      @"MainStoryboard_iPhone" bundle:nil];

  // Create an instance of BannerViewController or InterstitialViewController
  // for each table view cell and define its properties: adsize, title,
  // row image, and keyword. Add object to array.
  // Banner Ad.
  BannerViewController *bannerViewController =
      [[BannerViewController alloc] init];
  bannerViewController.adSize = kBannerSizeString;
  bannerViewController.title = @"Banner";
  bannerViewController.rowImage = [UIImage imageNamed:@"Banner_34x34.png"];
  bannerViewController.keyValue = @"banner";
  [array addObject:bannerViewController];
  bannerViewController = nil;

  // Expandable Ad.
  BannerViewController *expViewController =
      [[BannerViewController alloc] init];
  expViewController.adSize = kBannerSizeString;
  expViewController.title = @"Expandable";
  expViewController.rowImage = [UIImage imageNamed:@"Expandable_34x34.png"];
  expViewController.keyValue = @"expandable";
  [array addObject:expViewController];
  expViewController = nil;

  // AdMob Ad.
  BannerViewController *admobViewController =
      [[BannerViewController alloc] init];
  admobViewController.adSize = kBannerSizeString;
  admobViewController.title = @"AdMob Backfill";
  admobViewController.rowImage = [UIImage imageNamed:@"AdMob_34x34.png"];
  admobViewController.keyValue = @"admob";
  [array addObject:admobViewController];
  admobViewController = nil;

  // Richmedia Interstitial Ad.
  InterstitialViewController *intViewController = [storyboard
      instantiateViewControllerWithIdentifier:@"RMInterstitialViewController"];
  intViewController.adSize = kInterstitialSizeString;
  intViewController.title = @"Rich Media Interstitial";
  intViewController.rowImage = [UIImage imageNamed:@"RMInt_34x34.png"];
  intViewController.keyValue = @"interstitial1";
  [array addObject:intViewController];
  intViewController = nil;

  // Image Animation Ad.
  BannerViewController *imgViewController =
      [[BannerViewController alloc] init];
  imgViewController.adSize = kImageAnimationSizeString;
  imgViewController.title = @"Image Animation";
  imgViewController.rowImage = [UIImage imageNamed:@"ImageAnimation_34x34.png"];
  imgViewController.keyValue = @"imageanimation";
  [array addObject:imgViewController];
  imgViewController = nil;

  // Video Interstitial Ad.
  InterstitialViewController *videoViewController = [storyboard
      instantiateViewControllerWithIdentifier:
      @"VideoInterstitialViewController"];
  videoViewController.adSize = kInterstitialSizeString;
  videoViewController.title = @"Video Interstitial";
  videoViewController.rowImage = [UIImage imageNamed:@"VideoInt_34x34.png"];
  videoViewController.keyValue = @"videointerstitial";
  [array addObject:videoViewController];
  videoViewController = nil;

  // Application Download Ad.
  BannerViewController *appViewController =
      [[BannerViewController alloc] init];
  appViewController.adSize = kBannerSizeString;
  appViewController.title = @"Click to Download";
  appViewController.rowImage = [UIImage imageNamed:@"AppDownload_34x34.png"];
  appViewController.keyValue = @"appdownload";
  [array addObject:appViewController];
  appViewController = nil;

  // Click to Call Ad.
  BannerViewController *callViewController =
      [[BannerViewController alloc] init];
  callViewController.adSize = kBannerSizeString;
  callViewController.title = @"Click to Call";
  callViewController.rowImage = [UIImage imageNamed:@"RMInt_34x34.png"];
  callViewController.keyValue = @"clicktocall";
  [array addObject:callViewController];
  callViewController = nil;

  // Click to Map Ad.
  BannerViewController *mapViewController =
      [[BannerViewController alloc] init];
  mapViewController.adSize = kBannerSizeString;
  mapViewController.title = @"Click to Map";
  mapViewController.rowImage = [UIImage imageNamed:@"RMInt_34x34.png"];
  mapViewController.keyValue = @"clicktomap";
  [array addObject:mapViewController];
  mapViewController = nil;

  self.controllers = array;
}

#pragma mark -
#pragma mark Table Data Source Methods

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
  static NSString *MasterViewCell = @"MasterViewCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
      MasterViewCell];

  if (cell == nil) {
    cell = [[UITableViewCell alloc]
        initWithStyle:UITableViewCellStyleSubtitle
        reuseIdentifier:MasterViewCell];
  }

  // Configure the cell.
  NSInteger row = [indexPath row];

  // Retrieve view controller keyword to distinguish between banner and
  // interstitial view controller.
  NSString *keyValue = [[self.controllers objectAtIndex:row] keyValue];

  // Retrieve controller object from array where array index = table row index.
  if ([keyValue rangeOfString:@"interstitial"].location == NSNotFound) {
    BannerViewController *controller = [self.controllers objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.detailTextLabel.text = controller.adSize;
    cell.imageView.image = controller.rowImage;
  } else {
    InterstitialViewController *controller = [self.controllers
        objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.detailTextLabel.text = controller.adSize;
    cell.imageView.image = controller.rowImage;
  }

  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = [indexPath row];

  // Retrieve view controller keyword to determine if the view controller
  // is for a banner or an interstitial ad before pushing it onto the stack.
  NSString *keyValue = [[self.controllers objectAtIndex:row] keyValue];
  if ([keyValue rangeOfString:@"interstitial"].location == NSNotFound) {
    BannerViewController *nextController = [self.controllers objectAtIndex:row];
    [self.navigationController pushViewController:nextController animated:YES];
  } else {
    InterstitialViewController *nextController =
        [self.controllers objectAtIndex:row];
    [self.navigationController pushViewController:nextController animated:YES];
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
    (UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations.
  // This application only supports upright portrait orientation.
  if ([[UIDevice currentDevice] userInterfaceIdiom] ==
      UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return NO;
  }
}

@end

