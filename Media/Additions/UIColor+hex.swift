//
//  UIColor+hex.swift
//  Media
//
//  Created by Maria on 07/01/2021.
//

import UIKit

extension UIColor {

    /// Usage: UIColor(hex: 0xFFBABE)
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R,
                  green: components.G,
                  blue: components.B,
                  alpha: 1)
    }
}
