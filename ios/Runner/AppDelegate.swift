import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  /* override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
} */
override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
 FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

        let encryptionChannel = FlutterMethodChannel(name: "enc/dec", binaryMessenger: controller.binaryMessenger)
        encryptionChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // Note: this method is invoked on the UI thread.
            if(call.method == "encrypt"){
                guard let args = call.arguments as? [String : Any] else {return}
                let data = args["data"] as! String
                let key = args["key"] as! String
                let encryptedString = CryptoHelper.encrypt(dataFromFlutter: data, keyFromFlutter: key)
                self?.encrypt(result: result, encrypted: encryptedString!)
                return
            }else if(call.method == "decrypt"){
                guard let args = call.arguments as? [String : Any] else {return}
                let data = args["data"] as! String
                let key = args["key"] as! String
                let decryptedString = CryptoHelper.decrypt(dataFromFlutter: data, keyFromFlutter: key)
                self?.decrypt(result: result, decrypted: decryptedString!)
                return
            }else{
                result(FlutterMethodNotImplemented)
                return
            }
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func encrypt(result: FlutterResult, encrypted: String) {
        result(encrypted)
    }

    private func decrypt(result: FlutterResult, decrypted: String) {
        result(decrypted)
    }

final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    // ...
    notificationCategories: [
    const DarwinNotificationCategory(
        'demoCategory',
        <DarwinNotificationAction>[
            IOSNotificationAction('id_1', 'Action 1'),
            IOSNotificationAction(
            'id_2',
            'Action 2',
            options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
            },
            ),
            DarwinNotificationAction(
            'id_3',
            'Action 3',
            options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
            },
            ),
        ],
        options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
    )
],
}