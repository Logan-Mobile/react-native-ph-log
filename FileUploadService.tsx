/**
 * @description 日志文件提交  上传oss在外部上传
 * @author tuhui
 * @date 2021/5/26 8:59 上午
 * */

import React from 'react';
import { Platform } from 'react-native';
import moment from 'moment';
import { ActionSheet, PHToast } from '@ph/ph-rn-ui';
import { NativeModules } from 'react-native';

const { PhLog } = NativeModules;

export function showSelectLogModal(onSelectLog: Function) {

    PhLog.getAllFiles((files: Array<string>) => {

        const sortFiles = files.sort()

        ActionSheet.showActionSheetWithOptions(
            {
                cancelButtonIndex: sortFiles.length,
                options: sortFiles,
                title: ''
            },
            index => {
                PhLog.getDateFile(
                    `${moment(moment(sortFiles[index]).format('YYYY-MM-DD')).valueOf()}`,
                    (filePath: string) => {
                        let fileName = filePath;
                        let filePathSplitArr = filePath.split('/');
                        if (filePathSplitArr.length > 0) {
                            fileName = filePathSplitArr[filePathSplitArr.length - 1];
                        }
                        onSelectLog(filePath, fileName);
                    }
                );
            }
        );
    });
}

/**
 * 提交日志记录
 * @param filePath
 * @param token
 * @param extraParams
 */
async function submitLog(fileId: string, token: string, extraParams: any) {
    try {
        let commonParams = {
            platform: Platform.OS,
            osVersion: Platform.Version,
            upLoadTime: moment().valueOf()
        };

        let body = Object.assign({}, extraParams, commonParams);
        let response = await fetch(
            extraParams.url ? extraParams.url : 'http://support-ali-test.puhuiboss.com/api/biz-ops/aparsing/parsing',
            {
                method: 'POST',
                headers: {
                    'X-PH-TOKEN': token,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(body)
            }
        );
        let responseJson = await response.json();

        // todo 日志上报成功
        if (responseJson.success) {
            return Promise.resolve();
        } else {
            return Promise.reject(new Error('日志上报失败'));
        }
    } catch (error) {
        return Promise.reject(error);
    }
}

/**
 * 上传日志
 * @param filePath
 * @param token
 */
async function uploadFile(filePath: string, token: string) {
    let formData = new FormData();
    let url = '';

    let fileName = filePath;
    let filePathSplitArr = filePath.split('/');
    if (filePathSplitArr.length > 0) {
        fileName = filePathSplitArr[filePathSplitArr.length - 1];
    }

    let file = {
        uri: `file://${filePath}`,
        type: 'application/octet-stream',
        name: fileName
    };

    formData.append('file', file);

    return new Promise((resolve, reject) => {
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'multipart/form-data;charset=utf-8',
                'X-PH-TOKEN': token
            },
            body: formData
        })
            .then(response => response.json())
            .then(responseData => {
                resolve(responseData.id);
            })
            .catch(err => reject(new Error(err.message)));
    });
}

export {
    submitLog
};
