//
//  LUNTutorialViewController.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUNTutorialDataSource.h"
#import "LUNTutorialAnimator.h"
#import "LUNTutorialDelegate.h"
#import "LUNTapPassingScrollView.h"

@interface LUNTutorialViewController : UIViewController {
    
@protected
    /**
     *  @brief view of static background, defined by dataSource
     */
    __kindof UIView *staticBackgroundView;
    
    /**
     *  @brief scrollView that contains dynamic backgrounds views
     */
    LUNTapPassingScrollView *backgroundsScrollView;
    
    /**
     *  @brief scrollView that contains "text part" views
     */
    LUNTapPassingScrollView *labelsScrollView;
    
    /**
     *  @brief scrollView that contains icons' views
     */
    LUNTapPassingScrollView *iconsScrollView;
    
    
    /**
     *  @brief dynamic background views' containers
     */
    NSArray<__kindof UIView *> *backgroundPages;
    
    /**
     *  @brief views of dynamic background, defined by dataSource
     */
    NSArray<__kindof UIView *> *dynamicBackgroundViews;
    
    /**
     *  @brief wireframes, defined by dataSource
     */
    NSArray<__kindof UIView *> *wireframesViews;
    
    /**
     *  @brief innerWireframes, defined by dataSource
     */
    NSArray<__kindof UIView *> *innerWireframesViews;
    
    /**
     *  @brief views that contain "text" information, defined by dataSource
     */
    NSArray<__kindof UIView *> *labelsViews;
    
    /**
     *  @brief icons, defined by dataSource
     */
    NSArray<__kindof UIView *> *iconsViews;
    
    /**
     *  @brief static content view, defined by dataSource
     */
    __kindof UIView *staticContentView;
    
    /**
     *  @brief main scrolling item, it should always be at the top of your hierarchy
     */
    LUNTapPassingScrollView *mainScrollView;
    
}

#pragma mark - IBOutlets

/**
 *  @brief LUNTutorialViewController will automatically change currentPage of this pageControl
 */
@property (weak, nonatomic) IBOutlet UIPageControl *pageContol;

@property (weak, nonatomic) IBOutlet id<LUNTutorialDataSource> dataSource;

@property (weak, nonatomic) IBOutlet id<LUNTutorialAnimator> animator;

@property (weak, nonatomic) IBOutlet id<LUNTutorialDelegate> delegate;

#pragma mark - IBInspectables

/**
 *  @brief defines number of pages that will be shown on onboarding
 */

@property (assign, nonatomic) IBInspectable NSInteger numberOfRealPages;

/**
 *  @brief defines number of special states of onboarding, special state means, that background and wireframe of current page of onboarding will not be scrolled. Only icons, and labels will change. You can use this, if you want animations or changes in wireframes or background
 */
@property (assign, nonatomic) IBInspectable NSArray<NSNumber *> *specialStatesIndexes;

/**
 *  @brief defines height of staticContentView
 */
@property (assign, nonatomic) IBInspectable CGFloat staticContentHeight;

/**
 *  @brief defines height of roundness at the top of staticContentView
 */
@property (assign, nonatomic) IBInspectable CGFloat roundnessHeight;

#pragma mark - Methods

/**
 *  @brief reloads all views, using defined dataSource
 */
- (void)reloadData;

/**
 *  @brief shift of item, referred to roundnessHeight of staticContentView
 *
 *  @param relativeX current percentage of passed onboarding width, passed by center of view
 *
 *  @return float value
 */

- (CGFloat)topOffsetForRelativeX:(CGFloat)relativeX;

/**
 *  @brief rotation of item, referred to roundnessHeight of staticContentView
 *
 *  @param relativeX current percentage of passed onboarding width, passed by center of view
 *
 *  @return float value
 */
- (CGFloat)angleForRelativeX:(CGFloat)relativeX;


@end
