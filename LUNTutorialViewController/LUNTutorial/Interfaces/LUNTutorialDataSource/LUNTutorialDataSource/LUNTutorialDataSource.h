//
//  LUNTutorialDataSource.h
//  LUNTutorialDemo
//
//  Created by Vladimir Sharavara on 3/7/16.
//  Copyright © 2016 lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUNTutorialBackgroundDataSource.h"
#import "LUNTutorialWireframesDataSource.h"
#import "LUNTutorialInnerWireframesDataSource.h"
#import "LUNTutorialStaticContentViewDataSource.h"
#import "LUNTutorialIconDataSource.h"
#import "LUNTutorialLabelsDataSource.h"

@protocol LUNTutorialDataSource <LUNTutorialBackgroundDataSource, LUNTutorialWireframesDataSource, LUNTutorialInnerWireframesDataSource, LUNTutorialStaticContentViewDataSource, LUNTutorialIconDataSource, LUNTutorialLabelsDataSource>

@end
