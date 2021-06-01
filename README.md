# react-native-ph-log

## Getting started

`$ npm install react-native-ph-log --save`

### Mostly automatic installation

`$ react-native link react-native-ph-log`

## Usage
```javascript
import PhLog from 'react-native-ph-log';

// 设置为调试模式,控制台打印日志
PhLog.setDebug(debug: boolean) 
// 获取指定日期的日志 date: '2021-10-05' 
// ret 为文件路径
PhLog.getDateFile(date: string, (filePath: string))
// 获取所有文件名(非真实文件路径 仅展示用)
PhLog.getAllFiles((files:Array<string>))
// 写日志 
PhLog.w(info: string)
// 刷新MMAP 建议进入后台 APP 退出前调用,或者其他重要日志写入后调用
PhLog.f()
// 展示上传日志modal 用户可以选择一个日期的日志上传
PhLog.showUploadUI((filePath:string)=>{})
// 提交日志记录到后端日志服务
PhLog.submitLog(fileId:string,token:string,params:object)
}
```
