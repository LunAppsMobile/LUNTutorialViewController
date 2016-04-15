//
//  UIView+Addition.h
//
//  Created by Vladimir Sharavara on 3/11/16.
//  Copyright © 2016 LunApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EnumerationForTest)

- (void)add_enumerateSubviewsPassingTest:(BOOL (^)(UIView * view))testBlock
                                 objects:(void (^)(id  obj, BOOL *stop))block;

@end
