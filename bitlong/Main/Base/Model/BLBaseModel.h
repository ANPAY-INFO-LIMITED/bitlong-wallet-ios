//
//  BLBaseModel.h
//  TVLive
//
//  Created by xiaohesong on 15/10/12.

//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BLBaseModel : NSObject<NSSecureCoding>

- (instancetype)initWithDict:(id)dict;


+(BOOL)supportsSecureCoding;

@end
