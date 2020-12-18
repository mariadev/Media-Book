//
//  ViewController.swift
//  Base
//
//  Created by Maria on 10/12/2020.
//

import UIKit

enum MediaItemViewControllerState {
    
    case loading
    case noResults
    case failure
    case ready
}

class HomeViewController: UIViewController {
    
    let warningView = WarningView()
    var collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    
    let mediaItemCellIdentifier = "mediaItemCell"
    
    let mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []
    
    var activityView = UIActivityIndicatorView(style: .large)
    
    var state: MediaItemViewControllerState = .ready {
        willSet {

            updateScreenState(newValue: newValue)
        }
    }
    
    func updateScreenState(newValue: MediaItemViewControllerState) {
        
        guard state != newValue else { return }
        
        [collection, activityView, warningView].forEach { (view) in
            view?.isHidden = true
        }
        
        switch newValue {
        case.loading:
            activityView.isHidden = false
        case.ready:
            collection.isHidden = false
            collection.reloadData()
        default: ()
        }
        warningView.update(state: newValue)
    }
    
    init(mediaItemProvider: MediaItemProvider) {
        self.mediaItemProvider =  mediaItemProvider
        super.init(nibName: nil, bundle: nil)
        title = "Recent"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityView)
        view.addSubview(collection)
        view.addSubview(warningView)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        warningView.translatesAutoresizingMaskIntoConstraints = false
        warningView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        warningView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        state = .loading
        showActivityIndicatory()

        collection.backgroundColor = .white
        collection.register(MediaItemCollectionViewCell.self, forCellWithReuseIdentifier: mediaItemCellIdentifier)
        collection.dataSource = self
        
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 100, height: 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        mediaItemProvider.getHomeMediaItems(onSuccess: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.collection.reloadData()
            self?.state = mediaItems.count > 0 ? .ready: .noResults
            
        }) { [weak self] (error) in
            self?.state =  .failure
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  mediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  mediaItemCellIdentifier, for: indexPath) as?
                MediaItemCollectionViewCell else {
            fatalError()
        }
        
        let mediaItem = mediaItems[indexPath.item]
        cell.mediaItem = mediaItem
        return cell
    }
}

extension HomeViewController {
    
    func showActivityIndicatory() {
        activityView.center = view.center
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
    }
}
