//
//  DetailViewController.swift
//  Media
//
//  Created by Maria on 18/12/2020.
//

import UIKit

class  DetailViewController: UIViewController {
    
    var selectedMediaItem : MediaItemDetailProvidable?
    var mediaItemProvider: MediaItemProvider! //deberia ser opcional
    var mediaItemId: String!
    let layout = DetailViewControllerLayout()
    
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let favorite = StorageManager.shared.getFavorite(byId: mediaItemId) {
            selectedMediaItem = favorite
            syncViewWithModel()
            isFavorite = true
            self.layout.buttonPreview.setTitle("Remove favorite", for: .normal)

        } else {
            isFavorite = false
            self.layout.buttonPreview.setTitle("Add favorite", for: .normal)
            mediaItemProvider.getMediaItem(byId: mediaItemId, success: { [weak self] (selectedMediaItem) in
                self?.selectedMediaItem = selectedMediaItem
                self?.syncViewWithModel()
                
            }) { [weak self] (error) in
                let alertController = UIAlertController(title: nil, message: "Can not retrive media item", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: {(_) in
                    self?.dismiss(animated: true, completion: nil)
                }))
                self?.present(alertController, animated: true, completion: nil)
                
            }
        }
        
    }
    
    private func syncViewWithModel() {
        
        guard let retireveMediaItem =  selectedMediaItem else {
            return
        }
        
        layout.mediaItem = retireveMediaItem
        layout.buttonClose.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        layout.buttonPreview.addTarget(self, action: #selector(didTapToggleFavorite), for: .touchUpInside)
        setUpLayout()
        theme()
    }
    
    @objc func didTapCloseButton(_ sender: Any) {
        //        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func  didTapToggleFavorite(_ sender: Any) {
        guard let favorite = selectedMediaItem else {
            return
        }
        
        isFavorite.toggle()
//
        if  isFavorite {
            StorageManager.shared.add(favorite: favorite)
            self.layout.buttonPreview.setTitle("Remove favorite", for: .normal) //poner en una constante
        } else {
            StorageManager.shared.remove(favoriteWithId: favorite.mediaItemId)
            self.layout.buttonPreview.setTitle("Add favorite", for: .normal)
        }
        
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

