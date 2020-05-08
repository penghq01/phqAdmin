import util from './utils'
import { Message } from 'element-ui';
import { MessageBox } from 'element-ui';
import { Loading } from 'element-ui';
var loadingInstance=null;
const loading = {
  show (text = '加载中',background="rgba(255,255,255,0.7)") {
    loadingInstance=Loading.service({
      text:text,
      background:background
    });
  },
  hide () {
    if(loadingInstance!=null){
      loadingInstance.close();
      loadingInstance=null;
    }

  }
};
const msg = {
  info (text = '') {
    !util.empty(text) && Message(text);
  },
  success (text = '') {
    !util.empty(text) &&Message({
      type: 'success',
      message: text
    })
  },
  warning (text = '') {
    !util.empty(text) && Message({
      type: 'warning',
      message: text
    })
  },
  error (text = '') {
    !util.empty(text) && Message({
      type: 'error',
      message: text
    })
  }
};
const alert = (text = '', { title = '提示', okName = '确认',okFunction=()=>{}}) => {
  MessageBox.alert(text,title,{
    confirmButtonText:okName,
    callback:action=>{
      okFunction(action);
    }
  });
};
const  confirm =(text = '', {type="warning",title = '提示', cancelName = '取消', okName = '确认' ,okFunction=()=>{},cancelFunction=()=>{}})=>{
  return MessageBox.confirm(text,title, {
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

};

export default {
  loading, msg, alert, confirm, prompt, iframe
}
