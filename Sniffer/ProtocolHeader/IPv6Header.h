//
//  IPv6Header.h
//  Sniffer
//
//  Created by DZC on 2022/4/5.
//

#import <Foundation/Foundation.h>
#import "ItemDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface IPv6Header : NSObject <ItemDelegate>
@property NSString* srcAddr;
@property NSString* dstAddr;
@property NSString* nextHeader;
@property NSInteger payloadLen;
@property NSInteger hopLimit;
@property NSInteger flowLable;
@end

NS_ASSUME_NONNULL_END
