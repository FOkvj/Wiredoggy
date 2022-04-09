//
//  ICMPHeader.h
//  Sniffer
//
//  Created by DZC on 2022/4/7.
//

#import <Foundation/Foundation.h>
#import "InfoDelegate.h"
#import "ItemDelegate.h"
#import <netinet/ip_icmp.h>
NS_ASSUME_NONNULL_BEGIN

@interface ICMPHeader : NSObject <InfoDelegate, ItemDelegate>
@property NSInteger code;
@property NSInteger type;
@property NSInteger checkSum;
@property NSInteger seqNumBE;
@property NSInteger seqNumLE;
@property NSInteger idBE;
@property NSInteger idLE;
@end

NS_ASSUME_NONNULL_END
