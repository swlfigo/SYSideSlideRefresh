# SYSideSlideRefresh
Base on MJRefresh Project Modify, Use For ScrollView Side Slide Refresh. (基于MJRefresh的侧滑控件)

# Example

![QQ20190131-145644-HD.2019-01-31 14_57_37](http://img.isylar.com/media/QQ20190131-145644-HD.2019-01-31_14_57_37.gif)


# Usage:

* Add My Private Repo On Podfile
`source 'https://github.com/swlfigo/SYDevSpecs.git'`

* Installation with CocoaPods：pod 'SYSideSlideRefresh'

* Same way as `MJRefresh` add on ScrollView!

# More Detail

1. Inherit From `SYMJSideSlideRefreshBackFooter` As ParentClass, DIY your custom Side Slide!

2. Scroll And Trigger Loading Logic is `SYMJSideSlideRefreshFooter` Class .
3. No `HeaderScroll` Function Right Now!

# 使用

* 添加私有仓库 
`source 'https://github.com/swlfigo/SYDevSpecs.git'`

* 通过 Cocoapod 安装  pod 'SYSideSlideRefresh'

* 与 `MJRefreh` 相同使用方法

# 更多

1. 自定义UI的 Footer 继承自 `SYMJSideSlideRefreshBackFooter`

2. 滑动与触发刷新逻辑在 `SYMJSideSlideRefreshFooter` ,不建议重写 

4. 没有做头部刷新，因为使用场景不多

# Fatal Error On XCode 10

[Xcode 10 关于 CocoaPods 安装失败的问题](https://juejin.im/post/5ba7a984f265da0a8930308a)


```
RuntimeError - [!] Xcodeproj doesn't know about the following attributes {"inputFileListPaths"=>[], "outputFileListPaths"=>[]} for the 'PBXShellScriptBuildPhase' isa.
```

> 如果 `pod install` 时候出现问题，是因为新 `XCode10` 改了机制.

> 因为项目中使用到了 Run Script Phase, 而 inputFileListPaths 和 outputFileListPaths 是 Xcode 10 中新增的属性, 因此旧版本的 CocoaPods 无法解析. 所以, 最好的解决办法就是升级 CocoaPods.
