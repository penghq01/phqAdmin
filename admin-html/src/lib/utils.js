import moment from "moment"
//http://momentjs.cn/ 时间计算库网址
export default {
  empty (val = '') {
    let res = false;
    switch (val) {
      case "":
        res = true;
        break;
      case null:
        res = true;
        break;
      case 'null':
        res = true;
        break;
      case " ":
        res = true;
        break;
      case undefined:
        res = true;
        break;
      case "undefined":
        res = true;
        break;
      default:
        res=false;
        break
    }
    return res
  },
  NewObject(object={}){
    return JSON.parse(JSON.stringify(object));
  },
  //获取 Unix 时间戳 (秒)
  GetDateTimeUnix(){
    return moment().unix();
  },
  //获取 Unix 时间戳 (毫秒)
  GetDateTimeTimestamp(){
    return moment().valueOf();
  },
  //格式化 Unix 时间戳 (毫秒)为指定格式日期时间
  TimestampToDateTime(time=0,format="YYYY-MM-DD HH:mm:ss") {
    return moment(time).format(format);
  },
  //格式化 Unix 时间戳 (秒)为指定格式日期时间
  UnixToDateTime(time=0,format="YYYY-MM-DD HH:mm:ss") {
    return moment.unix(time).format(format);
  },
  //获取指定格式的日期时间
  DateTimeFormat(dateString="",format="YYYY-MM-DD HH:mm:ss"){
    if(this.empty(dateString)){
      return moment().format(format);
    }else{
      return moment(dateString).format(format);
    }
  },
  //计算date1和date2相差天数
  DateDiff(date1, date2) {
    let a = moment(date1);
    let b = moment(date2);
    let day;
    day=a.diff(b,"days");
    return day;
  },
}
