//
//  SharedData.m
//  Sniffer
//
//  Created by DZC on 2022/3/30.
//

#import "SharedData.h"
static SharedData* sharedData = nil;

@implementation SharedData


-(id)init{
    self = [super init];
    if (self) {
        _tableViewList = [NSMutableArray new];
        _outlineViewList = [NSMutableArray new];
        _dataList = [NSMutableArray new];
        _selectedRow = 0;
    }
    return self;
}

+(instancetype)getSharedDataInstance {
    if (sharedData == nil) {
        sharedData = [SharedData new];
    }
    return sharedData;
}

@end
