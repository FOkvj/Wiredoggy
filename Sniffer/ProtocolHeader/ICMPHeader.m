//
//  ICMPHeader.m
//  Sniffer
//
//  Created by DZC on 2022/4/7.
//

#import "ICMPHeader.h"

@implementation ICMPHeader
- (NSString *)getInfo {
    NSString* status = @"";
    if (_type == ICMP_ECHO) status = @"request";
    else if (_code == ICMP_ECHOREPLY) status = @"reply";
    NSString* info = [NSString stringWithFormat:@"Echo (ping) %@ id=0x%x, seq=%d/%d, ", status, _idBE, _seqNumBE, _seqNumLE];
    return info;
}
- (id)getOutlineViewItem {
    OutLineViewItem* item1;
    NSString* name1 = @"";
    name1 =  [name1 stringByAppendingString:@"Internet Control Message Protocol"];
    item1 = [[OutLineViewItem new] initWithName:name1];
    OutLineViewItem* typeItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Type: %d", _type]];
    [item1 addChildren:typeItem];
    OutLineViewItem* codeItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Code: %d", _code]];
    [item1 addChildren:codeItem];
    OutLineViewItem* sumItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Check sum: 0x%x", _checkSum]];
    [item1 addChildren:sumItem];
    OutLineViewItem* idbeItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Identifier(BE): %d(%0x%x)", _idBE, _idBE]];
    [item1 addChildren:idbeItem];
    OutLineViewItem* idleItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Identifier(LE): %d(%0x%x)", _idLE, _idLE]];
    [item1 addChildren:idleItem];
    OutLineViewItem* seqbeItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Sequence number(BE): %d(0x%x)", _seqNumBE, _seqNumBE]];
    [item1 addChildren:seqbeItem];
    OutLineViewItem* seqleItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Sequence number(LE): %d(0x%x)", _seqNumLE, _seqNumLE]];
    [item1 addChildren:seqleItem];
                            
    return item1;
}
@end
