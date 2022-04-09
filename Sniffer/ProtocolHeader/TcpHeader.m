//
//  TcpPackege.m
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import "TcpHeader.h"

@implementation TcpHeader
- (NSString*) getInfo {
    NSString* info = [NSString stringWithFormat:@"%d->%d",_sourcePort,_destPort];
    NSString* flags = @"";
    if (_flag_ACK == 1) flags = [flags stringByAppendingString:@"ACK "];
    if (_flag_SYN == 1) flags = [flags stringByAppendingString:@"SYN "];
    else if (_flag_FIN == 1) flags = [flags stringByAppendingString:@"FIN "];
    if (_flag_URG == 1) flags = [flags stringByAppendingString:@"URG "];
    if (_flag_PSH == 1) flags = [flags stringByAppendingString:@"PSH "];
    if (flags) info = [info stringByAppendingFormat:@"[%@]", flags];
    info = [info stringByAppendingFormat:@" Seq=%d Ack=%d Len=%d", _seq, _Ack, _payloadLen];
    if (_option) {
        info = [info stringByAppendingFormat:@" TSval=%d TSerc=%d", _option.TSval, _option.TSecr];
    }
    return info;
}

- (OutLineViewItem*)getOutlineViewItem {
    OutLineViewItem* item1;
    NSString* name1 = @"";
    name1 =  [name1 stringByAppendingFormat:@"Transmission Control Protocol, Src Port: %d, Dst Port: %d, Seq: %d, Ack: %d, Len: %d", _sourcePort, _destPort, _seq, _Ack, _offset];
    item1 = [[OutLineViewItem new] initWithName:name1];
    OutLineViewItem* spItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Source port: %d", _sourcePort]];
    [item1 addChildren:spItem];
    OutLineViewItem* dpItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Destination port: %d",_destPort]];
    [item1 addChildren:dpItem];
    OutLineViewItem* lenItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"TCP segment len: %d", _offset]];
    [item1 addChildren:lenItem];
    OutLineViewItem* offItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Fragment offset: %d", _offset]];
    [item1 addChildren:offItem];
    OutLineViewItem* seqItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Sequence number: %d", _seq]];
    [item1 addChildren:seqItem];
    OutLineViewItem* ackItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Acknowlegement number : %d", _Ack]];
    [item1 addChildren:ackItem];
    OutLineViewItem* sum = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Header check sum: 0x%x", _headerCheckSum]];
    [item1 addChildren:sum];
    OutLineViewItem* winItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Window : %d", _winSize]];
    [item1 addChildren:winItem];
    OutLineViewItem* urgentItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Urgent pointer: %d", _urgentPointer]];
    [item1 addChildren:urgentItem];

    NSString* flags;
    if (_flag_ACK == 1) flags = [flags stringByAppendingString:@"ACK "];
    if (_flag_SYN == 1) flags = [flags stringByAppendingString:@"SYN "];
    else if (_flag_FIN == 1) flags = [flags stringByAppendingString:@"FIN "];
    if (_flag_URG == 1) flags = [flags stringByAppendingString:@"URG "];
    if (_flag_PSH == 1) flags = [flags stringByAppendingString:@"PSH "];
    OutLineViewItem* flagsItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Flags: 0x%x (%@)", _flags, flags]];
    [item1 addChildren:flagsItem];
    return item1;
}
@end


