//
//  LUNSlidingImageView.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/5/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNSlidingImageView.h"

@interface LUNSlidingImageView()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *shapeImageViews;
@property (nonatomic, weak) IBOutlet UIView *shapesView;
@property (nonatomic, weak) IBOutlet UIImageView *slidingImage;

@end

@implementation LUNSlidingImageView

static const CGFloat kLUNFirstItemRotationAngle = 50.0f;
static const CGFloat kLUNSecondItemRotationAngle = 75.0f;

#pragma mark - initialization

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

- (void)loadViewFromXib {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
}

#pragma mark - setup

- (void)commonSetup {
    self.shapeImageViews = [self.shapeImageViews sortedArrayUsingComparator:^NSComparisonResult(UIView *  _Nonnull obj1, UIView *  _Nonnull obj2) {
        if (obj1.tag < obj2.tag) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
}

#pragma mark - public

- (void)setupMainImage:(UIImage *)image {
    self.slidingImage.image = image;
}

- (void)setupShapesImages:(NSArray<UIImage *> *)shapesImages {
    for (NSInteger index = 0; index < shapesImages.count; index++) {
        ((UIImageView *)self.shapeImageViews[index]).image = shapesImages[index];
    }
}

#pragma mark - animations

- (void)animateShapesHide {
    [UIView animateWithDuration:0.5f animations:^{
        self.shapesView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        for (NSInteger index = 0; index < self.shapeImageViews.count; ++index) {
            ((UIView *)self.shapeImageViews[index]).transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
            ((UIView *)self.shapeImageViews[0]).transform = CGAffineTransformMakeRotation(kLUNFirstItemRotationAngle * M_PI / 180.0f);
            ((UIView *)self.shapeImageViews[1]).transform =  CGAffineTransformMakeRotation(kLUNSecondItemRotationAngle * M_PI / 180.0f);
    }];
}

- (void)animateShapesShow:(NSArray<NSValue *> *)translations {
    [UIView animateWithDuration:0.5f animations:^{
        self.shapesView.transform = CGAffineTransformIdentity;
        for (NSInteger index = 0; index < self.shapeImageViews.count; ++index) {
            if (index == 0) {
                ((UIView *)self.shapeImageViews[index]).transform =CGAffineTransformMakeTranslation([translations[index] CGPointValue].x, [translations[index] CGPointValue].y);
            } else {
                if (index == 1) {
                    ((UIView *)self.shapeImageViews[index]).transform = CGAffineTransformMakeTranslation([translations[index] CGPointValue].x, [translations[index] CGPointValue].y);
                } else {
                    ((UIView *)self.shapeImageViews[index]).transform = CGAffineTransformMakeTranslation([translations[index] CGPointValue].x, [translations[index] CGPointValue].y);
                }
            }
        }
    }];
}

@end
