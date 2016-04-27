//
//  LUNTutorialInnerWireframesDataSource.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LUNTutorialInnerWireframesDataSource <NSObject>

@optional

- (__kindof UIView *)innerWireframeViewForIndex:(NSInteger)index;

@end
