//
//  ItemDelegate.h
//  Sniffer
//
//  Created by DZC on 2022/4/6.
//
/**
 用于生成outlineViewItem
 */
#import <Foundation/Foundation.h>
#import "OutlineViewItem.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ItemDelegate <NSObject>
-(id) getOutlineViewItem;
@end

NS_ASSUME_NONNULL_END
