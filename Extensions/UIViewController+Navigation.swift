//
//  UIViewController+Navigation.swift
//  Base
//
//  Created by Maria on 10/12/2020.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
