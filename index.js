// main index.js

import { NativeModules } from 'react-native';

import { showSelectLogModal as showUploadUI, submitLog } from './FileUploadService'

const { PhLog } = NativeModules;

const w = PhLog.w
const f = PhLog.f
const getAllFiles = PhLog.getAllFiles
const getDateFile = PhLog.getDateFile
const setDebug = PhLog.setDebug

export default {
    setDebug,
    getDateFile,
    getAllFiles,
    w,
    f,
    showUploadUI,
    submitLog
};
