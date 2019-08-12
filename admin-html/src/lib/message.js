import global from './global'
import util from './utils'

const loading = {
  show (text = '加载中') {
    layx.load('loadId', text);
  },
  hide () {
    layx.destroy('loadId');
  }
}
const msg = {
  info (text = '') {
    !util.empty(text) && global._this.$message(text);
  },
  success (text = '') {
    !util.empty(text) && global._this.$message({
      type: 'success',
      message: text
    })
  },
  warning (text = '') {
    !util.empty(text) && global._this.$message({
      type: 'warning',
      message: text
    })
  },
  error (text = '') {
    !util.empty(text) && global._this.$message.error(text);
  }
};
const alert = (text = '', { title = '提示', okName = '确认',okFunction=()=>{}}) => {
  global._this.$alert(text,title,{
    confirmButtonText:okName,
    callback:action=>{
       okFunction(action);
    }
  });
};
const confirm = (text = '', {type="warning",title = '提示', cancelName = '取消', okName = '确认' ,okFunction=()=>{},cancelFunction=()=>{}}) => {
  global._this.$confirm(text,title, {
    confirmButtonText: okName,
    cancelButtonText: cancelName,
    type:type
  }).then(() => {
    okFunction();
  }).catch(() => {
    cancelFunction();
  });
};
const iframe = (url = '', title = '', icon = 'h-icon-menu') => {
  layx.iframe('shadow', title, url, {
    skin: 'asphalt',
    shadable: true,//阻隔窗口
    minMenu: false,//不显示最小化按钮
    icon: ' <i class="' + icon + '"></i>'
  })
}

export default {
  loading, msg, alert, confirm, prompt, iframe
}
