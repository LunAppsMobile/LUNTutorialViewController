//
//  LUNNewYearViewController.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/4/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNNewYearViewController.h"
#import "LUNStaticView.h"
#import "LUNLabelsView.h"
#import "LUNGalaxyViewController.h"
#import "LUNBackgroundPatternedView.h"
#import "LUNSlidingImageView.h"
#import "LUNNatureViewController.h"
#import "NSArray+LUNObjectAtIndex.h"


@interface LUNNewYearViewController () <LUNTutorialAnimator, LUNTutorialDelegate, LUNTutorialDataSource>

@property (nonatomic, strong) NSArray<NSString *> *wireframesImages;
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *texts;
@property (nonatomic, strong) NSArray<NSString *> *mainImages;
@property (nonatomic, strong) NSArray<UIColor *> *backgroundColors;
@property (nonatomic, strong) NSArray<NSArray<NSValue *> *> *translations;

@end

@implementation LUNNewYearViewController

static const CGFloat kLUNGalaxyHeightMultiplier = 450.0f/1136.0f;
static const CGFloat kLUNIPhone5PixelHeight = 1136.0f;
static const CGFloat kLUNLeftTextShift = 20.0f;
static const CGFloat kLUNRightTextShift = 150.0f;
static const CGFloat kLUNLeftTitleShift = - 200.0f;
static const CGFloat kLUNRightTitleShift = 250.0f;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetup];
    [self contentSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self reloadData];
    [self.view layoutIfNeeded];
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
    self.wireframesImages = @[@"firstNewYearBackground",
                              @"secondNewYearBackground",
                              @"thirdNewYearBackground"];
    self.titles = @[@"CELEBRATE",
                    @"MAKE PEOPLE HAPPY",
                    @"BE CRAZY"];
    self.texts = @[@"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!",
                   @"Our quality prints are the perfect way to\nenjoy your best memories!"];
    self.backgroundColors = @[[UIColor colorWithRed:179.0f / 255.0f green:111.0f / 255.0f blue:172.0f / 255.0f alpha:1.0f],
                              [UIColor colorWithRed:122.0f / 255.0f green:197.0f / 255.0f blue:122.0f / 255.0f alpha:1.0f],
                              [UIColor colorWithRed:105.0f / 255.0f green:124.0f / 255.0f blue:210.0f / 255.0f alpha:1.0f]];
    self.translations = @[ @[[NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)],
                             [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)],
                             [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)],
                             [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)],
                             [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)],
                             [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)]
                             ],
                           
                           @[[NSValue valueWithCGPoint:CGPointMake(-20.0f * [self proportionalSize], 70.5f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(5.0f * [self proportionalSize], -63.0f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(-32.5f * [self proportionalSize], 41.0f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(1.0f * [self proportionalSize], -35.0f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(-6.0f * [self proportionalSize], -12.5f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(-17.5f * [self proportionalSize], 29.5f * [self proportionalSize])]],
                           
                           @[[NSValue valueWithCGPoint:CGPointMake(-20.0f * [self proportionalSize], 29.5f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(2.0f * [self proportionalSize], -33.5f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(-22.0f * [self proportionalSize], 13.5f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(0.0f * [self proportionalSize], 0.0f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(-1.5f * [self proportionalSize], -35.0f * [self proportionalSize])],
                             [NSValue valueWithCGPoint:CGPointMake(-2.0f * [self proportionalSize], 1.0f * [self proportionalSize])]] ];
    
    self.mainImages = @[@"firstSlidingImage",
                        @"secondSlidingImage",
                        @"thirdSlidingImage"];
}


- (void)reloadData {
    [super reloadData];
    for (UIView *view in backgroundPages) {
        view.clipsToBounds = NO;
    }
    [self.view bringSubviewToFront:backgroundsScrollView];
    [self.view bringSubviewToFront:mainScrollView];
}

- (CGFloat)proportionalSize {
    return self.view.frame.size.width/kLUNIPhone5PixelHeight;
}

#pragma mark - LUNTutorialBackgroundDataSource


- (__kindof UIView *)staticBackgroundView {
    LUNBackgroundPatternedView *patternedView = [[LUNBackgroundPatternedView alloc] init];
    return patternedView;
}

- (__kindof UIView *)dynamicBackgroundViewAtIndex:(NSInteger)index {
    LUNSlidingImageView *slidingImageView = [[LUNSlidingImageView alloc] initWithFrame:CGRectZero];
    [slidingImageView setupMainImage:[UIImage imageNamed:self.mainImages[index]]];
    
    NSMutableArray *imagesForIndex = [NSMutableArray new];
    for (NSInteger i = 1; i <= 6; i++) {
        [imagesForIndex addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld_%ldImage", (long)index + 1, (long)i]]];
    }
    
    [slidingImageView setupShapesImages:imagesForIndex];
    if (index == 0) {
        [slidingImageView animateShapesShow:self.translations[index]];
    } else {
        [slidingImageView animateShapesHide];
    }
    return slidingImageView;
}

#pragma mark - LUNTutorialStaticContentViewDataSource

- (CGFloat)staticContentHeight {
    return CGRectGetHeight(self.view.frame) * kLUNGalaxyHeightMultiplier;
}

- (__kindof UIView *)staticContentView {
    LUNStaticView *staticView = [[LUNStaticView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    staticView.startButtonTapBlock = ^void() {
        LUNNatureViewController *natureController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LUNNatureViewController class])];
        [self presentViewController:natureController animated:YES completion:nil];
    };
    [staticView setupButtonText:@"LET'S START"];
    [staticView setupPageControlsDotColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.24f]];
    [staticView setupPageControlsSelectedDotColors:@[[UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor]]];
    [staticView needShadow:NO];
    [staticView setupButtonBackgroundColor:[UIColor colorWithRed:247.0f / 255.0f green:212.0f / 255.0f blue:88.0f / 255.0f alpha:1.0f]];
    [staticView setupButtonCornerRadius:3.0f];
    [staticView setupButtonTextColor:[UIColor whiteColor]];
    [staticView setupButtonTextFont:[UIFont fontWithName:@"BrandonGrotesque-Bold" size:14]];
    [staticView setupButtonWidth: 436.0f/640.0f * CGRectGetWidth(self.view.frame)];
    [staticView setupButtonHeight: 80.0f/1134.0f * self.view.frame.size.height];
    [staticView setOffset:0 betweenIndexes:0 endIndex:1];
    return staticView;
}

#pragma mark - LUNTutorialLabelsDataSource

- (CGFloat)labelsTopMargin {
    return CGRectGetHeight(self.view.frame) - self.staticContentHeight;
}

- (__kindof UIView *)labelViewAtIndex:(NSInteger)index {
    LUNLabelsView *labelsView = [[LUNLabelsView alloc] initWithFrame:CGRectZero];
    [labelsView setupTitle:self.titles[index] supportingText:self.texts[index] titleColor:[UIColor whiteColor] textColor:[UIColor colorWithRed:255.0f / 255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:0.52f]];
    labelsView.titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:20];
    labelsView.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Regular" size:15];
    return labelsView;
}

#pragma mark - LUNAnimatorDelegate

- (void (^)(void))labelsAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftLabel:(__kindof UIView *)leftLabelView rightLabel:(__kindof UIView *)rightLabelView {
    return ^void (void) {
        LUNLabelsView *leftGalaxyView = leftLabelView;
        LUNLabelsView *rightGalaxyView = rightLabelView;
        
        leftGalaxyView.textLabel.transform = CGAffineTransformMakeTranslation(kLUNLeftTextShift * offset, 0);
        
        rightGalaxyView.textLabel.transform = CGAffineTransformMakeTranslation(kLUNRightTextShift *(1 - offset), 0);
        
        leftGalaxyView.titleLabel.transform = CGAffineTransformMakeTranslation(kLUNLeftTitleShift * offset, 0);
        
        rightGalaxyView.titleLabel.transform = CGAffineTransformMakeTranslation(kLUNRightTitleShift * (1 - offset), 0);
        
        leftGalaxyView.textLabel.alpha = 1 - 3 * offset;
        leftGalaxyView.titleLabel.alpha = 1 - 3 * offset;
        
        rightGalaxyView.textLabel.alpha = offset * offset;
        rightGalaxyView.titleLabel.alpha = offset ;
    };
}

#pragma mark - LUNTutorialScrollViewAnimator

- (void (^)(void))scrollAlongSideAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset {
    return ^void (void) {
        UIColor *leftColor = [self.backgroundColors LUN_objectAtIndex:startIndex];
        UIColor *rightColor = [self.backgroundColors LUN_objectAtIndex:endIndex];
        const CGFloat *leftColorComponents = CGColorGetComponents(leftColor.CGColor);
        const CGFloat *rightColorComponents = CGColorGetComponents(rightColor.CGColor);
        if (rightColorComponents && leftColorComponents) {
            CGFloat redDifference = - leftColorComponents[0] + rightColorComponents[0];
            CGFloat greenDifference = - leftColorComponents[1] + rightColorComponents[1];
            CGFloat blueDifference = - leftColorComponents[2] + rightColorComponents[2];
            CGFloat alphaDiference = - leftColorComponents[3] + rightColorComponents[3];
            staticBackgroundView.backgroundColor = [UIColor colorWithRed:leftColorComponents[0] + offset * redDifference green:leftColorComponents[1] + offset * greenDifference blue:leftColorComponents[2] + offset * blueDifference alpha:leftColorComponents[3] + offset * alphaDiference];
            
            [(LUNStaticView *)staticContentView setOffset:offset betweenIndexes:startIndex endIndex:endIndex];
        }
    };
}

- (void (^)(void))scrollStopAnimationAtIndex:(NSInteger)index {
    return ^void (void) {
        [((LUNSlidingImageView *)[dynamicBackgroundViews LUN_objectAtIndex:index]) animateShapesShow:self.translations[index]];
    };
}

#pragma mark - LUNTutorialDelegate

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController startedScrollingFromIndex:(NSInteger)index {
    [((LUNSlidingImageView *)[dynamicBackgroundViews LUN_objectAtIndex:index]) animateShapesHide];
}


- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController reachedPage:(NSInteger)index {
    [(LUNStaticView *)staticContentView  selectPageIndex:index];
}


@end
