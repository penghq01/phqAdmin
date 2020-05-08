<template>
    <div class="update">
        <div class="update-top">
            <div>PHQ程序更新系统</div>
            <div @click="outLogin">退出登录</div>
        </div>
        <div class="update-body">


            <div class="action" style="padding-bottom: 10px;">
                <div class="button-group">
                    <el-button type="info" @click="getFileList">刷新</el-button>
                    <el-upload
                            class="upload-demo"
                            action="#"
                            :show-file-list="false"
                            :before-upload="beforeAvatarUpload"
                            :http-request="httpRequest">
                        <div class="upload-btn">
                            <el-button type="primary">上传文件</el-button>
                        </div>
                    </el-upload>
                    <Poptip
                            transfer
                            confirm
                            title="确定删除文件吗?"
                            @on-ok="del()">
                        <el-button type="danger">删除文件</el-button>
                    </Poptip>
                    <Poptip
                            transfer
                            confirm
                            title="确定要下载文件吗?"
                            @on-ok="downloadFile()">
                        <el-button type="info">下载文件</el-button>
                    </Poptip>
                    <Poptip
                            v-show="showDeCompress"
                            transfer
                            confirm
                            title="确定解压文件吗?"
                            @on-ok="DeCompress()">
                        <el-button type="warning">解压文件</el-button>
                    </Poptip>
                    <el-button type="danger" v-show="ShowRunCommand" @click="ShowRunArgsDialog">执行文件</el-button>
                </div>
            </div>
            <div class="update-table">
                <div class="update-dir">
                    <div>
                        <div class="button-group">
                            <el-button type="primary" @click="setDefaultDir('html_dir')">HTML目录</el-button>
                            <el-button type="primary" @click="setDefaultDir('server_dir')">SERVER目录</el-button>
                            <el-button type="primary" @click="setDefaultDir('upload_dir')">上传目录</el-button>
                        </div>
                    </div>
                    <div class="update-dir-name">当前路径：</div>
                    <div>
                        <div v-for="(item,index) in DirPathArr" :key="index" @click="ChangeDir(index)">
                            <i v-show="index>0" class="el-icon-caret-right"/>
                            {{item}}
                            <i class="el-icon-caret-right"/>
                        </div>
                    </div>
                </div>
                <el-table v-loading="loading" :data="dataList" border stripe size="mini"
                          @current-change="handleCurrentChange" highlight-current-row>
                    <el-table-column label="文件名称" prop="file_name">
                        <template slot-scope="scope">
                          <span class="update-table-td">
                              <div class="update-table-td-ico">
                                  <i v-if="scope.row.is_dir" class="fa fa-folder-open" style="color:#D9AF15"></i>
                              <img v-else :src="extGetPng(scope.row.file_name)" />
                              </div>
                              <div @click="openDir(scope.row.is_dir,scope.row.file_name)">{{scope.row.file_name}}</div>
                          </span>
                        </template>
                    </el-table-column>
                    <el-table-column label="大小" width="200">
                        <template slot-scope="scope">
                            <div v-show="!scope.row.is_dir">{{getSize(scope.row.file_size)}}</div>
                        </template>
                    </el-table-column>
                </el-table>
            </div>


        </div>

        <myDialog
                :title="`文件${loadTxt}中，请耐心等待`"
                :is-show="loadShow"
                :is-see="true"
                :one="true"
                :show-close="false"
        >
            <el-progress :text-inside="true" :stroke-width="26" :percentage="loadPercentage"></el-progress>
        </myDialog>

        <myDialog
                title="执行文件"
                width="70%"
                :is-show="ShowRunArgs"
                :close="closeRunArgsDialog"
                :ok-click="runCommand"
                close-title="关闭"
                ok-title="执行"
        >
            <div>
                <div class="input-from">
                    <span>执行目录：</span>
                    <el-input type="text" v-model="runParams.run_dir" placeholder="执行目录"/>
                </div>
                <div class="input-from">
                    <span>执行文件：</span>
                    <el-input type="text" v-model="runParams.run_file" placeholder="执行文件"/>
                </div>
                <div class="input-from">
                    <span>执行参数：</span>
                    <el-select
                            style="width:100%"
                            v-model="runParams.args"
                            multiple
                            filterable
                            allow-create
                            default-first-option
                            placeholder="请选择或输入执行参数">
                        <el-option
                                v-for="item in argsOptions"
                                :key="item.value"
                                :label="item.label"
                                :value="item.value">
                        </el-option>
                    </el-select>
                </div>

                <div class="run-command-msg" v-show="runCommandMsg" v-html="runCommandMsg">

                </div>
            </div>
        </myDialog>
    </div>
</template>

<script>
    import http from "../lib/http";
    import message from "../lib/message";
    import FileSave from "file-saver"
    import storage from "../lib/storage";
    import utils from "../lib/utils";
    import fileIco from "../lib/fileIco";

    export default {
        name: "System",
        data() {
            return {
                loading: false,
                serveDir: {
                    "html_dir": "",
                    "server_dir": "",
                    "upload_dir": "",
                },
                dataList: [],
                loadTxt: "下载",
                SelectDirPath: "",
                DirPathArr: [],
                loadPercentage: 0,
                loadShow: false,
                showDeCompress: false,
                ShowRunCommand: false,
                currentRow: {},
                argsOptions: [
                    {
                        value: 'start',
                        label: 'start'
                    },
                    {
                        value: 'stop',
                        label: 'stop'
                    },
                    {
                        value: 'restart',
                        label: 'restart'
                    },
                    {
                        value: 'status',
                        label: 'status'
                    },
                    {
                        value: 'install',
                        label: 'install'
                    },
                    {
                        value: 'uninstall',
                        label: 'uninstall'
                    }],
                runArgs: [],
                ShowRunArgs: false,
                runCommandMsg: "",
                runParams: {
                    "run_file": "",
                    "run_dir": "",
                    "args": [],
                }
            }
        },
        mounted() {
            this.getDirPath();
        },
        watch: {
            SelectDirPath(val) {
                this.DirPathArr = val.split("\\");
            }
        },
        methods: {
            //退出登录
            outLogin() {
                message.confirm("确定要退出登录吗？", {
                    okFunction: () => {
                        storage.clear();
                        this.$router.push("/login");
                    }
                })
            },
            //获取图片
            extGetPng(name=""){
                let ext=this.getFileNameExp(name);
                if (ext=="7z"){
                    ext="z7";
                }
                if(utils.empty(ext)){
                    ext="other";
                }
                let ico=fileIco[ext];
                if(utils.empty(ico)){
                    return fileIco["other"];
                }
                return ico;
             },
            //设置默认目录
            setDefaultDir(key) {
                this.SelectDirPath = this.serveDir[key];
                this.getFileList()
            },
            //选择目录
            ChangeDir(key) {
                let newDir = [];
                this.DirPathArr.forEach((item, index) => {
                    if (index <= key) {
                        newDir.push(item);
                    }
                });
                this.SelectDirPath = newDir.join("\\");
                this.getFileList()
            },
            //打开目录
            openDir(isDir = false, dirName) {
                if (isDir) {
                    this.SelectDirPath += `\\${dirName}`;
                    this.getFileList()
                }
            },
            //获取文件后缀名
            getFileNameExp(filePath = "") {
                let startIndex = filePath.lastIndexOf(".");
                if (startIndex != -1) {
                    return filePath.substring(startIndex + 1, filePath.length).toLowerCase();
                } else {
                    return "";
                }
            },
            //选择行
            handleCurrentChange(val) {
                this.currentRow = val;
                this.showDeCompress = false;
                this.ShowRunCommand = false;
                let fileExt = "";
                if (utils.empty(val)) {
                    fileExt = "";
                } else {
                    fileExt = this.getFileNameExp(val.file_name);
                }
                if (fileExt == "zip") {
                    this.showDeCompress = true;
                }
                if (fileExt == "exe" || fileExt == "bat" || fileExt == "cmd") {
                    this.ShowRunCommand = true;
                }

            },
            //获取路径
            getDirPath() {
                http.post("/file/dir").then(data => {
                    this.serveDir = data;
                    this.SelectDirPath = this.serveDir.upload_dir;
                    this.getFileList()
                }).catch(err => {
                });
            },
            //获取文件列表
            getFileList() {
                this.dataList = [];
                this.loading = true;
                http.post("/file/list", {"dir_path": this.SelectDirPath}).then(data => {
                    this.dataList = data;
                    this.loading = false;
                }).catch(err => {
                    this.loading = false;
                });
            },
            //计算大小
            getSize(val = 0) {
                let kb = parseFloat(val) / 1024;
                let mb = kb / 1024;
                if (kb < 1024.000) {
                    return kb.toFixed(3) + " KB";
                } else {
                    return mb.toFixed(3) + " MB"
                }
            },
            //删除文件
            del() {
                http.post("/file/del", {
                    "file_name": this.currentRow.file_name,
                    "dir_path": this.SelectDirPath
                }).then(data => {
                    let index = this.dataList.findIndex(item => item.key == this.currentRow.key);
                    if (index >= 0) {
                        this.dataList.splice(index, 1)
                    }
                }).catch(err => {
                });
            },
            //解压文件
            DeCompress() {
                message.loading.show("文件解压中，请耐心等待……");
                http.post("/file/decompress", {
                    "file_name": this.currentRow.file_name,
                    "dir_path": this.SelectDirPath
                }).then(data => {
                    message.loading.hide();
                    this.getFileList();
                }).catch(err => {
                    message.loading.hide();
                });
            },
            //关闭执行文件窗口
            closeRunArgsDialog() {
                this.ShowRunArgs = false;
                this.runParams = {
                    "run_file": "",
                    "run_dir": "",
                    "args": []
                };
                this.runCommandMsg="";
            },
            //显示执行文件窗口
            ShowRunArgsDialog() {
                this.runCommandMsg="";
                this.ShowRunArgs = true;
                this.runParams.run_dir=this.SelectDirPath;
                this.runParams.run_file=this.currentRow.file_name;
            },
            //执行文件
            runCommand() {
                message.loading.show("正在执行命令，请耐心等待……");
                http.post("/file/run", this.runParams).then(data => {
                    message.loading.hide();
                    this.runCommandMsg = data;
                }).catch(err => {
                    message.loading.hide();
                });
            },
            //选择上传前回调
            beforeAvatarUpload(file) {
                return true
            },
            //上传文件
            httpRequest(file) {
                this.loadTxt = "上传";
                this.loadPercentage=0;
                this.loadShow = true;
                http.upload("/file/upload", {
                    "file_name": file.file,
                    "dir_path": this.SelectDirPath
                }, (progress, percentage) => {
                    this.loadPercentage = percentage;
                }).then(data => {
                    this.loadShow = false;
                    this.getFileList();
                }).catch(err => {
                    this.loadShow = false;
                });
            },
            //下载文件
            downloadFile() {
                this.loadTxt = "下载";
                this.loadPercentage=0;
                this.loadShow = true;
                http.download("/file/download", {
                    "file_name": this.currentRow.file_name,
                    "dir_path": this.SelectDirPath
                }, (progress, percentage) => {
                    this.loadPercentage = percentage;
                }).then(data => {
                    this.loadShow = false;
                    FileSave.saveAs(data, this.currentRow.file_name);
                }).catch(err => {
                    this.loadShow = false;
                });
            },
        }
    }
</script>

<style scoped lang="scss">
    .update {
        &-top {
            padding: 10px 15px;
            background-color: $primary-color;
            display: flex;
            justify-content: space-between;
            align-items: center;

            & > div {
                color: #ffffff;

                &:first-child {
                    font-size: 20px;
                }

                &:last-child {
                    &:hover {
                        color: $primary-gray;
                        cursor: pointer;
                    }
                }
            }
        }

        &-body {
            padding: 10px;
        }

        &-dir {
            padding: 0 0 10px 0;
            display: flex;
            align-items: center;

            & > div {
                &:last-child {
                    display: flex;
                    justify-items: center;

                    & > div {
                        background-color: #B58E04;
                        color: #ffffff;
                        padding: 4px;
                        position: relative;
                        margin-right: 3px;
                        padding-left: 20px;

                        &:first-child {
                            padding-left: 4px;
                        }

                        &:hover {
                            background-color: #907204;
                            cursor: pointer;

                            & > i {
                                &:last-child {
                                    color: #907204;
                                }
                            }
                        }

                        &:active {
                            color: #FEDD69;
                        }

                        & > i {
                            position: absolute;
                            font-size: 44px;
                            top: -8px;

                            &:first-child {
                                left: -18px;
                                z-index: 1;
                            }

                            &:last-child {
                                z-index: 2;
                                right: -27px;
                                color: #B58E04;
                            }
                        }
                    }
                }
            }
        }

        &-table {
            &-td {
                display: flex;
                align-items: center;
                & > div {
                    &:hover {
                        color: $primary-color;
                        cursor: pointer;
                    }
                }
                &-ico{
                    height:50px;
                    width:50px;
                    //margin-left:5px;
                    margin-right:10px;
                    display:flex;
                    justify-content:flex-end;
                    align-items: center;
                    & > i {
                        margin-right: 5px;
                        font-size:45px;
                    }
                    &>img{
                        max-height:50px;
                        max-width:50px;
                        margin-right:5px;
                    }
                }
            }
        }
    }

    .run-command-msg {
        white-space: pre-wrap;
        word-wrap: break-word;
        word-break: break-all;
        background-color:#000000;
        padding:10px;
        color:#28D503;
        border-radius:3px;
    }
</style>
