//
//  LUNNatureWireframeView.m
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 4/8/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import "LUNNatureWireframeView.h"

@interface LUNNatureWireframeView ()

@property (nonatomic, strong) IBOutlet UIImageView *wireframeImageView;

@end

@implementation LUNNatureWireframeView

- (void)setupWireframeImage:(UIImage *)image {
    self.wireframeImageView.image = image;
}

@end
