<template>
    <div class="icon">

        <div class="add-icon" v-if="!isSelect">
            <el-button type="primary" @click="opened=true">添加</el-button>
        </div>

        <div class="icon-list">
            <span :class="item.icon" v-for="(item,index) in iconList" :key="index">
                 <span class="del" v-if="!isSelect">
                      <Poptip
                              transfer
                              confirm
                              title="确定删除吗?"
                              @on-ok="del(item)">
                       <el-button type="danger" size="mini">删除</el-button>
                      </Poptip>
                 </span>
                 <span class="select" v-if="isSelect">
                     <el-button type="primary" size="mini" @click="iconSelect(item.icon)">选择</el-button>
                 </span>
            </span>
        </div>
        <Paging v-model="pageData" @change="pageChange"></Paging>
        <myDialog
                title="添加图标"
                :is-show="opened"
                :close="close"
                close-title="取 消"
                :ok-click="add"
                ok-title="添 加"
        >
            <div class="input-div">
                <el-input v-model="addIcon.icon" placeholder="图标样式（必填）"/>
            </div>
            <div class="input-div">
                <el-input v-model="addIcon.title" placeholder="图标名称（可选）"/>
            </div>
        </myDialog>
    </div>
</template>

<script>
    import http from "../lib/http";
    import utils from "../lib/utils";
    import message from "../lib/message";

    export default {
        name: "Icon",
        props: {
            isSelect: {
                type: Boolean,
                default: false
            }
        },
        data() {
            return {
                opened: false,
                iconList: [],
                addIcon: {},
                pageData:{
                    page:1,
                    page_size:50,
                    total_count:0
                }
            }
        },
        mounted() {
            this.getIconList();
        },
        methods: {
            getIconList() {
                message.loading.show();
                http.post(`icon/list/${this.pageData.page_size}/${this.pageData.page}`).then(data => {
                    this.iconList = data.data;
                    this.pageData=data.paginate;
                }).catch(err => {
                })
            },
            del(item) {
                message.loading.show("正在删除");
                http.post("icon/del", {"id": item.id}).then(() => {
                    this.iconList.splice(this.iconList.indexOf(item), 1);
                }).catch(err => {
                });
            },
            add() {
                if (utils.empty(this.addIcon.icon)) {
                   message.msg.error("图标样式不能为空");
                    return;
                }
                message.loading.show("添加中");
                http.post("icon/add", this.addIcon).then(data => {
                    this.close();
                    this.iconList.unshift(data);
                }).catch(err => {
                });
            },
            close() {
                this.opened = false;
                this.addIcon = {};
            },
            iconSelect(icon) {
                this.$emit("on-select", icon);
            },
            pageChange() {
                this.getIconList();
            },
        }
    }
</script>

<style scoped lang="scss">
    .add-icon {
        padding: 10px;
    }

    .icon-list{
        display:flex;
        justify-content:flex-start;
        align-items: center;
        flex-wrap: wrap;
        &>span {
            transition:all 1s ease-out;
            display:flex;
            justify-content: center;
            align-items: center;
            font-size: 60px;
            width: 100px;
            height: 100px;
            padding: 10px;
            background-color: #F1F1F1;
            margin: 5px;
            position: relative;

            & > span {
                display: none;
                position: absolute;
               top:0;
            }

            &:hover {
                & > span {
                    display: block;
                }

                background-color: #8A8A8A;
            }
        }
    }
</style>
