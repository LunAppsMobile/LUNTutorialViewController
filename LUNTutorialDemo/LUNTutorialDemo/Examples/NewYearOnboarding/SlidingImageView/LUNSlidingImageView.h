//
//  LUNSlidingImageView.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/5/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUNSlidingImageView : UIView

- (void)setupMainImage:(UIImage *)image;

- (void)setupShapesImages:(NSArray<UIImage *> *)shapesImages;

- (void)animateShapesHide;

- (void)animateShapesShow:(NSArray<NSValue *> *)translations;

@end
