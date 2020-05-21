# 后台管理系统

#### 介绍
使用go语言开发的前后端分离web管理后台，前端采用vue-cli3.x,Element开源UI框架，数据库支持Mysql和sqlite3可以在配置文件设置，可一键编译为Electron应用（PC客户端）
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
1. 安装Vue开发环境，安装教程百度上面有很多，这里就不给出连接啦。
2. 安装golang开发环境，同上安装教程百度上面有很多，这里就不给出连接啦。
3. 下载源码到本地,下载地址：<a href="https://gitee.com/cgrj/phqAdmin" target="_blank">https://gitee.com/cgrj/phqAdmin</a>
4. 如果使用Mysql数据库，请安装Mysql数据库
5. 安装beego协助快速开发工具bee，安装教程：<a href="https://beego.me/docs/install/bee.md" target="_blank">点击这里</a>

#### 后端打包和运行
  1. bee安装好之后打开cmd窗口进入到server目录下
  2. 开发运行 
  ``bee run``
 3. 打包请参考：<a href="https://beego.me/docs/install/bee.md" target="_blank">点击这里</a>
#### 前端打包和运行
  1. npm环境安装好之后打开cmd窗口进入到admin-html目录下,执行命令安装依赖
  ``npm install``
  
  2. 开发运行命令  
  
      * WEB端运行 ``npm run serve``
     * PC 端运行  ``npm run electron:serve``
    
  3. 打包  
  
     * WEB端打包   ``npm run build``
     * PC 端打包  ``npm run electron:build``
  4. 后端和前端都成功运行之后在浏览器输入http://localhost:8080/admin 即可看到运行效果
  
#### 部署
 应用部署可以看这里： <a href="https://beego.me/docs/deploy/" target="_blank">点击查看部署</a>

#### 演示
0. 服务器带宽低，打开有点慢，请见谅
1. 演示地址：[http://www.cgrj.top/admin/](http://www.cgrj.top/admin/)
2. PC客户端演示版下载  
    * 解压缩版（.rar）：<a href="http://www.cgrj.top/phq_admin_pc.rar" target="_blank">下载</a> 
      
    * 安装包版（.exe）：<a href="http://www.cgrj.top/phq_admin_pc.exe" target="_blank">下载</a> 
3. 账号密码：admin  123456  该账号为测试账号只有部分功能 
####图片预览

|WEB端|PC端|
|--|--|
| ![登录](http://www.cgrj.top/admin-img/web/000.jpg)| ![000](http://www.cgrj.top/admin-img/pc/000.jpg) |
| ![路由权限管理](http://www.cgrj.top/admin-img/web/001.jpg)| ![001](http://www.cgrj.top/admin-img/pc/001.jpg) |
| ![路由权限修改](http://www.cgrj.top/admin-img/web/002.jpg)| ![002](http://www.cgrj.top/admin-img/pc/002.jpg) |
| ![选择图标](http://www.cgrj.top/admin-img/web/003.jpg)| ![003](http://www.cgrj.top/admin-img/pc/003.jpg)  |
| ![数据权限管理](http://www.cgrj.top/admin-img/web/004.jpg) | ![004](http://www.cgrj.top/admin-img/pc/004.jpg) |
| ![数据权限修改](http://www.cgrj.top/admin-img/web/005.jpg) | ![005](http://www.cgrj.top/admin-img/pc/005.jpg) |
| ![管理员管理](http://www.cgrj.top/admin-img/web/006.jpg) | ![006](http://www.cgrj.top/admin-img/pc/006.jpg)  |
| ![角色修改](http://www.cgrj.top/admin-img/web/007.jpg) | ![007](http://www.cgrj.top/admin-img/pc/007.jpg)  |
| ![图片管理](http://www.cgrj.top/admin-img/web/008.jpg) | ![008](http://www.cgrj.top/admin-img/pc/008.jpg) |
| ![图片预览](http://www.cgrj.top/admin-img/web/009.jpg) | ![009](http://www.cgrj.top/admin-img/pc/009.jpg) |
| ![图标管理](http://www.cgrj.top/admin-img/web/010.jpg) | ![010](http://www.cgrj.top/admin-img/pc/010.jpg) |
| ![011](http://www.cgrj.top/admin-img/web/011.jpg) | ![011](http://www.cgrj.top/admin-img/pc/011.jpg) |
| ![012](http://www.cgrj.top/admin-img/web/012.jpg) | ![012](http://www.cgrj.top/admin-img/pc/012.jpg) |



