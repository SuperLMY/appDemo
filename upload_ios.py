#!/usr/bin/env python3
import time
import subprocess
import requests
import json
import webbrowser
import os

project_name = 'Runner' #项目名称
project_sheme = 'Runner' #项目sheme
# project_path = '/Users/sghl/Documents/workspace/flutter-project/crpapp/ios' #项目路径
project_path = './ios' #项目路径
export_path = 'export' #导出路径
ipa_download_url = 'https://fir.im/qgx8'
ipa_version_name = '1.0.0'
uploadType = 2   # 0不需要上传 1 是蒲公英 2是fir.im
# 蒲公英
USER_KEY = ''
API_KEY = ''
# fir
TOKEN = 'ccb47d3c7d690aa4d9ed432b83ee267c'  #qa
# TOKEN = '1fd6b6dc9ce7cbdf882b40c06ad973d7'    #uat
description = '1.修改改价id为空的时候为不显示\n'

class Archive(object):
    def __init__(self):
        pass

    def start(self):
        self.xcodeClean()


    def printA(self):
        print(ipa_download_url+'is'+ipa_version_name)

    def xcodeClean(self):
        print('\n\n==========开始xcode clean==========')
        start = time.time()
        clean_command = 'xcodebuild clean -workspace %s/%s.xcworkspace -scheme %s -configuration Release' % (
            project_path, project_name, project_sheme)
        print('clean command: %s' % clean_command)
        clean_command_run = subprocess.Popen(clean_command, shell=True)
        clean_command_run.wait()
        end = time.time()

        #返回结果
        clean_result_code = clean_command_run.returncode
        if clean_result_code != 0:
            print("=====xcode clean失败,用时:%.2f秒=====" % (end - start))
        else:
            print("=====xcode clean成功,用时:%.2f秒=====" % (end - start))
        self.archive()

    def archive(self):
        print("\n\n===========开始archive操作===========")

        # 删除之前的文件
        subprocess.call(['rm', '-rf', '%s/%s' % (project_path, export_path)])
        print(['rm', '-rf', '%s/%s' % (project_path, export_path)])
        time.sleep(1)
        # 创建文件夹存放打包文件
        print(['mkdir', '-p', '%s/%s' % (project_path, export_path)])
        subprocess.call(['mkdir', '-p', '%s/%s' % (project_path, export_path)])
        time.sleep(1)

        start = time.time()
        archive_command = 'xcodebuild archive -workspace %s/%s.xcworkspace -scheme %s -configuration Release -archivePath %s/%s' % (
            project_path, project_name, project_sheme, project_path, export_path)
        archive_command_run = subprocess.Popen(archive_command, shell=True)
        archive_command_run.wait()
        end = time.time()
        # Code码
        archive_result_code = archive_command_run.returncode
        if archive_result_code != 0:
            print("=======archive失败,用时:%.2f秒=======" % (end - start))
        else:
            print("=======archive成功,用时:%.2f秒=======" % (end - start))
            # 导出IPA
            self.export()

    def export(self):
            print("\n\n===========开始export操作===========")
            print("\n\n==========请你耐心等待一会~===========")
            start = time.time()
            export_command = 'xcodebuild -exportArchive -archivePath %s/%s.xcarchive -exportPath %s/%s -exportOptionsPlist %s/ExportOptions.plist' % (
                project_path, export_path, project_path, export_path,
                project_path)
            export_command_run = subprocess.Popen(export_command, shell=True)
            export_command_run.wait()
            end = time.time()
            # Code码
            export_result_code = export_command_run.returncode
            if export_result_code != 0:
                print("=======导出IPA失败,用时:%.2f秒=======" % (end - start))
            else:
                print("=======导出IPA成功,用时:%.2f秒=======" % (end - start))
                # 删除archive.xcarchive文件
                subprocess.call(['rm', '-rf', '%s/%s.xcarchive' % (project_path, export_path)])
                if uploadType == 0:
                    pass
                elif uploadType == 1:
                    self.upload('%s/%s/%s.ipa' % (project_path, export_path, project_name))
                elif uploadType == 2:
                    self.uploadFir('%s/%s/%s.ipa' % (project_path, export_path, project_name))



    def uploadFir(self, ipa_path):
        print("\n\n===========fir===========")
        print(ipa_path)
        # if ipa_path:
        #     firlogin = subprocess.Popen('fir login {}'.format(TOKEN), shell=True)
        #     firlogin.wait()
        #     firUpload = subprocess.Popen('fir publish {} -c {}'.format(ipa_path, description),  shell=True)
        #     firUpload.wait()
        #     self.open_browser(self)
        getKey = "curl -X 'POST' 'http://api.fir.im/apps' \
            -H 'Content-Type: application/json' \
            -d '{\"type\":\"ios\", \"bundle_id\":\"com.rootcloud.crp\", \"api_token\":\"ccb47d3c7d690aa4d9ed432b83ee267c\"}'"
        res = os.popen(getKey).read()
        result = json.loads(res)

        key = result['cert']['binary']['key']
        token = result['cert']['binary']['token']
        uploadUrl = result['cert']['binary']['upload_url']
        uploadCmd = "curl   -F 'key=%s'              \
            -F 'token=%s'             \
            -F 'file=@%s'            \
            -F 'x:name=crp'             \
            -F 'x:version=1.0.0'         \
            -F 'x:build=1'               \
            %s"%(key, token, ipa_path, uploadUrl)
        uploadResult = os.popen(uploadCmd).read()
        print(uploadResult)
        self.sendFeishuMessage()

    def upload(self, ipa_path):
        print("\n\n===========开始上传蒲公英操作===========")
        if ipa_path:
            # https://www.pgyer.com/doc/api具体参数大家可以进去里面查看,
            url = 'http://www.pgyer.com/apiv1/app/upload'
            data = {
                'uKey': USER_KEY,
                '_api_key': API_KEY,
                'installType': '1',
                'updateDescription': description
            }
            files = {'file': open(ipa_path, 'rb')}
            r = requests.post(url, data=data, files=files)
            if r.status_code == 200:
                # 是否需要打开浏览器
                self.open_browser(self)
                # self.sendDingDingMessage()
        else:
            print("\n\n===========没有找到对应的ipa===========")
            return

    @staticmethod
    def open_browser(self):
        webbrowser.open(ipa_download_url, new=1, autoraise=True)

    def sendFeishuMessage(self):
        url = 'https://open.feishu.cn/open-apis/bot/hook/5a70bef7397f4a37b6d8c0cb300e9583'
        HEADERS = {
            "Content-Type": "application/json ;charset=utf-8 "
        }
        String_textMsg = {
            "title": "ios app update",
            "text": "下载地址: https://fir.im/qgx8"
        }

        # "atMobiles": [
        #     # 如果需要@某人，这里写他的手机号
        # ],
        String_textMsg = json.dumps(String_textMsg)
        res = requests.post(url, data=String_textMsg, headers=HEADERS)
        print(res.text)


if __name__ == '__main__':
    os.system('flutter build ios')
    archive = Archive()
    archive.start()
