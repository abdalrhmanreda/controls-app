import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let channel = FlutterMethodChannel(name: "tech.codex.shared_auth/token",
                                       binaryMessenger: engineBridge.applicationRegistrar.messenger())
    channel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if (call.method == "getSharedKeychainGroupId") {
        let teamID = self?.getTeamID() ?? "ABDSDa125"
        result("\(teamID).com.codex.shared")
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
  }

  private func getTeamID() -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: "bundleSeedID",
      kSecAttrService as String: "bundleSeedID",
      kSecReturnAttributes as String: true
    ]
    
    var result: AnyObject?
    var status = SecItemCopyMatching(query as CFDictionary, &result)
    
    if status == errSecItemNotFound {
      status = SecItemAdd(query as CFDictionary, nil)
      if status == errSecSuccess {
        status = SecItemCopyMatching(query as CFDictionary, &result)
      }
    }
    
    if status == errSecSuccess, let dict = result as? [String: Any], let accessGroup = dict[kSecAttrAccessGroup as String] as? String {
      let components = accessGroup.components(separatedBy: ".")
      if !components.isEmpty {
        return components[0]
      }
    }
    return nil
  }
}
