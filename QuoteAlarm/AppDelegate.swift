//
//  AppDelegate.swift
//  QuoteAlarm
//
//  Created by Saga on 2021/10/19.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 通知許可
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                userNotificationCenter.delegate = self
            } else {
                print("通知が許可されていません")
            }
        }
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // アプリがフォアグラウンドで動作している時に届いた通知をどのように処理するか
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    }

    // 通知をタップした場合の動作
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        UserDefaults.standard.setValue("fromDidReceive", forKey: "FromDidReceive")

    }

}

