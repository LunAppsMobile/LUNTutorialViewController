//
//  LUNTutorialInnerWirefamesAnimator.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/13/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LUNTutorialInnerWirefamesAnimator <NSObject>

@optional

- (void (^)(void))innerWireframesAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftItem:(__kindof UIView *)leftItem rightItem:(__kindof UIView *)rightItem;

@end
