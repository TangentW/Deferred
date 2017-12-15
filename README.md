# Deferred
[![](https://img.shields.io/badge/language-ObjectiveC-blue.svg)](https://github.com/TangentW/Deferred)
[![CocoaPods](https://img.shields.io/cocoapods/v/TanDeferred.svg)](https://github.com/TangentW/Deferred)
[![](https://img.shields.io/badge/wechat-FlashLuster-green.svg)](https://github.com/TangentW)

## Introduction
A little `Functional` & `Reactive` programming library.

## Installation
###  Cocoapods
Add `TanDeferred` in your `Podfile`:

```
use_frameworks!

pod "TanDeferred"
```

Then run the following command:

```
$ pod install
```

### Manually
1. Download the source code.
2. Drag folder **Deferred/Deferred** into your project.

## Usage
### Basic usage
```Objc
// Create an instance of Deferred
Deferred *deferred = [Deferred deferred];

// Subscribe
[deferred subscribe:^(id  _Nullable value) {
    NSLog(@"%@", value);
}];

// Just fill it
[deferred fill:@"Hello World"];
```

Or you can create with an initialized value:

```Objc
Deferred *deferred = [Deferred just:@"Hello World"];
```

### Map & FlatMap
```Objc
[[[deferred map:^id _Nullable(id  _Nullable value) {
    return [value stringByAppendingString:@"Good morning"];
}] flatMap:^Deferred * _Nonnull(id  _Nullable value) {
    return [Deferred just:[value stringByAppendingString:@"Good night"]];
}] subscribe:^(id  _Nullable value) {
    NSLog(@"%@", value);
}];
```

### Multi-thread
There are `four` queues to control `Deferred` to execute missions with `multi-thread`:

* MainQueue
* SyncQueue （Default）
* AsyncQueue
* CustomQueue

```Objc
[[deferred mapOn:[AsyncQueue shared] with:^id _Nullable(id  _Nullable value) {
    return [value stringByAppendingString:@"Baby"];
}] subscribeOn:[MainQueue shared] with:^(id  _Nullable value) {
    NSLog(@"%@", value);
}];
```

## License
The MIT License (MIT)

