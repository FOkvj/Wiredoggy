//
//  InfoDelegate.h
//  Sniffer
//
//  Created by DZC on 2022/4/5.
//
/**
 这是一个生成信息的协议，签订该协议的类必须实现协议中的方法
 */
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol InfoDelegate <NSObject>
-(NSString*) getInfo;
@end

NS_ASSUME_NONNULL_END
