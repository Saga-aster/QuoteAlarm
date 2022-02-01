//
//  RepeatSettingViewController.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/01/23.
//

import UIKit

class RepeatSettingViewController: UIViewController {

    enum DayOfTheWeek: Int {

        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7

    }

    @IBOutlet weak var tableView: UITableView!

    let dayOfTheWeek = ["月曜日","火曜日","水曜日","木曜日","金曜日","土曜日","日曜日"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

    }

}

extension RepeatSettingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayOfTheWeek.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // セルのテキスト設定
        var content = cell.defaultContentConfiguration()
        content.text = dayOfTheWeek[indexPath.row]
        cell.contentConfiguration = content

        // 前回選択されたセルがあったのであれば、チェックマークをつけておく

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // 選択されたセルにチェックマークをつけるorチェックマークを外す

    }

}
