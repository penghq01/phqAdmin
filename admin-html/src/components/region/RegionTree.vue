<template>
    <div class="region-tree">
        <div class="page-action" v-show="!select">
            <div>
                <el-button type="primary" icon="el-icon-plus" @click="showDrawer()">添加</el-button>
                <el-button type="warning" icon="el-icon-edit-outline" @click="showDrawer(true)">修改</el-button>
                <Popconfirm @ok="del"></Popconfirm>
            </div>
        </div>
        <div v-if="uiAuth._admin_api_region_list">
            <vxe-table
                    :height="bodyHeight-50"
                    border
                    show-overflow
                    row-key
                    row-id="code"
                    @radio-change="tableRowChangeEvent"
                    @cell-dblclick="cellDblClick"
                    @cell-click="tableRowChangeEvent"
                    :radio-config="{highlight: true}"
                    highlight-hover-row
                    ref="xTreeRegion"
                    :data="dataList"
                    :tree-config="treeConfig">
                <vxe-table-column tree-node>
                    <template #header>
                        <div>
                            <el-button type="text" @click="clearRadioRowEevnt" :disabled="!selectTableRow">取消选择
                            </el-button>
                            <span> 行政区划名称</span>
                        </div>
                    </template>
                    <template v-slot="{row}">
                        <div class="region-tree-name">{{row.name}}</div>
                    </template>
                </vxe-table-column>
                <vxe-table-column title="行政区划代码" field="code" width="120" :visible="!select"></vxe-table-column>
                <vxe-table-column title="排序" field="sort" width="60" :visible="!select"></vxe-table-column>
            </vxe-table>
        </div>
        <el-drawer
                ref="drawer"
                :title="`${isEdit?'修改':'添加'}行政区划`"
                :visible.sync="drawerShow"
                size="60%"
                direction="rtl"
                :before-close="drawerHandleClose">
            <div>
                <el-form :model="params" :rules="rules" ref="paramsForm">
                    <el-form-item v-show="!isEdit" label="所属上级：">
                        {{this.selectTableRow?this.selectTableRow.name:'顶级'}}
                    </el-form-item>
                    <el-form-item label="名称" prop="name">
                        <el-input v-model="params.name"></el-input>
                    </el-form-item>
                    <el-form-item label="代码" prop="code">
                        <el-input v-model="params.code"></el-input>
                    </el-form-item>
                    <el-form-item label="排序">
                        <el-input v-model="params.sort"></el-input>
                    </el-form-item>
                    <el-form-item style="text-align:center">
                        <el-button type="primary" @click="isEdit?edit():add()">{{isEdit?'修改':'添加'}}</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </el-drawer>
    </div>
</template>

<script>
    import {mapState} from "vuex";
    import http from "../../lib/http";
    import utils from "../../lib/utils";
    import message from "../../lib/message";

    const defaultParams = {code: "", name: "", parent_code: defaultCode, sort: 0};
    const defaultCode="5303";
    // loadData
    export default {
        name: "RegionTree",
        props: {
            select: {
                type: Boolean,
                default: false
            },
            bodyHeight: {
                type: Number,
                default: 0,
            }
        },
        computed: {...mapState(["uiAuth"])},
        data() {
            return {
                dataList: [],
                selectTableRow: null,//选择行
                drawerShow: false, //抽屉是否显示
                isEdit: false,
                isSee: false,
                params: utils.NewObject(defaultParams),
                treeConfig: {
                    lazy: true,
                    children: 'children',
                    line: true,
                    hasChild: 'hasChild',
                    loadMethod: this.loadData,
                    iconOpen: 'fa fa-minus-square-o',
                    iconClose: 'fa fa-plus-square-o',
                    iconLoaded: 'el-icon-loading'
                },
                rules: {
                    name: [
                        {required: true, message: '请输入行政区划名称', trigger: 'blur'}
                    ],
                    code: [
                        {required: true, message: '请输入行政区划代码', trigger: 'blur'}
                    ]
                }
            }
        },
        mounted() {
            this.getDataList();
        },
        methods: {
            //获取数据
            getDataList(parent_code = defaultCode) {
                http.post("region/list", {"parent_code": parent_code}).then(data => {
                    data.forEach(item => item.hasChild = true);
                    this.dataList = data;
                }).catch(err => {
                })
            },
            //懒加载
            loadData({row}) {
                return new Promise((resolve, reject) => {
                    http.post("region/list", {"parent_code": row.code}).then(data => {
                        data.forEach(item => item.hasChild = true);
                        resolve(data);
                    }).catch(err => {
                        row.hasChild = false;
                        resolve([]);
                        /*if (this.select) {
                            this.$emit("change", this.selectTableRow);
                        }*/
                    })
                })
            },
            //单选行事件
            tableRowChangeEvent({row, rowIndex}) {
                this.selectTableRow = row;
                let xTreeRegion = this.$refs.xTreeRegion
                xTreeRegion.setRadioRow(row);
               // xTreeRegion.toggleTreeExpand(row);
                if (this.select) {
                    /*if (!row.hasChild) {
                        this.$emit("change", this.selectTableRow);
                    }*/
                    this.$emit("change", this.selectTableRow);
                }
            },
            //双击事件
            cellDblClick({row, rowIndex}) {
                this.selectTableRow = row;
                let xTreeRegion = this.$refs.xTreeRegion
                xTreeRegion.setRadioRow(row);
                if (this.select) {
                    /*xTreeRegion.toggleTreeExpand(row);
                    if (!row.hasChild) {
                        this.$emit("change", this.selectTableRow);
                    }*/
                    this.$emit("change", this.selectTableRow);
                }
            },
            //取消选择
            clearRadioRowEevnt() {
                this.selectTableRow = null
                this.$refs.xTreeRegion.clearRadioRow();
                if (this.select) {
                    this.$emit("change", null);
                }

            },
            //Drawer抽屉关闭回调
            drawerHandleClose(done) {
                done();
                this.isEdit = false;
                this.drawerShow = false;
                this.isSee = false;
                this.params = utils.NewObject(defaultParams);
                this.$refs.paramsForm.resetFields();
            },
            //显示抽屉
            showDrawer(isEdit = false) {
                this.isEdit = isEdit;
                this.drawerShow = true;
                this.params.parent_code = defaultCode;
                if (this.selectTableRow != null) {
                    this.params.parent_code = this.selectTableRow.code;
                }
                if (isEdit) {
                    this.params.parent_code = this.selectTableRow.parent_code;
                    this.params.name = this.selectTableRow.name;
                    this.params.code = this.selectTableRow.code;
                    this.params.sort = this.selectTableRow.sort;
                }
            },
            add() {
                this.$refs.paramsForm.validate((valid) => {
                    if (valid) {
                        message.loading.show("添加中");
                        this.params.sort = parseInt(this.params.sort);
                        http.post("region/add", this.params).then(data => {
                            data.hasChild = false;
                            if (this.selectTableRow == null) {
                                if (utils.empty(this.dataList)) {
                                    this.dataList = [data];
                                } else {
                                    this.dataList.unshift(data);
                                }
                            } else {
                                if(utils.empty(this.selectTableRow.children)){
                                    this.$set(this.selectTableRow,"children",[data]);
                                }else{
                                    this.selectTableRow.children.unshift(data);
                                }
                                this.$refs.xTreeRegion.setTreeExpand(this.selectTableRow, true);
                            }
                            this.params = utils.NewObject(defaultParams);
                            this.$refs.paramsForm.resetFields();
                        }).catch(err => {
                        });
                    }
                });
            },
            edit() {
                this.$refs.paramsForm.validate((valid) => {
                    if (valid) {
                        message.loading.show("修改中");
                        this.params.sort = parseInt(this.params.sort);
                        http.post("region/edit", this.params).then(data => {
                            this.selectTableRow.name = data.name;
                            this.selectTableRow.code = data.code;
                            this.selectTableRow.sort = data.sort;
                            this.$refs.drawer.closeDrawer();
                        }).catch(err => {
                        });
                    }
                });
            },
            del() {
                if (this.selectTableRow == null) {
                    message.msg.error("请选择要删除的行政区划");
                    return;
                }
                if (!utils.empty(this.selectTableRow.children) && this.selectTableRow.children.length > 0) {
                    message.msg.error("行政区划存在下级行政区划，不能删除");
                    return;
                }
                message.loading.show("删除中");
                http.post("region/del", {"code": this.selectTableRow.code}).then(data => {
                    this.delTreeItem(this.dataList, this.selectTableRow.code);
                    this.selectTableRow = null;
                }).catch(err => {
                });

            },
            //删除树中的指定项
            delTreeItem(treeList = [], code = '0') {
                treeList.forEach((item, index) => {
                    if (item.code == code) {
                        treeList.splice(index, 1);
                    } else {
                        if (!utils.empty(item.children) && item.children.length > 0) {
                            this.delTreeItem(item.children, code);
                        }
                    }
                });
            },
            //添加节点到指定树中
            addTreeItem(treeList = [], code, data) {
                treeList.forEach((item, index) => {
                    if (item.code == code) {
                        item.hasChild = true;
                        if (!utils.empty(item.children) && item.children.length > 0) {
                            item.children.unshift(data);
                        } else {
                            this.$set(item, "children", [data])
                        }
                    } else {
                        if (!utils.empty(item.children) && item.children.length > 0) {
                            this.addTreeItem(item.children, code, data);
                        }
                    }
                });
            }
        }
    }
</script>
<style scoped lang="scss">
    .region-tree {
        &-name {
            display: inline-block;
            padding-left: 0;
        }
    }
</style>
