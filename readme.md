# LUNTutorialViewController
[![Foo](https://lunapps.com/img/crafted-in-lunapps.png)](https://lunapps.com/)

This project aims simplification of creation of onboarding/tutorial of your iOS app.

Please check this [article](https://lunapps.com/blog/onboarding-framework-for-ios/) on our blog.

Purpose 
-------

Good onboardings help users start using the app right away. It’s a really cool thing that makes your app get some brownies from happy users and probably helps you increase the retention rate of your application.

Supported OS & SDK Versions
---------------------------

* Supported build target - iOS 8.0

ARC Compatibility
-----------------

LUNTutorialViewController requires ARC.

Thread Safety
-------------

LUNTutorialViewController is derived from UIViewController and - as with all UIKit components - it should only be accessed from the main thread.

Examples
--------

![1_scaled.gif](https://i1.wp.com/lunapps.com/blog/wp-content/uploads/2016/04/1_scaled.gif?zoom=2&resize=500%2C334&ssl=1)

![2_scaled.gif](https://i2.wp.com/lunapps.com/blog/wp-content/uploads/2016/04/2_scaled.gif?zoom=2&resize=500%2C334&ssl=1)

![3_scaled.gif](https://i1.wp.com/lunapps.com/blog/wp-content/uploads/2016/04/3_scaled-1.gif?zoom=2&resize=500%2C334&ssl=1)

![4_scaled.gif](https://i0.wp.com/lunapps.com/blog/wp-content/uploads/2016/04/4_scaled-2.gif?zoom=2&resize=500%2C334&ssl=1)

![5_scaled.gif](https://i0.wp.com/lunapps.com/blog/wp-content/uploads/2016/04/5_scaled-2.gif?zoom=2&resize=500%2C334&ssl=1)


Installation
------------

To use the LUNTutorialViewController class in an app, just drag the LUNTutorialViewController, LUNTapPassingScrollView class files and NSArray+LUNObjectAtIndex category files  (demo files and assets are not needed) into your project.

Also you can use CocoaPods 
### Сocoapods version

```ruby
pod 'LUNTutorialViewController'
```

Properties
----------

```objc
@property (weak, nonatomic) IBOutlet id<LUNTutorialDataSource> dataSource;
```

An object that supports the `LUNTutorialDataSource` protocol and provide possibility to construct and modify LUNTutorialViewController.

```objc
@property (weak, nonatomic) IBOutlet id<LUNTutorialAnimator> animator;
```

An object that supports the `LUNTutorialAnimator` protocol and provide possibility to animate all parts of LUNTutorialViewController.

```objc
@property (weak, nonatomic) IBOutlet id<LUNTutorialDelegate> delegate;
```

An object that supports the `LUNTutorialDelegate` protocol and can respond to LUNTutorialViewController state changes.

```objc
@property (weak, nonatomic) IBOutlet UIPageControl *pageContol;
```

LUNTutorialViewController will automatically change currentPage of this pageControl.

```objc
@property (assign, nonatomic) IBInspectable NSInteger numberOfRealPages;
```

Defines number of pages that will be shown in LUNTutorialViewController.

```objc
@property (assign, nonatomic) IBInspectable NSArray<NSNumber *> *specialStatesIndexes;
```

Defines number and indexes of special states of LUNTutorialViewController. Special state means, that background and wireframe of current page of onboarding will not be scrolled. Only icons, and labels will change. You can use this, if you want animations or changes in wireframes or background.

```objc
@property (assign, nonatomic) IBInspectable CGFloat staticContentHeight;
```

Defines height of staticContentView.

```objc
@property (assign, nonatomic) IBInspectable CGFloat roundnessHeight;
```

Defines height of roundness at the top of staticContentView.

Methods
--------

The LUNTutorialViewController class has the following methods:

```objc
- (void)reloadData;
```

This reloads LUNTutorialViewController from the dataSource and refreshes the display.

```objc
- (CGFloat)topOffsetForRelativeX:(CGFloat)relativeX;
```

Returns shift of item, referred to roundnessHeight of staticContentView.

```objc
- (CGFloat)angleForRelativeX:(CGFloat)relativeX;
```

Returns rotation of item, referred to roundnessHeight of staticContentView.

Protocols
---------

The LUNTutorialViewController provides three protocol interfaces: `LUNTutorialDataSource`, `LUNTutorialAnimator`  and `LUNTutorialDelegate`.

### LUNTutorialDataSource 

The LUNTutorialDataSource protocol inherits LUNTutorialBackgroundDataSource, LUNTutorialWireframesDataSource, LUNTutorialInnerWireframesDataSource, LUNTutorialStaticContentViewDataSource, LUNTutorialIconDataSource, LUNTutorialLabelsDataSource. Each of these protocols is responsible for data that would be shown at each LUNTutorialViewController layer(not CALayer).

#### LUNTutorialBackgroundDataSource

```objc
- (__kindof UIView *)dynamicBackgroundViewAtIndex:(NSInteger)index;
```

Defines what UIView will be displayed at requested index as dynamic background. When you reach page with this index this view will have the same bounds as ViewController's view. 

```objc
- (__kindof UIView *)staticBackgroundView;
```

Defines what UIView will be displayed as staticBackgroundView. It always has the same frame as ViewController's view.

```objc
- (UIColor *)scrollViewBackgroundColor;
```

Defines backgroundColor of dynamicBackgroundsScrollView.

#### LUNTutorialWireframesDataSource

```objc
- (__kindof UIView *)wireframeViewForIndex:(NSInteger)index;
```

Defines what UIView will be displayed at requested index as wireframe. When you reach page with this index this view will be centered by x and y with ViewController's view. 

#### LUNTutorialInnerWireframesDataSource

```objc
- (__kindof UIView *)innerWireframeViewForIndex:(NSInteger)index;
```

Defines what UIView will be displayed at requested index as wireframe. When you reach page with this index this view will be centered by x and y with  ViewController's view. 

#### LUNTutorialStaticContentViewDataSource

```objc
- (__kindof UIView *)staticContentView;
```

Defines what UIView will be displayed as staticContentView. It locates at the bottom of the LUNTutorialViewController's view and has the same width.

#### LUNTutorialIconDataSource
```objc
- (__kindof UIView *)iconAtIndex:(NSInteger)index;
```

Defines what UIView will be displayed at requested index as icon. When you reach page with this index this view will be centered by x and y with ViewController's view. 


#### LUNTutorialLabelsDataSource
```objc
- (__kindof UIView *)labelViewAtIndex:(NSInteger)index;
```

Defines what UIView will be displayed at requested index as label. When you reach page with this index this view will be centered by x and y with ViewController's view. 

```objc
- (CGFloat)labelsTopMargin;
```

Defines margin between top of ViewController's view and labelsScrollView top.

```objc
- (CGFloat)labelsBottomMargin;
```

Defines margin between bottom of ViewController's view and labelsScrollView bottom.

### LUNTutorialAnimator 

The LUNTutorialDataSource protocol inherits LUNTutorialBackgroundAnimator, LUNTutorialLabelAnimator, LUNTutorialScrollAnimator, LUNTutorialWireframeAnimator, LUNTutorialIconAnimator, LUNTutorialInnerWirefamesAnimator. Each of these protocols is responsible for animating each LUNTutorialViewController layer(not CALayer).

LUNTutorialBackgroundAnimator, LUNTutorialLabelAnimator, LUNTutorialWireframeAnimator, LUNTutorialIconAnimator, LUNTutorialInnerWirefamesAnimator have similar structures and has method that defines animation between changing of states. 

Example: 
LUNTutorialWireframeAnimator

```objc
- (void (^)(void))wireframesAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset leftItem:(__kindof UIView *)leftItem rightItem:(__kindof UIView *)rightItem;
```

Returning block will be called when scrollViewDidScroll of mainScrollView triggers.

LUNTutorialScrollAnimator is different.

#### LUNTutorialScrollAnimator

```objc
- (void (^)(void))scrollStopAnimationAtIndex:(NSInteger)index;
```

Defines animation block that will be executed when scrolling has stopped at requested index.

```objc
- (void (^)(void))scrollAlongSideAnimationFromIndex:(NSInteger)startIndex toIndex:(NSInteger)endIndex offset:(CGFloat)offset;
```

Defines animation block that will be executed while scrolling between states.

### LUNTutorialDelegate

LUNTutorialDelegate notifies about changes in LUNTutorialViewController

```objc
- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController startedScrollingFromIndex:(NSInteger)index;

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController reachedPage:(NSInteger)index;

- (void)LUNTutorialViewController:(LUNTutorialViewController *)tutorialController reachedScrollPercentage:(CGFloat)percentage leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;
```

License
-------
Usage is provided under the [MIT License](http://opensource.org/licenses/MIT)
