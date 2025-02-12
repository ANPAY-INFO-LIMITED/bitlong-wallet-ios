//
//  BLKeychain.h
//  TVLive
//


//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLKeychain : NSObject

+ (void)save:(NSString *)key data:(id)data;
+ (id)load:(NSString *)key class:(Class)class;
+ (void)delete:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
