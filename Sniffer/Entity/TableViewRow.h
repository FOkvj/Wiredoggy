//
//  TableViewRow.h
//  Sniffer
//
//  Created by DZC on 2022/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewRow : NSObject
@property NSInteger identy;
@property NSString* source;
@property NSString* destination;
@property NSString* protocol;
@property NSInteger length;
@property NSString* info;
@property NSString* time;
@end

NS_ASSUME_NONNULL_END
