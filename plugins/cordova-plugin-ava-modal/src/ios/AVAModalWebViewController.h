@import UIKit;

@protocol AVAModalWebViewControllerDelegate <NSObject>
- (void)avaModalWebViewControllerDidClose;
- (void)avaModalWebViewControllerDidClosePreview :(nonnull NSString *)data;
@end

@interface AVAModalWebViewController: UIViewController
@property (nonatomic, weak) __nullable id<AVAModalWebViewControllerDelegate> delegate;
- (void)open:(nonnull NSNumber*)aPrice;
@end

