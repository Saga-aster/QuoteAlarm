//
//  UIButton.swift
//  QuoteAlarm
//
//  Created by Saga on 2022/05/01.
//

import UIKit

extension UIButton {

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        self.touchesStartAnimation()
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        self.touchesEndAnimation()
    }

    private func touchesStartAnimation() {
        UIView.animate(withDuration: 0.01, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)

    }

    private func touchesEndAnimation() {
        UIView.animate(withDuration: 0.01, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }

}
