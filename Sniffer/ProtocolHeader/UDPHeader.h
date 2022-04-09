//
//  UDPHeader.h
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import <Cocoa/Cocoa.h>
#import "InfoDelegate.h"
#import "ItemDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface UDPHeader : NSObject <InfoDelegate, ItemDelegate>
@property NSInteger sourcePort;
@property NSInteger destPort;
@property NSInteger length;
@property NSInteger checkSum;
@property NSInteger payloadLength;

@end

NS_ASSUME_NONNULL_END
