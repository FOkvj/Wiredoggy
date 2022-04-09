//
//  Device.m
//  Sniffer
//
//  Created by DZC on 2022/4/3.
//

#import "Device.h"

@implementation Device

@synthesize name;
@synthesize type;
@synthesize status;
-(id)init{
    self = [super init];
    if (self) {
        status = 0;
    }
    return self;
}
@end
