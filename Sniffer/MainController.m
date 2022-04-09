//
//  MainController.m
//  Sniffer
//
//  Created by DZC on 2022/3/30.
//

#import "MainController.h"

#import "PackegeUtils.h"
#import "TableViewRow.h"
//#import <pcap/bpf.h>
#import <net/bpf.h>
@interface MainController ()

@end


@implementation MainController
//用于子线程
id refSelf;
///线程同步锁
NSCondition *showCondtion;
NSCondition *captureCondition;
/**
 MainController初始化
 */
- (id) init {
    self = [super init];
    if (self) {
        tableViewList = [SharedData getSharedDataInstance].tableViewList;
        outlineViewList = [SharedData getSharedDataInstance].outlineViewList;
        dataList = [SharedData getSharedDataInstance].dataList;
        [tableView setColumnAutoresizingStyle:NSTableViewUniformColumnAutoresizingStyle];
        [tableView sizeToFit];
        refSelf = self;
        [stopButton setEnabled:NO];
        showCondtion = [NSCondition new];
        captureCondition = [NSCondition new];
        timeLimit = 11.0;
        NSLog(@"Mainthread%@", [NSThread currentThread]);
    }
    return self;
}
/**
 C
 */
/**
 处理所用变量
 */
int link_header_len;

- (IBAction)startCapture:(id)sender {
    [tableView setColumnAutoresizingStyle:NSTableViewUniformColumnAutoresizingStyle];
    [tableView sizeToFit];
    [self clearData];
    [self start];
}

- (void)capture:(NSString*)fiterStr{

    char *device;
    char error_buffer[PCAP_ERRBUF_SIZE];
    struct bpf_program bpf;
    bpf_u_int32 netmask;
    bpf_u_int32 srcip;
    pcap_t *handle;
    int timeout_limit = 10000; /* In milliseconds */
    NSString* devName = [[SharedData getSharedDataInstance].selectedDev name];
    device = [devName UTF8String];
    if (device == NULL) {
        printf("Error finding device: %s\n", error_buffer);
       
    }
    // Get network device source IP address and netmask.
    if (pcap_lookupnet(device, &srcip, &netmask, error_buffer) == PCAP_ERROR) {
        printf("Error finding device: %s\n", error_buffer);
    }
    /* Open device for live capture */
    handle = pcap_open_live(device, BUFSIZ, 0, timeout_limit, error_buffer);
    
    /**设置filter*/
    char* filter = [fiterStr UTF8String];
    // Convert the packet filter epxression into a packet filter binary.
    if (pcap_compile(handle, &bpf, filter, 1, netmask) == PCAP_ERROR) {
        fprintf(stderr, "pcap_compile(): %s\n", pcap_geterr(handle));
    }

    // Bind the packet filter to the libpcap handle.
    if (pcap_setfilter(handle, &bpf) == PCAP_ERROR) {
        fprintf(stderr, "pcap_setfilter(): %s\n", pcap_geterr(handle));
    }
    /*获取数据链路层头部长度*/
    link_header_len = get_link_header_len(handle);
    //连续循环抓包
    pcap_loop(handle, 0, packet_handler, NULL);

}


void packet_handler(u_char *dumpfile, const struct pcap_pkthdr *header, const u_char *pkt_data){
    
    //检查当前线程是否别取消
    if ([NSThread currentThread].isCancelled == YES) {
        [NSThread exit];
    }
    //用于展示
    NSMutableArray* headerPack = [NSMutableArray new];
    TableViewRow* tableViewRow = [TableViewRow new];
    
    //16进制展示
    NSString* data = @"\n";
    NSMutableArray* dataList = [SharedData getSharedDataInstance].dataList;
   for (int i = 1; (i < header->caplen + 1 ) ; i++)
   {
       data = [data stringByAppendingFormat:@"%.2x  ", pkt_data[i-1]];
       if ((i % 16) == 0) data = [data stringByAppendingFormat:@"\n"];
   }
    
    
    //frame总览
    OutLineViewItem* frame;
    NSString* name = @"";
    name =  [name stringByAppendingFormat:@"Frame: %d bytes on wire,  %d bytes capture on interface %@", header->len, header->caplen,[[SharedData getSharedDataInstance].selectedDev name]];
    frame = [[OutLineViewItem new] initWithName:name];

    //包id
    tableViewRow.identy = [[refSelf valueForKey:@"tableViewList"] count];
    struct tm *ltime = localtime(&header->ts.tv_sec); //将时间戳转换为可读字符
    char timestr[16];
    strftime(timestr, sizeof timestr, "%H:%M:%S", ltime);
    //包时间
    tableViewRow.time = [NSString stringWithUTF8String:timestr];
    OutLineViewItem* timeItem = [[OutLineViewItem new] initWithName:[NSString stringWithFormat:@"Echo time: %s", timestr]];
    [frame addChildren:timeItem];
    [headerPack addObject:frame];
    
    /**--------------协议解析--------------*/
    //封装以太头
    EthernetHeader* ethernetHeader = packEthernetHeader(pkt_data);
    [headerPack addObject: [ethernetHeader getOutlineViewItem]];
    pkt_data += link_header_len;//跳过数据链路层
    //IP
    if ([ethernetHeader.type hasPrefix:@"IP"] ) {

        
        NSString* protocol;
        IPHeader* ipHeader;
        if ([ethernetHeader.type isEqualToString:@"IPv6"]) {
            IPv6Header* ipv6Header = packIPv6Header(pkt_data);
            protocol = ipv6Header.nextHeader;
            tableViewRow.source = ipv6Header.srcAddr;
            tableViewRow.destination = ipv6Header.dstAddr;
            [headerPack addObject:[ipv6Header getOutlineViewItem]];
            pkt_data += 40;//ipv6头固定40字节
        }
        else if ([ethernetHeader.type isEqualToString:@"IPv4"]) {
            ipHeader = packIPHeader(pkt_data);
            [headerPack addObject:[ipHeader getOutlineViewItem]];
            tableViewRow.source = ipHeader.sourceIP;
            tableViewRow.destination = ipHeader.destIP;
            pkt_data += ipHeader.headerLen*4; //ip长度字段单位为4字节
            protocol = ipHeader.protocol;
        }

        //TCP
        if ([protocol isEqualToString:@"TCP"]) {
            TcpHeader* tcpHeader = packTcpHeader(pkt_data);
            [headerPack addObject:[tcpHeader getOutlineViewItem]];
            tableViewRow.protocol = @"TCP";
            tableViewRow.info = [tcpHeader getInfo];
            tableViewRow.length = tcpHeader.offset * 4;
            //http
            if (tcpHeader.sourcePort == 80 || tcpHeader.destPort == 80) {
                pkt_data += tcpHeader.offset * 4;
                
            }
        }
        //UDP
        else if ([protocol isEqualToString:@"UDP"]) {
            UDPHeader* udpHeader = packUDPHeader(pkt_data);
            [headerPack addObject:[udpHeader getOutlineViewItem]];
            tableViewRow.protocol = @"UDP";
            tableViewRow.length = udpHeader.length;
            tableViewRow.info = [udpHeader getInfo];
        }
        //ICMP
        else if ([protocol isEqualToString:@"ICMP"]) {
            ICMPHeader* icmpHeader = packICMPHeader(pkt_data);
            [headerPack addObject:[icmpHeader getOutlineViewItem]];
            tableViewRow.protocol = @"ICMP";
            tableViewRow.length = header->caplen;
            NSString* info = [icmpHeader getInfo];
            info = [info stringByAppendingFormat:@"ttl=%d", ipHeader.timeToLive];
            tableViewRow.info = info;
        }
    }
    //ARP
    else if ([ethernetHeader.type isEqualToString:@"ARP"]) {
        ARPHeader* arpHeader = packARPHeader(pkt_data);
        [headerPack addObject:[arpHeader getOutlineViewItem]];
        tableViewRow.protocol = @"ARP";
        tableViewRow.source = ethernetHeader.sourceMac;
        tableViewRow.destination = ethernetHeader.destMac;
        tableViewRow.info = [arpHeader getInfo];
    }

    NSMutableArray* tableViewList = [SharedData getSharedDataInstance].tableViewList;
    NSMutableArray* outlineViewList = [SharedData getSharedDataInstance].outlineViewList;
  
    //封装tableviewrow
    [tableViewList addObject: tableViewRow];
    //加入outlineview展示列表
    [outlineViewList addObject:headerPack];
    //data部分
    [dataList addObject:data];
    
    NSLog(@"capture%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:2];
    [refSelf performSelectorOnMainThread:@selector(flush) withObject:refSelf waitUntilDone:YES];

}

- (void)flush{
    [tableView reloadData];
    [outlineView reloadData];
    [self updateDataTextField];
}

- (IBAction)stopCapture:(id)sender {
    [self stop];
}

- (IBAction)rowChangeSelected:(id)sender
{
    
    NSInteger old = [SharedData getSharedDataInstance].selectedRow;
    NSInteger cur = [tableView selectedRow];
    if (old != cur) {
        [SharedData getSharedDataInstance].selectedRow = cur;
        
    }
    [outlineView reloadData];
    [self updateDataTextField];
}

- (void)updateDataTextField {
    NSInteger selectedRow = [SharedData getSharedDataInstance].selectedRow;
    if (selectedRow >= 0 && [dataList count] > 0) {
        [dataTextField setStringValue:[dataList objectAtIndex:selectedRow]];
    }
}

- (IBAction)filte:(id)sender {
    if ([filterTextField stringValue] && ![[filterTextField stringValue] isEqualToString:@""] ) {
        [self stop];
        [self clearData];
        [self start];
    }
}

- (void)start{
    [self startTimer];
    [SharedData getSharedDataInstance].selectedRow = 0;
    [tableView reloadData];
    [outlineView reloadData];
    [startButton setEnabled:NO];
    captureThread = [[NSThread new] initWithTarget:self selector:@selector(capture:) object:[filterTextField stringValue]];
    [captureThread start];
    [stopButton setEnabled:YES];
}

- (void)stop{
    [startButton setEnabled:YES];
    [stopButton setEnabled:NO];
    [captureThread cancel];
}

- (void)clearData{
    [tableViewList removeAllObjects];
    [outlineViewList removeAllObjects];
    [dataTextField setStringValue:@""];
    [dataList removeAllObjects];
    
}

/**进度条*/
- (void)startTimer
{
    [self resetElapsedTime];
    if (timer == nil)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(timerTickHandler)
                                               userInfo:nil
                                                repeats:YES];
    }
}

- (void)stopTimer
{
    [timer invalidate];
    timer = nil;
}

- (void)timerTickHandler
{
    [self updateElapsedTime];
    [progressBar setDoubleValue:elapsedTime];
    
    if (elapsedTime > timeLimit)
    {
        [self resetElapsedTime];
        [progressBar setDoubleValue:0.0f];
        [self stopTimer];
    }
}

- (void)updateElapsedTime
{
    elapsedTime = [NSDate timeIntervalSinceReferenceDate] - startTime;
}

- (void)resetElapsedTime
{
    startTime = [NSDate timeIntervalSinceReferenceDate];
    [self updateElapsedTime];
}
@end
