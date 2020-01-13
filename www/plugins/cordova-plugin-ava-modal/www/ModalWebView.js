cordova.define("cordova-plugin-ava-modal.ModalWebView", function(require, exports, module) {
var exec = require('cordova/exec');

function ModalWebView (onCloseCallback) {
  var successCallback = function (msg) {
    console.log('success: ' + msg);
    if (typeof onCloseCallback === 'function') {
      onCloseCallback(msg);
    }
  };
  var errorCallback = function (msg) {
    console.log('error: ' + msg);
    successCallback();
  };
  setTimeout(function () {
    exec(successCallback, errorCallback, 'ModalWebView', 'init', []);
  }, 10);
}

ModalWebView.prototype = {
  constructor: ModalWebView,
  open: function (price) {
    var successCallback = function (msg) {};
    var errorCallback = function (msg) {};
    exec(successCallback, errorCallback, 'ModalWebView', 'open', [price]);
  }
};

module.exports = ModalWebView;

});
