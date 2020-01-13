declare namespace CordovaPluginModalWebView {
  interface ModalWebView {
    open(price: string): void;
  }
  interface ModalWebViewStatic {
    new (closeCallback?: () => void): ModalWebView;
  }
}

interface Window {
  ModalWebView: CordovaPluginModalWebView.ModalWebViewStatic;
}

declare var ModalWebView: CordovaPluginModalWebView.ModalWebViewStatic;
