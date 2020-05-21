# 后台管理系统

#### 介绍
使用go语言开发的前后端分离web管理后台，前端采用vue-cli3.x,Element开源UI框架，数据库支持Mysql和sqlite3可以在配置文件设置，可一键编译为Electron PC
客户端
#### 软件框架
1. 后端数据接口使用的beego MVC开源框架
2. ORM使用的xorm开源框架
3. vue-cli3.x脚手架
4. Element开源UI框架

#### 内置功能
1. 管理员管理（管理可登录后台操作的账号）
2. 角色管理（管理管理员可操作的页面，对应按钮的功能）
3. 路由权限管理（控制前端显示的菜单）
4. 数据权限管理（控制系统的数据接口）
5. 数据备份恢复（可备份恢复数据，下载备份）
6. 图片管理（分类管理已上传的图片，同一张图片可多处使用，避免重复上传图片）
7. 图标管理（管理后端使用的的各种图标）
8. 用户管理（该处是管理前端的用户）
9. 文件上传（各种文件上传）
10. Excel文件导出（可支持批量导出数据到Excel文件，只需调用一个函数即可，简单快捷）
11. Excel文件导入（可导入Excel文件到数据库任何表，只需在配置文件中添加要导入表字段类型的json文件，简单快捷）

#### 安装教程

1. 下载源码到本地,下载地址：[https://gitee.com/cgrj/phqAdmin](https://gitee.com/cgrj/phqAdmin)
2. 如果使用Mysql数据库，先安装数据库
3. 安装beego开发工具bee,安装教程[点击这里](https://beego.me/docs/install/bee.md)
4. 安装Vue开发环境，百度上很多

#### 演示
1. 演示地址：[http://www.cgrj.top/admin/](http://www.cgrj.top/admin/)
2. 账号密码：admin  123456  该账号为测试账号只有部分功能 

####WEB版图片预览

![登录](http://www.cgrj.top/admin-img/web/000.jpg)

![路由权限管理](http://www.cgrj.top/admin-img/web/001.jpg) |

![路由权限修改](http://www.cgrj.top/admin-img/web/002.jpg) 

![选择图标](http://www.cgrj.top/admin-img/003/web.jpg) 

![数据权限管理](http://www.cgrj.top/admin-img/web/004.jpg) 

![数据权限修改](http://www.cgrj.top/admin-img/web/005.jpg) 

![管理员管理](http://www.cgrj.top/admin-img/web/006.jpg) 

![角色修改](http://www.cgrj.top/admin-img/web/007.jpg) 

![图片管理](http://www.cgrj.top/admin-img/web/008.jpg) 

![图片预览](http://www.cgrj.top/admin-img/web/009.jpg) 

![图标管理](http://www.cgrj.top/admin-img/web/010.jpg) 

####PC版图片预览

![000](http://www.cgrj.top/admin-img/pc/000.jpg)

![001](http://www.cgrj.top/admin-img/pc/001.jpg)

![002](http://www.cgrj.top/admin-img/pc/002.jpg) 

![003](http://www.cgrj.top/admin-img/pc/003.jpg) 

![004](http://www.cgrj.top/admin-img/pc/004.jpg) 

![005](http://www.cgrj.top/admin-img/pc/005.jpg)
 
![006](http://www.cgrj.top/admin-img/pc/006.jpg) 

![007](http://www.cgrj.top/admin-img/pc/007.jpg) 

![008](http://www.cgrj.top/admin-img/pc/008.jpg)
 
![009](http://www.cgrj.top/admin-img/pc/009.jpg) 

![010](http://www.cgrj.top/admin-img/pc/010.jpg)

![011](http://www.cgrj.top/admin-img/pc/011.jpg)

![012](http://www.cgrj.top/admin-img/pc/012.jpg)
