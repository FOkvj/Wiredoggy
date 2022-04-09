//
//  EthernetPackege.h
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import <Cocoa/Cocoa.h>
#import "ItemDelegate.h"
NS_ASSUME_NONNULL_BEGIN;

@interface EthernetHeader: NSObject <ItemDelegate>

@property NSString* sourceMac;
@property NSString* destMac;
@property NSString* type;

@end

NS_ASSUME_NONNULL_END
