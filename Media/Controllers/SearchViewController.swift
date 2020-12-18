//
//  SearchViewController.swift
//  Media
//
//  Created by Maria on 17/12/2020.
//


import UIKit


class  SearchViewController: UIViewController {
    
    var collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    let searchBar = UISearchController(searchResultsController: nil).searchBar
    
    private var mediaItems: [MediaItemProvidable] = []
    let mediaItemCellIdentifier = "mediaItemCell"
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Search"
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collection)
        collection.backgroundColor = .systemPink
        collection.register(MediaItemCollectionViewCell.self, forCellWithReuseIdentifier: mediaItemCellIdentifier)
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerSearch")
        
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 100, height: 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)
        
    }
    

    
}




extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerSearch", for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
    return header
}
    
    
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

