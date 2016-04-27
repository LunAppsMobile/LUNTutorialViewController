//
//  LUNTutorialIconAnimator.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LUNTutorialIconAnimator <NSObject>

@optional

- (void (^)(void))iconAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftIcon:(__kindof UIView *)leftIcon rightIcon:(__kindof UIView *)rightIcon;

@end
