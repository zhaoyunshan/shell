#!/bin/bash

chmod +x ../svnserve.sh

echo "mac下配置SVN服务器"


echo "接下来将在~/Users目录下配置SVN服务"

cd ~/../

if test -a ./svnserve
then
    echo "已存在一个名叫svnserve的文件是否删除(y/n):"
    read res
    if [ $res == "y" ]
    then
        sudo rm -rf svnserve
    else
        sleep
    fi
fi

sudo svnadmin create ./svnserve

cd ./svnserve/conf

sudo sed -i '' '24i\'$'\n@members = \n'  authz

sudo sed -i '' "s/# anon-access = read/anon-access = read/g" svnserve.conf

sudo sed -i '' "s/# auth-access = write/auth-access = write/g" svnserve.conf

sudo sed -i '' "s/# authz-db = authz/authz-db = authz/g" svnserve.conf

sudo sed -i '' "s/# password-db = passwd/password-db = passwd/g" svnserve.conf

echo "请设置用户名和密码："

while true
do
    echo "请输入用户名"
    read account
    echo "请输入密码:"
    read password

    sudo sed -i '' '7i\'$'\nHHHHHHHHHHHHHHHHHHHH\n' passwd

    sudo sed -i '' "7s/HHHHHHHHHHHHHHHHHHHH/$account = $password /g" passwd

    sudo sed -i '' "s/^member.*/&${account}/g" authz

    echo "是否继续添加(y/n):"
    read iscontinue
    if [ $iscontinue == "y" ]
    then
        sudo sed -i '' "s/^member.*/&, /g" authz
        sleep
    else
        break
    fi
done

sudo sed -i '' '26i\'$'\n@member = rw\n' authz

sudo sed -i '' '25i\'$'\n[/]\n' authz

cd ~/../svnserve

sudo svnserve -d -r /Users/svnserve


