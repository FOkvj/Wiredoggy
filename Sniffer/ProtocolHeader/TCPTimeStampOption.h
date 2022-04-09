//
//  TCPOption.h
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCPTimeStampOption : NSObject
@property NSString* kind;
@property NSInteger optLength;
@property NSInteger TSval;
@property NSInteger TSecr;
@end

NS_ASSUME_NONNULL_END
