import Flutter
import UIKit

public class SwiftFlutterPluginMipushPlugin: NSObject, FlutterPlugin ,MiPushSDKDelegate, UNUserNotificationCenterDelegate {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_mipush", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginMipushPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if (call.method == "init") {
        initPush(result: result)
        print("注册推送")
      }else if(call.method == "loginIn"){
//        登录进入
        MiPushSDK.setAlias((call.arguments as? [String:Any])?["userId"] as? String)
        print((call.arguments as? [String:Any])?["userId"] as? String)
      }else if(call.method == "loginOut"){
//        退出进入
        MiPushSDK.unsetAlias((call.arguments as? [String:Any])?["userId"] as? String)
      }
        
    }
    private func initPush(result: @escaping FlutterResult) {
//      NSLog(TAG + "initPush")
      MiPushSDK.registerMiPush(self, type: UIRemoteNotificationType(rawValue: UInt(0)), connect: true)
      result("success")
    }
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//      let nsdata = NSData(data: deviceToken)
//      let token = nsdata.description
//      NSLog(TAG + "application, token = " + token)
      MiPushSDK.bindDeviceToken(deviceToken)
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
      MiPushSDK.handleReceiveRemoteNotification(userInfo)
      return true
    }
    
    @available(iOS 10.0, *)
      public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo: [AnyHashable : Any] = notification.request.content.userInfo;
      if notification.request.trigger is UNPushNotificationTrigger {
        MiPushSDK.handleReceiveRemoteNotification(userInfo)
      }
      completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    @available(iOS 10.0, *)
      public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo: [AnyHashable : Any] = response.notification.request.content.userInfo;
      if response.notification.request.trigger is UNPushNotificationTrigger {
        MiPushSDK.handleReceiveRemoteNotification(userInfo)
        let log = "MiPush notify: \(userInfo)"
        NSLog(log)
      }
      completionHandler()
    }
    
    public func miPushRequestSucc(withSelector selector: String!, data: [AnyHashable : Any]!) {
//      NSLog(TAG + "miPushRequestSucc, selector = " + selector + ", data = " + data.description)
    }
    
    public func miPushRequestErr(withSelector selector: String!, error: Int32, data: [AnyHashable : Any]!) {
  //    NSLog(TAG + "miPushRequestErr, selector = " + selector + ", error = " + error.description + ", data = " + data.description)
    }
    
    public func miPushReceiveNotification(_ data: [AnyHashable : Any]!) {
//      NSLog(TAG + "miPushReceiveNotification, data = " + data.description)
    }
}
