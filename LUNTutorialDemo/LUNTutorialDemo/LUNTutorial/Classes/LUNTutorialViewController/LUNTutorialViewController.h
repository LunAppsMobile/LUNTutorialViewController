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
    __kindof UIView *staticBackgroundView;
    LUNTapPassingScrollView *backgroundsScrollView;
    LUNTapPassingScrollView *labelsScrollView;
    LUNTapPassingScrollView *iconsScrollView;
    NSArray<__kindof UIView *> *pages;
    NSArray<__kindof UIView *> *dynamicBackgroundViews;
    NSArray<__kindof UIView *> *wireframesViews;
    NSArray<__kindof UIView *> *innerWireframesViews;
    NSArray<__kindof UIView *> *labelsViews;
    NSArray<__kindof UIView *> *iconsViews;
    __kindof UIView *staticContentView;
    __kindof UIView *usersContentView;
    LUNTapPassingScrollView *mainScrollView;
    
}

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UIPageControl *pageContol;

@property (weak, nonatomic) IBOutlet id<LUNTutorialDataSource> dataSource;

@property (weak, nonatomic) IBOutlet id<LUNTutorialAnimator> animator;

@property (weak, nonatomic) IBOutlet id<LUNTutorialDelegate> delegate;

#pragma mark - IBInspectables

@property (assign, nonatomic) IBInspectable NSInteger numberOfRealPages;

@property (assign, nonatomic) IBInspectable NSArray<NSNumber *> *specialStatesIndexes;

@property (assign, nonatomic) IBInspectable CGFloat staticContentHeight;

@property (assign, nonatomic) IBInspectable CGFloat roundnessHeight;

#pragma mark - Methods

- (void)reloadData;

- (CGFloat)topOffsetForRelativeX:(CGFloat)relativeX;

- (CGFloat)angleForRelativeX:(CGFloat)relativeX;


@end
