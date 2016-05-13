#!/bin/bash

echo SVN 版本管理脚本

echo "请输入svn服务器代码库路径："

read svn_server_path

echo "请输入svn本地代码路径， 如果没有请填写你希望存储的路径（下载到本地时的路径,默认当前位置）"

read svn_local_path

echo "我可以为你做这些"

echo    1   从服务器下载代码到本地
echo    2   将服务器代码更新到本地
echo    3   提交本地代码到服务器
echo    4   以本地代码初始化SVN服务器
echo    5   创建分支
echo    6   删除分支
echo    7   合并分支到主干
echo    8   查看日志



#下载
funcCheckout(){

    svn co $svn_server_path  $code_local_path
}

#更新
funcUpdate(){

    cd $svn_local_path
    svn up
}

#提交
funcCommit(){

    echo "请输入提交日志："
    read message
    svn commit -m "$message"
}

#初始化
funcImport(){

    echo "请输入要导入的文件路径："
    read local_path
    cd $local_path

    echo "请输入日志信息："
    read message

    svn import -m "$message" $svn_sever_path
}


#创建分支
funcCreateBranch(){

    echo "请输入SVN服务器分支路径："
    read branch_path

    echo "请输入日志信息："
    read message

    svn copy $branch_path -m "$message" $svn_sever_path
}

#删除分支
funcDeleteBranch(){

    echo "请输入分支路径："
    read branch_path

    echo "请输入日志信息："
    read message

    svn rm $branch_path -m "$message"
}

#合并分支到主干
funcMergeToTrunk(){

    echo "请输入分支路径："
    read branch_path

    echo "请输入主干路径："
    read trunk_path

    echo "请输入日志信息："

    read message

    cd $trunk_path

    svn merge -m $branch_path
}

funcLog(){
    cd svn_local_path
    svn log
}

echo "请选择你的服务："

read tag

case $tag in
    1)  funcCheckout
    ;;
    2)  funcUpdate
    ;;
    3)  funcCommit
    ;;
    4)  funcImport
    ;;
    5)  funcCreateBranch
    ;;
    6)  funcDeleteBranch
    ;;
    7)  funcMergeToTrunk
    ;;
    8)  funcLog
    ;;
    *)  echo "如有问题请及时与我联系QQ:2434783536，期待下次合作"
    ;;
esac


