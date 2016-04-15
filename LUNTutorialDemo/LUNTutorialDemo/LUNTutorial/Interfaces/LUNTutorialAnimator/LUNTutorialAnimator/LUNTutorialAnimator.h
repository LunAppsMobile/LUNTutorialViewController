//
//  LUNTutorialAnimator.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//


#import "LUNTutorialBackgroundAnimator.h"
#import "LUNTutorialLabelAnimator.h"
#import "LUNTutorialScrollAnimator.h"
#import "LUNTutorialWireframeAnimator.h"
#import "LUNTutorialIconAnimator.h"
#import "LUNTutorialInnerWirefamesAnimator.h"

@protocol LUNTutorialAnimator <LUNTutorialBackgroundAnimator, LUNTutorialLabelAnimator, LUNTutorialScrollAnimator, LUNTutorialWireframeAnimator, LUNTutorialIconAnimator, LUNTutorialInnerWirefamesAnimator>

@end
