//
//  Alarm.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/04/23.
//

import Foundation
import UIKit

struct AlarmData: Codable {

    let date: Date
    let repeatWeekdayFlags: [Bool]
    let snooze: Bool
    let soundName: String

}
