//
//  AppDelegate.h
//  Sniffer
//
//  Created by DZC on 2022/3/27.
//

#import <Cocoa/Cocoa.h>

@class MainController;
@class StartController;
@interface AppDelegate : NSObject <NSApplicationDelegate> {
    MainController* mainWindow;
}
//@property (atomic, copy,   readwrite) NSData *                  authorization;
-(IBAction)showCaptureWindow:(id)sender;

@end

