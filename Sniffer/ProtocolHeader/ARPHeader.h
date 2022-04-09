//
//  ARPHeader.h
//  Sniffer
//
//  Created by DZC on 2022/4/5.
//

#import <Foundation/Foundation.h>
#import "InfoDelegate.h"
#import "ItemDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface ARPHeader : NSObject <InfoDelegate, ItemDelegate>
@property NSString* sendHardWareAddr;
@property NSString* sendIpAddr;
@property NSString* targetHardWareAddr;
@property NSString* targetIpAdrr;
@property NSInteger optionCode;
@property NSInteger hardWareSize;
@property NSInteger protocolSize;
@property NSString* protocolType;
@end

NS_ASSUME_NONNULL_END
