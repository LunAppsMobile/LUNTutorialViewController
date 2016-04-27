//
//  LUNAnimalsViewController.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/11/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNAnimalsViewController.h"
#import "LUNRotatingWireframesAnimator.h"
#import "LUNStaticView.h"
#import "LUNGalaxyViewController.h"
#import "LUNNatureWireframeView.h"
#import "LUNLabelsView.h"
#import "NSArray+LUNObjectAtIndex.h"

@interface LUNAnimalsViewController () <LUNTutorialDelegate, LUNTutorialDataSource, LUNTutorialAnimator>

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *texts;

@end

@implementation LUNAnimalsViewController

static const CGFloat kLUNNatureHeightMultiplier = 450.0f/1136.0f;
static const CGFloat kLUNNatureBackgroundShift = 175.0f;

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
    self.animator = self;
    self.delegate = self;
    self.dataSource = self;
    self.numberOfRealPages = 3;
    self.roundnessHeight = 10;
}

- (void)contentSetup {
    self.titles = @[@"BEARS",
                    @"BIRDS",
                    @"ELEPHANT"];
    
    self.texts = @[@"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!"];
}

- (void)reloadData {
    [super reloadData];
    [self.view layoutIfNeeded];
    for (NSInteger index = backgroundPages.count - 1; index >= 0; index--) {
        [backgroundsScrollView bringSubviewToFront:[backgroundPages LUN_objectAtIndex:index]];
    }
    
    UIView *workaroundView = [UIView new];
    workaroundView.backgroundColor = staticContentView.backgroundColor;
    workaroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:workaroundView aboveSubview:backgroundsScrollView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:workaroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:staticContentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:workaroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:staticContentView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:workaroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:staticContentView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:workaroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:staticContentView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:-1 * self.roundnessHeight]];
    workaroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    workaroundView.layer.shadowOpacity = 1.0f;
    workaroundView.layer.shadowRadius = 16.0f;
    workaroundView.layer.shadowOffset = CGSizeMake(0, 12.5f);
    workaroundView.layer.shadowPath = ((CAShapeLayer *)staticContentView.layer.mask).path;
}

#pragma mark - LUNTutorialStaticContentDataSource

- (CGFloat)staticContentHeight {
    return CGRectGetHeight(self.view.frame) * kLUNNatureHeightMultiplier;
}

- (__kindof UIView *)staticContentView {
    LUNStaticView *staticView = [[LUNStaticView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    staticView.startButtonTapBlock = ^void() {
        LUNGalaxyViewController *galaxyController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LUNGalaxyViewController class])];
        [self presentViewController:galaxyController animated:YES completion:nil];
    };
    [staticView setupButtonText:@"LET'S START"];
    [staticView setupPageControlsDotColor:[UIColor colorWithRed:122.0f / 255.0f green:122.0f / 255.0f blue:122.0f / 255.0f alpha:0.24f]];
    [staticView setupPageControlsSelectedDotColors:@[[UIColor blackColor], [UIColor blackColor], [UIColor blackColor]]];
    [staticView needShadow:NO];
    [staticView setupButtonBackgroundColor:[UIColor colorWithRed:59.0f / 255.0f green:59.0f / 255.0f blue:59.0f / 255.0f alpha:1.0f]];
    [staticView setupButtonCornerRadius:7.5f];
    [staticView setupButtonTextColor:[UIColor whiteColor]];
    [staticView setupButtonTextFont:[UIFont fontWithName:@"BrandonGrotesque-Bold" size:14]];
    [staticView setupButtonWidth: 428.0f/640.0f * CGRectGetWidth(self.view.frame)];
    [staticView setupButtonHeight: 80.0f/1136.0f * CGRectGetHeight(self.view.frame)];
    staticView.backgroundColor = [UIColor whiteColor];
    
    UIView *workaroundView = [UIView new];
    workaroundView.backgroundColor = [UIColor colorWithRed:59.0f / 255.0f green:59.0f / 255.0f blue:59.0f / 255.0f alpha:1.0f];
    workaroundView.translatesAutoresizingMaskIntoConstraints = NO;
    workaroundView.clipsToBounds = NO;
    workaroundView.layer.masksToBounds = NO;
    
    [staticView insertSubview:workaroundView atIndex:0];
    [staticView addConstraint:[NSLayoutConstraint constraintWithItem:staticView.letsStartButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:workaroundView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [staticView addConstraint:[NSLayoutConstraint constraintWithItem:staticView.letsStartButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:workaroundView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [staticView addConstraint:[NSLayoutConstraint constraintWithItem:staticView.letsStartButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:workaroundView attribute:NSLayoutAttributeWidth multiplier:436.0f / 374.0f constant:0.0f]];
    [workaroundView addConstraint:[NSLayoutConstraint constraintWithItem:workaroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetHeight(staticView.letsStartButton.frame) * 0.4f]];
    workaroundView.layer.shadowRadius = 15.0f;
    workaroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    workaroundView.layer.shadowOpacity = 1.0f;
    workaroundView.layer.shadowOffset = CGSizeMake(0, 6);
    
    return staticView;
}

#pragma mark - LUNTutorialBackgroundDataSource

- (__kindof UIView *)dynamicBackgroundViewAtIndex:(NSInteger)index {
    UIImageView *imageViewForIndex = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"animalBackground%ld", (long)index+1]]];
    if (index != 0) {
        imageViewForIndex.alpha = 0.0f;
        imageViewForIndex.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        imageViewForIndex.contentMode = UIViewContentModeTopRight;
    }
    return imageViewForIndex;
}

#pragma mark - LUNTutorialWireframesDataSource

- (__kindof UIView *)wireframeViewForIndex:(NSInteger)index {
    UIImageView *imageViewForIndex = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"animalWireframe%ld", (long)index+1]]];
    CGRect rect = CGRectMake(0, 0, 614.0f / 1134.0f * self.view.frame.size.height, 1076.0f / 1134.0f * self.view.frame.size.height);
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


#pragma mark - LUNTutorialLabelAnimator

- (void (^)(void))labelsAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftLabel:(__kindof UIView *)leftLabelView rightLabel:(__kindof UIView *)rightLabelView {
    return ^void (void) {
        
        leftLabelView.alpha = 1 - offset;
        
        rightLabelView.alpha = offset;
    };
}

#pragma mark - LUNTutorialLabelsDataSource

- (CGFloat)labelsTopMargin {
    return CGRectGetHeight(self.view.frame) - self.staticContentHeight + self.roundnessHeight + 18.0f;
}

- (__kindof UIView *)labelViewAtIndex:(NSInteger)index {
    LUNLabelsView *labelsView = [[LUNLabelsView alloc] initWithFrame:CGRectZero];
    [labelsView setupTitle:self.titles[index] supportingText:self.texts[index] titleColor:[UIColor blackColor] textColor:[UIColor colorWithRed:52.0f / 255.0f green:52.0f / 255.0f blue:52.0f / 255.0f alpha:0.54f]];
    labelsView.titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Black" size:20];
    labelsView.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Regular" size:15];
    [labelsView setupLabelsMargin:3];
    return labelsView;
}

#pragma mark - LUNTutorialIconDataSource

- (__kindof UIView *)iconAtIndex:(NSInteger)index {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon%ld", (long)index + 1]]];
}

#pragma mark - LUNTutorialBackgroundAnimator

- (void (^)(void))backgroundAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftBackground:(__kindof UIView *)leftBackground rightBackground:(__kindof UIView *)rightBackground {
    return ^void (void) {
        leftBackground.alpha = 1 - offset * offset;
        leftBackground.transform = CGAffineTransformMakeTranslation(offset * kLUNNatureBackgroundShift, 0);
        
        rightBackground.alpha = offset * offset;
        rightBackground.transform = CGAffineTransformMakeTranslation((offset - 1) * kLUNNatureBackgroundShift, 0);
    };
}

#pragma mark - LUNTutorialWireframeAnimator

- (void (^)(void))wireframesAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftItem:(__kindof UIView *)leftItem rightItem:(__kindof UIView *)rightItem {
    return ^void (void) {
        leftItem.alpha = 1 - offset;
        leftItem.transform =  CGAffineTransformMakeRotation([self angleForRelativeX:0.5 + offset]);
        
        rightItem.alpha = offset;
        rightItem.transform =  CGAffineTransformMakeRotation(-1 * [self angleForRelativeX:1.5 - offset]);
    };
}

@end
