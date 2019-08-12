export default {
  empty (val = '') {
    let res = false;
    switch (val) {
      case '':
        res = true;
        break;
      case null:
        res = true;
        break;
      case 'null':
        res = true;
        break;
      case ' ':
        res = true;
        break;
      case undefined:
        res = true;
        break;
      case 'undefined':
        res = true;
        break
    }
    return res
  },
  NewObject(object={}){
    return JSON.parse(JSON.stringify(object));
  },
  UnixToDateTime(time=0,format="Y-m-d H:i:s") {
    let date = new Date(time*1000);
    let Y = date.getFullYear();
    let m = date.getMonth() + 1;
    let d = date.getDate();
    let H=date.getHours();
    let i=date.getMinutes();
    let s=date.getSeconds();
    m=m<10?"0"+m:m;
    d=d<10?"0"+d:d;
    H=H<10?"0"+H:H;
    i=i<10?"0"+i:i;
    s=s<10?"0"+s:s;
    let str=format.replace(/Y/g,Y);
    str=str.replace(/m/g,m);
    str=str.replace(/d/g,d);
    str=str.replace(/H/g,H);
    str=str.replace(/i/g,i);
    str=str.replace(/s/g,s);
    return str;
  },
  GetDateTime(addDays=0,format="Y-m-d H:i:s"){
    let myDate= new Date();
    if(addDays !=0 ){
      myDate.setDate(myDate.getDate()+addDays);
    }
    let Y=myDate.getFullYear();    //获取完整的年份(4位,1970-????)
    let m=myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
    let d=myDate.getDate();        //获取当前日(1-31)
    //myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
    //myDate.getTime();        //获取当前时间(从1970.1.1开始的毫秒数)
    let H=myDate.getHours();       //获取当前小时数(0-23)
    let i=myDate.getMinutes();     //获取当前分钟数(0-59)
    let s=myDate.getSeconds();     //获取当前秒数(0-59)
    //myDate.getMilliseconds();    //获取当前毫秒数(0-999)
    let str=format.replace(/Y/g,Y);
    str=str.replace(/m/g,m);
    str=str.replace(/d/g,d);
    str=str.replace(/H/g,H);
    str=str.replace(/i/g,i);
    str=str.replace(/s/g,s);
    return str;
  }
}
