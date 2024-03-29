//
//  SearchViewController.swift
//  Media
//
//  Created by Maria on 17/12/2020.
//
import UIKit

final class  SearchCollectionViewController: UIViewController {

    var collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    let searchBar = UISearchController(searchResultsController: nil).searchBar
    let detailViewController = DetailViewController()

    let mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []

    let mediaItemCellIdentifier = "mediaItemCell"
    let warningView = WarningView()
    let spinner = Spinner()

    var state: MediaItemViewControllerState = .ready {
        willSet {
            updateScreenState(newValue: newValue)
        }
    }

    init(mediaItemProvider: MediaItemProvider) {
        self.mediaItemProvider =  mediaItemProvider
        super.init(nibName: nil, bundle: nil)
        title = ControllerName.search

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        state = .ready
    }

    override func viewDidLoad() {

        collection.register(MediaItemCollectionViewCell.self, forCellWithReuseIdentifier: mediaItemCellIdentifier)
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerSearch")
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.delegate = self
        searchBar.barTintColor = .white

        spinner.showActivityIndicatory(view: view)
        state = .loading

        appyTheme()
        setupLayout()

    }

}

extension SearchCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        state = .loading

        guard let queryParams = searchBar.text, !queryParams.isEmpty else {
            return
        }

        mediaItemProvider.getSearchMediaItems(withQueryParams: queryParams, success: {[weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.collection.reloadData()
            self?.state = !mediaItems.isEmpty ? .ready: .noResults

        }) { [weak self] _ in self?.state =  .failure }

    }
}

extension SearchCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mediaItem =  mediaItems[indexPath.row]

        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider

        present(detailViewController, animated: true, completion: nil)
    }

}

extension SearchCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellIdentifier, for: indexPath) as?
                MediaItemCollectionViewCell else {
            fatalError()
        }

        let mediaItem = mediaItems[indexPath.item]
        cell.mediaItem = mediaItem
        return cell
    }
}

// MARK: Search Bar

extension SearchCollectionViewController {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerSearch", for: indexPath)
        header.addSubview(searchBar)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        searchBar.backgroundColor = .white
        return header
    }

}

// MARK: Set Up Layout

extension SearchCollectionViewController {

    func setupLayout () {

        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false

        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: Sizes.collectionWidth, height: Sizes.collectionHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)

        warningView.layoutParentView(parentView: view)
    }

    func appyTheme() {
        view.backgroundColor =  UIColor.white
        collection.backgroundColor =  UIColor.white
    }

}

// MARK: Screen update state

extension SearchCollectionViewController {

    func updateScreenState(newValue: MediaItemViewControllerState) {

        guard state != newValue else { return }

        [collection, spinner.activityView, warningView].forEach {
            $0.isHidden = true
        }

        switch newValue {
        case.loading:
            spinner.activityView.isHidden = false
        case.ready:
            collection.isHidden = false
            collection.reloadData()
            spinner.activityView.stopAnimating()
        default: ()
        }
        warningView.update(state: newValue)
    }
}
