//
//  Spinner.swift
//  Media
//
//  Created by Maria on 18/12/2020.
//

import UIKit

final class Spinner {

    var activityView = UIActivityIndicatorView(style: .large)

    func showActivityIndicatory(view: UIView) {
        view.addSubview(activityView )
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.startAnimating()
    }
}
