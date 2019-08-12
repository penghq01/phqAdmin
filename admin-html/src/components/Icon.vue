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
                addIcon: {}
            }
        },
        mounted() {
            this.getIconList();
        },
        methods: {
            getIconList() {
                this.message.loading.show();
                http.post("icon/list").then(data => {
                    this.iconList = data;
                }).catch(err => {
                })
            },
            del(item) {
                this.message.loading.show("正在删除");
                http.post("icon/del", {"id": item.id}).then(() => {
                    this.iconList.splice(this.iconList.indexOf(item), 1);
                }).catch(err => {
                });
            },
            add() {
                if (utils.empty(this.addIcon.icon)) {
                    this.message.msg.error("图标样式不能为空");
                    return;
                }
                this.message.loading.show("添加中");
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
            }
        }
    }
</script>

<style scoped lang="scss">
    .add-icon {
        padding: 10px;
    }

    .icon-list > span {
        font-size: 40px;
        width: 60px;
        height: 60px;
        padding: 10px;
        background-color: #F1F1F1;
        margin: 5px;
        text-align: center;
        position: relative;

        & > span {
            display: none;
            position: absolute;
            margin-top: -50px;
            margin-left: -8px;
        }

        &:hover {
            & > span {
                display: block;
            }

            background-color: #8A8A8A;
        }
    }
</style>
