//
//  OutLineViewItem.h
//  Sniffer
//
//  Created by DZC on 2022/4/6.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface OutLineViewItem : NSObject
@property NSString* name;
@property NSMutableArray* children;

- (id)initWithName:(NSString*) name;
- (void)addChildren:(OutLineViewItem *)item;
@end

NS_ASSUME_NONNULL_END
