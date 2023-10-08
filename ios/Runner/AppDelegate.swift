import UIKit
import ActivityKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let liveChannel = FlutterMethodChannel(name: "samples.flutter.dev/liveChannel",
                                                    binaryMessenger: controller.binaryMessenger)
      var activity: Activity<sample_ios_live_activityAttributes>? = nil;
      
      liveChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if (call.method == "start") {
              // pasang native life activity
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
          if (call.method == "end") {
              if (activity != nil) {
                  let finalContent = sample_ios_live_activityAttributes.ContentState(
                    value: 100
                  )
                  Task {
                      await activity?.end(ActivityContent(state: finalContent, staleDate: nil), dismissalPolicy: .immediate)
                      activity = nil;
                  }
              }
          }
        })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
