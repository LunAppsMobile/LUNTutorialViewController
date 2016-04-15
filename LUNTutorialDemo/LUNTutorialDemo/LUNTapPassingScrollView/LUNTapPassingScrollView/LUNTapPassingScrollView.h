//
//  LUNTapPassingScrollView.h
//
//  Created by Vladimir Sharavara on 3/11/16.
//  Copyright © 2016 LunApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUNTapPassingScrollView : UIScrollView


@property (nonatomic, strong) NSSet<Class> *forwardsTouchesToClasses;

@property (nonatomic, strong) NSArray<__kindof UIView *> *underlyingViews;

@end
