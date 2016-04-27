//
//  LUNTutorialItemAnimator.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol LUNTutorialWireframeAnimator <NSObject>

@optional

- (void (^)(void))wireframesAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftItem:(__kindof UIView *)leftItem rightItem:(__kindof UIView *)rightItem;

@end
