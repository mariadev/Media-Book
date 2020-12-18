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

class  HomeViewController: UIViewController {
    
    let failureEmoji =  UILabel()
    let failureEmojiText =  UILabel()
    var stackFailureEmoji =  UIStackView()
    var collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    
    let mediaItemCellIdentifier = "mediaItemCell"
    
    let mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []
    
    var activityView = UIActivityIndicatorView(style: .large)
    
    var state: MediaItemViewControllerState = .ready {
        willSet {
            
            guard state != newValue else {return}
            
            [collection,activityView, stackFailureEmoji].forEach { (view) in
                view?.isHidden = true
            }
            
            switch newValue {
            case.loading:
                activityView.isHidden = false
            case .noResults:
                stackFailureEmoji.isHidden = false
                failureEmojiText.text = "no Results"
            case.failure:
                stackFailureEmoji.isHidden = false
                print("fail")
                failureEmojiText.text = "Conexion Error"
                failureEmoji.text = "❌"
                
            case.ready:
                collection.isHidden = false
                collection.reloadData()
            }
        }
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
        
        state = .loading
        showActivityIndicatory()
        showFailureEmoji()
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collection)
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

extension HomeViewController: UICollectionViewDelegate {
    
}

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
        activityView.center = self.view.center
        self.view.addSubview(activityView )
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
        
    }
    
}

extension HomeViewController {
    
    func showFailureEmoji() {
        let emojiView = UIView()
        self.view.addSubview(emojiView )
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.backgroundColor = .white
        NSLayoutConstraint.activate([
            
            emojiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emojiView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor),
            emojiView.topAnchor.constraint(equalTo: self.view.topAnchor),
            emojiView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
        stackFailureEmoji = UIStackView(arrangedSubviews: [failureEmoji, failureEmojiText])
        stackFailureEmoji.axis = .vertical
        emojiView.addSubview(stackFailureEmoji)
        stackFailureEmoji.backgroundColor = .white
        stackFailureEmoji.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackFailureEmoji.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            stackFailureEmoji.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor),
        ])
        
        failureEmoji.text = "😞"
        failureEmoji.font = UIFont.systemFont(ofSize: 30)
        failureEmoji.translatesAutoresizingMaskIntoConstraints = false
        failureEmoji.textAlignment = .center
        
        failureEmojiText.text = "Conexion Fail"
        failureEmojiText.font = UIFont.systemFont(ofSize: 30)
        failureEmojiText.textAlignment = .center
        
    }
    
}


