title: 多个下拉按钮的处理
---

 实现的效果如下

<a href = "/images/MorePullDown/root.gif"> <img src = "/images/MorePullDown/root.gif" width = 360 height = 240 alt = "root.gif"/> </a>

[项目代码][项目代码]

页面很简单，4个按钮、一张图片、一个 `TableView` 和一个半透明 `View`。

开始撸代码。

### 先来写按钮

按钮包含了一个 `UILabel` 和一个 `UIImageView` ,点击的时候 `UIImageView` 翻转。

 
先看 `XYButton.h`

```objectivec
#import <UIKit/UIKit.h>
@class XYButton;

typedef void(^ clickCityBtn_block_xyButton)(XYButton * view);


@interface XYButton : UIView

@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UIImageView * imageView;


- (void)setTitle:(NSString *)title;

/**
 *  是否 是 显示模式  YES  显示
 */
@property (nonatomic, assign)BOOL isShow;


@property (nonatomic, copy)clickCityBtn_block_xyButton clickCityBtn_block_xyButton;
- (void)clickCityBtn_block_xyButton:(void(^)(XYButton * view))clickCityBtn_block_xyButton;

@end
```

`block` 用来进行点击后的回调， `isShow` 用来标记状态。

点击事件通过 `touchesEnded:withEvent:` 来处理

```objectivec
- (void)touchesEnded
{
    self.isShow = !self.isShow;
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded];
    self.clickCityBtn_block_xyButton ? self.clickCityBtn_block_xyButton(self) : 0;
}
```

按钮上面的字会有长有短，为了好看，需要计算长度进行居中：

```objectivec
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    CGFloat width = [title boundingRectWithSize:CGSizeMake(222, 20)
    				 	options:NSStringDrawingUsesLineFragmentOrigin 
    				     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}
    				      	context:nil].size.width;
    //图片的宽度是12，所以label的宽度不能超过 width - 12
    width = (width > self.width - 12) ? (self.width - 12) : width;
    self.titleLabel.width = width;
    self.titleLabel.mj_x  = self.width / 2 - (width + 12 + 2) / 2;
    self.imageView.mj_x = CGRectGetMaxX(self.titleLabel.frame) + 2;
}
```
至此按钮已经完成


### 放4个按钮的 View

为了方便控制，4个按钮需要封装到一个 `View` 中。

照例先看 `XYNearDriverSchoolSelectView.h`

```objectivec
#import <UIKit/UIKit.h>

@class XYButton;

typedef void (^clickSelectView_block)(XYButton * btn);

@interface XYNearDriverSchoolSelectView : UIView

@property (nonatomic, copy)clickSelectView_block clickSelectView_block;
- (void)clickSelectView_blockWithBlock:(void(^)(XYButton * btn))clickSelectView_block;

@end
```

只有一个 `block` 进行按钮被点击后的回调。

截下来创建4个按钮

```objectivec
NSInteger width = (NSInteger)((self.width - 3) / 4);
NSArray * titleArray = @[@"默认排序", @"价格", @"距离", @"报名人数"];
WeakSelf(weakSelf);

for (int i = 0 ; i < titleArray.count ; i ++) {
     XYButton * btn = [[XYButton alloc] 
    		 	initWithFrame:CGRectMake((width + 1) * i, 1, width, self.height - 1)];
     [btn setTitle:titleArray[i]];
     btn.tag = 100000 + i;
     [self addSubview:btn];
     
     [btn clickCityBtn_block_xyButton:^(XYButton *view) {
         weakSelf.clickSelectView_block ? weakSelf.clickSelectView_block(view) : 0 ;
     }];
 }
 ```
 
 ### 控制器
 
 首先看属性
 
 ```objectivec
 @property (nonatomic, strong)XYNearDriverSchoolSelectView * selectView;

@property (nonatomic, strong)XYNearDriverSchoolSelectTableView * selectTableView;

/**
 *  上一次点击的 Btn
 */
@property (nonatomic, weak)XYButton * oldBtn;
/**
 *  处于 显示 模式的btn
 */
@property (nonatomic, weak)XYButton * showBtn;
 ```
 
 然后是 `ViewDidLoad` 
 
 ```objectivec
 - (void)viewDidLoad {
    
    self.view.backgroundColor = kDefaultBackgroudColor;
    
    //这是页面的内容
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 
   							 CGRectGetMaxY(self.selectView.frame) + 1,
     							kScreenWidth, 
    kScreenHeight -  CGRectGetMaxY(self.selectView.frame) - 1 -kNavigationBar_Height)];
    
    
    imageView.image = kImage(@"image");
    imageView.backgroundColor = kWhiteColor;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    
    //半透明的 View
    [self.view addSubview:self.selectTableView.backgroudView];
    [self.selectTableView.backgroudView clickView:^(UIView *view) {
        [self.showBtn touchesEnded:[NSSet set] withEvent:nil];
    }];
    
    //TableView
    [self.view addSubview:self.selectTableView];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //放4个按钮的 View
    [self.view addSubview:self.selectView];

   
}
```


`selectTableView` 的初始化

```objectivec
- (XYNearDriverSchoolSelectTableView *)selectTableView
{
    if (!_selectTableView) {
        _selectTableView = [[XYNearDriverSchoolSelectTableView alloc] 
        initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        /**
         *  点击cell 的回调
         */
        [_selectTableView didSelectRowWithBlock:^(XYNearDriverSchoolSelectTableView 
        *tableView, NSIndexPath *indexPath) {
            
        }];
    }
    return _selectTableView;
}
```





`selectView` 的初始化

不想看代码的直接看下面

```objectivec
- (XYNearDriverSchoolSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[XYNearDriverSchoolSelectView alloc] initWithFrame:
        					CGRectMake(0, 0, kScreenWidth, 30)];
        
        WeakSelf(weakSelf);
        
        NSMutableArray * groupArray = @[].mutableCopy;
        for (int i = 0 ; i < 4 ; i ++) {
            NSMutableArray * array = @[].mutableCopy;
            for (int i = 0 ; i < (arc4random()% 40) + 1; i ++) {
                [array addObject:[NSString stringWithFormat:@"%d",(arc4random()% 40)]];
            }
            [groupArray addObject:array];
        }
        
        [_selectView clickSelectView_blockWithBlock:^(XYButton *btn) {
           
            if (btn.isShow) {
                NSLog(@" -- %@",btn.titleLabel.text);
                self.showBtn = btn;
                self.selectTableView.backgroudView.hidden = NO;
                weakSelf.selectTableView.groupArray = groupArray[btn.tag - 100000];
            }
           
            if (self.oldBtn != btn && self.oldBtn.isShow) {
                [self.oldBtn touchesEnded:[NSSet set] withEvent:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 
                (int64_t)(kHomeCityAnimate_time / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                 ^{
                    [weakSelf clickSelectViewWithBth:btn];
                });
            } else {
                [weakSelf clickSelectViewWithBth:btn];
            }
            
        }];
    }
    return _selectView;
}

```

这里初始化完成 `selectView` 后，处理按钮的点击方法，4个按钮对应4个列表，我们这里只随机4组字符串:

```objectivec
NSMutableArray * groupArray = @[].mutableCopy;
        for (int i = 0 ; i < 4 ; i ++) {
            NSMutableArray * array = @[].mutableCopy;
            for (int i = 0 ; i < (arc4random()% 40) + 1; i ++) {
                [array addObject:[NSString stringWithFormat:@"%d",(arc4random()% 40)]];
            }
            [groupArray addObject:array];
        }
```

然后开始处理点击事件：

首先判断按钮的 `isShow` ,这里的获取到的 `isShow` 是更新后的，因为在按钮的 `touchesEnded:withEvent:` 先给 `isShow` 赋值，然后旋转 `imageView` 最后才进行的回调，所以 `isShow` 如果是 `YES`,那么就是处于下拉状态:

```objectivec
if (btn.isShow) {
     NSLog(@" -- %@",btn.titleLabel.text);
     self.showBtn = btn;
     self.selectTableView.backgroudView.hidden = NO;
     weakSelf.selectTableView.groupArray = groupArray[btn.tag - 100000];
 }
```
在这里面给 `self.showBtn` 赋值，把黑色半透明View的hidden置为 `NO`,再通过 `tag` 取到对应的数据。

然后进行判断点击的是否是同一个按钮:

```objectivec
//如果点击的不是同一个
if (self.oldBtn != btn && self.oldBtn.isShow) {
	 [self.oldBtn touchesEnded:[NSSet set] withEvent:nil];
	 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 
				 (int64_t)(kHomeCityAnimate_time / 2 * NSEC_PER_SEC)),
	 			 dispatch_get_main_queue(), ^{
	     [weakSelf clickSelectViewWithBth:btn];
	 });
} else {
	 [weakSelf clickSelectViewWithBth:btn];
}
```
如果点击的不是同一个按钮，那么先把 `oldBtn` 手动点击一下，让 `TableView` 缩回去，然后在 `kHomeCityAnimate_time / 2` 秒之后调用 `clickSelectViewWithBth:`,如果点击的同一个按钮，直接调用 `clickSelectViewWithBth:`

再来说说 `clickSelectViewWithBth:` 方法

```objectivec
- (void)clickSelectViewWithBth:(XYButton *)btn
{
    NSInteger y = CGRectGetMaxY(self.selectView.frame) + 1;
    if (!btn.isShow) {
        y = - self.selectTableView.height;
    }
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        self.selectTableView.mj_y = y;
    }];
    
    self.oldBtn = btn;
    
    self.selectTableView.backgroudView.hidden = !self.showBtn.isShow;
}
```

依据按钮的状态来决定 `TableView` 的位置，每次完成后都把 `oldBtn` 指向该按钮,然后 

`self.selectTableView.backgroudView.hidden = !self.showBtn.isShow;` 

是为了防止点击了不同的按钮的时候，上一个按钮会把 `TableView` 往回缩，这时候黑色半透明View会消失，所以加入了一个 `showBtn` ，就是当前处于显示状态的按钮，如果处于显示状态的按钮的 `isShow` 为 `NO`，那么说明所有按钮都不在显示状态，那么黑色半透明View应该消失。




<p><font color = #cd4c56> *第一次写这样的博客，写的有点乱，时间也有限，亲们有哪里看不懂的可以留言* </font></p>






[项目代码]: https://github.com/qiangxinyu/MorePullDown