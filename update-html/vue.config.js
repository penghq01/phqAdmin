module.exports = {
  lintOnSave: false,
  css: {
    loaderOptions: {
      sass: {
        data: `@import "src/lib/scss/element-color.scss";`
      }
    }
  },
  devServer: {
    // 设置代理
    proxy: {
      /*'/update/api': {
        target: 'http://localhost:50635/', // 域名
        ws: true, // 是否启用websockets
        changOrigin: true, //开启代理：在本地会创建一个虚拟服务端，然后发送请求的数据
        pathRequiresRewrite: {
          '^/update/api': '/'
        }
      },*/
      '/update/api': {
        target: 'http://www.cgrj.top/', // 域名
        ws: true, // 是否启用websockets
        changOrigin: true, //开启代理：在本地会创建一个虚拟服务端，然后发送请求的数据
        pathRequiresRewrite: {
          '^/update/api': '/'
        }
      }
    }
  },
    //静态资源目录
  assetsDir: 'update',
  //编译后访问目录
  publicPath: '/update',
  //编译输出目录
  outputDir:"./dist/update",
};
