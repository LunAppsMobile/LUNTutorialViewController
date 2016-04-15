//
//  LUNTutorialBackgroundAnimator.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LUNTutorialBackgroundAnimator <NSObject>

@optional

- (void (^)(void))backgroundAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftBackground:(__kindof UIView *)leftBackground rightBackground:(__kindof UIView *)rightBackground;

@end
