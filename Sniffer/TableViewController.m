//
//  TableViewController.m
//  Sniffer
//
//  Created by DZC on 2022/3/28.
//

#import "TableViewController.h"
#import "TableViewRow.h"
@implementation TableViewController

- (id) init {
    self = [super init];
    if (self) {
        list = [SharedData getSharedDataInstance].tableViewList;
//        list = [NSMutableArray new];
    }
    return self;
}


- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
    return [list count];
}
//
- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    TableViewRow* tableViewRow = [list objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    return [tableViewRow valueForKey:identifier];
}
//- (void) tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    Layer *l = [list objectAtIndex:row];
//    NSString *identifier = [tableColumn identifier];
//    [l setValue:object forKey:identifier];
//}



@end
