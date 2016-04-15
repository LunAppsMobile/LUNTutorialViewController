//
//  UIView+Addition.m
//
//  Created by Vladimir Sharavara on 3/11/16.
//  Copyright © 2016 LunApps. All rights reserved.
//

#import "UIView+EnumerationForTest.h"

@implementation UIView (EnumerationForTest)

- (void)add_enumerateSubviewsPassingTest:(BOOL (^_Nonnull)(UIView * _Nonnull view))testBlock
                                 objects:(void (^)(id _Nonnull obj, BOOL * _Nullable stop))block {
    if (!block)
        return;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self];
    
    while (array.count > 0)
    {
        UIView *view = [array firstObject];
        [array removeObjectAtIndex:0];
        
        if (view != self && testBlock(view))
        {
            BOOL stop = NO;
            block(view, &stop);
            if (stop)
                return;
        }
        
        [array addObjectsFromArray:view.subviews];
    }
}

@end
