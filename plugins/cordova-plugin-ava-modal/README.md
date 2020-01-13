---
title: ModalWebView
description: Open modal WebView.
---

# cordova-plugin-ava-modal


## Installation

This requires cordova 5.0+

## Usage

```js
var modal = new ModalWebView(function () {
  console.log('modal closed');
});

var button = document.getElementById('some_element');
button.addEventListener('click', function() {
  modal.open(some_var);
});
```
