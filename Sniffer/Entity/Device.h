//
//  Device.h
//  Sniffer
//
//  Created by DZC on 2022/4/3.
//

#import <Foundation/Foundation.h>
#define DEV_IS_ALIVE 1
NS_ASSUME_NONNULL_BEGIN

@interface Device : NSObject
@property NSString* name;
@property NSString* type;
@property NSInteger status;//0:dead 1:alive

@end

NS_ASSUME_NONNULL_END
