//
//  AlarmSettingViewController.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/03/26.
//

import UIKit

class AlarmSettingViewController: UITableViewController {

    @IBOutlet private weak var repeatSettingStatusLabel: UILabel!
    @IBOutlet private weak var currentSelectedSoundLabel: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var snoozeStatusSwitch: UISwitch!
    var repeatWeekdayFlags = [Bool]()
    var soundName = String()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 選択された繰り返し設定の取得
        if let savedRepeatWeekdayFlags = UserDefaults.standard.object(forKey: "RepeatFlags") as? [Bool] {
            repeatWeekdayFlags = savedRepeatWeekdayFlags
            if repeatWeekdayFlags[0] {
                repeatSettingStatusLabel.text = "なし"
            } else {
                repeatSettingStatusLabel.text = "あり"
            }
        } else {
            repeatWeekdayFlags = [true, false, false, false, false, false, false, false]
            repeatSettingStatusLabel.text = "なし"
        }

        // 選択されたサウンドの取得
        if let savedSelectedSoundName = UserDefaults.standard.object(forKey: "SoundName") as? String {
            soundName = savedSelectedSoundName
            currentSelectedSoundLabel.text = soundName
        } else {
            soundName = "Ambition"
            currentSelectedSoundLabel.text = soundName
        }

        // 繰り返し設定の有無に応じてラベルを「あり」「なし」にする
        if repeatWeekdayFlags[0] == true {
            repeatSettingStatusLabel.text = "なし"
        } else {
            repeatSettingStatusLabel.text = "あり"
        }

        currentSelectedSoundLabel.text = soundName

    }


    @IBAction func cancelButtonTapped(_ sender: Any) {

        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }

    @IBAction func saveButtonTapped(_ sender: Any) {

        let alarmData = AlarmData(date: datePicker.date, repeatWeekdayFlags: repeatWeekdayFlags, snooze: snoozeStatusSwitch.isOn, soundName: soundName)
        let alarmSetting = AlarmSetting()
        alarmSetting.setAlarm(alarmData: alarmData)
        let encodedAlarmData = Converter().encode(alarmData)
        UserDefaults.standard.setValue(encodedAlarmData, forKey: "AlarmData")
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }

    // MARK: - TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 1:
            let repeatSettingVC = storyboard?.instantiateViewController(withIdentifier: "RepeatSettingVC") as! RepeatSettingViewController
            navigationController?.pushViewController(repeatSettingVC, animated: true)

        case 3:
            let soundSelectVC = storyboard?.instantiateViewController(withIdentifier: "SoundSelectVC") as! SoundSelectViewController
            navigationController?.pushViewController(soundSelectVC, animated: true)
        default:
            break
        }

    }

}
