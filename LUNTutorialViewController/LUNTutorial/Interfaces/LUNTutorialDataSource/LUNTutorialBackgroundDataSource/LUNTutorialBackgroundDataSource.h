//
//  LUNTutorialBackgroundDataSource.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LUNTutorialBackgroundDataSource <NSObject>

@optional

- (__kindof UIView *)dynamicBackgroundViewAtIndex:(NSInteger)index;

- (__kindof UIView *)staticBackgroundView;

- (UIColor *)scrollViewBackgroundColor;

@end
