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
        activityView.center = view.center
        view.addSubview(activityView )
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
        
    }
}
