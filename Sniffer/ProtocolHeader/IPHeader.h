//
//  Packege.h
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import <Cocoa/Cocoa.h>
#import "ItemDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface IPHeader : NSObject <ItemDelegate>

@property NSInteger identy;
@property NSInteger version;
@property NSInteger headerLen;
@property NSString* serviceType;
@property NSInteger totalLen;
@property NSString* Identification;
@property NSMutableArray* flags;
@property NSInteger offset;
@property NSInteger timeToLive;
@property NSString* protocol;
@property NSInteger headerCheckSum;
@property NSString* sourceIP;
@property NSString* destIP;

@end

NS_ASSUME_NONNULL_END
