//
//  LUNTutorialLabelAnimator.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LUNTutorialLabelAnimator <NSObject>

@optional

- (void (^)(void))labelsAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftLabel:(__kindof UIView *)leftLabelView rightLabel:(__kindof UIView *)rightLabelView;

@end
