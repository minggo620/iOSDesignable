##微信公众号:

![学习流程图](https://github.com/minggo620/iOSRuntimeLearn/blob/master/picture/gongzhonghao.jpg?raw=true)  
#谈不完美的IBDesignable/IBInspectable可视化效果编程  
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSDesignable/archive/master.zip)   
我们好像慢慢地习惯了“理想很丰满，现实很骨感”这样顺序这样的转折这样常态，那么如果是“现实很丰满，理想很骨感”，我们能接受吗？现实丰满可以，但是理想很骨感那就不要将就了。就像薛之谦希望是能通过“丑八怪 呀啊呀啊呀哎呀”来唱红的自己，而不是上综艺做直男直到没朋友的谐星来笑红自己却跟他的歌关系不大。 

苹果开发中使用的XCode也有这样的“现实丰满，理想骨感”例子，苹果公司在2011年就推出了UIStoryboard技术，到现在已经6年了。苹果还不在xcode的Interface Builder上直接提供修改控件的圆角，边框设置，而是提供IBDesignable/IBInspectable这样的技术让这些重复简单的工作由开发者来实现圆角外框，最后category上使用IBDesignable/IBInspectable却不能直接现实想要的结果。 

那边我们来体验一下薛之谦的“人红歌不红”的“现实很丰满，理想很骨感”感觉。 
![文章思维导图.png](http://upload-images.jianshu.io/upload_images/1252638-f37440d4434ac6ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) 
###一.我们想要很简单
在Storyboard中的**所有控件**能通过Interface builder直接设置最基本圆角，边框和边框颜色属性，表达理想的**Storyboard能显示**出我要的渲染效果，而不是编写代码后只能在运行在手机或模拟器时才出现我们想要的效果。就像薛之谦想通唱歌红了自己，简单明了。  
###二.基本概念 
>1. IB_DESIGNABLE的宏的功能就是让XCode动态渲染出该类图形化界面。UIView 或 NSView使用IB_DESIGNABLE宏声明时候，就是让Interface Builder知道它应该在UIStoryboard或者Xib中画布上直接渲染视图，不需要等到编译运行后就能预先展示出来效果 。
2. IBInspectable修饰属性，可以是用户自定义的运行时属性，让支持KVC的属性能够在Attribute Inspector中配置。

###三.使用方式
######1.IB_DESIGNABLE放在@interface或者@implement都可以，申明这个类在XCode直接看到渲染的效果。

    IB_DESIGNABLE
    @interface IBDesignableImageView : UIImageView

######2.IBInspectable 修饰属性，使属性能在XCode中直接设置。**

    @property(nonatomic,assign) IBInspectable CGFloat cornerRadius;

###四 .普通类继承关系实现渲染效果
根据第三所列出的2个关键点，详细具体实现：
######1.自定义IBDesignableImageView 继承UIImageView。

    #import <UIKit/UIKit.h>
    IB_DESIGNABLE
    @interface IBDesignableImageView : UIImageView
        @property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
    @end
######2.接着在IBDesignableImageView.m文件实现下set方法

    #import "IBDesignableImageView.h"
    @implementation IBDesignableImageView
    -(void)setCornerRadius:(CGFloat)cornerRadius{
        _cornerRadius = cornerRadius;//不要使用self.cornerRadius = cornerRadius;这样会死循环
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
    }
    @end
######3.接着，XCode中Customer Class选择IBDesignableImageView。
######4.最后，interface builder属性栏中设置你刚刚属性。
![类继承关系实现效果图](http://upload-images.jianshu.io/upload_images/1252638-b5fa0f97509f2a0c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
主要就是以上四步基本满足一下下storyboard成功展示一种View实时渲染效果的快感，犹如薛之谦尝试到一首《丑八怪》火一阵子，爽一阵子的快感，并且不会让人误认为这是赵全的《我很丑可是我很温柔》的续本。
###五.UIView的Category实现渲染效果
尝到了好处，自然想到实现通用的方式给需要控件都加上interface builder可设置相关属性。所以，我们自认为UIView其他子View父类，那么如果UIView可是直接在XCode上设置属性实现渲染，那么其他子View随之得到渲染效果。
######1.我们最想看到的结果是
我们最想看到结果是，UIImageView、UITextField、UIButton等等都能如愿的被interface builder直接修改相关圆角，边框等等属性。噔噔，我们脑海浮现以下画面：
![最理想状态](http://upload-images.jianshu.io/upload_images/1252638-bb7efcdd94eef870.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
######2.编写UIView的Category类UIView+MGO.h
    #import <UIKit/UIKit.h>
    IB_DESIGNABLE
    @interface UIView (MGO)
        @property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
        @property(nonatomic,assign) IBInspectable CGFloat borderWidth;
        @property(nonatomic,assign) IBInspectable UIColor *borderColor;
        @property(nonatomic,assign) IBInspectable CGFloat defineValue;
    @end
######3.编写UIView+MGO.m中的实现
    #import "UIView+MGO.h"
    #import <objc/runtime.h>
    @implementation UIView (MGO)
    -(void)setCornerRadius:(CGFloat)cornerRadius{
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
    }
    -(void)setBorderColor:(UIColor *)borderColor{
        self.layer.borderColor = borderColor.CGColor;
    }
    -(void)setBorderWidth:(CGFloat)borderWidth{
        self.layer.borderWidth = borderWidth;
    }
    -(void)setDefineValue:(CGFloat)defineValue{
        objc_setAssociatedObject(self, @selector(defineValue), @(defineValue),OBJC_ASSOCIATION_ASSIGN);
    }
    -(CGFloat)cornerRadius{
        return self.layer.cornerRadius;
    }
    -(CGFloat)borderWidth{
        return self.layer.borderWidth;
    }
    -(UIColor *)borderColor{
        return [UIColor colorWithCGColor:self.layer.borderColor];
    }
    -(CGFloat)defineValue{
        return [objc_getAssociatedObject(self, @selector(defineValue)) floatValue];
    }
    @end
这个.m的实现类，有几个知识点要注意：
1).category中添加IBInspectable修饰属性，必须带有set和get的方法，不然编译都通过。
2).KVC观察属性值变化，从而得到即时刷新效果。
3).category中自定义属性如上边defineValue属性，使用runtime方式赋值。所以会有objc_setAssociatedObject(self, @selector(defineValue), @(defineValue),OBJC_ASSOCIATION_ASSIGN);这样的代码。_defineValue = defineValue;这样也是行，这样是有语法问题的。
详细的runtime和KVC知识点可以查看[《谈Runtime机制和使用的整体化梳理》](http://www.jianshu.com/p/8916ad5662a2)和[《谈KVC、KVO（重点观察者模式）机制编程》](http://www.jianshu.com/p/b24d3829b978)
######4.在interface builder设置相关属性
1).属性栏可以看可设置圆角，边框宽度等
![设置UIView(MGO定义出来属性)](http://upload-images.jianshu.io/upload_images/1252638-123b5012da33d253.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2).Runtime Attribute栏中也能自动生成刚刚设置的属性值
![Runtime Attribute显示属性值](http://upload-images.jianshu.io/upload_images/1252638-d64f673e368515d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

######5.查看storyboard上的头像有没有显示设置的属性值
![UIView(MGO)展示的效果](http://upload-images.jianshu.io/upload_images/1252638-e0d549d1519f0d7a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Oh。。。my god！storyboard上一点效果也没显示出来，反而模拟器运行效果确实理想的状态。活生生的“现实很丰满，理想很骨感”表现得淋漓尽致。难道要硬着头皮瞬间退回到解放前，重复不断的写继承代码。。。打死也不，，，告诉你淘宝发过来的验证码！
###六.曲线救国处理Category不显示效果问题
曲线救国生活中可以，国就是救那么一两次，没国了也没办法。程序中，每时每刻都在救国，明摆着这欺负人嘛！不过，国我们还是得救的，歌薛之谦还是要唱的，先找到两者的微妙关系，串成曲线才行。于是乎，薛之谦将段子手的头衔发挥到极致，参加各大综艺，《火星情报站》《极限挑战》《大学生来了》等等，趁机唱唱“丑八怪 呀啊呀啊哎呀”，道理就明了了，就是死活出现在人面前晃来晃去。
哟，那会不会interface builder死活要看到UIView的自定义子类的继承类，设置在Customer Class中才行啊。试试？
######1.编写一个 空白MGOImageView继承UIImageView。
    #import <UIKit/UIKit.h>
    @interface MGOImageView : UIImageView
    @end
#####2.MGOImageView.m文件什么也不干，就是等机会对接UIView(MGO)自定义属性。
    #import "MGOImageView.h"
    @implementation MGOImageView
    @end
#####3.选中storyboard中的UIImageView在Customer Class选择 MGOImageView。
![编写空白MGOImageView尝试](http://upload-images.jianshu.io/upload_images/1252638-35836a69e7bf6e2c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
噢，，，了个天啊！storyboard上一点效果都没有少显示出来，反而吓到了现实中的我。那就趁热吃豆腐了，把其他控件都写一个对应空白的子类，设置在customer class上。
![其他控件都添加对应的子类](http://upload-images.jianshu.io/upload_images/1252638-bb27de25bd3a6028.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

好像幸福就是来得那么突然，伤心的小船说翻就翻了。会不会有更大幸福，于是乎，小明在google上搜索“IBDesignable/IBInspectable在Category中没有效果”。看了两三页搜索结果，最后比较接近的是Cocachina中也有一个没有人回复的相关帖子，和另外一篇跟我的发现一样要写一个空白的子类设置在Customer Class 中才行。
###七.对比总结
经过以上一系列折腾，最后的结果确认令我觉得“不完美的IBDesignable/IBInspectable”。有些对XCode，Storyboard项目者有些一丁点的期待外，同时也是希望有开发者提供更好的处理方式。对比其他IDE，，就算了。追求完美我们是天生的，尽情开发我们也是认真的。
###八.源码下载
#####*[https://github.com/minggo620/iOSDesignable.git](https://github.com/minggo620/iOSDesignable.git)*
######好想要到薛之谦的微信，向他发1毛钱的红包，然后他会一如既往地回“不好意思，我不收别人的微信红包”，接着我收到了200块红包。
