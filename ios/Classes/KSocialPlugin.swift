import Flutter
import FBSDKCoreKit
import UIKit

public class KSocialPlugin: NSObject, FlutterPlugin {
    let facebookLogin = FacebookLogin()
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "k_social", binaryMessenger: registrar.messenger())
    let instance = KSocialPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method.contains("facebook") {
            facebookLogin.handle(call, result: result)
        }
  }

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        var options = [UIApplication.LaunchOptionsKey : Any]()
        for (k, value) in launchOptions {
            if let key = k as? UIApplication.LaunchOptionsKey {
                options[key] = value
            }
        }
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: options)
        
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(
            application,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}

