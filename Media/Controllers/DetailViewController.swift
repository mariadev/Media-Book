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
    let bookDetailView = BookDetailView()
    
    var isFavorite: Bool = false
    
    public override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let favorite = StorageManager.shared.getFavorite(byId: mediaItemId) {
            selectedMediaItem = favorite
            syncViewWithModel()
            isFavorite = true
            self.bookDetailView.buttonPreview.setTitle("Remove favorite", for: .normal)
            
        } else {
            isFavorite = false
            self.bookDetailView.buttonPreview.setTitle("Add favorite", for: .normal)
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
        
        bookDetailView.update(model: retireveMediaItem)
        bookDetailView.buttonClose.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        bookDetailView.buttonPreview.addTarget(self, action: #selector(didTapToggleFavorite), for: .touchUpInside)
 
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
            self.bookDetailView.buttonPreview.setTitle("Remove favorite", for: .normal) //poner en una constante
        } else {
            StorageManager.shared.remove(favoriteWithId: favorite.mediaItemId)
            self.bookDetailView.buttonPreview.setTitle("Add favorite", for: .normal)
        }
        
    }
}


