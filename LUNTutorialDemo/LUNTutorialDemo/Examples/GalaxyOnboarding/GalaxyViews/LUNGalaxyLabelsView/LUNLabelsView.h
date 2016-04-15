//
//  LUNLabelsView.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/1/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUNLabelsView : UIView

- (void)setupTitle:(NSString *)titleText supportingText:(NSString *)supportingText titleColor:(UIColor *)titleColor textColor:(UIColor *)textColor;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

- (void)setupLabelsMargin:(CGFloat)spacingValue;

@end
