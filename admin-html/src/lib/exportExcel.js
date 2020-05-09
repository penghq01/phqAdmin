import message from "./message";
import http from "./http";
import {MessageBox} from 'element-ui';

function ExportExcel(tHeader = [], filterVal = [], excelData = [], fileName) {
    import('@/vendor/Export2Excel').then(excel => {
        const data = FormatJson(filterVal, excelData);
        excel.export_json_to_excel({
            header: tHeader,
            data,
            filename: fileName,
        });
    });
}

function FormatJson(filterVal, jsonData) {

    jsonData.map(v => filterVal.map(j => v[j]));

    return jsonData.map(v => filterVal.map(j => v[j]))

}

export default {
    //fieldName：字段名，name：字段的中文名，handle：处理函数
    field(fieldName, name, handle = val => {
        return val
    }) {
        return {
            "field_name": fieldName,
            "name": name,
            "handle": handle
        };
    },
    excelHandle(url, formatArr = [], {params = {}, fileName = "WEB导出Excel数据", showIndex = false, indexName = "序号",pageSize=10}={}) {
        MessageBox.prompt('您要导出几页数据？请输入数量', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
        }).then(({value}) => {
            let size = parseInt(value);
            if (size > 0) {
                message.loading.show("数据加载中……，请耐心等待");
                let page_size = size * pageSize;
                http.post(`${url}/${page_size}/1`,params).then(data => {
                    message.loading.hide();
                    let excelData = [];
                    if (data.data.length > 0) {
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
                                        handleParams.push(row[paramsField])
                                    });
                                    fieldVal=field.handle(handleParams);
                                } else {
                                    fieldVal=field.handle(row[field_name]);
                                }
                                tem[`${field_name}_${index}`]=fieldVal;
                            })
                            excelData.push(tem);
                        });
                        message.loading.hide();
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
