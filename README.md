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
## 零侵入实现黑暗模式示例
* 代码参照`Appdelegate.m`文件

![Image text](http://www.zxlee.cn/ZXThemeDemo1.gif) 
## 说明
`ZXTheme`用于修改全局UI的主题，设置方法与注意点说明以UILabel为例：
* 示例代码
```objective-c
[ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
    ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
    labelTheme.textColor = [UIColor blueColor];
    labelTheme.textAlignment = NSTextAlignmentCenter;
    return labelTheme;
};
```
* 说明：我们需要修改全局label的主题，则书写`[ZXTheme defaultTheme].zx_labelThemeBlock`
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
1.`themeblock`返回值为nil，则代表当前label对象不设置主题  
2.`ZXLabelTheme`对象中属性没有设置，则代表当前label对象中对应属性不设置主题  
3.`ZXLabelTheme`对象中属性有值，则当前label对象中对应属性用`ZXLabelTheme`对象的对应属性值，例如`labelTheme.textColor`有值，则label的textColor为`labelTheme.textColor`，否则label的textColor为label本身的textColor  
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
/**
 是否是控制器的self.view

 @return 是否是控制器的self.view
 */
- (BOOL)zx_isControllerView;
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
### ZXTheme支持设置全局主题的View
* [UIView](#UIView)
* [UILabel](#UILabel)
* [UIButton](#UIButton)
* [UISegmentedControl](#UISegmentedControl)
* [UITextField](#UITextField)
* [UISlider](#UISlider)
* [UISwitch](#UISwitch)
* [UIActivityIndicatorView](#UIActivityIndicatorView)
* [UIProgressView](#UIProgressView)
* [UIPageControl](#UIPageControl)
* [UIStepper](#UIStepper)
* [UIImageView](#UIImageView)
* [UITextView](#UITextView)
* [UITabBar](#UITabBar)
* [UITabBarItem](#UITabBarItem)
* [UINavigationBar](#UINavigationBar)
* [UIBarButtonItem](#UIBarButtonItem)
* [UITableView](#UITableView)
* [UICollectionView](#UICollectionView)
* [自定义其他View或属性的主题](#custom)
***

### <a id="UIView"></a>UIView
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
* `ZXViewTheme`所有属性  

|      属性       |       描述       |
| :-------------: | :--------------: |
| backgroundColor | 设置view背景颜色 |



***

### <a id="UILabel"></a>UILabel
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
* `ZXLabelTheme`所有属性  

|           属性            |               描述               |
| :-----------------------: | :------------------------------: |
|         textColor         |           设置文字颜色           |
|           font            |           设置文字字体           |
|       textAlignment       |         设置文字对齐方式         |
|       lineBreakMode       |         设置文字换行模式         |
|        highlighted        |         设置文字是否高亮         |
|   highlightedTextColor    |      设置文字高亮时候的颜色      |
| adjustsFontSizeToFitWidth | 设置文字是否根据宽度自动调整字体 |
|       numberOfLines       |         设置文字最大行数         |
|      backgroundColor      |         设置文字背景颜色         |



***

### <a id="UIButton"></a>UIButton
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
* ZXButtonTheme所有属性/方法

|             属性/方法             |             描述             |
| :-------------------------------: | :--------------------------: |
|             tintColor             |      设置按钮tintColor       |
|      setTitleColor:forState:      |   根据状态设置按钮文字颜色   |
|   setTitleShadowColor:forState:   | 根据状态设置按钮文字阴影颜色 |
|         setImage:forState         |     根据状态设置按钮图片     |
| setBackgroundImageColor::forState |   根据状态设置按钮背景图片   |
|          backgroundColor          |       设置按钮背景颜色       |



***

### <a id="UISegmentedControl"></a>UISegmentedControl
* 设置segmentedControl主题
```objective-c
[ZXTheme defaultTheme].zx_segmentedControlThemeBlock = ^ZXSegmentedControlTheme * _Nonnull(UISegmentedControl * _Nonnull segmentedControl) {
    ZXSegmentedControlTheme *segmentedControlTheme = [[ZXSegmentedControlTheme alloc]init];
    segmentedControlTheme.tintColor = [UIColor redColor];
    return segmentedControlTheme;
};
```
* `ZXSegmentedControlTheme`所有属性  

|    属性   |              描述               |
| :-------------: | :-----------------------------: |
|    tintColor    | 设置SegmentedControl的tintColor |
| backgroundColor | 设置SegmentedControl的背景颜色  |



***

### <a id="UITextField"></a>UITextField
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

|    属性     |              描述              |
| :--------------: | :----------------------------: |
|    textColor     |       设置TextField颜色        |
|       font       |       设置TextField字体        |
|  textAlignment   |     设置TextField对齐方式      |
|    tintColor     |    设置TextField的tintColor    |
| placeholderColor | 设置TextField的placeholder颜色 |
| backgroundColor  |    设置TextField的背景颜色     |



***

### <a id="UISlider"></a>UISlider
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
* `ZXSliderTheme`所有属性  

|       属性       |          描述          |
| :-------------------: | :--------------------: |
| minimumTrackTintColor | 设置Slider左侧背景颜色 |
| maximumTrackTintColor | 设置Slider右侧背景颜色 |
|    thumbTintColor     |   设置Slider滑块颜色   |
|   minimumValueImage   |   设置Slider左侧图片   |
|   maximumValueImage   |   设置Slider右侧图片   |
|    backgroundColor    |   设置Slider背景颜色   |



***

### <a id="UISwitch"></a>UISwitch
* 设置switch主题
```objective-c
[ZXTheme defaultTheme].zx_switchThemeBlock = ^ZXSwitchTheme * _Nonnull(UISwitch * _Nonnull mySwitch) {
    ZXSwitchTheme *switchTheme = [[ZXSwitchTheme alloc]init];
    switchTheme.onTintColor = [UIColor redColor];
    switchTheme.tintColor = [UIColor redColor];
    return switchTheme;
};
```
* `ZXSwitchTheme`所有属性  

|    属性    |          描述           |
| :-------------: | :---------------------: |
|    tintColor    |  设置Switch的tintColor  |
|   onTintColor   | 设置Switch的onTintColor |
| backgroundColor |   设置Switch背景颜色    |



***

### <a id="UIActivityIndicatorView"></a>UIActivityIndicatorView
* 设置activityIndicatorView主题
```objective-c
[ZXTheme defaultTheme].zx_activityIndicatorViewThemeBlock = ^ZXActivityIndicatorViewTheme * _Nonnull(UIActivityIndicatorView * _Nonnull activityIndicatorView) {
    ZXActivityIndicatorViewTheme *activityIndicatorViewTheme = [[ZXActivityIndicatorViewTheme alloc]init];
    activityIndicatorViewTheme.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    return activityIndicatorViewTheme;
};
```
* ZXActivityIndicatorViewTheme所有属性  

|         属性          |             描述              |
| :------------------------: | :---------------------------: |
| activityIndicatorViewStyle | 设置ActivityIndicatorView样式 |
|      backgroundColor       |      设置Switch背景颜色       |



***

### <a id="UIProgressView"></a>UIProgressView
* 设置progressView主题
```objective-c
[ZXTheme defaultTheme].zx_progressViewThemeBlock = ^ZXProgressViewTheme * _Nonnull(UIProgressView * _Nonnull progressView) {
    ZXProgressViewTheme *progressViewTheme = [[ZXProgressViewTheme alloc]init];
    progressViewTheme.progressTintColor = [UIColor redColor];
    progressViewTheme.trackTintColor = [UIColor blueColor];
    return progressViewTheme;
};
```
* `ZXProgressViewTheme`所有属性  

|             属性              |            描述             |
| :---------------: | :--------------------------------: |
| progressTintColor | 设置ProgressView已加载的进度条颜色 |
|  trackTintColor   | 设置ProgressView未加载的进度条颜色 |
|   progressImage   | 设置ProgressView已加载的进度条图片 |
|    trackImage     | 设置ProgressView未加载的进度条图片 |



***

### <a id="UIPageControl"></a>UIPageControl
* 设置pageControl主题
```objective-c
[ZXTheme defaultTheme].zx_pageControlThemeBlock = ^ZXPageControlTheme * _Nonnull(UIPageControl * _Nonnull pageControl) {
    ZXPageControlTheme *pageControlTheme = [[ZXPageControlTheme alloc]init];
    pageControlTheme.pageIndicatorTintColor = [UIColor redColor];
    pageControlTheme.currentPageIndicatorTintColor = [UIColor blueColor];
    return pageControlTheme;
};
```
* `ZXPageControlTheme`所有属性  


|             属性              |            描述             |
| :---------------------------: | :-------------------------: |
|    pageIndicatorTintColor     | 设置PageControl其他页的颜色 |
| currentPageIndicatorTintColor | 设置PageControl当前页的颜色 |



***

### <a id="UIStepper"></a>UIStepper
* 设置stepper主题
```objective-c
[ZXTheme defaultTheme].zx_stepperThemeBlock = ^ZXStepperTheme * _Nonnull(UIStepper * _Nonnull stepper) {
    ZXStepperTheme *stepperTheme = [[ZXStepperTheme alloc]init];
    stepperTheme.tintColor = [UIColor whiteColor];
    return stepperTheme;
};
```
* `ZXStepperTheme`所有属性  

|      属性       |          描述          |
| :-------------: | :--------------------: |
|    tintColor    | 设置Stepper的tintColor |
| backgroundColor |  设置Stepper背景颜色   |



***

### <a id="UIImageView"></a>UIImageView
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
* `ZXImageViewTheme`所有属性  

|              属性               |                        描述                         |
| :-----------------------------: | :-------------------------------------------------: |
|              image              |                设置ImageView的image                 |
|           imageColor            |              设置ImageView的image颜色               |
|        highlightedImage         |           设置ImageView的highlightedImage           |
|      highlightedImageColor      |         设置ImageView的highlightedImage颜色         |
|         animationImages         |            设置ImageView的动画image数组             |
|      animationImagesColor       |           设置ImageView的image数组的颜色            |
|   highlightedAnimationImages    |       设置ImageView的动画highlightedImage数组       |
| highlightedAnimationImagesColor | 设置ImageView的highlightedAnimationImages数组的颜色 |
|            tintColor            |              设置ImageView的tintColor               |
|         backgroundColor         |                设置ImageView背景颜色                |



***

### <a id="UITextView"></a>UITextView
* 设置textView主题
```objective-c
[ZXTheme defaultTheme].zx_textViewThemeBlock = ^ZXTextViewTheme * _Nonnull(UITextView * _Nonnull textView) {
    ZXTextViewTheme *textViewTheme = [[ZXTextViewTheme alloc]init];
    textViewTheme.textColor = [UIColor redColor];
    textViewTheme.backgroundColor = [UIColor blueColor];
    return textViewTheme;
};
```
* `ZXTextViewTheme`所有属性  

|      属性       |            描述            |
| :-------------: | :------------------------: |
|    textColor    |   设置TextView的文字颜色   |
|      font       |   设置TextView的文字字体   |
|  textAlignment  | 设置TextView的文字对齐方式 |
| backgroundColor |   设置TextView的背景颜色   |



***

### <a id="UITabBar"></a>UITabBar
* 设置tabBar主题
```objective-c
[ZXTheme defaultTheme].zx_tabBarThemeBlock  = ^ZXTabBarTheme * _Nonnull(UITabBar * _Nonnull tabBar) {
    ZXTabBarTheme *tabBarTheme = [[ZXTabBarTheme alloc]init];
    tabBarTheme.translucent = NO;
    tabBarTheme.barTintColor = [self getTabbarTintColor];
    return tabBarTheme;
};
```
* `ZXTabBarTheme`所有属性  

|          属性           |                描述                 |
| :---------------------: | :---------------------------------: |
|        tintColor        |        设置Tabbar的tintColor        |
|       translucent       |         设置Tabbar是否透明          |
|      barTintColor       |         设置Tabbar的背景色          |
|     backgroundImage     |        设置Tabbar的背景图片         |
| selectionIndicatorImage | 设置Tabbar的selectionIndicatorImage |
|       shadowImage       |       设置Tabbar的shadowImage       |



***

### <a id="UITabBarItem"></a>UITabBarItem
* 设置tabBarItem主题
```objective-c
[ZXTheme defaultTheme].zx_tabBarItemThemeBlock = ^ZXTabBarItemTheme * _Nonnull(UITabBarItem * _Nonnull tabBarItem) {
    ZXTabBarItemTheme *tabBarItemTheme = [[ZXTabBarItemTheme alloc]init];
    tabBarItemTheme.selectedImageColor = [UIColor redColor];
    [tabBarItemTheme setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName, [UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return tabBarItemTheme;
};
```
* `ZXTabBarItemTheme`所有属性  

|            属性/方法             |               描述                |
| :------------------------------: | :-------------------------------: |
|              image               |       设置TabBarItem的image       |
|            imageColor            |     设置TabBarItem的image颜色     |
|          selectedImage           |   设置TabBarItem的selectedImage   |
|        selectedImageColor        | 设置TabBarItem的selectedImage颜色 |
| setTitleTextAttributes:forState: |  根据状态设置TabBarItem文字属性   |



***

### <a id="UINavigationBar"></a>UINavigationBar
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
* `ZXNavigationBarTheme`所有属性  

|        属性         |                  描述                  |
| :-----------------: | :------------------------------------: |
|      tintColor      |      设置NavigationBar的tintColor      |
|     translucent     |       设置NavigationBar是否透明        |
|    barTintColor     |    设置NavigationBar的barTintColor     |
|     shadowImage     |     设置NavigationBar的shadowImage     |
| titleTextAttributes | 设置NavigationBar的titleTextAttributes |



***

### <a id="UIBarButtonItem"></a>UIBarButtonItem
* 设置barButtonItem主题
```objective-c
[ZXTheme defaultTheme].zx_barButtonItemThemeBlock = ^ZXBarButtonItemTheme * _Nonnull(UIBarButtonItem * _Nonnull barButtonItem){
    ZXBarButtonItemTheme *barButtonItemTheme = [[ZXBarButtonItemTheme alloc]init];
    barButtonItemTheme.tintColor = [UIColor redColor];
    return barButtonItemTheme;
};
```
* `ZXBarButtonItemTheme`所有属性  

|    属性    |             描述              |
| :--------: | :---------------------------: |
|   style    |   设置BarButtonItem的style    |
| tintColor  | 设置BarButtonItem的tintColor  |
| customView | 设置BarButtonItem的customView |



***

### <a id="UITableView"></a>UITableView
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
* `ZXTableViewTheme`所有属性  

|                属性                 |                        描述                        |
| :---------------------------------: | :------------------------------------------------: |
|           backgroundColor           |           设置TableView的backgroundColor           |
|           backgroundView            |           设置TableView的backgroundView            |
|          sectionIndexColor          |          设置TableView的sectionIndexColor          |
|     sectionIndexBackgroundColor     |     设置TableView的sectionIndexBackgroundColor     |
| sectionIndexTrackingBackgroundColor | 设置TableView的sectionIndexTrackingBackgroundColor |
|           separatorStyle            |           设置TableView的separatorStyle            |
|           separatorColor            |           设置TableView的separatorColor            |
|           separatorEffect           |           设置TableView的separatorEffect           |
|           tableHeaderView           |           设置TableView的tableHeaderView           |
|           tableFooterView           |           设置TableView的tableFooterView           |
|        cellForRowAtIndexPath        |                设置TableView的cell                 |
|       viewForHeaderInSection        |             设置TableView的headerView              |
|       viewForFooterInSection        |             设置TableView的footerView              |



***

### <a id="UICollectionView"></a>UICollectionView
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
* `ZXCollectionViewTheme`所有属性 

|            属性             |                    描述                    |
| :-------------------------: | :----------------------------------------: |
|       backgroundColor       |    设置CollectionView的backgroundColor     |
|       backgroundView        |     设置CollectionView的backgroundView     |
|   cellForItemAtIndexPath    |          设置CollectionView的cell          |
| viewForSupplementaryElement | 设置CollectionView的headerView和footerView |


### <a id="custom"></a>自定义其他View或属性的主题
* 例如需要添加UIAlertController的主题设置
* 创建UIAlertController的分类
* 在.m文件中实现
```objective-c
#import "UIAlertController+ZXCustomTheme.h"
#import "ZXTheme.h"
@implementation UIAlertController (ZXCustomTheme)
+ (void)load{
    [self zx_handleThemeWithTargetSelector:@selector(addAction:) handleSelector:@selector(zx_addAction:)];
}
- (void)zx_addAction:(UIAlertAction *)action{
    [action setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [self zx_addAction:action];
}
@end
```
* 以上代码实现将UIAlertController的actions文字颜色变为红色的效果













