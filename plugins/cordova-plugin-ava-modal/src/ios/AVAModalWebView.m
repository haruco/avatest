#import "AVAModalWebView.h"
#import "AVAModalWebViewController.h"

// AARRGGBB
#define ARGB(c) [UIColor colorWithRed:(((c)>>16)&0xFF)/255.0 \
green:(((c)>>8)&0xFF)/255.0 \
blue:(((c)>>0)&0xFF)/255.0 \
alpha:(((c)>>24)&0xFF)/255.0]

@interface AVAModalWebView () <AVAModalWebViewControllerDelegate>
@property(nonatomic, strong) AVAModalWebViewController *modalController;
@property(nonatomic, copy) NSString *callbackId;
@end

@implementation AVAModalWebView
- (void)init:(CDVInvokedUrlCommand*)command {
	self.callbackId = command.callbackId;
}
- (void)open:(CDVInvokedUrlCommand*)command {

	NSNumber *price = [[command arguments] objectAtIndex:0];
	AVAModalWebViewController *rootController = [[AVAModalWebViewController alloc] init];
	rootController.delegate = self;
	rootController.title = @"Buy";
	self.modalController = rootController;
	UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:rootController];
	[naviController setModalPresentationStyle:UIModalPresentationOverCurrentContext];

	[self.viewController presentViewController:naviController animated:YES completion:^{
		[rootController open:price];
	}];

	CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}
- (void)avaModalWebViewControllerDidClose {
	[self.viewController dismissViewControllerAnimated:YES completion:nil];

	if (self.callbackId) {
		CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
		[result setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
	}
}

- (void)avaModalWebViewControllerDidClosePreview :(nonnull NSString *)data {
	[self.viewController dismissViewControllerAnimated:YES completion:nil];

	if (self.callbackId) {
		CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:data];
		[result setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
	}
}

- (void)onReset {
	[super onReset];
	self.callbackId = nil;
}
@end
