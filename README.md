# flutter_live_activity_ios_sample

A simple live activity ios for flutter


### Next Progress
- Live activity update
- Update live activity with push notification

## Getting Started

make sure your xcode is up to date to make this example works..

### Add an iOS platform-specific implementation

Open the file [AppDelegate.swift](https://github.com/RahmadFani/flutter_ios_live_activity_sample/) located under Runner > Runner in the Project navigator.

``` swift
let liveChannel = FlutterMethodChannel(name: "samples.flutter.dev/liveChannel",
                                                    binaryMessenger: controller.binaryMessenger)
// native to start live activity ios
if (call.method == "start") {
  do {
      let adventure = sample_ios_live_activityAttributes(name: "Sample")
  
      let initialState = sample_ios_live_activityAttributes.ContentState(
        value: 0
      )
      
      activity = try Activity.request(
          attributes: adventure,
          content: .init(state: initialState, staleDate: nil),
          pushType: nil
      )
      
  } catch {
      let errorMessage = """
                  Couldn't start activity
                  ------------------------
                  \(String(describing: error))
                  """
      
      result(FlutterError(code: "400", message: errorMessage, details: error))
  }
}
// and end live activity ios...
```

### Flutter to call/invoke native code

Open the file [main.dart](https://github.com/RahmadFani/flutter_ios_live_activity_sample/) locate under lib\main.dart

For start live activity ios 

``` dart 
const platform = MethodChannel('samples.flutter.dev/liveChannel');

try {
  await platform.invokeMethod('start');
} on PlatformException {
  // ! Error code here
}
```

For End live activity ios 

``` dart 
const platform = MethodChannel('samples.flutter.dev/liveChannel');

try {
  await platform.invokeMethod('end');
} on PlatformException {
  // ! Error code here
}
```

### Edit/Custom Live activity ios

You can edit/custom Live activity ios [sample_ios_live_activityLiveActivity.swift](https://github.com/RahmadFani/flutter_ios_live_activity_sample/blob/main/ios/sample_ios_live_activity/sample_ios_live_activityLiveActivity.swift), located at ios/flutter_ios_live_activity_sample or you can make new live activity, to make new you need open [Runner.xcworkspace] locate at ios after than open, choose File > New > Target. then search widget extension

