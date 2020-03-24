#!/bin/sh

#  Script.sh
#  CarDetection
#
#  Created by limingyang on 2020/3/23.
#  Copyright © 2020 李明洋. All rights reserved.

echo "------------申明路径和变量名--------------\n"

path=$(cd `dirname $0`; pwd)
COMPILE_APP_NAME="CarDetection"
TARGET_NAME="CarDetection"
Export_Path="Export"
echo $path

echo "\n------------修改info.plist--------------\n"

CFBundleKey=CFBundleDisplayName
#NewCFBundleDisplayName="再次修改"
value=`/usr/libexec/Plistbuddy -c "Print :'$CFBundleKey'" ./$COMPILE_APP_NAME/Info.plist`
#/usr/libexec/Plistbuddy -c "Set :CFBundleDisplayName '$NewCFBundleDisplayName'" Info.plist
#/usr/libexec/Plistbuddy -c "Print :CFBundleDisplayName" Info.plist
echo "-------$value-------"

#echo "\n-------------开始build-------------\n"
#
##cd "${PROJDIR}"
#PROJECT_BUILDDIR="${path}/build/Release-iphoneos"
#echo ${path}/${COMPILE_APP_NAME}.xcworkspace
#xcodebuild -target "${TARGET_NAME}" clean
##
#xcodebuild archive -workspace ${path}/${COMPILE_APP_NAME}.xcworkspace \
#-scheme ${COMPILE_APP_NAME} \
#-configuration Release \
#-archivePath $path/$Export_Path
#
##Check if build succeeded
#if [ $? != 0 ]
#then
#echo "#################构建失败################"
#  exit 1
#fi
#echo "#################构建成功################"

echo "\n-------------export.plist-------------\n"

ADHOCExportOptionsPlist=exportOptions.plist

value=`/usr/libexec/Plistbuddy -c "Print'" $ADHOCExportOptionsPlist`

/usr/libexec/Plistbuddy -c "Add :method String 'development'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Add :compileBitcode Bool 'NO'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Add :destination String 'export'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Add :signingStyle String 'automatic'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Add :stripSwiftSymbols Bool 'YES'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Add :teamID String 'T6B252GRK6'" $ADHOCExportOptionsPlist

/usr/libexec/Plistbuddy -c "Set :method 'development'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Set :compileBitcode Bool 'NO'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Set :destination 'export'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Set :signingStyle 'automatic'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Set :stripSwiftSymbols Bool 'YES'" $ADHOCExportOptionsPlist
/usr/libexec/Plistbuddy -c "Set :teamID 'T6B252GRK6'" $ADHOCExportOptionsPlist

/usr/libexec/Plistbuddy -c "Print" $ADHOCExportOptionsPlist

echo "\n-------------清空export文件夹-------------\n"
rm -rf $path/$Export_Path

echo "\n-------------开始导出-------------\n"
starttime=`date +'%Y-%m-%d %H:%M:%S'`
#执行程序

xcodebuild -exportArchive \
-archivePath $path/$Export_Path.xcarchive \
-exportPath $path/$Export_Path \
-exportOptionsPlist $ADHOCExportOptionsPlist

endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date="$starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo "本次导出用时： "$((end_seconds-start_seconds))"s"

echo "\n-------------结束-------------\n"
