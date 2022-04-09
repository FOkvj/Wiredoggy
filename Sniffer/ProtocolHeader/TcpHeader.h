//
//  TcpPackege.h
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import <Cocoa/Cocoa.h>
#import "TCPTimeStampOption.h"
#import "InfoDelegate.h"
#import "ItemDelegate.h"
@interface TcpHeader: NSObject <InfoDelegate, ItemDelegate>

@property NSInteger sourcePort;
@property NSInteger destPort;
@property NSInteger seq;
@property NSInteger Ack;
@property NSInteger flags;
@property NSInteger flag_ACK;
@property NSInteger flag_SYN;
@property NSInteger flag_FIN;
@property NSInteger flag_URG;
@property NSInteger flag_PSH;
@property NSInteger winSize;
@property NSInteger headerCheckSum;
@property NSInteger urgentPointer;
@property NSInteger payloadLen;
@property float timeStamp;
@property NSInteger TSval;
@property NSInteger ESecr;
@property NSInteger offset;
@property TCPTimeStampOption* option;

@end

