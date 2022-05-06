//
//  Converter.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/04/23.
//

import Foundation

class Converter {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    func encode(_ alarmData: AlarmData) -> Data? {

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try? encoder.encode(alarmData)

    }

    func decode(_ alarmData: Data) -> AlarmData? {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(AlarmData.self, from: alarmData)
        
    }

}
