//
//  DevTableViewController.h
//  Sniffer
//
//  Created by DZC on 2022/4/2.
//

#import <Cocoa/Cocoa.h>
#import "SharedData.h"
#import "Device.h"
NS_ASSUME_NONNULL_BEGIN

@interface DevTableViewController : NSObject <NSTableViewDataSource, NSTableViewDelegate> {
    IBOutlet NSTableView* devTableView;
    NSMutableArray* devList;
}
- (void) initDev;
- (IBAction)selectedRowChange:(id)sender;
@end

NS_ASSUME_NONNULL_END
