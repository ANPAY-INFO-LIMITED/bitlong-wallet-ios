//
//  NSLoggerWrapper.h
//  redlips
//
//  Created by David on 15/3/12.

//

#import "AbstractLogger.h"

@interface SystemLogger : AbstractLogger

+ (SystemLogger *)instance;

@end
