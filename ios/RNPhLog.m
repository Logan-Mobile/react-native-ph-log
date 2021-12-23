#import "RNPhLog.h"
#import "iOS/Logan.h"

@implementation RNPhLog

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
