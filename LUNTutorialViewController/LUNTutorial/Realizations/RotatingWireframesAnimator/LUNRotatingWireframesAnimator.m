//
//  LUNRotatingWireframesAnimator.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/15/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNRotatingWireframesAnimator.h"

@implementation LUNRotatingWireframesAnimator

static const CGFloat LUNDefaultWireframeYTranslation = 80.0f;
static const CGFloat LUNDefaultWireframeRotationAngle = 15.0f;

#pragma mark - LUNTutorialBackgroundAnimator

- (void (^)(void))backgroundAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftBackground:(__kindof UIView *)leftBackground rightBackground:(__kindof UIView *)rightBackground {
    return ^void (void) {
        leftBackground.alpha = 1 - offset * offset;
        leftBackground.transform = CGAffineTransformMakeTranslation(offset * 175, 0);
        
        rightBackground.alpha = offset * offset;
        rightBackground.transform = CGAffineTransformMakeTranslation((offset - 1) * 175, 0);
    };
}

#pragma mark - LUNTutorialItemAnimator

- (void (^)(void))wireframesAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftItem:(__kindof UIView *)leftItem rightItem:(__kindof UIView *)rightItem {
    return ^void (void) {
        leftItem.alpha = 1 - offset;
        leftItem.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, offset * LUNDefaultWireframeYTranslation), CGAffineTransformMakeRotation(offset * ( - LUNDefaultWireframeRotationAngle) * M_PI / 180.0f));
        
        rightItem.alpha = offset;
        rightItem.transform =  CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, (1 - offset) *LUNDefaultWireframeYTranslation), CGAffineTransformMakeRotation((1 - offset) * LUNDefaultWireframeRotationAngle * M_PI  / 180.0f));
    };
    ;
}

#pragma mark - LUNTutorialLabelAnimator

- (void (^)(void))labelsAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftLabel:(__kindof UIView *)leftLabelView rightLabel:(__kindof UIView *)rightLabelView {
    return ^void (void) {
        leftLabelView.alpha = 1 - offset;
        
        rightLabelView.alpha = offset;
    };
}


@end
