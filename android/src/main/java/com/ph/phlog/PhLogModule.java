// PhLogModule.java

package com.ph.phlog;

import android.text.TextUtils;

import com.dianping.logan.Logan;
import com.dianping.logan.LoganConfig;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class PhLogModule extends ReactContextBaseJavaModule {

    public static String LOG_FILE_PATH;
    public static String LOG_CACHE_PATH;

    private final ReactApplicationContext reactContext;

    public PhLogModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "PhLog";
    }

    @ReactMethod
    public void sampleMethod(String stringArgument, int numberArgument, Callback callback) {
        // TODO: Implement some actually useful functionality
        callback.invoke("Received numberArgument: " + numberArgument + " stringArgument: " + stringArgument);
    }

    @ReactMethod
    public void w(String log) {
        Logan.w(log, 1);
    }

    @ReactMethod
    public void getAllFiles(Callback callback) {
        WritableArray mapParams = Arguments.createArray();
        Map<String, Long> map = Logan.getAllFilesInfo();

        if (map != null) {
            for (Map.Entry<String, Long> entry : map.entrySet()) {
                mapParams.pushString(entry.getKey());
            }
        }

        callback.invoke(mapParams);
    }

    @ReactMethod
    public void setDebug(boolean b) {
        Logan.setDebug(b);
    }

    @ReactMethod
    public void f() {
        Logan.f();
    }

    @ReactMethod
    public void getDateFile(String date, Callback callback) {
        if (TextUtils.isEmpty(date)) {
            callback.invoke(false);
        } else {
            String path = this.getFileName(date);
            if (TextUtils.isEmpty(path)) {
                callback.invoke(false);
            } else {
                callback.invoke(path);
            }
        }
    }

    /**
     * 需要在application中初始化
     */
    public static void init(String filePath, String cachePath) {
        LOG_CACHE_PATH = cachePath;
        LOG_FILE_PATH = filePath;
        LoganConfig config = new LoganConfig.Builder()
                .setCachePath(cachePath)
                .setPath(filePath)
                .setEncryptKey16("0123456789012345".getBytes())
                .setEncryptIV16("0123456789012345".getBytes())
                .setMaxFile(20)
                .build();
        Logan.setDebug(BuildConfig.DEBUG);
        Logan.init(config);
    }

    public static void nativeWrite(String log) {
        Logan.w(log, 1);
    }


    public String getFileName(String date) {
        File file = new File(LOG_FILE_PATH);
        File[] subFile = file.listFiles();

        if (subFile != null && subFile.length > 0) {
            for (int iFileLength = 0; iFileLength < subFile.length; iFileLength++) {
                // 判断是否为文件夹
                if (!subFile[iFileLength].isDirectory()) {
                    String filename = subFile[iFileLength].getName();
                    if (filename.equals(date)) {
                        return subFile[iFileLength].getAbsolutePath();
                    }
                }
            }
        }


        return null;
    }
}
