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
      '/admin-api': {
        target: 'http://localhost:8181/', // 域名
        ws: true, // 是否启用websockets
        changOrigin: true, //开启代理：在本地会创建一个虚拟服务端，然后发送请求的数据
        pathRequiresRewrite: {
          '^/admin-api': '/'
        }
      }
    }
  },
  assetsDir: 'static'
};
