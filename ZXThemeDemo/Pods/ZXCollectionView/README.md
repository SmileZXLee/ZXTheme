# ZXCollectionView
## 安装
### 通过CocoaPods安装
```ruby
pod 'ZXCollectionView'
```
### 手动导入
* 将ZXCollectionView拖入项目中。

### 导入头文件
```objective-c
#import "ZXCollectionView.h"
```
## 创建ZXCollectionView示例
### 创建一个单一布局的CollectionView
* 在CollectionView所在的控制器中，此处定义的cell对应模型为ZXTestSingleCVModel
```objective-c
//声明cell是什么类
self.collectionView.zx_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nullable indexPath) {
    return [ZXTestSingleCVCell class];
};
//快速创建（设置布局）
ZXCVFastModel *fastModel = [[ZXCVFastModel alloc]init];
///设置ZXCollectionView显示3列
fastModel.colCount = 3;
//设置ZXCollectionView中cell的高度为宽度+30
fastModel.itemHConstant = 30;
//设置ZXCollectionView内容宽度，若不设置默认为ZXCollectionView.frame.size.width
fastModel.superW = [UIScreen mainScreen].bounds.size.width;
//设置布局模型
[self.collectionView zx_fastWithModel:fastModel];

//设置ZXCollectionView的数据
self.collectionView.zxDatas = [self getData];
```
* 在ZXTestSingleCVCell中
```objective-c
#import "ZXTestSingleCVCell.h"
#import "ZXTestSingleCVModel.h"
@interface ZXTestSingleCVCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//若cell中有包含model的属性，则会自动将model赋值给它(如果有多个含有model字符串的属性，则赋值给第一个)
@property (strong, nonatomic)ZXTestSingleCVModel *sigleModel;
@end
@implementation ZXTestSingleCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}
//重写model的set方法即可
-(void)setSigleModel:(ZXTestSingleCVModel *)sigleModel{
    _sigleModel= sigleModel;
    self.nameLabel.text = sigleModel.name;
    self.iconImgV.image = sigleModel.iconImg;
}

@end
```
* 查看效果
<img src="http://www.zxlee.cn/ZXCollectionViewDemoImg/singleDemo.png"/>

***


### 创建一个多个section的collectionView
* 在CollectionView所在的控制器中，此处定义的cell对应模型为ZXTestSingleCVModel
```objective-c
//声明cell是什么类
self.collectionView.zx_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nullable indexPath) {
    return [ZXTestSingleCVCell class];
};
//声明headerView是什么类
self.collectionView.zx_setHeaderClassInSection = ^Class _Nonnull(NSInteger section) {
    return [ZXTestSecsCVHeaderView class];
};
//设置headerView
self.collectionView.zx_getHeaderViewInSection = ^(NSInteger section, ZXTestSecsCVHeaderView *  _Nonnull headerView, id  _Nonnull model) {
    headerView.titleLabel.text = [NSString stringWithFormat:@"headerView--%lu",section];
};
//声明footerView是什么类
self.collectionView.zx_setFooterClassInSection = ^Class _Nonnull(NSInteger section) {
    return [ZXTestSecsCVFooterView class];
};
//设置footerView
self.collectionView.zx_getFooterViewInSection = ^(NSInteger section, ZXTestSecsCVHeaderView *  _Nonnull footerView, id  _Nonnull model) {
    footerView.titleLabel.text = [NSString stringWithFormat:@"footerView--%lu",section];
};
//快速创建（设置布局）
ZXCVFastModel *fastModel = [[ZXCVFastModel alloc]init];
///设置ZXCollectionView显示3列
fastModel.colCount = 3;
//设置ZXCollectionView中cell的高度为宽度+30
fastModel.itemHConstant = 30;
//设置ZXCollectionView内容宽度，若不设置默认为ZXCollectionView.frame.size.width
fastModel.superW = [UIScreen mainScreen].bounds.size.width;
//设置布局模型
[self.collectionView zx_fastWithModel:fastModel];

//设置ZXCollectionView的数据
self.collectionView.zxDatas = [self getData];
```
* 在ZXTestSingleCVCell中代码同上

* 查看效果
<img src="http://www.zxlee.cn/ZXCollectionViewDemoImg/secsDemo.png"/>

***

### 创建一个根据indexPath变换布局的collectionView
* 在CollectionView所在的控制器中，此处定义的cell对应模型为ZXTestSingleCVModel
```objective-c
//声明cell是什么类
self.collectionView.zx_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nullable indexPath) {
    return [ZXTestSingleCVCell class];
};
//快速创建（设置布局）
ZXCVFastModel *fastModel = [[ZXCVFastModel alloc]init];
///设置ZXCollectionView显示3列
fastModel.colCount = 3;
//设置ZXCollectionView中cell的高度为宽度+30
fastModel.itemHConstant = 30;
//设置ZXCollectionView内容宽度，若不设置默认为ZXCollectionView.frame.size.width
fastModel.superW = [UIScreen mainScreen].bounds.size.width;
//设置布局模型
[self.collectionView zx_fastWithModel:fastModel];
//根据IndexPath更改itemSize
self.collectionView.zx_setItemSizeAtIndexPath = ^CGSize(NSIndexPath * _Nonnull indexPath, id  _Nonnull model, CGSize orgSize) {
    if(indexPath.row == 0){
        CGFloat intmW = [self.collectionView zx_getItemWWithCol:1 margin:10 attachMargin:YES superW:fastModel.superW];;
        return CGSizeMake(intmW, intmW + 30);
    }
    return orgSize;
};
//设置ZXCollectionView的数据
self.collectionView.zxDatas = [self getData];
```

* 在ZXTestSingleCVCell中代码同上

* 查看效果
<img src="http://www.zxlee.cn/ZXCollectionViewDemoImg/varDemo.png"/>

***

## 具体使用说明
### 如何快速使用
* 创建一个collectionView的步骤大致分为，声明cell，声明headerView&footerView，self.collectionView.zxDatas赋值，在cell中声明一个含有“model”的属性名，重写该属性的set方法即可。
* ZXCollectionView中的大多数方法都是zx_开头，zx_set开头代表设置collectionView，例如：zx_setCellClass...即为设置(声明)cell的类是谁；zx_get开头代表从collectionView中获取信息，例如zx_getCellAt...即为获取cell对象，可依据此结合下方说明快速记忆。
### cell相关
* 声明cell
```objective-c
self.collectionView.zx_setCellClassAtIndexPath = ^Class (NSIndexPath *  indexPath) {
    //可以根据indexPath返回不同的cell
    return [MyCell class];
};
```
* 获取cell对象，对cell对象进行操作
```objective-c
self.collectionView.zx_getCellAtIndexPath = ^(NSIndexPath *indexPath, id cell, id model) {
    //这里的id cell中id可以改成自己当前的cell类名(若只有一种cell)，id model中的id可以改成自己当前模型的类名(若只有一种模型)
}
```
* 设置cell大小
```objective-c
self.collectionView.zx_setItemSizeAtIndexPath = ^CGSize(NSIndexPath * _Nonnull indexPath, id  _Nonnull model, CGSize orgSize){
    //这里的orgSize为ZXCVFastModel中设置的或自定义layout布局的itemSize，可以在此基础上修改，也可以直接重新设置
    return orgSize;
};
```
### headerView&footerView相关，此处以headerView为例
* 声明headerView
```objective-c
//声明HeaderView是什么类
self.collectionView.zx_setHeaderClassInSection = ^Class(NSInteger section) {
    return [MyHeaderView class];
};
```
* 获取headerView对象
```objective-c
//获取HeaderView对象并对其进行处理
self.collectionView.zx_getHeaderViewInSection = ^(NSUInteger section, MyHeaderView *headerView, NSMutableArray *secArr) {
    headerView.headerLabel.text = [NSString stringWithFormat:@"HeaderView--%lu",section];
};
```
* 设置headerView大小(非必须)，若不设置，默认为headerView初始化时的大小
```objective-c
self.collectionView.zx_setHeaderSizeInSection = ^CGSize(NSInteger section) {
    return CGSizeZero;
};
```
### 布局相关
#### 快速布局
* 使用ZXCVFastModel快速创建基础布局
```objective-c
ZXCVFastModel *fastModel = [[ZXCVFastModel alloc]init];
[self.collectionView zx_fastWithModel:fastModel];
```
* 若需要cell之间间距为5
```objective-c
fastModel.margin = 5;
```
* 若需要设置列数为3列
```objective-c
fastModel.colCount = 3;
```
* 若需要设置margin是否对左右边缘不生效
```objective-c
fastModel.attachMargin = NO;
```
* cell宽度会依据上述要求计算出来
* 若需要设置cell的高度(固定高度)
```objective-c
fastModel.itemH = 100;
```
* 若需要设置cell的高度(高度是宽度的1.2倍)
```objective-c
fastModel.itemHMultiply = 1.2;
```
* 若需要设置cell的高度(高度比宽度多30)
```objective-c
fastModel.itemHConstant = 30;
```
* 若需要设置cell的容器宽度，默认为collectionView宽度
```objective-c
fastModel.superW = [UIScreen mainScreen].bounds.size.width;
```

* ZXCVFastModel所有属性
```objective-c
// cell间距，默认为10
@property(nonatomic, assign)CGFloat margin;
// 垂直滚动时cell列数，默认为2
@property(nonatomic, assign)NSUInteger colCount;
// 水平滚动时cell行数，默认为2
@property(nonatomic, assign)NSUInteger rowCount;
// 滚动方向，默认为垂直滚动
@property(nonatomic, assign)ZXScrollDirection scrollDirection;
// 垂直滚动时手动设置的高度，若设置则其余高度设置失效
@property(nonatomic, assign)CGFloat itemH;
// 垂直滚动时手动设置的宽度比例itemH = itemW * itemHMultiply，若设置则其余高度设置失效
@property(nonatomic, assign)CGFloat itemHMultiply;
// 垂直滚动时手动设置的宽度比例itemH = itemHW + itemHConstant，若设置则其余高度设置失效
@property(nonatomic, assign)CGFloat itemHConstant;
// 水平滚动时手动设置的宽度，若设置则其余宽度设置失效
@property(nonatomic, assign)CGFloat itemW;
// 水平滚动时手动设置的宽度比例itemW = itemH * itemWMultiply，若设置则其余宽度设置失效
@property(nonatomic, assign)CGFloat itemWMultiply;
// 水平滚动时手动设置的宽度比例itemW = itemH + itemWConstant，若设置则其余宽度设置失效
@property(nonatomic, assign)CGFloat itemWConstant;
// margin是否对左右边缘也生效，默认为YES
@property(nonatomic, assign)BOOL attachMargin;
// 垂直滚动时cell容器的宽度，默认为ZXCollectionView宽度
@property(nonatomic, assign)CGFloat superW;
// 水平滚动时cell容器的高度，默认为ZXCollectionView高度
@property(nonatomic, assign)CGFloat superH;
```
#### 系统布局相关(若快速构建不足以满足需求，可自定义布局，也可以在快速构建基础上修改org开头的字段即为原始布局)
```objective-c
//设置cell的size
@property (nonatomic, copy) CGSize (^zx_setItemSizeAtIndexPath)(NSIndexPath * indexPath,id model,CGSize orgSize);
//设置cell之间行间隙
@property (nonatomic, copy) CGFloat (^zx_setMinLineSpacingInSection)(NSInteger section,CGFloat orgSpacing);
//设置cell之间列间隙
@property (nonatomic, copy) CGFloat (^zx_setMinInteritemSpacingInSection)(NSInteger section,CGFloat orgSpacing);
//设置cell上左下右边界缩进
@property (nonatomic, copy) UIEdgeInsets (^zx_setInsetInSection)(NSInteger section,UIEdgeInsets orgEdgeInsets);
//设置HeaderView的Size(非必须)
@property (nonatomic, copy) CGSize (^zx_setHeaderSizeInSection)(NSInteger section);
//设置FooterView的Size(非必须)
@property (nonatomic, copy) CGSize (^zx_setFooterSizeInSection)(NSInteger section);
//无数据是否显示HeaderView，默认为YES
@property(nonatomic, assign)BOOL zx_showHeaderWhenNoMsg;
//无数据是否显示FooterView，默认为YES
@property(nonatomic, assign)BOOL zx_showFooterWhenNoMsg;
```

***

## 兼容系统布局与基本使用习惯，快速构建collectionView
