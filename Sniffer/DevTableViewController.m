//
//  DevTableViewController.m
//  Sniffer
//
//  Created by DZC on 2022/4/2.
//

#import "DevTableViewController.h"
#import "pcap.h"

@implementation DevTableViewController
- (id)init {
    self = [super init];
    if (self) {
        devList = [NSMutableArray new];
        [self initDev];
    }
    return self;
}
/**
 * find all devices
 */
-(void)initDev {
    char error_buffer[PCAP_ERRBUF_SIZE]; /* Size defined in pcap.h */
    /* Find a device */
    pcap_if_t *alldevsp;
    
    int dev_cnt = pcap_findalldevs(&alldevsp, error_buffer);
    if (dev_cnt == -1) return;
    for (pcap_if_t * d = alldevsp; d != NULL; d = d->next) {
        Device* dev = [Device new];
        NSString* name = [NSString stringWithUTF8String:d->name];
        dev.name = name;
        NSInteger flag = d->flags;
        if (flag & PCAP_IF_LOOPBACK) {
            dev.type = @"loopback";
            dev.status = DEV_IS_ALIVE;
        }
        if ((flag & PCAP_IF_CONNECTION_STATUS) == PCAP_IF_CONNECTION_STATUS_CONNECTED) {
            dev.status = DEV_IS_ALIVE;
        }
        if (flag & PCAP_IF_WIRELESS) {
            dev.type = @"wifi";
        }

        [devList addObject:dev];
    }
}
- (IBAction)selectedRowChange:(id)sender {
    [SharedData getSharedDataInstance].selectedDev = [devList objectAtIndex:[devTableView selectedRow]];
}
- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
        return [devList count];
}
- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    Device* dev = [devList objectAtIndex:row];
    
    NSString *identifier = [tableColumn identifier];
    if ([identifier isEqualToString:@"name"]) {
        if (dev.type) {
            return [dev.type stringByAppendingString:[@": " stringByAppendingString:dev.name]];
        } else {
            return dev.name;
        }
    } else if(dev.status == DEV_IS_ALIVE) {
        return @"alive";
    }
    return nil;
}


@end
