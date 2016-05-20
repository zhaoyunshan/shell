#!/bin/bash


# iOS ipa 自动打包

#工程环境路径
project_path="/Users/pg/Desktop/InnJia3.0"

#scheme名称
project_scheme="InnJia_2.0"

#target名称
target_name="InnJia_2.0"

#配置模式

configuration="Release"


echo "工程路径:      ${project_path}"
echo "scheme名称:   ${project_scheme_name}"
echo "target名称:   ${target_name}"
echo "配置模式:      $configuration"


echo "是否继续（y/n）:"

read result

if [ $result="y" ]
then
    sleep
else
    exit
fi

#进入工程主目录

echo "进入工程主目录：$project_path"

cd $project_path



#执行buildclean 命令

echo "xcodebuild clean 命令"

xcodebuild clean

echo "clean 成功！输入任意键继续："

read anyword

#执行build命令

echo "执行编译生成.app命令"

#判断当前工程环境
if [ -e ${project_path}/*.xcworkspace ]
then
    xcodebuild -workspace $project_scheme.xcworkspace -scheme $project_scheme -sdk iphoneos -configuration $configuration -derivedDataPath build
else
    xcodebuild -workspace $target_name.xcodeproj -sdk iphoneos -configuration $configuration -derivedDataPath build
fi

echo "build 成功！输入任意键继续:"
read anyword


#.app生成后的路径
app_name_path=$project_path/build/Build/Products/Release-iphoneos/${target_name}.app

#.ipa生成后的路径

ipa_name_path="${target_name}.ipa"

xcrun -sdk iphoneos PackageApplication -v $app_name_path -o $project_path/$ipa_name_path

time=$(date +%Y-%m-%d-%k:%M:%S)

mkdir ~/Desktop/$time

mv $project_path/$ipa_name_path ~/Desktop/$time/


