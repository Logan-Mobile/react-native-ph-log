// PhLog.m

#import "PhLog.h"
#import "Logan.h"



@implementation PhLog

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

// 写日志
RCT_EXPORT_METHOD(w:(NSString *)stringArgument)
{
    logan(1,stringArgument);
}

// 设置为调试模式
RCT_EXPORT_METHOD(setDebug:(BOOL)b)
{
    loganUseASL(b);
}

// 缓存刷入文件
RCT_EXPORT_METHOD(f)
{
    loganFlush();
}

// 获取指定文件
RCT_EXPORT_METHOD(getDateFile:(NSString *)time callBack:(RCTResponseSenderBlock)callback){
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"LoganLoggerv3"];
    NSString *timeDay = [self getTimeFromTimestamp:time];
    filePath = [filePath stringByAppendingPathComponent:timeDay];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if (isDirExist) {
        callback(@[filePath]);
    }else{
        callback(@[@"0"]);
    }
}

- (NSString *)getTimeFromTimestamp:(NSString *)timeString {
    //将对象类型的时间转换为NSDate类型
    double time = [timeString doubleValue];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    //设置时间格式
    NSDateFormatter * formatter= [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //将时间转换为字符串
    NSString *timeStr = [formatter stringFromDate:myDate];
    return timeStr;
}

// 获取所有的文件
RCT_EXPORT_METHOD(getAllFiles:(RCTResponseSenderBlock)callback)
{
    NSDictionary *map = loganAllFilesInfo();
    callback(@[map.allKeys]);
}

-(instancetype)init
{
    if (self = [super init]) {
        NSData *keydata = [@"0123456789012345" dataUsingEncoding:NSUTF8StringEncoding];
        NSData *ivdata = [@"0123456789012345" dataUsingEncoding:NSUTF8StringEncoding];
        uint64_t file_max = 20 * 1024 * 1024;
        loganInit(keydata, ivdata, file_max);
    }
    return self;
}




@end
