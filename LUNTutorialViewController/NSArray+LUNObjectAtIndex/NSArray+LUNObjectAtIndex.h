//
//  NSArray+LUNObjectAtIndex.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/29/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (LUNObjectAtIndex)

- (ObjectType)LUN_objectAtIndex:(NSUInteger)index;

@end
