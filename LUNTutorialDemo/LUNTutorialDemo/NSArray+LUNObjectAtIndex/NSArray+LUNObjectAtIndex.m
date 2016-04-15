//
//  NSArray+LUNObjectAtIndex.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/29/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "NSArray+LUNObjectAtIndex.h"

@implementation NSArray (LUNObjectAtIndex)

- (id)LUN_objectAtIndex:(NSUInteger)index {
    if (index > self.count - 1) {
        return nil;
    } else {
        return self[index];
    }
}

@end
