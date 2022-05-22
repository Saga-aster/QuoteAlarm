//
//  AlarmSetting.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/04/25.
//

import Foundation
import UserNotifications

class AlarmSetting {

    func setAlarm(alarmData: AlarmData) {

        print("AlarmData: \(alarmData.date),\(alarmData.repeatWeekdayFlags),\(alarmData.snooze),\(alarmData.soundName)")
        // インスタンス
        let notificationCenter = UNUserNotificationCenter.current()
        let notificationContent = UNMutableNotificationContent()
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = calendar.dateComponents([.hour, .minute], from: alarmData.date)

        // 新たな通知設定の前に、予定されている全ての通知設定を解除
        notificationCenter.removeAllPendingNotificationRequests()

        // 通知内容
        notificationContent.title = "おはようございます"
        notificationContent.body = "今日の名言を見てみましょう！"
        notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: alarmData.soundName + ".mp3"))

        if alarmData.repeatWeekdayFlags[0] == true {

            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let notificationIdentifier = "Notification"
            let notificationRequest = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: notificationTrigger)
            notificationCenter.add(notificationRequest, withCompletionHandler: nil)

            if alarmData.snooze == true {
                let snoozeDate = DateComponents(hour: dateComponents.hour, minute: dateComponents.minute! + 5)
                print("Snooze: \(snoozeDate)")
                let snoozeTrigger = UNCalendarNotificationTrigger(dateMatching: snoozeDate, repeats: false)
                let snoozeRequest = UNNotificationRequest(identifier: "Snooze", content: notificationContent, trigger: snoozeTrigger)
                notificationCenter.add(snoozeRequest, withCompletionHandler: nil)

            }

        } else {

            var repeatDateComponents = [DateComponents]()
            // zipで配列のインデックスと要素を取得する
            for (index, flag) in zip(alarmData.repeatWeekdayFlags.indices, alarmData.repeatWeekdayFlags) {

                if flag {

                    switch index {
                        // 曜日がtrue -> 該当曜日ごとにDateを生成する（0は繰り返し「なし」のため何もしない）
                        // 月 -> 2　日 -> 1
                    case 1:
                        dateComponents.weekday = 2
                        print("Mon:\(calendar.date(from: dateComponents)!)")
                        repeatDateComponents.append(dateComponents)
                    case 2:
                        dateComponents.weekday = 3
                        print("Tue:\(calendar.date(from: dateComponents)!)")
                        repeatDateComponents.append(dateComponents)
                    case 3:
                        dateComponents.weekday = 4
                        print("Wed:\(calendar.date(from: dateComponents)!)")
                        repeatDateComponents.append(dateComponents)
                    case 4:
                        dateComponents.weekday = 5
                        print("Thu:\(calendar.date(from: dateComponents)!)")
                        repeatDateComponents.append(dateComponents)
                    case 5:
                        dateComponents.weekday = 6
                        print("Fri:\(calendar.date(from: dateComponents)!)")
                        repeatDateComponents.append(dateComponents)
                    case 6:
                        dateComponents.weekday = 7
                        print("Sat:\(calendar.date(from: dateComponents)!)")
                        repeatDateComponents.append(dateComponents)
                    case 7:
                        dateComponents.weekday = 1
                        print("Sun:\(calendar.date(from: dateComponents)!)")
                        repeatDateComponents.append(dateComponents)
                    default:
                        break
                    }

                }

            }

            for repeatDate in repeatDateComponents {

                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: repeatDate, repeats: true)
                let notificationIdentifier = "Notification:" + "\(repeatDate.weekday!)"
                print("identifier: \(notificationIdentifier)")
                let notificationRequest = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: notificationTrigger)
                notificationCenter.add(notificationRequest, withCompletionHandler: nil)
                print(notificationCenter)

                if alarmData.snooze == true {
                    let snoozeDate = DateComponents(hour: repeatDate.hour!, minute: repeatDate.minute! + 5, weekday: repeatDate.weekday!)
                    let snoozeIdentifier = "Snooze" + "\(snoozeDate.weekday!)"
                    let snoozeTrigger = UNCalendarNotificationTrigger(dateMatching: snoozeDate, repeats: true)
                    let snoozeRequest = UNNotificationRequest(identifier: snoozeIdentifier, content: notificationContent, trigger: snoozeTrigger)
                    print(snoozeRequest)
                    notificationCenter.add(snoozeRequest, withCompletionHandler: nil)
                }

            }

        }

    }
}
