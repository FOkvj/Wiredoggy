//
//  MainController.h
//  Sniffer
//
//  Created by DZC on 2022/3/30.
//

#import <Cocoa/Cocoa.h>
#import "SharedData.h"
#import "pcap.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainController : NSWindowController{
    //展示数据部件的数据源引用
    NSMutableArray* tableViewList;
    NSMutableArray* outlineViewList;
    NSMutableArray* dataList;
    
    //主展示部件
    __weak IBOutlet NSTableView *tableView;
    __weak IBOutlet NSOutlineView *outlineView;
    __weak IBOutlet NSTextField *dataTextField;
    
    __weak IBOutlet NSTextField *filterTextField;
    __weak IBOutlet NSButton *startButton;
    __weak IBOutlet NSButton *stopButton;
    
    //进度条
    __weak IBOutlet NSProgressIndicator *progressBar;
    NSTimeInterval startTime;
    NSTimeInterval elapsedTime;
    NSTimeInterval timeLimit;
    NSTimer *timer;
    
    //抓包线程
    NSThread* captureThread;
}


///接收UI部件动作
- (IBAction)startCapture:(id)sender;
- (IBAction)stopCapture:(id)sender;
- (IBAction)rowChangeSelected:(id)sender;
- (IBAction)filte:(id)sender;


///抓包
- (void)capture:(NSString*)fiterStr;
- (void)flush;
- (void)clearData;
- (void)start;
- (void)stop;
- (void)updateDataTextField;


///进度条
- (void)startTimer;
- (void)stopTimer;
- (void)timerTickHandler;
- (void)updateElapsedTime;
- (void)resetElapsedTime;
@end

NS_ASSUME_NONNULL_END
