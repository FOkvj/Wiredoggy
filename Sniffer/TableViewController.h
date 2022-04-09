//
//  TableViewController.h
//  Sniffer
//
//  Created by DZC on 2022/3/28.
//

#import <Cocoa/Cocoa.h>
#import "SharedData.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : NSObject <NSTableViewDataSource>  {
@private
    
    NSMutableArray * list;
}
//@property (weak) IBOutlet NSMenu *tableViewMenu;
@end

NS_ASSUME_NONNULL_END
