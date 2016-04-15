//
//  LUNGalaxyViewController.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/1/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNGalaxyViewController.h"
#import "LUNStaticView.h"
#import "LUNLabelsView.h"
#import "LUNNewYearViewController.h"
#import "NSArray+LUNObjectAtIndex.h"

@interface LUNGalaxyViewController() <LUNTutorialAnimator, LUNTutorialDelegate, LUNTutorialDataSource>

@property (nonatomic, strong) NSArray<NSString *> *backgroundImages;
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *texts;
@property (nonatomic, strong) NSArray<UIColor *> *textColors;

@property (nonatomic, strong) UIView *blackView;

@end

@implementation LUNGalaxyViewController

static const CGFloat kLUNGalaxyHeightMultiplier = 450.0f/1136.0f;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetup];
    [self contentSetup];
    [self reloadData];
    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - Setup

- (void)commonSetup {
    self.animator = self;
    self.delegate = self;
    self.dataSource = self;
    self.numberOfRealPages = 3;
    self.roundnessHeight = 0;
}

- (void)contentSetup {
    self.backgroundImages = @[@"firstGalaxyBackground",
                              @"secondGalaxyBackground",
                              @"thirdGalaxyBackground"];
    self.titles = @[@"BE PART OF THE GALAXY",
                    @"KEEP CALM",
                    @"BE SOCIAL"];
    self.texts = @[@"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!"];
    self.textColors = @[[UIColor colorWithRed:158.0f / 255.0f green:148.0f / 255.0f blue:178.0f / 255.0f alpha:1.0f],
                        [UIColor colorWithRed:126.0f / 255.0f green:146.0f / 255.0f blue:169.0f / 255.0f alpha:1.0f],
                        [UIColor colorWithRed:132.0f / 255.0f green:138.0f / 255.0f blue:116.0f / 255.0f alpha:1.0f]];
}


- (void)reloadData {
    [super reloadData];
    for (UIView *view in pages) {
        view.clipsToBounds = YES;
    }
    mainScrollView.alwaysBounceHorizontal = NO;
    mainScrollView.bounces = NO;
}

#pragma mark - LUNTutorialBackgroundDataSource

- (CGFloat)staticContentHeight {
    return CGRectGetHeight(self.view.frame) * kLUNGalaxyHeightMultiplier;
}

- (__kindof UIView *)dynamicBackgroundViewAtIndex:(NSInteger)index {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.backgroundImages[index]]];
}

- (UIColor *)scrollViewBackgroundColor {
    return [UIColor blackColor];
}

#pragma mark - LUNTutorialScrollViewAnimator

- (void (^)(void))scrollAlongSideAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset {
    return ^void (void) {
        UIColor *leftColor = [self.textColors LUN_objectAtIndex:startIndex];
        UIColor *rightColor = [self.textColors LUN_objectAtIndex:endIndex];
        const CGFloat *leftColorComponents = CGColorGetComponents(leftColor.CGColor);
        const CGFloat *rightColorComponents = CGColorGetComponents(rightColor.CGColor);
        if (rightColorComponents && leftColorComponents) {
            CGFloat redDifference = - leftColorComponents[0] + rightColorComponents[0];
            CGFloat greenDifference = - leftColorComponents[1] + rightColorComponents[1];
            CGFloat blueDifference = - leftColorComponents[2] + rightColorComponents[2];
            CGFloat alphaDiference = - leftColorComponents[3] + rightColorComponents[3];
            [(LUNStaticView *)staticContentView  setupButtonTextColor:[UIColor colorWithRed:leftColorComponents[0] + offset * redDifference green:leftColorComponents[1] + offset * greenDifference blue:leftColorComponents[2] + offset * blueDifference alpha:leftColorComponents[3] + offset * alphaDiference]];
        }
    };
}

#pragma mark - LUNTutorialStaticContentViewDataSource

- (__kindof UIView *)staticContentView {
    LUNStaticView *staticView = [[LUNStaticView alloc] initWithFrame:CGRectZero];
    staticView.startButtonTapBlock = ^void() {
        LUNNewYearViewController *newYearController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LUNNewYearViewController class])];
        [self presentViewController:newYearController animated:YES completion:nil];
    };
    [staticView setupButtonWidth: 312.0f/640.0f * self.view.frame.size.width];
    [staticView setupButtonHeight: 80.0f/1134.0f * self.view.frame.size.height];
    return staticView;
}

#pragma mark - LUNTutorialLabelsDataSource

- (CGFloat)labelsTopMargin {
    return CGRectGetHeight(self.view.frame) - self.staticContentHeight;
}

- (__kindof UIView *)labelViewAtIndex:(NSInteger)index {
    LUNLabelsView *labelsView = [[LUNLabelsView alloc] initWithFrame:CGRectZero];
    [labelsView setupTitle:self.titles[index] supportingText:self.texts[index] titleColor:[UIColor whiteColor] textColor:self.textColors[index]];
    labelsView.titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:17];
    labelsView.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Regular" size:15];
    return labelsView;
}

#pragma mark - LUNAnimatorDelegate

- (void (^)(void))labelsAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftLabel:(__kindof UIView *)leftLabelView rightLabel:(__kindof UIView *)rightLabelView {
    return ^void (void) {
        LUNLabelsView *leftGalaxyView = leftLabelView;
        LUNLabelsView *rightGalaxyView = rightLabelView;
        
        leftGalaxyView.textLabel.transform = CGAffineTransformMakeTranslation(20 * offset, 0);
        rightGalaxyView.textLabel.transform = CGAffineTransformMakeTranslation(150 - 150 * offset, 0);
        leftGalaxyView.titleLabel.transform = CGAffineTransformMakeTranslation(-1 * 200 *offset, 0);
        rightGalaxyView.titleLabel.transform = CGAffineTransformMakeTranslation(250 - 250 * offset, 0);
        
        leftGalaxyView.textLabel.alpha = 1 - 3 * offset;
        leftGalaxyView.titleLabel.alpha = 1 - 3 * offset;
        
        rightGalaxyView.textLabel.alpha = offset * offset;
        rightGalaxyView.titleLabel.alpha = offset ;
    };
}

- (void (^)(void))backgroundAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftBackground:(__kindof UIView *)leftBackground rightBackground:(__kindof UIView *)rightBackground {
    return ^void (void) {
        if (!self.blackView) {
            self.blackView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame), 0, 50, CGRectGetHeight(self.view.frame))];
            self.blackView.backgroundColor = [UIColor blackColor];
            [self.view insertSubview:self.blackView belowSubview:staticContentView];
        }
        for (NSInteger index = startIndex; index < pages.count; ++index) {
            [backgroundsScrollView sendSubviewToBack:[pages LUN_objectAtIndex:index]];
        }
        [backgroundsScrollView bringSubviewToFront:[pages LUN_objectAtIndex:startIndex]];
        
        [pages LUN_objectAtIndex:startIndex].transform = CGAffineTransformMakeTranslation(-1 * 150 * offset, 0);
        [pages LUN_objectAtIndex:endIndex].transform = CGAffineTransformMakeTranslation(-250 + 250 * offset, 0);
        leftBackground.transform = CGAffineTransformMakeTranslation(440 * offset, 0);
        rightBackground.transform = CGAffineTransformMakeTranslation(20 - 20 *offset, 0);
        self.blackView.transform = CGAffineTransformConcat([pages LUN_objectAtIndex:startIndex].transform, CGAffineTransformMakeTranslation(-CGRectGetWidth(backgroundsScrollView.frame) * offset, 0));
    };
}

#pragma mark - LUNTutorialDelegate

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController reachedPage:(NSInteger)index {
    [(LUNStaticView *)staticContentView  selectPageIndex:index];
}

@end
