//
//  TopViewController.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/03/26.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet private weak var alarmTimeLabel: UILabel!
    @IBOutlet private weak var alarmStatusSwitch: UISwitch!
    @IBOutlet private weak var alarmTimeTitleLabel: UILabel!
    @IBOutlet private weak var alarmSettingButton: UIButton!
    private var alertController: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let savedAlarmTime = UserDefaults.standard.object(forKey: "AlarmTime") as? String {
            alarmTimeLabel.font = UIFont.systemFont(ofSize: 60.0)
            alarmTimeLabel.text = savedAlarmTime
        } else {
            alarmTimeLabel.font = UIFont.systemFont(ofSize: 45.0)
            alarmTimeLabel.text = "未設定"
            alarmTimeTitleLabel.alpha = 0.1
            alarmTimeLabel.alpha = 0.1
            alarmStatusSwitch.isOn = false
        }

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getPendingNotificationRequests { requests in

            DispatchQueue.main.async {
                if requests.isEmpty {
                    self.alarmTimeTitleLabel.alpha = 0.1
                    self.alarmTimeLabel.alpha = 0.1
                    self.alarmStatusSwitch.isOn = false

                } else {
                    self.alarmTimeTitleLabel.alpha = 1.0
                    self.alarmTimeLabel.alpha = 1.0
                    self.alarmStatusSwitch.isOn = true
                }
            }

        }

    }

    @IBAction func alarmStatusChanged(_ sender: UISwitch) {

        if sender.isOn {
            // UserDefaultsにアラーム設定データが入っているか
            if let savedAlarmData = UserDefaults.standard.object(forKey: "AlarmData") as? Data {
                let alarmData = Converter().decode(savedAlarmData)
                let alarmSetting = AlarmSetting()
                alarmSetting.setAlarm(alarmData: alarmData!)
                alarmTimeTitleLabel.alpha = 1.0
                alarmTimeLabel.alpha = 1.0
            } else {
                // アラーム未設定の表示
                alert(title: "アラーム設定情報がありません",
                      message: "[アラーム設定]ボタンより、アラーム設定を行ってください")
                sender.isOn = false
            }

        } else {
            // 予定されている通知データを削除（アラーム設定データはUserDefaultsに残しておく）
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.removeAllPendingNotificationRequests()
            alarmTimeTitleLabel.alpha = 0.1
            alarmTimeLabel.alpha = 0.1
        }

    }

    func alert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

}
