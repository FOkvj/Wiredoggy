//
//  SharedData.h
//  Sniffer
//
//  Created by DZC on 2022/3/30.
//

#import <Cocoa/Cocoa.h>
#import "Device.h"

NS_ASSUME_NONNULL_BEGIN

@interface SharedData : NSObject {
}

@property NSMutableArray* tableViewList;
@property NSMutableArray* outlineViewList;
@property NSMutableArray* dataList;
@property NSInteger selectedRow;
@property Device* selectedDev;

+(instancetype)getSharedDataInstance;

@end

NS_ASSUME_NONNULL_END
