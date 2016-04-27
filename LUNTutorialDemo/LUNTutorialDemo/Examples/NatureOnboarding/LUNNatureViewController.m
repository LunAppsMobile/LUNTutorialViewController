//
//  LUNNatureViewController.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/6/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNNatureViewController.h"
#import "LUNRotatingWireframesAnimator.h"
#import "LUNStaticView.h"
#import "LUNGalaxyViewController.h"
#import "LUNNatureWireframeView.h"
#import "LUNLabelsView.h"
#import "NSArray+LUNObjectAtIndex.h"
#import "LUNAnimalsViewController.h"

@interface LUNNatureViewController () <LUNTutorialDelegate, LUNTutorialDataSource>

@property (nonatomic, strong) LUNRotatingWireframesAnimator *rotatingAnimator;
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *texts;
@property (nonatomic, strong) NSArray<NSString *> *wireframes;

@end

@implementation LUNNatureViewController

static const CGFloat kLUNNatureHeightMultiplier = 440.0f/1136.0f;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetup];
    [self contentSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self reloadData];
    [self.view layoutIfNeeded];
}

#pragma mark - Setup

- (void)commonSetup {
    self.rotatingAnimator = [[LUNRotatingWireframesAnimator alloc] init];
    self.animator = self.rotatingAnimator;
    self.delegate = self;
    self.dataSource = self;
    self.numberOfRealPages = 3;
    self.roundnessHeight = 10;
}

- (void)contentSetup {
    self.titles = @[@"ANIMALS",
                    @"FLOWERS",
                    @"NATURE"];
    self.texts = @[@"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!"];
    self.wireframes = @[@"wireframe1",
                        @"wireframe2",
                        @"wireframe3"];
}

- (void)reloadData {
    [super reloadData];
    [self.view layoutIfNeeded];
    for (NSInteger index = backgroundPages.count - 1; index >= 0; index--) {
        [backgroundsScrollView bringSubviewToFront:[backgroundPages LUN_objectAtIndex:index]];
    }
}

#pragma mark - LUNTutorialStaticContentDataSource

- (CGFloat)staticContentHeight {
    return CGRectGetHeight(self.view.frame) * kLUNNatureHeightMultiplier;
}

- (__kindof UIView *)staticContentView {
    LUNStaticView *staticView = [[LUNStaticView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    staticView.startButtonTapBlock = ^void() {
        LUNAnimalsViewController *animalsController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LUNAnimalsViewController class])];
        [self presentViewController:animalsController animated:YES completion:nil];
    };
    [staticView setupButtonText:@"LET'S START"];
    [staticView setupPageControlsDotColor:[UIColor colorWithRed:122.0f / 255.0f green:122.0f / 255.0f blue:122.0f / 255.0f alpha:0.24f]];
    [staticView setupPageControlsSelectedDotColors:@[[UIColor blackColor], [UIColor blackColor], [UIColor blackColor]]];
    [staticView needShadow:NO];
    [staticView setupButtonBackgroundColor:[UIColor clearColor]];
    [staticView setupButtonCornerRadius:0.0f];
    [staticView setupButtonTextColor:[UIColor blackColor]];
    [staticView setupButtonTextFont:[UIFont fontWithName:@"BrandonGrotesque-Bold" size:14]];
    [staticView setupButtonWidth: 428.0f/640.0f * CGRectGetWidth(self.view.frame)];
    [staticView setupButtonHeight: 80.0f/1136.0f * CGRectGetHeight(self.view.frame)];
    [staticView setupButtonBorderWidth:2.0f];
    staticView.backgroundColor = [UIColor whiteColor];
    return staticView;
}

#pragma mark - LUNTUtorialBackgroundDataSource

- (__kindof UIView *)dynamicBackgroundViewAtIndex:(NSInteger)index {
    UIImageView *imageViewForIndex = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"background%ld", (long)index+1]]];
    imageViewForIndex.contentMode = UIViewContentModeScaleAspectFill;
    if (index != 0) {
        imageViewForIndex.alpha = 0.0f;
    }
    return imageViewForIndex;
}

#pragma mark - LUNTutorialWireframesDataSource

- (__kindof UIView *)wireframeViewForIndex:(NSInteger)index {
    UIImageView *imageViewForIndex = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"wireframe%ld", (long)index+1]]];
    CGRect rect = CGRectMake(0, 0, 611.0f / 1134.0f * self.view.frame.size.height, 1076.0f / 1134.0f * self.view.frame.size.height);
    imageViewForIndex.frame = rect;
    imageViewForIndex.contentMode = UIViewContentModeScaleToFill;
    UIImage *scaledImage = imageViewForIndex.image;
    
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    [scaledImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    LUNNatureWireframeView *wireframeForIndex = [[LUNNatureWireframeView alloc] init];
    [wireframeForIndex setupWireframeImage:newImage];
    return wireframeForIndex;
}

#pragma mark - LUNTutorialDelegate

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController reachedPage:(NSInteger)index {
    [(LUNStaticView *)staticContentView  selectPageIndex:index];
}

#pragma mark - LUNTutorialLabelsDataSource

- (CGFloat)labelsTopMargin {
    return CGRectGetHeight(self.view.frame) - self.staticContentHeight + self.roundnessHeight;
}

- (__kindof UIView *)labelViewAtIndex:(NSInteger)index {
    LUNLabelsView *labelsView = [[LUNLabelsView alloc] initWithFrame:CGRectZero];
    [labelsView setupTitle:self.titles[index] supportingText:self.texts[index] titleColor:[UIColor blackColor] textColor:[UIColor colorWithRed:52.0f / 255.0f green:52.0f / 255.0f blue:52.0f / 255.0f alpha:0.54f]];
    labelsView.titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:20];
    labelsView.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Regular" size:15];
    return labelsView;
}

@end
