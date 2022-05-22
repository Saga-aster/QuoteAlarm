//
//  SoundSelectViewController.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/03/26.
//

import UIKit
import AVFoundation

class SoundSelectViewController: UITableViewController {

    let sounds = ["Ambition", "ヴァルス", "オーケストラジングル", "休日はまったり", "START!!", "日曜のラジオ", "日輪の光", "森の中の小鳥のさえずり"]
    var selectSoundFlags = [Bool]()
    var audioPlayer: AVAudioPlayer!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let savedFlags = UserDefaults.standard.object(forKey: "SelectedSoundFlags") as? [Bool] {
            print(savedFlags)
            selectSoundFlags = savedFlags
        } else {
            selectSoundFlags = [true, false, false, false, false, false, false, false]
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sounds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = sounds[indexPath.row]
        cell.contentConfiguration = content

        // 各セルのフラグのtrue/falseをチェックし、結果に応じてチェックマークを付ける/付けない
        if selectSoundFlags[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        changeFlagStatus(row: indexPath.row)
        tableView.reloadData()
        playSound(name: sounds[indexPath.row])

    }

    func changeFlagStatus(row: Int) {

        selectSoundFlags = [false, false, false, false, false, false, false, false]
        selectSoundFlags[row] = true
        UserDefaults.standard.set(selectSoundFlags, forKey: "SelectedSoundFlags")
        UserDefaults.standard.set(sounds[row], forKey: "SoundName")

    }


}

extension SoundSelectViewController: AVAudioPlayerDelegate {
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("サウンドファイルが見つかりません")
            return
        }
        do {
            audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.play()
        } catch  {
            print("再生できませんでした")
        }
    }



}
