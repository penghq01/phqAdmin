const func = {
    //不能为空
    empty(val = "") {
        let isNull = false;
        switch (val) {
            case '':
                isNull = true;
                break;
            case null:
                isNull = true;
                break;
            case 'null':
                isNull = true;
                break;
            case undefined:
                isNull = true;
                break;
            case 'undefined':
                isNull = true;
                break;
            default:
                isNull = false;
                break;
        }
        return isNull;
    },
    //数字
    number(val = 0) {
        let reg = new RegExp(/^[0-9]*$/);
        return reg.test(val);
    },
    //汉字
    chineseChar(val = "") {
        let reg = new RegExp(/^[\u4e00-\u9fa5]{0,}$/);
        return reg.test(val);
    },
    //英文和数字
    atoBAndNum(val = "") {
        let reg = new RegExp(/^[A-Za-z0-9]+$/);
        return reg.test(val);
    },
    //len的所有字符
    lenString(val = "", len = 0) {
        let reg = new RegExp(`^.{${len}}$`);
        return reg.test(val);
    },
    //max的所有字符
    maxString(val = "", max = 0) {
        let reg = new RegExp(`^.{,${max}}$`);
        return reg.test(val);
    },
    //min的所有字符
    minString(val = "", min = 0) {
        let reg = new RegExp(`^.{${min},}$`);
        return reg.test(val);
    },
    //长度为min-max的所有字符
    rangeString(val = "", min = 0, max = 0) {
        let reg = new RegExp(`^.{${min},${max}}$`);
        return reg.test(val);
    },
    //身份证号码
    idNum(code = "") {
        let city = {
            11: "北京",
            12: "天津",
            13: "河北",
            14: "山西",
            15: "内蒙古",
            21: "辽宁",
            22: "吉林",
            23: "黑龙江 ",
            31: "上海",
            32: "江苏",
            33: "浙江",
            34: "安徽",
            35: "福建",
            36: "江西",
            37: "山东",
            41: "河南",
            42: "湖北 ",
            43: "湖南",
            44: "广东",
            45: "广西",
            46: "海南",
            50: "重庆",
            51: "四川",
            52: "贵州",
            53: "云南",
            54: "西藏 ",
            61: "陕西",
            62: "甘肃",
            63: "青海",
            64: "宁夏",
            65: "新疆",
            71: "台湾",
            81: "香港",
            82: "澳门",
            91: "国外 "
        };
        let tip = "";
        let pass = true;

        if (!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)) {
            tip = "身份证号格式错误";
            pass = false;
        } else if (!city[code.substr(0, 2)]) {
            tip = "地址编码错误";
            pass = false;
        } else {
            //18位身份证需要验证最后一位校验位
            if (code.length == 18) {
                code = code.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
                //校验位
                var parity = [1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++) {
                    ai = code[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var last = parity[sum % 11];
                if (parity[sum % 11] != code[17]) {
                    tip = "校验位错误";
                    pass = false;
                }
            }
        }
        return pass;
    },
    //手机号码
    mobile(val = "") {
        let reg = new RegExp(/^1(3|4|5|6|7|8|9)\d{9}$/);
        return reg.test(val);
    },
    //车牌号码，包括新能源
    plate(val = "") {
        let reg = new RegExp(/^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z](([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))$/);
        return reg.test(val);
    },
    //邮件验证
    email(val = ""){
        let reg = new RegExp(/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/); //正则表达式
        return reg.test(val);
    }
};
const funcList = {
    //不能为空
    "empty": "empty",
    //数字
    "number": "number",
    //汉字
    "chineseChar": "chineseChar",
    //英文和数字
    "atoBAndNum": "atoBAndNum",
    //len的所有字符
    "lenString": "lenString",
    //max的所有字符
    "maxString": "maxString",
    //min的所有字符
    "minString": "minString",
    //长度为min-max的所有字符
    "rangeString": "rangeString",
    //身份证号码
    "idNum": "idNum",
    //手机号码
    "mobile": "mobile",
    //车牌号码
    "plate": "plate",
    //邮件验证
    "email":"email"
};
export default {
    funcList,
    valid(data = {}, validInfo = []) {
        let isOK = true;
        let msg = "";
        let key = "";
        for (let index = 0; index < validInfo.length; index++) {
            let item = validInfo[index];
            key = item.name;
            let params = item.param.split("|");
            switch (params[0]) {
                case funcList.empty:
                    isOK = !func.empty(data[item.name]);
                    if (data[item.name] == 0) {
                        isOK = false;
                    }
                    msg = `${item.field_name}不能为空`;
                    break;
                case funcList.number:
                    isOK = func.number(data[item.name]);
                    msg = `${item.field_name}必须是数字`;
                    break;
                case funcList.chineseChar:
                    isOK = func.chineseChar(data[item.name]);
                    msg = `${item.field_name}必须是汉字`;
                    break;
                case funcList.atoBAndNum:
                    isOK = func.atoBAndNum(data[item.name]);
                    msg = `${item.field_name}只能是英文和数字`;
                    break;
                case funcList.lenString:
                    isOK = func.lenString(data[item.name], params[1]);
                    msg = `${item.field_name}的长度必须是${params[1]}位`;
                    break;
                case funcList.maxString:
                    isOK = func.maxString(data[item.name], params[1]);
                    msg = `${item.field_name}的长度最多${params[1]}位`;
                    break;
                case funcList.minString:
                    isOK = func.minString(data[item.name], params[1]);
                    msg = `${item.field_name}的长度最少${params[1]}位`;
                    break;
                case funcList.rangeString:
                    isOK = func.rangeString(data[item.name], params[1], params[2]);
                    msg = `${item.field_name}的长度最少${params[1]}位，最多${params[2]}位`;
                    break;
                case funcList.idNum:
                    isOK = func.idNum(data[item.name]);
                    if (func.empty(item.field_name)) {
                        msg = `身份证不合法`;
                    } else {
                        msg = `${item.field_name}不合法`;
                    }
                    break;
                case funcList.mobile:
                    isOK = func.mobile(data[item.name]);
                    if (func.empty(item.field_name)) {
                        msg = `手机号码不合法`;
                    } else {
                        msg = `${item.field_name}不合法`;
                    }
                    break;
                case funcList.plate:
                    isOK = func.plate(data[item.name]);
                    if (func.empty(item.field_name)) {
                        msg = `车牌号码不合法`;
                    } else {
                        msg = `${item.field_name}不合法`;
                    }
                    break;
                case funcList.email:
                    isOK = func.email(data[item.name]);
                    if (func.empty(item.field_name)) {
                        msg = `电子邮件不合法`;
                    } else {
                        msg = `${item.field_name}不合法`;
                    }
                    break;
                default:
                    isOK = true;
                    break;
            }
            if (!isOK) {
                break;
            }
        }
        return {"status": isOK, "msg": msg, "key": key};
    },
    getValidInfo(name = "", funcName = "", fieldName = "", param = "") {
        return {"name": name, "param": `${funcName}|${param}`, "field_name": fieldName};
    }
}
