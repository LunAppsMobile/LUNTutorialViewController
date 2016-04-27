//
//  LUNTutorialDelegate.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/31/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LUNTutorialViewController;

@protocol LUNTutorialDelegate <NSObject>

@optional

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController startedScrollingFromIndex:(NSInteger)index;

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController reachedPage:(NSInteger)index;

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController reachedScrollPercentage:(CGFloat)percentage leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;

@end
