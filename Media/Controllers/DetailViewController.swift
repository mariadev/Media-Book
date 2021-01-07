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
    var isFavorite: Bool = false
    
    let bookDetailView = BookDetailView()
    
    let spinner = Spinner()
    let warningView = WarningView()
    
    var state: MediaItemViewControllerState = .ready {
        willSet {
            updateScreenState(newValue: newValue)
        }
    }
    
    public override func loadView() {
        view = bookDetailView
        
    }
    
    override func viewDidLoad() {
        spinner.showActivityIndicatory(view: view)
        warningView.layoutParentView(parentView: view)
        state = .loading
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let favorite = StorageManager.shared.getFavorite(byId: mediaItemId) {
            selectedMediaItem = favorite
            syncViewWithModel()
            isFavorite = true
            self.bookDetailView.buttonFavorite.setTitle("Remove favorite", for: .normal)
            
        } else {
            isFavorite = false
            self.bookDetailView.buttonFavorite.setTitle("Add favorite", for: .normal)
            mediaItemProvider.getMediaItem(byId: mediaItemId, success: { [weak self] (selectedMediaItem) in
                self?.selectedMediaItem = selectedMediaItem
                self?.syncViewWithModel()
                
            }) { [weak self] (error) in
                let alertController = UIAlertController(title: nil, message: "Can not retrive media item", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: {(_) in
                    self?.dismiss(animated: true, completion: nil)
                }))
                self?.present(alertController, animated: true, completion: nil)
                self?.state =  .failure
                
            }
        }
        
    }
    
    private func syncViewWithModel() {
        guard let retireveMediaItem =  selectedMediaItem else {
            return
        }
        
        bookDetailView.update(model: retireveMediaItem)
        bookDetailView.buttonClose.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        bookDetailView.buttonFavorite.addTarget(self, action: #selector(didTapToggleFavorite), for: .touchUpInside)
        
        state = .ready
    }
    
    @objc func didTapCloseButton(_ sender: Any) {
        //        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        state = .loading
        
    }
    
    @objc func  didTapToggleFavorite(_ sender: Any) {
        guard let favorite = selectedMediaItem else {
            return
        }
        
        isFavorite.toggle()
        //
        if  isFavorite {
            StorageManager.shared.add(favorite: favorite)
            self.bookDetailView.buttonFavorite.setTitle("Remove favorite", for: .normal) //poner en una constante
        } else {
            StorageManager.shared.remove(favoriteWithId: favorite.mediaItemId)
            self.bookDetailView.buttonFavorite.setTitle("Add favorite", for: .normal)
        }
        
    }
}


//MARK: Screen update state

extension DetailViewController {
    
    func updateScreenState(newValue: MediaItemViewControllerState) {
        
        guard state != newValue else { return }
        
        [bookDetailView.bookCoverAndDetailStackView, bookDetailView.title, bookDetailView.bookDescription,spinner.activityView, warningView].forEach {
            $0.isHidden = true
        }
        switch newValue {
        case.loading:
            spinner.activityView.isHidden = false
        case.ready:
            [bookDetailView.bookCoverAndDetailStackView, bookDetailView.title, bookDetailView.bookDescription].forEach {
                $0.isHidden = false
            }
            spinner.activityView.stopAnimating()
            
        default: ()
        }
        warningView.update(state: newValue)
    }
}
