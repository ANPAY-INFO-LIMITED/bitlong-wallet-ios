//
//  NSBundle+Category.m
//  TVLive
//


//

#import "NSBundle+Category.h"

@implementation NSBundle (Category)


+(NSString *)getAppVersion{
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(NSString *)getBundleID{
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

@end
