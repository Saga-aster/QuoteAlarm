//
//  AlarmSettingView.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/02/06.
//

import UIKit

class AlarmSettingView: UIViewController {

    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var repeatStatusLabel: UILabel!
    @IBOutlet weak var currentSelectedSoundLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // アラーム設定
    func alarmSet() {

        // アラーム時刻の取得〜変換
        let calendar = Calendar(identifier: .gregorian)
        UserDefaults.standard.setValue(alarmDatePicker.date, forKey: "AlarmDate")
        let dateComponents = calendar.dateComponents([.weekday, .hour, .minute], from: alarmDatePicker.date)
        print(dateComponents)

        // NotificationCenterのインスタンス
        let notificationCenter = UNUserNotificationCenter.current()

        // 新たな通知設定の前に、予定されている全ての通知設定を解除
        notificationCenter.removeAllDeliveredNotifications()

        // 通知内容
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "おはようございます"
        notificationContent.body = "今日の名言を見てみましょう！"
//        notificationContent.sound =

        // 通知のトリガー設定
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // 通知の識別子
        let notificationIdentifier = "Notification"

        // 通知リクエストを作成
        let notificationRequest = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: notificationTrigger)

        // 作成したリクエストで通知設定
        notificationCenter.add(notificationRequest, withCompletionHandler: nil)

    }

}

