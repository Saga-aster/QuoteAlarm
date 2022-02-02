//
//  AlarmSettingViewController.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/01/22.
//

import UIKit

class AlarmSettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    enum Cell: Int, CaseIterable {
        case alarmSwitch
        case alarmTimeSetting
        case repeatSetting
        case alarmSoundSetting
        case vibrationSetting

        var cellIdentifier: String {
            switch self {
            case .alarmSwitch:
                return "AlarmSwitch"
            case .alarmTimeSetting:
                return "AlarmTimeSetting"
            case .repeatSetting:
                return "RepeatSetting"
            case .alarmSoundSetting:
                return "AlarmSoundSetting"
            case .vibrationSetting:
                return "VibrationSetting"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AlarmSwitch", bundle: nil), forCellReuseIdentifier: "AlarmSwitch")
        tableView.register(UINib(nibName: "AlarmTimeSetting", bundle: nil), forCellReuseIdentifier: "AlarmTimeSetting")
        tableView.register(UINib(nibName: "RepeatSetting", bundle: nil), forCellReuseIdentifier: "RepeatSetting")
        tableView.register(UINib(nibName: "AlarmSoundSetting", bundle: nil), forCellReuseIdentifier: "AlarmSoundSetting")
        tableView.register(UINib(nibName: "VibrationSetting", bundle: nil), forCellReuseIdentifier: "VibrationSetting")

    }

}

extension AlarmSettingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("セルのカウント: \(Cell.allCases.count)")
        return Cell.allCases.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellType = Cell(rawValue: indexPath.row)!

        switch cellType {
        case .alarmSwitch:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! AlarmSwitch
            return cell
        case .alarmTimeSetting:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! AlarmTimeSetting
            return cell
        case .repeatSetting:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! RepeatSetting
            return cell
        case .alarmSoundSetting :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! AlarmSoundSetting
            return cell
        case .vibrationSetting:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! VibrationSetting
            return cell

        }

    }

}
