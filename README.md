##微信公众号:

![学习流程图](https://github.com/minggo620/iOSRuntimeLearn/blob/master/picture/gongzhonghao.jpg?raw=true)  
#谈不完美的IBDesignable/IBInspectable可视化效果编程  
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSDesignable/archive/master.zip)   
我们好像慢慢地习惯了“理想很丰满，现实很骨感”这样顺序这样的转折，那么如果是“现实很丰满，理想很骨感”，我们能接受吗？现实丰满可以，但是理想很骨感那就不要将就了。就像薛之谦希望是能通过理想丰满的“丑八怪 呀啊呀啊呀哎呀”而唱红现实骨感的自己，而不是上综艺做直男直到没朋友的谐星，笑红自己丰满现实，却让他理想的歌显得骨感。  
苹果开发中使用的XCode也有这样的“现实丰满，理想骨感”例子，苹果公司在2011年就推出了UIStoryboard技术，到现在已经6年了。苹果还不在xcode的Interface Builder上直接提供修改控件的圆角，边框设置，而是提供IBDesignable/IBInspectable这样的技术让这些重复简单的工作由开发者来实现圆角外框，最后category上使用IBDesignable/IBInspectable却不能直接现实想要的结果。  
那边我们来体验一下薛之谦的“人红歌不红”的“现实很丰满，理想很骨感”感觉。  
![文章思维导图.png](http://upload-images.jianshu.io/upload_images/1252638-f37440d4434ac6ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  
###一.我们想要的lix    
###一.基本概念  
>1. IB_DESIGNABLE的宏的功能就是让XCode动态渲染出该类图形化界面。UIView 或 NSView使用IB_DESIGNABLE宏声明时候，就是让Interface Builder知道它应该在UIStoryboard或者Xib中画布上直接渲染视图，不需要等到编译运行后就能预先展示出来效果。 
2. IBInspectable修饰属性，可以是用户自定义的运行时属性，让支持KVC的属性能够在Attribute Inspector中配置。