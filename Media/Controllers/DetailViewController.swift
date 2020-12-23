//
//  DetailViewController.swift
//  Media
//
//  Created by Maria on 18/12/2020.
//

import UIKit

class  DetailViewController: UIViewController {
    
    let selectedMediaItem : MediaItemDetailProvidable
    
    let layout = DetailViewControllerLayout()
    
    
    
    init(selectedMediaItem: MediaItemDetailProvidable) {
        self.selectedMediaItem = selectedMediaItem
        super.init(nibName: nil, bundle: nil)
        title = "detail"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        setUpLayout()
        theme()
        layout.buttonClose.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        layout.mediaItem = selectedMediaItem
    }
    
    @objc func didTapCloseButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        print("close")
        
    }
    
}

extension DetailViewController {
    
    func setUpLayout () {
        
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 64, leading: 0, bottom: 16, trailing: 16)
        view.addSubview(layout)
        
        layout.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        layout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        layout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        layout.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        
    }
    
    func theme () {
        layout.backgroundColor = .systemPink
        view.backgroundColor = .white
    }
}

