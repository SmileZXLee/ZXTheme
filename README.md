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
## 主题设置
### 说明
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

### 所有UI控件主题设置
#### UILabel
* 设置label主题
```objective-c
[ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
    ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
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
### TODO...






