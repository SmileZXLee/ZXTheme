# ZXTheme
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/SmileZXLee/ZXTheme/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/ZXTheme.svg?style=flat)](http://cocoapods.org/?q=ZXTheme)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/ZXCollectionView.svg?style=flat)](http://cocoapods.org/?q=ZXTheme)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
## 安装
### 通过CocoaPods安装
```ruby
pod 'ZXTheme'
```
### 手动导入
* 将ZXTheme拖入项目中。

### 导入头文件
```objective-c
#import "ZXTheme.h"
```
## 说明
ZXTheme用于修改全局UI的主题，设置方法与注意点说明以UILabel为例：
* 示例代码
```objective-c
[ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
    ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
    labelTheme.textColor = [UIColor blueColor];
    labelTheme.textAlignment = NSTextAlignmentCenter;
    return labelTheme;
};
```
* 说明：我们需要修改全局label的主题，则书写[ZXTheme defaultTheme].zx_labelThemeBlock
* 这个block中有一个label对象，代表当前需要设置主题的label
* 这个block需要一个返回值，在设置label主题的block中，这个返回值是ZXLabelTheme对象，创建这个对象，并更改其中的属性即可更改对应的label主题
* 下方示例代码实现将所有文字内容为“测试”的label文字颜色设置为绿色，其他label的文字颜色不变
```objective-c
[ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
    ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
    if([label.text isEqualToString:@"测试"]){
        labelTheme.textColor = [UIColor greenColor];
    }
    return labelTheme;
};
```
* 下方示例代码实现将所有文字内容为“测试”的label文字颜色设置为绿色，其他label的文字颜色不变，所有label背景色变为红色
```objective-c
[ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
    ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
    if([label.text isEqualToString:@"测试"]){
        labelTheme.textColor = [UIColor greenColor];
    }
    labelTheme.backgroundColor = [UIColor redColor];
    return labelTheme;
};
```
* 下方示例代码实现将所有文字内容为“测试”的label文字颜色设置为绿色并且背景色变为红色，其他label主题不变
```objective-c
[ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
    ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
    if([label.text isEqualToString:@"测试"]){
        labelTheme.textColor = [UIColor greenColor];
        labelTheme.backgroundColor = [UIColor redColor];
        return labelTheme;
    }else{
        return nil;
    }
};
```
* 由上方三段示例代码可以得出以下规律：  
1.themeblock返回值为nil，则代表当前label对象不设置主题  
2.ZXLabelTheme对象中属性没有设置，则代表当前label对象中对应属性不设置主题  
3.ZXLabelTheme对象中属性有值，则当前label对象中对应属性用ZXLabelTheme对象的对应属性值，例如labelTheme.textColor有值，则label的textColor为labelTheme.textColor，否则label的textColor为label本身的textColor  
* 注意：ZXTheme中设置的主题拥有最高的管理权限，也就意味着，若您在ZXTheme中设置了对应UI控件的主题，则您在其他地方都无法更改对应UI控件的主题

以上是相关注意点和使用技巧说明，设置其他UI控件主题同理，因此下方不再赘述

*** 

## 所有UI控件主题设置
### 通用工具函数
* UIView(Extension)
```objective-c
/**
 获取view所属的控制器

 @return view所属的控制器
 */
- (UIViewController*)zx_getViewController;

/**
 判断当前view是否是目标view类的子类(包含子类递归)

 @param cls 目标view的类
 @return 当前view是否是目标view类的子类(包含子类递归)
 */
- (BOOL)zx_inViewClass:(Class)cls;
```
* UILabel(Extension)
```objective-c
/**
 是否属于UIButton
 */
@property(assign, nonatomic,readonly) BOOL zx_belongsToBtn;

/**
 是否属于UITextField中的placeholder
 */
@property(assign, nonatomic,readonly) BOOL zx_belongsToTextFieldPlaceholder;
```
* UIImage(Extension)
```objective-c
/**
 将UIImage渲染为指定颜色

 @param color 渲染颜色
 @return 渲染之后的UIImage
 */
- (UIImage*)renderColor:(UIColor *)color;
```
### ZXTheme
```objective-c
+ (instancetype)defaultTheme;
/**
 是否是暗黑主题
 */
@property(assign, nonatomic, getter=zx_isDarkTheme)BOOL zx_darkTheme;
/**
 发送主题更新通知
 */
- (void)zx_themeUpdate;
/**
 设置UIView的主题
 */
@property(copy, nonatomic)ZXViewTheme *(^zx_viewThemeBlock)(UIView *view);
/**
 设置UILabel的主题
 */
@property(copy, nonatomic)ZXLabelTheme *(^zx_labelThemeBlock)(UILabel *label);
/**
 设置UIButton的主题
 */
@property(copy, nonatomic)ZXButtonTheme *(^zx_buttonThemeBlock)(UIButton *button);
/**
 设置UISegmentedControl的主题
 */
@property(copy, nonatomic)ZXSegmentedControlTheme *(^zx_segmentedControlThemeBlock)(UISegmentedControl *segmentedControl);
/**
 设置UITextField的主题
 */
@property(copy, nonatomic)ZXTextFieldTheme *(^zx_textFieldThemeBlock)(UITextField *textField);
/**
 设置UISlider的主题
 */
@property(copy, nonatomic)ZXSliderTheme *(^zx_sliderThemeBlock)(UISlider *slider);
/**
 设置UISwitch的主题
 */
@property(copy, nonatomic)ZXSwitchTheme *(^zx_switchThemeBlock)(UISwitch *mySwitch);
/**
 设置UIActivityIndicatorView的主题
 */
@property(copy, nonatomic)ZXActivityIndicatorViewTheme *(^zx_activityIndicatorViewThemeBlock)(UIActivityIndicatorView *activityIndicatorView);
/**
 设置UIProgressView的主题
 */
@property(copy, nonatomic)ZXProgressViewTheme *(^zx_progressViewThemeBlock)(UIProgressView *progressView);
/**
 设置UIPageControl的主题
 */
@property(copy, nonatomic)ZXPageControlTheme *(^zx_pageControlThemeBlock)(UIPageControl *pageControl);
/**
 设置UIStepper的主题
 */
@property(copy, nonatomic)ZXStepperTheme *(^zx_stepperThemeBlock)(UIStepper *stepper);
/**
 设置UIImageView的主题
 */
@property(copy, nonatomic)ZXImageViewTheme *(^zx_imageViewThemeBlock)(UIImageView *imageView);
/**
 设置UITextView的主题
 */
@property(copy, nonatomic)ZXTextViewTheme *(^zx_textViewThemeBlock)(UITextView *textView);
/**
 设置UITabBar的主题
 */
@property(copy, nonatomic)ZXTabBarTheme *(^zx_tabBarThemeBlock)(UITabBar *tabBar);
/**
 设置UITabBarItem的主题
 */
@property(copy, nonatomic)ZXTabBarItemTheme *(^zx_tabBarItemThemeBlock)(UITabBarItem *tabBarItem);
/**
 设置UINavigationBar的主题
 */
@property(copy, nonatomic)ZXNavigationBarTheme *(^zx_navigationBarThemeBlock)(UINavigationBar *navigationBar);
/**
 设置UIBarButtonItem的主题
 */
@property(copy, nonatomic)ZXBarButtonItemTheme *(^zx_barButtonItemThemeBlock)(UIBarButtonItem *barButtonItem);
/**
 设置UITableView的主题
 */
@property(copy, nonatomic)ZXTableViewTheme *(^zx_tableViewThemeBlock)(UITableView *tableView);
/**
 设置UICollectionView的主题
 */
@property(copy, nonatomic)ZXCollectionViewTheme *(^zx_collectionViewThemeBlock)(UICollectionView *collectionView);
```

***

### UIView
* 设置view主题
```objective-c
[ZXTheme defaultTheme].zx_viewThemeBlock = ^ZXViewTheme * _Nonnull(UIView * _Nonnull view) {
    ZXViewTheme *viewTheme = [[ZXViewTheme alloc]init];
    if([view.nextResponder isKindOfClass:[UIViewController class]]){
        viewTheme.backgroundColor = [self getControllerBacViewColor];
    }
    return viewTheme;
};
```
* ZXStepperTheme所有属性
```objective-c
/**
 设置背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UILabel
* 设置label主题
```objective-c
[ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
    ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
    labelTheme.textColor = [UIColor redColor];
    labelTheme.font = [UIFont systemFontOfSize:14];
    labelTheme.textAlignment = NSTextAlignmentCenter;
    labelTheme.lineBreakMode = NSLineBreakByCharWrapping;
    labelTheme.backgroundColor = [UIColor redColor];
    return labelTheme;
};
```
* ZXLabelTheme所有属性
```objective-c
/**
 设置文字颜色
 */
@property(strong, nonatomic) UIColor *textColor;
/**
 设置文字字体
 */
@property(strong, nonatomic) UIFont *font;
/**
 设置文字对齐方式
 */
@property(assign, nonatomic) NSTextAlignment textAlignment;
/**
 设置文字换行模式
 */
@property(assign, nonatomic) NSLineBreakMode lineBreakMode;
/**
 设置文字是否高亮
 */
@property(assign, nonatomic) BOOL highlighted;
/**
 设置文字高亮时候的颜色
 */
@property(strong, nonatomic) UIColor *highlightedTextColor;
/**
 设置文字是否根据宽度自动调整字体
 */
@property(assign, nonatomic) BOOL adjustsFontSizeToFitWidth;
/**
 设置文字最大行数
 */
@property(assign, nonatomic) long long numberOfLines;
/**
 设置文字背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UIButton
* 设置button主题
```objective-c
[ZXTheme defaultTheme].zx_buttonThemeBlock = ^ZXButtonTheme * _Nonnull(UIButton * _Nonnull button) {
    ZXButtonTheme *buttonTheme = [[ZXButtonTheme alloc]init];
    [buttonTheme setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [buttonTheme setBackgroundImage:[UIImage imageNamed:@"kanjia"] forState:UIControlStateNormal];
    buttonTheme.backgroundColor = [UIColor yellowColor];
    return buttonTheme;
};
```
* ZXButtonTheme所有属性
```objective-c
/**
 设置按钮tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 根据状态设置按钮文字颜色
 
 @param color 按钮文字颜色
 @param state 按钮状态
 */
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮文字颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *titleColorMapper;

/**
 根据状态设置按钮文字阴影颜色
 
 @param color 文字阴影颜色
 @param state 按钮状态
 */
- (void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮文字阴影颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *titleShadowColorMapper;
/**
 根据状态设置按钮图片
 
 @param image 按钮图片
 @param state 按钮状态
 */
- (void)setImage:(UIImage *)image forState:(UIControlState)state;
/**
 按钮图片与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *imageMapper;
/**
 根据状态设置按钮背景图片
 
 @param image 按钮背景图片
 @param state 按钮状态
 */
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
/**
 按钮背景图片与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *backgroundImageMapper;
/**
 根据状态设置按钮图片颜色
 
 @param color 按钮图片颜色
 @param state 按钮状态
 */
- (void)setImageColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮图片颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *imageColorMapper;

/**
 根据状态设置按钮背景图片颜色
 
 @param color 按钮背景图片颜色
 @param state 按钮状态
 */
- (void)setBackgroundImageColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮背景图片颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *backgroundImageColorMapper;

/**
 设置按钮背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UISegmentedControl
* 设置segmentedControl主题
```objective-c
[ZXTheme defaultTheme].zx_segmentedControlThemeBlock = ^ZXSegmentedControlTheme * _Nonnull(UISegmentedControl * _Nonnull segmentedControl) {
    ZXSegmentedControlTheme *segmentedControlTheme = [[ZXSegmentedControlTheme alloc]init];
    segmentedControlTheme.tintColor = [UIColor redColor];
    return segmentedControlTheme;
};
```
* ZXSegmentedControlTheme所有属性
```objective-c
/**
 设置SegmentedControl的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置SegmentedControl的背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UITextField
* 设置textField主题
```objective-c
[ZXTheme defaultTheme].zx_textFieldThemeBlock = ^ZXTextFieldTheme * _Nonnull(UITextField * _Nonnull textField) {
    ZXTextFieldTheme *textFieldTheme = [[ZXTextFieldTheme alloc]init];
    textFieldTheme.tintColor = [UIColor redColor];
    textFieldTheme.textColor = [UIColor blueColor];
    textFieldTheme.placeholderColor = [UIColor redColor];
    return textFieldTheme;
};
```
* ZXTextFieldTheme所有属性
```objective-c
/**
 设置TextField颜色
 */
@property(strong, nonatomic) UIColor *textColor;
/**
 设置TextField字体
 */
@property(strong, nonatomic) UIFont *font;
/**
 设置TextField对齐方式
 */
@property(assign, nonatomic) NSTextAlignment textAlignment;
/**
 设置TextField的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置TextField的placeholder颜色
 */
@property(strong, nonatomic) UIColor *placeholderColor;
/**
 设置TextField的背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UISlider
* 设置slider主题
```objective-c
[ZXTheme defaultTheme].zx_sliderThemeBlock = ^ZXSliderTheme * _Nonnull(UISlider * _Nonnull slider) {
    ZXSliderTheme *sliderTheme = [[ZXSliderTheme alloc]init];
    sliderTheme.minimumTrackTintColor = [UIColor redColor];
    sliderTheme.maximumTrackTintColor = [UIColor blueColor];
    sliderTheme.thumbTintColor = [UIColor yellowColor];
    return sliderTheme;
};
```
* ZXSliderTheme所有属性
```objective-c
/**
 设置Slider左侧背景颜色
 */
@property(strong, nonatomic) UIColor *minimumTrackTintColor;
/**
 设置Slider右侧背景颜色
 */
@property(strong, nonatomic) UIColor *maximumTrackTintColor;
/**
 设置Slider滑块颜色
 */
@property(strong, nonatomic) UIColor *thumbTintColor;
/**
 设置Slider左侧图片
 */
@property(strong, nonatomic) UIImage *minimumValueImage;
/**
 设置Slider右侧图片
 */
@property(strong, nonatomic) UIImage *maximumValueImage;
/**
 设置Slider背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UISwitch
* 设置switch主题
```objective-c
[ZXTheme defaultTheme].zx_switchThemeBlock = ^ZXSwitchTheme * _Nonnull(UISwitch * _Nonnull mySwitch) {
    ZXSwitchTheme *switchTheme = [[ZXSwitchTheme alloc]init];
    switchTheme.onTintColor = [UIColor redColor];
    switchTheme.tintColor = [UIColor redColor];
    return switchTheme;
};
```
* ZXSwitchTheme所有属性
```objective-c
/**
 设置Switch的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置Switch的onTintColor
 */
@property(strong, nonatomic) UIColor *onTintColor;
/**
 设置Switch背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UIActivityIndicatorView
* 设置activityIndicatorView主题
```objective-c
[ZXTheme defaultTheme].zx_activityIndicatorViewThemeBlock = ^ZXActivityIndicatorViewTheme * _Nonnull(UIActivityIndicatorView * _Nonnull activityIndicatorView) {
    ZXActivityIndicatorViewTheme *activityIndicatorViewTheme = [[ZXActivityIndicatorViewTheme alloc]init];
    activityIndicatorViewTheme.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    return activityIndicatorViewTheme;
};
```
* ZXActivityIndicatorViewTheme所有属性
```objective-c
/**
 设置ActivityIndicatorView样式
 */
@property(assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/**
 设置ActivityIndicatorView背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UIProgressView
* 设置progressView主题
```objective-c
[ZXTheme defaultTheme].zx_progressViewThemeBlock = ^ZXProgressViewTheme * _Nonnull(UIProgressView * _Nonnull progressView) {
    ZXProgressViewTheme *progressViewTheme = [[ZXProgressViewTheme alloc]init];
    progressViewTheme.progressTintColor = [UIColor redColor];
    progressViewTheme.trackTintColor = [UIColor blueColor];
    return progressViewTheme;
};
```
* ZXProgressViewTheme所有属性
```objective-c
/**
 设置ProgressView已加载的进度条颜色
 */
@property(strong, nonatomic) UIColor *progressTintColor;
/**
 设置ProgressView未加载的进度条颜色
 */
@property(strong, nonatomic) UIColor *trackTintColor;
/**
 设置ProgressView已加载的进度条图片
 */
@property(strong, nonatomic) UIImage *progressImage;
/**
 设置ProgressView未加载的进度条图片
 */
@property(strong, nonatomic) UIColor *trackImage;
```

***

### UIPageControl
* 设置pageControl主题
```objective-c
[ZXTheme defaultTheme].zx_pageControlThemeBlock = ^ZXPageControlTheme * _Nonnull(UIPageControl * _Nonnull pageControl) {
    ZXPageControlTheme *pageControlTheme = [[ZXPageControlTheme alloc]init];
    pageControlTheme.pageIndicatorTintColor = [UIColor redColor];
    pageControlTheme.currentPageIndicatorTintColor = [UIColor blueColor];
    return pageControlTheme;
};
```
* ZXPageControlTheme所有属性
```objective-c
/**
 设置PageControl其他页的颜色
 */
@property(strong, nonatomic) UIColor *pageIndicatorTintColor;
/**
 设置PageControl当前页的颜色
 */
@property(strong, nonatomic) UIColor *currentPageIndicatorTintColor;
```

***

### UIStepper
* 设置stepper主题
```objective-c
[ZXTheme defaultTheme].zx_stepperThemeBlock = ^ZXStepperTheme * _Nonnull(UIStepper * _Nonnull stepper) {
    ZXStepperTheme *stepperTheme = [[ZXStepperTheme alloc]init];
    stepperTheme.tintColor = [UIColor whiteColor];
    return stepperTheme;
};
```
* ZXStepperTheme所有属性
```objective-c
/**
 设置Stepper的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置Stepper背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UIImageView
* 设置imageView主题
```objective-c
[ZXTheme defaultTheme].zx_imageViewThemeBlock = ^ZXImageViewTheme * _Nonnull(UIImageView * _Nonnull imageView) {
    if(imageView.frame.size.width == 50){
        ZXImageViewTheme *imageViewTheme = [[ZXImageViewTheme alloc]init];
        imageViewTheme.imageColor = [UIColor redColor];
        imageViewTheme.backgroundColor = [UIColor yellowColor];
        return imageViewTheme;
    }else{
        return nil;
    }
};
```
* ZXImageViewTheme所有属性
```objective-c
/**
 设置ImageView的image
 */
@property(strong, nonatomic) UIImage *image;
/**
 设置ImageView的image颜色
 */
@property(strong, nonatomic) UIColor *imageColor;
/**
 设置ImageView的highlightedImage
 */
@property(strong, nonatomic) UIImage *highlightedImage;
/**
 设置ImageView的highlightedImage颜色
 */
@property(strong, nonatomic) UIColor *highlightedImageColor;
/**
 设置ImageView的动画image数组
 */
@property(strong, nonatomic) NSArray *animationImages;
/**
 设置ImageView的image数组的颜色
 */
@property(strong, nonatomic) UIColor *animationImagesColor;
/**
 设置ImageView的动画highlightedImage数组
 */
@property(strong, nonatomic) NSArray *highlightedAnimationImages;
/**
 设置ImageView的highlightedAnimationImages数组的颜色
 */
@property(strong, nonatomic) UIColor *highlightedAnimationImagesColor;
/**
 设置ImageView的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置ImageView背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UITextView
* 设置textView主题
```objective-c
[ZXTheme defaultTheme].zx_textViewThemeBlock = ^ZXTextViewTheme * _Nonnull(UITextView * _Nonnull textView) {
    ZXTextViewTheme *textViewTheme = [[ZXTextViewTheme alloc]init];
    textViewTheme.textColor = [UIColor redColor];
    textViewTheme.backgroundColor = [UIColor blueColor];
    return textViewTheme;
};
```
* ZXTextViewTheme所有属性
```objective-c
/**
 设置文字颜色
 */
@property(strong, nonatomic) UIColor *textColor;
/**
 设置文字字体
 */
@property(strong, nonatomic) UIFont *font;
/**
 设置文字对齐方式
 */
@property(assign, nonatomic) NSTextAlignment textAlignment;
/**
 设置背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
```

***

### UITabBar
* 设置tabBar主题
```objective-c
[ZXTheme defaultTheme].zx_tabBarThemeBlock  = ^ZXTabBarTheme * _Nonnull(UITabBar * _Nonnull tabBar) {
    ZXTabBarTheme *tabBarTheme = [[ZXTabBarTheme alloc]init];
    tabBarTheme.translucent = NO;
    tabBarTheme.barTintColor = [self getTabbarTintColor];
    return tabBarTheme;
};
```
* ZXTabBarTheme所有属性
```objective-c
/**
 设置Tabbar的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置Tabbar是否透明
 */
@property(assign, nonatomic) BOOL translucent;
/**
 设置Tabbar的背景色
 */
@property(strong, nonatomic) UIColor *barTintColor;
/**
 设置Tabbar的背景图片
 */
@property(strong, nonatomic) UIImage *backgroundImage;
/**
 设置Tabbar的selectionIndicatorImage
 */
@property(strong, nonatomic) UIImage *selectionIndicatorImage;
/**
 设置Tabbar的shadowImage
 */
@property(strong, nonatomic) UIImage *shadowImage;
```

***

### UITabBarItem
* 设置tabBarItem主题
```objective-c
[ZXTheme defaultTheme].zx_tabBarItemThemeBlock = ^ZXTabBarItemTheme * _Nonnull(UITabBarItem * _Nonnull tabBarItem) {
    ZXTabBarItemTheme *tabBarItemTheme = [[ZXTabBarItemTheme alloc]init];
    tabBarItemTheme.selectedImageColor = [UIColor redColor];
    [tabBarItemTheme setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName, [UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return tabBarItemTheme;
};
```
* ZXTabBarItemTheme所有属性
```objective-c
/**
 设置TabBarItem的image
 */
@property(strong, nonatomic) UIImage *image;
/**
 设置TabBarItem的image颜色
 */
@property(strong, nonatomic) UIColor *imageColor;
/**
 设置TabBarItem的selectedImage
 */
@property(strong, nonatomic) UIImage *selectedImage;
/**
 设置TabBarItem的selectedImage颜色
 */
@property(strong, nonatomic) UIColor *selectedImageColor;

/**
 根据状态设置TabBarItem文字属性
 
 @param attributes 文字阴影颜色
 @param state 按钮状态
 */
- (void)setTitleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attributes forState:(UIControlState)state;
/**
 TabBarItem文字属性与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *titleTextAttributesMapper;
```

***

### UINavigationBar
* 设置navigationBar主题
```objective-c
[ZXTheme defaultTheme].zx_navigationBarThemeBlock = ^ZXNavigationBarTheme * _Nonnull(UINavigationBar * _Nonnull navigationBar) {
    ZXNavigationBarTheme *navigationBarTheme = [[ZXNavigationBarTheme alloc]init];
    navigationBarTheme.translucent = NO;
    navigationBarTheme.barTintColor = UIColorFromRGB(0x1c1c1c);
    navigationBarTheme.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    return navigationBarTheme;
};
```
* ZXNavigationBarTheme所有属性
```objective-c
/**
 设置NavigationBar的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置NavigationBar是否透明
 */
@property(assign, nonatomic) BOOL translucent;
/**
 设置NavigationBar的背景色
 */
@property(strong, nonatomic) UIColor *barTintColor;
/**
 设置NavigationBar的shadowImage
 */
@property(strong, nonatomic) UIImage *shadowImage;
/**
 设置NavigationBar的titleTextAttributes
 */
@property(strong, nonatomic) NSDictionary<NSAttributedStringKey, id> *titleTextAttributes;
```

***

### UIBarButtonItem
* 设置barButtonItem主题
```objective-c
[ZXTheme defaultTheme].zx_barButtonItemThemeBlock = ^ZXBarButtonItemTheme * _Nonnull(UIBarButtonItem * _Nonnull barButtonItem){
    ZXBarButtonItemTheme *barButtonItemTheme = [[ZXBarButtonItemTheme alloc]init];
    barButtonItemTheme.tintColor = [UIColor redColor];
    return barButtonItemTheme;
};
```
* ZXBarButtonItemTheme所有属性
```objective-c
/**
 设置BarButtonItem的style
 */
@property(assign, nonatomic) UIBarButtonItemStyle style;
/**
 设置BarButtonItem的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置BarButtonItem的customView
 */
@property(strong, nonatomic) UIView *customView;
```

***

### UITableView
* 设置tableView主题
```objective-c
[ZXTheme defaultTheme].zx_tableViewThemeBlock = ^ZXTableViewTheme * _Nonnull(UITableView * _Nonnull tableView) {
    ZXTableViewTheme *tableViewTheme = [[ZXTableViewTheme alloc]init];
    tableViewTheme.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViewTheme.backgroundColor = [self getTableViewBacColor];
    tableViewTheme.viewForHeaderInSection = ^UIView * _Nonnull(UIView * _Nonnull headerView, NSUInteger section) {
        headerView.backgroundColor = [self getTableViewHeaderViewBacColor];
        for (UIView *view in headerView.subviews) {
            if([view isKindOfClass:[UILabel class]]){
                ((UILabel *)view).textColor = [self getTableViewHeaderViewLabelTextColor];
            }
            
        }
        return headerView;
    };
    tableViewTheme.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.backgroundColor = [self getTableViewCellBacColor];
        for (UIView *view in cell.contentView.subviews) {
            if([view isKindOfClass:[UILabel class]]){
                ((UILabel *)view).textColor = [self getTableViewCellLabelTextColor];
            }
            if([view isKindOfClass:[UIImageView class]]){
                ((UIImageView *)view).image = [((UIImageView *)view).image renderColor:[self getTableViewCellImageViewRenderColor]];
            }
        }
        return cell;
    };
    return tableViewTheme;
};
```
* ZXTableViewTheme所有属性
```objective-c
/**
 设置TableView的backgroundColor
 */
@property(strong, nonatomic) UIColor *backgroundColor;
/**
 设置TableView的backgroundView
 */
@property(strong, nonatomic) UIView *backgroundView;
/**
 设置TableView的sectionIndexColor
 */
@property(strong, nonatomic) UIColor *sectionIndexColor;
/**
 设置TableView的sectionIndexBackgroundColor
 */
@property(strong, nonatomic) UIColor *sectionIndexBackgroundColor;
/**
 设置TableView的sectionIndexTrackingBackgroundColor
 */
@property(strong, nonatomic) UIColor *sectionIndexTrackingBackgroundColor;
/**
 设置TableView的separatorStyle
 */
@property(assign, nonatomic) UITableViewCellSeparatorStyle separatorStyle;
/**
 设置TableView的separatorColor
 */
@property(strong, nonatomic) UIColor *separatorColor;
/**
 设置TableView的separatorEffect
 */
@property(strong, nonatomic) UIVisualEffect *separatorEffect;
/**
 设置TableView的tableHeaderView
 */
@property(strong, nonatomic) UIView *tableHeaderView;
/**
 设置TableView的tableFooterView
 */
@property(strong, nonatomic) UIView *tableFooterView;
/**
 设置TableView的cell
 */
@property(copy, nonatomic) UITableViewCell *(^cellForRowAtIndexPath)(UITableViewCell *cell,NSIndexPath *indexPath);
/**
 设置TableView的headerView
 */
@property(copy, nonatomic) UIView *(^viewForHeaderInSection)(UIView *headerView,NSUInteger section);
/**
 设置TableView的footerView
 */
@property(copy, nonatomic) UIView *(^viewForFooterInSection)(UIView *footerView,NSUInteger section);
```

***

### UICollectionView
* 设置collectionView主题
```objective-c
[ZXTheme defaultTheme].zx_collectionViewThemeBlock = ^ZXCollectionViewTheme * _Nonnull(UICollectionView * _Nonnull collectionView) {
    ZXCollectionViewTheme *collectionViewTheme = [[ZXCollectionViewTheme alloc]init];
    collectionViewTheme.backgroundColor = [self getCollectionViewBacColor];
    collectionViewTheme.cellForItemAtIndexPath = ^UICollectionViewCell * _Nonnull(UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.backgroundColor = [self getCollectionViewCellBacColor];
        for (UIView *view in cell.contentView.subviews) {
            if([view isKindOfClass:[UILabel class]]){
                ((UILabel *)view).textColor = [self getCollectionViewCellLabelTextColor];
            }
        }
        return cell;
    };
    collectionViewTheme.viewForSupplementaryElement = ^UICollectionReusableView * _Nonnull(UICollectionReusableView * _Nonnull reusableView, NSString * _Nonnull kind, NSIndexPath * _Nonnull indexPath) {
        reusableView.backgroundColor = [self getCollectionViewHeaderViewBacColor];
        for (UIView *view in reusableView.subviews) {
            if([view isKindOfClass:[UILabel class]]){
                ((UILabel *)view).textColor = [self getCollectionViewHeaderViewLabelTextColor];
            }
            
        }
        return reusableView;
    };
    return collectionViewTheme;
};
```
* ZXCollectionViewTheme所有属性
```objective-c
/**
 设置CollectionView的backgroundColor
 */
@property(strong, nonatomic) UIColor *backgroundColor;
/**
 设置CollectionView的backgroundView
 */
@property(strong, nonatomic) UIView *backgroundView;
/**
 设置CollectionView的cell
 */
@property(copy, nonatomic) UICollectionViewCell *(^cellForItemAtIndexPath)(UICollectionViewCell *cell,NSIndexPath *indexPath);
/**
 设置CollectionView的headerView和FfooterView
 */
@property(copy, nonatomic) UICollectionReusableView *(^viewForSupplementaryElement)(UICollectionReusableView *reusableView,NSString *kind,NSIndexPath *indexPath);
```









