@import Foundation;
#import <Cordova/CDVPlugin.h>

@interface AVAModalWebView : CDVPlugin
- (void)init:(CDVInvokedUrlCommand *)command; // TODO method name
- (void)open:(CDVInvokedUrlCommand *)command;
@end

