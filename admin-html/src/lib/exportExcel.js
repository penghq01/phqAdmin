import message from "./message";
import http from "./http";
import {MessageBox} from 'element-ui';

function ExportExcel(tHeader = [], filterVal = [], excelData = [], fileName) {
    import('@/vendor/Export2Excel').then(excel => {
        const datas = FormatJson(filterVal, excelData);
        excel.export_json_to_excel({
            header: tHeader,
            data:datas,
            filename: fileName,
        });
        message.loading.hide();
    });
}

function FormatJson(filterVal, jsonData) {

    jsonData.map(v => filterVal.map(j => v[j]));

    return jsonData.map(v => filterVal.map(j => v[j]))

}
//formatArr[{fieldName：字段名，name：字段的中文名，handle：处理函数 }]
export default {
    /*
    * fieldName：字段名
    * name：字段的中文名
    * handle：处理函数
    **/
    field(nickName,fieldName, handle = val => {
        return val
    }) {
        return {
            "field_name": fieldName,
            "name": nickName,
            "handle": handle
        };
    },
    /*
    *formatArr：field数组
    **/
    excelHandle(url, formatArr = [], {params = {}, fileName = "WEB导出Excel数据", showIndex = false, indexName = "序号",pageSize=10,page=1}={}) {
        MessageBox.prompt(`您要导出几页数据（每页${pageSize}条，从当前页开始导出）？请输入页数`, '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
        }).then(({value}) => {
            let size = parseInt(value);
            if (size > 0) {
                message.loading.show("数据加载中……，请耐心等待");
                let page_size = size * pageSize;
                http.post(`${url}/${page_size}/${page}`,params).then(data => {
                    message.loading.hide();
                    let excelData = [];
                    if (data.data instanceof Array && data.data.length > 0) {
                        message.loading.show("数据处理中……，请耐心等待");
                        let tHeader = []
                        let filterVal = []
                        if (showIndex) {
                            tHeader.push(indexName)
                            filterVal.push("serialNumber")
                        }
                        formatArr.forEach((field, index) => {
                            tHeader.push(field.name)
                            filterVal.push(`${field.field_name}_${index}`)
                        })
                        data.data.forEach((row, serialNumber) => {
                            let tem = {};
                            if (showIndex) {
                                tem["serialNumber"]=serialNumber+1;
                            }
                            formatArr.forEach((field, index) => {
                                let field_name = field.field_name;
                                let nameArr = field_name.split("|")
                                let fieldVal="";
                                if (nameArr.length > 1) {
                                    let handleParams = []
                                    nameArr.forEach(paramsField => {
                                        let objArr =  paramsField.split(".");
                                        if(objArr.length>1){
                                            let paramsObjData=null;
                                            objArr.forEach(obj=>{
                                                if(paramsObjData == null){
                                                    paramsObjData=row[obj];
                                                }else{
                                                    paramsObjData = paramsObjData[obj];
                                                }
                                            });
                                            handleParams.push(paramsObjData)
                                        }else{
                                            handleParams.push(row[paramsField])
                                        }

                                    });
                                    fieldVal=field.handle(handleParams);
                                } else {
                                    let objArr =  field_name.split(".");
                                    if(objArr.length>1){
                                        let paramsObjData=null;
                                        objArr.forEach(obj=>{
                                            if(paramsObjData == null){
                                                paramsObjData=row[obj];
                                            }else{
                                                paramsObjData = paramsObjData[obj];
                                            }
                                        });
                                        fieldVal=field.handle(paramsObjData);
                                    }else{
                                        fieldVal=field.handle(row[field_name]);
                                    }
                                }
                                tem[`${field_name}_${index}`]=fieldVal;
                            })
                            excelData.push(tem);
                        });
                        ExportExcel(tHeader, filterVal, excelData, fileName);
                    } else {
                        message.msg.info("没有获取到数据");
                    }
                }).catch(err => {
                    message.loading.hide();
                });
            } else {
                message.msg.error("最少导出一页数据");
            }
        }).catch(() => {
        });
    },
}
