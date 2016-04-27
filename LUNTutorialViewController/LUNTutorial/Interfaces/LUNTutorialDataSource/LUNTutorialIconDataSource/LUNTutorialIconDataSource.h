//
//  LUNTutorialIconDataSource.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LUNTutorialIconDataSource <NSObject>

@optional

- (__kindof UIView *)iconAtIndex:(NSInteger)index;

@end
