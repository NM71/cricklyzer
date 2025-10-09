import Flutter
import UIKit
import Photos

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "com.cricklyzer.permissions"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "requestStoragePermission":
        self?.requestPhotoPermission(result: result)
      case "checkStoragePermission":
        result(self?.checkPhotoPermission() ?? false)
      case "requestCameraPermission":
        self?.requestCameraPermission(result: result)
      case "checkCameraPermission":
        result(self?.checkCameraPermission() ?? false)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func checkPhotoPermission() -> Bool {
    let status = PHPhotoLibrary.authorizationStatus()
    return status == .authorized || status == .limited
  }

  private func requestPhotoPermission(result: @escaping FlutterResult) {
    if checkPhotoPermission() {
      result(true)
      return
    }

    PHPhotoLibrary.requestAuthorization { status in
      DispatchQueue.main.async {
        let granted = status == .authorized || status == .limited
        result(granted)
      }
    }
  }

  private func checkCameraPermission() -> Bool {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    return status == .authorized
  }

  private func requestCameraPermission(result: @escaping FlutterResult) {
    if checkCameraPermission() {
      result(true)
      return
    }

    AVCaptureDevice.requestAccess(for: .video) { granted in
      DispatchQueue.main.async {
        result(granted)
      }
    }
  }
}
