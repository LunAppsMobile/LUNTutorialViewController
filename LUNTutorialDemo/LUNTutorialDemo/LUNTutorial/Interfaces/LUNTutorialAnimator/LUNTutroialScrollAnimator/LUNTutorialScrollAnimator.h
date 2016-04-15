//
//  LUNTutorialScrollAnimator.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LUNTutorialScrollAnimator <NSObject>

@optional

- (void (^)(void))scrollStopAnimationAtIndex:(NSInteger)index;

- (void (^)(void))scrollAlongSideAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset;

@end
