//
//  LUNTutorialLabelsDataSource.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LUNTutorialLabelsDataSource <NSObject>

@optional

- (__kindof UIView *)labelViewAtIndex:(NSInteger)index;

- (CGFloat)labelsTopMargin;

- (CGFloat)labelsBottomMargin;

@end
