//
//  LUNStaticView.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/1/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUNStaticView : UIView

@property (nonatomic, copy) void (^startButtonTapBlock)();

@property (nonatomic, weak) IBOutlet UIButton *letsStartButton;

- (void)selectPageIndex:(NSInteger)index;

- (void)setupButtonText:(NSString *)text;

- (void)setupPageControlsSelectedDotColors:(NSArray<UIColor *> *)colors;

- (void)setupPageControlsDotColor:(UIColor *)color;

- (void)setupButtonBackgroundColor:(UIColor *)color;

- (void)setupButtonTextColor:(UIColor *)color;

- (void)setupButtonCornerRadius:(CGFloat)cornerRadius;

- (void)setupButtonTextFont:(UIFont *)font;

- (void)setupButtonBorderWidth:(CGFloat)borderWidth;

- (void)setupButtonWidth:(CGFloat)buttonWidth;

- (void)setupButtonHeight:(CGFloat)buttonHeight;

- (void)needShadow:(BOOL)needShadow;

- (void)setOffset:(CGFloat)offset betweenIndexes:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end
