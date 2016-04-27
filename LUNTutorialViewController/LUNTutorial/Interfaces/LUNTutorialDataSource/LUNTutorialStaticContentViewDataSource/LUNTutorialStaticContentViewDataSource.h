//
//  LUNTutorialStaticContentViewDataSource.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LUNTutorialStaticContentViewDataSource <NSObject>

@optional

- (__kindof UIView *)staticContentView;

@end
