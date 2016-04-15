//
//  LUNStaticView.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/1/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNStaticView.h"
#import "NSArray+LUNObjectAtIndex.h"
#import "FXPageControl.h"

@interface LUNStaticView ()


@property (nonatomic, weak) IBOutlet FXPageControl *pageControl;
@property (nonatomic, strong) NSArray<UIColor *> *selectedShadowColors;

@property (nonatomic, strong) NSArray<UIColor *> *selectedColors;
@property (nonatomic, strong) UIColor *unselectedDotColor;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonWidthConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *buttonHeightConstraint;
@property (nonatomic, weak) IBOutlet UIView *gradientView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *gradientsImageViews;

@end

@implementation LUNStaticView

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
    self.letsStartButton.layer.borderColor = [UIColor colorWithRed:199.0f / 255.0f green:166.0f / 255.0f blue:255.0f / 255.0f  alpha:0.04f].CGColor;
    self.selectedShadowColors = @[[UIColor colorWithRed:255.0f / 255.0f green:140.0f / 255.0f blue:70.0f / 255.0f alpha:0.65f],
                                  [UIColor colorWithRed:6.0f / 255.0f green:149.0f / 255.0f blue:255.0f / 255.0f alpha:0.67f],
                                  [UIColor colorWithRed:196.0f / 255.0f green:199.0f / 255.0f blue:79.0f / 255.0f alpha:1.0f]];
    self.selectedColors = @[[UIColor colorWithRed:255.0f / 255.0f green:96.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f],
                            [UIColor colorWithRed:6.0f / 255.0f green:149.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f],
                            [UIColor colorWithRed:196.0f / 255.0f green:199.0f / 255.0f blue:79.0f / 255.0f alpha:1.0f]];
    self.pageControl.dotSpacing = 5.0f;
    self.pageControl.dotShadowBlur = 7.5f;
    self.pageControl.dotShadowOffset = CGSizeMake(0, 5);
    self.pageControl.selectedDotShadowBlur = 7.5f;
    self.pageControl.dotSize = 7.0f;
    self.pageControl.numberOfPages = 3;
    
    self.gradientsImageViews = [self.gradientsImageViews sortedArrayUsingComparator:^NSComparisonResult(UIView *  _Nonnull obj1, UIView *  _Nonnull obj2) {
        if (obj1.tag < obj2.tag) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
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

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.gradientView.bounds;
    frame.origin.y -= 10;
    frame.size.height += 10;
    self.gradientLayer.frame = frame;
}

#pragma mark - Public

- (void)setupButtonText:(NSString *)text {
    [self.letsStartButton setTitle:text forState:UIControlStateNormal];
}

- (void)setupPageControlsSelectedDotColors:(NSArray<UIColor *> *)colors {
    self.selectedColors = colors;
}

- (void)setupPageControlsDotColor:(UIColor *)color {
    self.unselectedDotColor = color;
}

- (void)setupButtonBackgroundColor:(UIColor *)color {
    self.letsStartButton.backgroundColor = color;
}

- (void)setupButtonTextColor:(UIColor *)color {
    [self.letsStartButton setTitleColor:color forState:UIControlStateNormal];
}

- (void)setupButtonCornerRadius:(CGFloat)cornerRadius {
    self.letsStartButton.layer.cornerRadius = cornerRadius;
}

- (void)setupButtonTextFont:(UIFont *)font {
    self.letsStartButton.titleLabel.font = font;
}

- (void)setupButtonWidth:(CGFloat)buttonWidth {
    self.buttonWidthConstraint.constant = buttonWidth;
    [self layoutIfNeeded];
}

- (void)setupButtonHeight:(CGFloat)buttonHeight {
    self.buttonHeightConstraint.constant = buttonHeight;
    [self layoutIfNeeded];
}

- (void)setupButtonBorderWidth:(CGFloat)borderWidth {
    self.letsStartButton.layer.borderWidth = borderWidth;
    self.letsStartButton.layer.borderColor = [UIColor blackColor].CGColor;
}

#pragma mark - User interactions

- (void)selectPageIndex:(NSInteger)index {
    self.pageControl.selectedDotShadowColor = self.selectedShadowColors[index];
    [self.pageControl setCurrentPage:index];
    [self.pageControl updateCurrentPageDisplay];
}

- (IBAction)startButtonTapped:(id)sender {
    if (self.startButtonTapBlock) {
        self.startButtonTapBlock();
    }
}

- (void)needShadow:(BOOL)needShadow {
    if (!needShadow) {
        self.pageControl.dotShadowBlur = 0.0f;
        self.pageControl.selectedDotShadowBlur = 0.0f;
        self.pageControl.dotShadowColor = [UIColor clearColor];
        self.pageControl.selectedDotShadowColor = [UIColor clearColor];
        self.pageControl.selectedDotShadowOffset = CGSizeZero;
        self.pageControl.dotShadowOffset = CGSizeZero;
    }
}

#pragma mark - FXPageControlDelegate

- (CGPathRef)pageControl:(FXPageControl *)pageControl shapeForDotAtIndex:(NSInteger)index {
    return FXPageControlDotShapeCircle;
}

- (UIColor *)pageControl:(FXPageControl *)pageControl colorForDotAtIndex:(NSInteger)index {
    if (self.unselectedDotColor) {
        return self.unselectedDotColor;
    } else {
        return [UIColor colorWithRed:158.0f / 255.0f green:148.0f / 255.0f blue:178.0f / 255.0f alpha:0.22f];
    }
}

- (CGPathRef)pageControl:(FXPageControl *)pageControl selectedShapeForDotAtIndex:(NSInteger)index {
    return FXPageControlDotShapeCircle;
}

- (UIColor *)pageControl:(FXPageControl *)pageControl selectedColorForDotAtIndex:(NSInteger)index {
    return self.selectedColors[index];
}

- (void)setOffset:(CGFloat)offset betweenIndexes:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    ((UIView *)[self.gradientsImageViews LUN_objectAtIndex:startIndex]).alpha = 1 - offset * offset / (offset * offset + (1 - offset) * (1 - offset));
    ((UIView *)[self.gradientsImageViews LUN_objectAtIndex:endIndex]).alpha = offset * offset / (offset * offset + (1 - offset) * (1 - offset));
}

@end
