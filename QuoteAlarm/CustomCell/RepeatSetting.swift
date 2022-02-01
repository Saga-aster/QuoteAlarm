//
//  RepeatSetting.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/01/09.
//

import UIKit

class RepeatSetting: UITableViewCell {

    var delegate: TransitionDelegate?

    @IBAction func buttonTapped(_ sender: Any) {

        delegate?.transition()

    }
    
}
