//
//  LUNTapPassingScrollView.m
//
//  Created by Vladimir Sharavara on 3/11/16.
//  Copyright © 2016 LunApps. All rights reserved.
//

#import "LUNTapPassingScrollView.h"
#import "UIView+EnumerationForTest.h"

@implementation LUNTapPassingScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup {
    _forwardsTouchesToClasses = [NSSet setWithArray:@[[UIControl class]]];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointInside = [self mustCapturePoint:point withEvent:event];
    if (!pointInside) {
        return NO;
    }
    return [super pointInside:point withEvent:event];
}

#pragma mark - Private Methods

- (BOOL)mustCapturePoint:(CGPoint)point withEvent:(UIEvent *)event {
    if (![self mustCapturePoint:point withEvent:event view:self.superview]) {
        return NO;
    }
    
    __block BOOL mustCapturePoint = YES;
    [_underlyingViews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self mustCapturePoint:point withEvent:event view:obj]) {
            mustCapturePoint = NO;
            *stop = YES;
        }
    }];
    return mustCapturePoint;
}

- (BOOL)mustCapturePoint:(CGPoint)point withEvent:(UIEvent *)event view:(UIView *)view {
    CGPoint tapPoint = [self convertPoint:point toView:view];
    __block BOOL mustCapturePoint = YES;
    __block UIView *weakView = view;
    [view add_enumerateSubviewsPassingTest:^BOOL(UIView * _Nonnull testView) {
        BOOL forwardTouches = [self forwardTouchesToClass:testView.class];
        return forwardTouches;
    } objects:^(UIView * _Nonnull testView, BOOL * _Nullable stop) {
        CGRect imageFrameInSuperview = [testView.superview convertRect:testView.frame toView:weakView];
        if (CGRectContainsPoint(imageFrameInSuperview, tapPoint)) {
            mustCapturePoint = NO;
            *stop = YES;
        }
    }];
    return mustCapturePoint;
}

- (BOOL)forwardTouchesToClass:(Class)class {
    while ([class isSubclassOfClass:[NSObject class]]) {
        if ([_forwardsTouchesToClasses containsObject:class]) {
            return YES;
        }
        class = [class superclass];
    }
    return NO;
}

@end
