//
//  RepeatSettingViewController.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/03/26.
//

import UIKit

class RepeatSettingViewController: UITableViewController {

    let repeatWeekdayLabels = ["なし", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"]
    var repeatWeekdayFlags = [true, false, false, false, false, false, false, false]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let savedFlags = UserDefaults.standard.object(forKey: "RepeatFlags") as? [Bool] {
            print(savedFlags)
            repeatWeekdayFlags = savedFlags
        } else {
            print("保存されたフラグはありません")
        }


    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return repeatWeekdayLabels.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = repeatWeekdayLabels[indexPath.row]
        cell.contentConfiguration = content

        // 各セルのフラグのtrue/falseをチェックし、結果に応じてチェックマークを付ける/付けない
        if repeatWeekdayFlags[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        changeFlagStatus(row: indexPath.row)
        tableView.reloadData()

    }

    // フラグ切り替え
    func changeFlagStatus(row: Int) {
        if row == 0 {
            repeatWeekdayFlags[0] = true
            repeatWeekdayFlags[1...] = [false, false, false, false, false, false, false]
            UserDefaults.standard.setValue(repeatWeekdayFlags, forKey: "RepeatFlags")
            print(repeatWeekdayFlags)
        } else {
            repeatWeekdayFlags[0] = false
            repeatWeekdayFlags[row].toggle()
            UserDefaults.standard.setValue(repeatWeekdayFlags, forKey: "RepeatFlags")
        }

        if repeatWeekdayFlags[1...] == [false, false, false, false, false, false, false] {
            repeatWeekdayFlags[0] = true
            UserDefaults.standard.setValue(repeatWeekdayFlags, forKey: "RepeatFlags")
        }

    }

}
