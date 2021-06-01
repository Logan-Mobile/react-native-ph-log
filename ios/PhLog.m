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

// 获取所有的文件
RCT_EXPORT_METHOD(getAllFiles:(RCTResponseSenderBlock)callback)
{
    NSDictionary *map = loganAllFilesInfo();
    callback(@[map]);
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
