//
//  OutlineViewController.h
//  Sniffer
//
//  Created by DZC on 2022/3/29.
//

#import <Cocoa/Cocoa.h>
#import "SharedData.h"
NS_ASSUME_NONNULL_BEGIN

@interface OutlineViewController : NSObject <NSOutlineViewDataSource> {
    NSMutableArray* allPackets;
}

@property NSMutableArray* list;

@end

NS_ASSUME_NONNULL_END
