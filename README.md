# -百思不得姐-
项目名称：百思不得姐		 项目时长：2015/12 – 2016/2
软件环境：Mac OSX 10.10.5       硬件环境：MacPro        开发工具：Xcode   7.1
项目描述：一款高仿的百思不得姐项目,主要针对搞笑段子视频音频的分享。最大的娱乐创意社区，                    致力于提供各种搞笑、萌、动漫、幽默图片，汇聚大量的超火爆、超级冷、高笑点的段子。
描述：根据设计文档文档的需求，完成了UI界面搭建，通过UITableView优化了相关性能。程序主要运用代码加xib的方式完成，更加灵活自如。用到了自动布局 auto Layout，以及ios8自动计算cell高度等相关技术。项目中用到了MJExtension,MJRefresh,AFN,SDWebImage等主流框架，使相关代码更加精简，性能更加流畅稳定。根据开发文档请求服务器，获得相关返回结果，通过MVC模式完美的展示在界面上。界面简单运行流畅，目前还比较稳定，后续将陆续加入音频和视频相关功能，从而提高软件的易用性。
主要技术： 1.自定义UITabbarController  和UINavigationController以及相关的子控制器
                  2.使用SdWebImage进行图片缓存，AFN加载网络请求 ,MJExtension实现精简字典转模型相           
                    关过程，MJRrfresh实现上拉下拉刷新功能
                    3.项目中还用到了pop实现相关spring动画，SVProgressHUD等相关第三方框架的使用         
                   使程序代码更精简流畅
                    4.通过MVC使得精华和新帖界面UI更加简洁流畅，良好的解除了耦合度，cell通过xib                                 
                   创建以auto layout方式使程序更加简洁美观
                5.相关常量和宏的抽取，以及Other里面对UiView,NSDate相关分类的封装使得程序更加                                         
                  具有扩展性，方便以后的改动和相关功能的完善。
                6.Cocoa Pods的使用使程序更容易管理维护

