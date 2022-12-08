import UIKit
import Flutter
import background_locator
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
      GeneratedPluginRegistrant.register(with: self)
      BackgroundLocatorPlugin.setPluginRegistrantCallback(registerPlugins)
      registerOtherPlugins()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func registerOtherPlugins() {
    }
}

func registerPlugins(registry: FlutterPluginRegistry) -> () {
    if (!registry.hasPlugin("BackgroundLocatorPlugin")) {
        GeneratedPluginRegistrant.register(with: registry)
    }
}
