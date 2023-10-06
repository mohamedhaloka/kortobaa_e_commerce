import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)



     let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "order_methods",
                                                  binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
 guard call.method == "confirmOrder" else {
    result(FlutterMethodNotImplemented)
    return
  }

  let args = call.arguments as? Dictionary<String, Any>
    if let url = URL(string: args["paymentUrl"]) {
        UIApplication.shared.open(url)
    }

        })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


}
