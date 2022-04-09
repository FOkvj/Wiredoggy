//
//  AppDelegate.m
//  Sniffer
//
//  Created by DZC on 2022/3/27.
//
#import "AppDelegate.h"
#import "MainController.h"
@interface AppDelegate () {
}

@property (strong) IBOutlet NSWindow *window;

// private stuff

@end

@implementation AppDelegate

- (IBAction)showCaptureWindow:(id)sender {
    mainWindow = nil;
    if (!mainWindow) {
        mainWindow = [[MainController new] initWithWindowNibName:@"StartWindow"];
    }
    [mainWindow showWindow:nil];
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    #pragma unused(sender)
    return YES;
}

@end
