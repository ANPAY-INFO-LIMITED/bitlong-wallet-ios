//
//  LoggerFactory.h
//  redlips
//
//  Created by David on 15/3/12.

//

#import <Foundation/Foundation.h>
#import "AbstractLogger.h"

static NSInteger const kLogLevel             = 4;

@interface LoggerFactory : NSObject

+ (AbstractLogger *)defaultLogger:(Class)c;
+ (AbstractLogger *)getLoggerByName:(NSString *)loggerName inClass:(Class)c;

@end
