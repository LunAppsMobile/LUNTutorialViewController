//
//  LUNLabelsView.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/1/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNLabelsView.h"

@interface LUNLabelsView ()
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *textLabelToTitleLabelVerticalSpacingConstraint;

@end

@implementation LUNLabelsView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadViewFromXib];
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self loadViewFromXib];
        [self commonSetup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonSetup];
}

#pragma mark - Private

- (void)commonSetup {
    
}

- (void)loadViewFromXib {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
}

#pragma mark - public

- (void)setupTitle:(NSString *)titleText supportingText:(NSString *)supportingText titleColor:(UIColor *)titleColor textColor:(UIColor *)textColor {
    self.titleLabel.text = titleText;
    self.textLabel.text = supportingText;
    self.textLabel.textColor = textColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setupLabelsMargin:(CGFloat)spacingValue {
    self.textLabelToTitleLabelVerticalSpacingConstraint.constant = spacingValue;
    [self layoutIfNeeded];
}

@end
