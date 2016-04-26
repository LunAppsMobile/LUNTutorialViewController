//
//  LUNTutorialViewController.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNTutorialViewController.h"
#import "NSArray+LUNObjectAtIndex.h"

@interface  LUNTutorialViewController() <UIScrollViewDelegate>

@property (nonatomic, assign) CGPoint circleCenter;
@property (nonatomic, assign) CGFloat circleRadius;

@end

@implementation LUNTutorialViewController

static const CGFloat kLUNDefaultMargin = 4.0f;

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

#pragma mark - Setups

- (void)setupViews {
    [self setupStaticBackground];
    [self setupBackgroundsScrollView];
    [self setupPages];
    [self setupDynamicBackground];
    [self setupWireframes];
    [self setupInnerWireframes];
    [self setupStaticContentView];
    [self setupIcons];
    [self setupLabels];
    [self setupMainScrollingItem];
}

- (void)setupBackgroundsScrollView {
    backgroundsScrollView = [[LUNTapPassingScrollView alloc] init];
    backgroundsScrollView.autoresizesSubviews = NO;
    backgroundsScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    backgroundsScrollView.showsVerticalScrollIndicator = NO;
    backgroundsScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:backgroundsScrollView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:backgroundsScrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:backgroundsScrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:backgroundsScrollView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:backgroundsScrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    
    backgroundsScrollView.pagingEnabled = YES;
    backgroundsScrollView.scrollEnabled = NO;
    [self setupBackgroundsScrollViewBackgroundColor];
    
}

- (void)setupBackgroundsScrollViewBackgroundColor {
    if ([self.dataSource respondsToSelector:@selector(scrollViewBackgroundColor)]) {
        backgroundsScrollView.backgroundColor = [self.dataSource scrollViewBackgroundColor];
    } else {
        backgroundsScrollView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setupPages {
    NSMutableArray *pagesArray = [NSMutableArray new];
    for (NSInteger index = 0; index < self.numberOfRealPages; ++index) {
        UIView *pageForIndex = [[UIView alloc] init];
        pageForIndex.backgroundColor = [UIColor clearColor];
        pageForIndex.translatesAutoresizingMaskIntoConstraints = NO;
        pageForIndex.autoresizesSubviews = NO;
        [pagesArray addObject:pageForIndex];
        [backgroundsScrollView addSubview:pageForIndex];
        [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundsScrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
        [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundsScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
        [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundsScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundsScrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
        if (index == 0) {
            [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundsScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
        } else {
            if (index == self.numberOfRealPages - 1) {
                [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundsScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
                [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageForIndex attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pagesArray[index - 1] attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
            } else {
                [backgroundsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pagesArray[index - 1] attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
            }
        }
    }
    pages = [NSArray arrayWithArray:pagesArray];
}

- (void)setupStaticBackground {
    if ([self.dataSource respondsToSelector:@selector(staticBackgroundView)]) {
        staticBackgroundView = [self.dataSource staticBackgroundView];
        staticBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:staticBackgroundView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:staticBackgroundView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:staticBackgroundView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:staticBackgroundView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:staticBackgroundView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    }
}

- (void)setupDynamicBackground {
    if ([self.dataSource respondsToSelector:@selector(dynamicBackgroundViewAtIndex:)]) {
        NSMutableArray *dynamicViews = [NSMutableArray new];
        for (NSInteger index = 0; index < self.numberOfRealPages; ++index) {
            UIView *currentPage = pages[index];
            UIView *viewForIndex = [self.dataSource dynamicBackgroundViewAtIndex:index];
            [dynamicViews addObject:viewForIndex];
            viewForIndex.translatesAutoresizingMaskIntoConstraints = NO;
            [currentPage addSubview:viewForIndex];
            [currentPage addConstraint:[NSLayoutConstraint constraintWithItem:currentPage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:viewForIndex attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
            [currentPage addConstraint:[NSLayoutConstraint constraintWithItem:currentPage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:viewForIndex attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
            [currentPage addConstraint:[NSLayoutConstraint constraintWithItem:currentPage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:viewForIndex attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];
            [currentPage addConstraint:[NSLayoutConstraint constraintWithItem:currentPage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:viewForIndex attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
        }
        dynamicBackgroundViews = [NSArray arrayWithArray:dynamicViews];
    }
}

- (void)setupWireframes {
    if ([self.dataSource respondsToSelector:@selector(wireframeViewForIndex:)]) {
        NSMutableArray *wireframes = [NSMutableArray new];
        for (NSInteger index = 0; index < self.numberOfRealPages; ++index) {
            UIView *currentPage = pages[index];
            UIView *wireframeForIndex = [self.dataSource wireframeViewForIndex:index];
            wireframeForIndex.translatesAutoresizingMaskIntoConstraints = NO;
            [wireframes addObject:wireframeForIndex];
            [currentPage addSubview:wireframeForIndex];
            [currentPage addConstraint:[NSLayoutConstraint constraintWithItem:currentPage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:wireframeForIndex attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
            [currentPage addConstraint:[NSLayoutConstraint constraintWithItem:currentPage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:wireframeForIndex attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
        }
        wireframesViews = [NSArray arrayWithArray:wireframes];
    }
}

- (void)setupInnerWireframes {
    if ([self.dataSource respondsToSelector:@selector(innerWireframeViewForIndex:)]) {
        NSMutableArray *innerWireframes = [NSMutableArray new];
        for (NSInteger index = 0; index < self.numberOfRealPages; ++index) {
            UIView *currentWireframe = wireframesViews[index];
            UIView *wireframeForIndex = [self.dataSource innerWireframeViewForIndex:index];
            wireframeForIndex.translatesAutoresizingMaskIntoConstraints = NO;
            [innerWireframes addObject:wireframeForIndex];
            [currentWireframe addSubview:wireframeForIndex];
            [currentWireframe addConstraint:[NSLayoutConstraint constraintWithItem:currentWireframe attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:wireframeForIndex attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
            [currentWireframe addConstraint:[NSLayoutConstraint constraintWithItem:currentWireframe attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:wireframeForIndex attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
        }
        innerWireframesViews = [NSArray arrayWithArray:innerWireframes];
    }
}

- (void)setupStaticContentView {
    if ([self.dataSource respondsToSelector:@selector(staticContentView)]) {
        UIView *staticView = [self.dataSource staticContentView];
        staticView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:staticView];
        [staticView addConstraint:[NSLayoutConstraint constraintWithItem:staticView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(self.staticContentHeight + self.roundnessHeight)]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:staticView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:staticView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:staticView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        staticContentView = staticView;
        if (self.roundnessHeight) {
            CGFloat viewWidth = CGRectGetWidth(self.view.frame);
            CGFloat viewHeight = CGRectGetHeight(self.view.frame);
            CGFloat radius =  ((viewWidth / 2) * (viewWidth / 2) + self.roundnessHeight * self.roundnessHeight)/(2 * self.roundnessHeight);
            self.circleRadius = radius;
            self.circleCenter = CGPointMake(viewWidth / 2, radius);
            UIBezierPath *maskPath = [UIBezierPath bezierPath];
            [maskPath moveToPoint:CGPointMake(viewWidth, self.roundnessHeight)];
            [maskPath addLineToPoint:CGPointMake(viewWidth, viewHeight)];
            [maskPath addLineToPoint:CGPointMake(0, viewHeight)];
            [maskPath addArcWithCenter:CGPointMake(viewWidth / 2, radius) radius:radius startAngle:acos(-viewWidth/(2 * radius)) endAngle:M_PI_2 clockwise:YES];
            [maskPath addArcWithCenter:CGPointMake(viewWidth / 2, radius) radius:radius startAngle:M_PI_2 endAngle:acos(viewWidth / (2 * radius)) clockwise:YES];
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.frame = staticContentView.bounds;
            maskLayer.path = maskPath.CGPath;
            staticView.layer.mask = maskLayer;
        }
    }
}

- (void)setupLabels {
    if ([self.dataSource respondsToSelector:@selector(labelViewAtIndex:)]) {
        labelsScrollView = [[LUNTapPassingScrollView alloc] init];
        labelsScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        labelsScrollView.showsHorizontalScrollIndicator = NO;
        labelsScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:labelsScrollView];
        if ([self.dataSource respondsToSelector:@selector(labelsTopMargin)]) {
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:labelsScrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:-1 * [self.dataSource labelsTopMargin]]];
        } else {
            if ([self.dataSource respondsToSelector:@selector(labelsBottomMargin)]) {
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:labelsScrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:[self.dataSource labelsBottomMargin]]];
            } else {
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:labelsScrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:-1 * (self.view.frame.size.height - self.staticContentHeight) - kLUNDefaultMargin]];
            }
        }
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:labelsScrollView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:labelsScrollView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
        labelsScrollView.backgroundColor = [UIColor clearColor];
        labelsScrollView.pagingEnabled = YES;
        labelsScrollView.scrollEnabled = NO;
        
        NSMutableArray *labelsArray = [NSMutableArray new];
        for (NSInteger index = 0; index < self.numberOfRealPages + self.specialStatesIndexes.count; ++index) {
            UIView *labelAtIndex = [self.dataSource labelViewAtIndex:index];
            labelAtIndex.translatesAutoresizingMaskIntoConstraints = NO;
            [labelsScrollView addSubview:labelAtIndex];
            [labelsArray addObject:labelAtIndex];
            [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsScrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
            [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
            [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
            [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsScrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
            if (index == 0) {
                [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
            } else {
                if (index == self.numberOfRealPages - 1) {
                    [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
                    [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsArray[index - 1] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
                } else {
                    [labelsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:labelsArray[index - 1] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:labelAtIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
                }
            }
            labelsViews = [NSArray arrayWithArray:labelsArray];
        }
    }
}

- (void)setupMainScrollingItem {
    mainScrollView = [[LUNTapPassingScrollView alloc] init];
    mainScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    mainScrollView.autoresizesSubviews = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:mainScrollView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor clearColor];
    mainScrollView.scrollEnabled = YES;
    mainScrollView.pagingEnabled = YES;
    UIView *previousPage;
    for (NSInteger index = 0; index < self.numberOfRealPages + self.specialStatesIndexes.count; ++index) {
        UIView *pageForIndex = [[UIView alloc] init];
        pageForIndex.backgroundColor = [UIColor clearColor];
        pageForIndex.translatesAutoresizingMaskIntoConstraints = NO;
        pageForIndex.autoresizesSubviews = YES;
        pageForIndex.userInteractionEnabled = YES;
        [mainScrollView addSubview:pageForIndex];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:mainScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
        [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:mainScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
        if (index == 0) {
            [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:mainScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
        } else {
            if (index == self.numberOfRealPages + self.specialStatesIndexes.count - 1) {
                [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:mainScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
                [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:previousPage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
            } else {
                [mainScrollView addConstraint:[NSLayoutConstraint constraintWithItem:previousPage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
            }
        }
        previousPage = pageForIndex;
    }
}

- (void)setupIcons {
    if ([self.dataSource respondsToSelector:@selector(iconAtIndex:)]) {
        iconsScrollView = [[LUNTapPassingScrollView alloc] init];
        iconsScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        iconsScrollView.scrollEnabled = NO;
        iconsScrollView.showsHorizontalScrollIndicator = NO;
        iconsScrollView.showsVerticalScrollIndicator = NO;
        iconsScrollView.pagingEnabled = YES;
        
        UIView *workaroundView = [UIView new];
        workaroundView.backgroundColor = [UIColor clearColor];
        workaroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:workaroundView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:workaroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:staticContentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:workaroundView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:workaroundView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:workaroundView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
        
        
        [self.view addSubview:iconsScrollView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:iconsScrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:iconsScrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:iconsScrollView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:workaroundView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
        
        
        UIView *previousPage;
        NSMutableArray *icons = [NSMutableArray new];
        for (NSInteger index = 0; index < self.numberOfRealPages; ++index) {
            UIView *pageForIndex = [[UIView alloc] init];
            pageForIndex.backgroundColor = [UIColor clearColor];
            pageForIndex.translatesAutoresizingMaskIntoConstraints = NO;
            pageForIndex.autoresizesSubviews = YES;
            pageForIndex.userInteractionEnabled = YES;
            [iconsScrollView addSubview:pageForIndex];
            
            UIView *iconAtIndex = [self.dataSource iconAtIndex:index];
            iconAtIndex.translatesAutoresizingMaskIntoConstraints = NO;
            
            [icons addObject:iconAtIndex];
            
            [pageForIndex addSubview:iconAtIndex];
            
            
            [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageForIndex attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:iconAtIndex attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
            [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageForIndex attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:iconAtIndex attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
            [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:pageForIndex attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:iconAtIndex attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];
            
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:iconsScrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
            [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:iconsScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
            [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:iconsScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
            [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:iconsScrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
            if (index == 0) {
                [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:iconsScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
            } else {
                if (index == self.numberOfRealPages - 1) {
                    [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:iconsScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
                    [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:previousPage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
                } else {
                    [iconsScrollView addConstraint:[NSLayoutConstraint constraintWithItem:previousPage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pageForIndex attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
                }
            }
            previousPage = pageForIndex;
        }
        iconsViews = [NSArray arrayWithArray:icons];
    }
}

#pragma mark - Reload

- (void)reloadData {
    [self clearMainControllerView];
    [self setupViews];
}

- (void)clearMainControllerView {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(LUNTutorialViewController:startedScrollingFromIndex:)]) {
        
        CGFloat width = CGRectGetWidth(mainScrollView.frame);
        CGFloat offset = scrollView.contentOffset.x;
        NSInteger leftIndex = floor(offset / width);
        
        NSInteger specialStatesPassed = 0;
        for (NSInteger index = 0; index <= leftIndex; ++index) {
            if ([self.specialStatesIndexes containsObject:@(index)]) {
                specialStatesPassed++;
            }
        }
        NSInteger realLeftIndex = leftIndex - specialStatesPassed;
        
        [self.delegate LUNTutorialViewController:self startedScrollingFromIndex:realLeftIndex];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == mainScrollView) {
        
        CGFloat width = CGRectGetWidth(mainScrollView.frame);
        CGFloat offset = scrollView.contentOffset.x;
        NSInteger leftIndex = floor(offset / width);
        CGFloat percent = offset / width - leftIndex;
        
        NSInteger specialStatesPassed = 0;
        for (NSInteger index = 0; index <= leftIndex; ++index) {
            if ([self.specialStatesIndexes containsObject:@(index)]) {
                specialStatesPassed++;
            }
        }
        NSInteger realLeftIndex = leftIndex - specialStatesPassed;
        
        
        if ([self.animator respondsToSelector:@selector(scrollAlongSideAnimationFromIndex:toIndex:offset:)]) {
            [self.animator scrollAlongSideAnimationFromIndex:leftIndex toIndex:leftIndex + 1 offset:percent]();
        }
        
        BOOL isCurrentStateSpecial = [self.specialStatesIndexes containsObject:@(leftIndex)];
        CGPoint resultOffset = CGPointMake(mainScrollView.contentOffset.x - specialStatesPassed * CGRectGetWidth(mainScrollView.frame), 0);
        if (!isCurrentStateSpecial) {
            [backgroundsScrollView setContentOffset:resultOffset animated:NO];
        }
        [labelsScrollView setContentOffset:resultOffset animated:NO];
        [iconsScrollView setContentOffset:resultOffset animated:NO];
        
        
        if ([self.animator respondsToSelector:@selector(backgroundAnimationFromIndex:toIndex:offset:leftBackground:rightBackground:)]) {
            [self.animator backgroundAnimationFromIndex:leftIndex toIndex:leftIndex + 1 offset:percent leftBackground:[dynamicBackgroundViews LUN_objectAtIndex:realLeftIndex] rightBackground:[dynamicBackgroundViews LUN_objectAtIndex:realLeftIndex + 1]]();
        }
        
        if ([self.animator respondsToSelector:@selector(wireframesAnimationFromIndex:toIndex:offset:leftItem:rightItem:)]) {
            [self.animator wireframesAnimationFromIndex:leftIndex toIndex:leftIndex + 1 offset:percent leftItem:[wireframesViews LUN_objectAtIndex:realLeftIndex] rightItem:[wireframesViews LUN_objectAtIndex:realLeftIndex +1]]();
        }
        
        if ([self.animator respondsToSelector:@selector(innerWireframesAnimationFromIndex:toIndex:offset:leftItem:rightItem:)]) {
            [self.animator innerWireframesAnimationFromIndex:leftIndex toIndex:leftIndex + 1 offset:percent leftItem:[innerWireframesViews LUN_objectAtIndex:realLeftIndex] rightItem:[innerWireframesViews LUN_objectAtIndex:realLeftIndex +1]]();
        }
        
        if ([self.animator respondsToSelector:@selector(labelsAnimationFromIndex:toIndex:offset:leftLabel:rightLabel:)]) {
            [self.animator labelsAnimationFromIndex:leftIndex toIndex:leftIndex + 1 offset:percent leftLabel:[labelsViews LUN_objectAtIndex:realLeftIndex] rightLabel:[labelsViews LUN_objectAtIndex:realLeftIndex + 1]]();
        }
        
        if ([self.animator respondsToSelector:@selector(iconAnimationFromIndex:toIndex:offset:leftIcon:rightIcon:)]) {
            [self.animator iconAnimationFromIndex:leftIndex toIndex:leftIndex + 1 offset:percent leftIcon:[iconsViews LUN_objectAtIndex:realLeftIndex] rightIcon:[iconsViews LUN_objectAtIndex:realLeftIndex + 1]]();
        } else {
            [self animateLeftIcon:[iconsViews LUN_objectAtIndex:realLeftIndex] rightIcon:[iconsViews LUN_objectAtIndex:realLeftIndex + 1] offset:percent];
        }
        
        if ([self.delegate respondsToSelector:@selector(LUNTutorialViewController:reachedScrollPercentage:leftIndex:rightIndex:)]) {
            [self.delegate LUNTutorialViewController:self reachedScrollPercentage:percent leftIndex:leftIndex rightIndex:leftIndex + 1];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == mainScrollView) {
        NSInteger index = round(mainScrollView.contentOffset.x / CGRectGetWidth(mainScrollView.frame));
        [self.pageContol setCurrentPage:index];
        if ([self.animator respondsToSelector:@selector(scrollStopAnimationAtIndex:)]) {
            [self.animator scrollStopAnimationAtIndex:index]();
        }
        if ([self.delegate respondsToSelector:@selector(LUNTutorialViewController:reachedPage:)]) {
            [self.delegate LUNTutorialViewController:self reachedPage:index];
        }
        if ([self.delegate respondsToSelector:@selector(LUNTutorialViewController:reachedScrollPercentage:leftIndex:rightIndex:)]) {
            [self.delegate LUNTutorialViewController:self reachedScrollPercentage:1.0f leftIndex:index - 1 rightIndex:index];
        }
    }
}

#pragma mark - Icon animating

- (CGFloat)topOffsetForRelativeX:(CGFloat)relativeX {
    CGFloat absoluteX = relativeX * CGRectGetWidth(self.view.bounds);
    CGFloat deltaX = absoluteX - self.circleCenter.x;
    return self.circleCenter.y - sqrtf(self.circleRadius * self.circleRadius - deltaX * deltaX);
}

- (CGFloat)angleForRelativeX:(CGFloat)relativeX {
    CGFloat absoluteX = relativeX * CGRectGetWidth(self.view.bounds);
    return asinf((self.circleCenter.x - absoluteX) / self.circleRadius);
}

- (void)animateLeftIcon:(__kindof UIView *)leftIcon rightIcon:(__kindof UIView *)rightIcon offset:(CGFloat)offset {
    leftIcon.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, [self topOffsetForRelativeX:0.5 + offset]), CGAffineTransformMakeRotation([self angleForRelativeX:0.5 + offset]));
    leftIcon.alpha = 1 - offset;
    
    rightIcon.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, [self topOffsetForRelativeX:(1.5 - offset)]), CGAffineTransformMakeRotation(-1 * [self angleForRelativeX:(1.5 - offset)]));
    rightIcon.alpha = offset;
}

@end
