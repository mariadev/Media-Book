//
//  ViewController.swift
//  Base
//
//  Created by Maria on 10/12/2020.
//

import UIKit

final class  HomeCollectionViewController: UIViewController {

    var collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())

    let warningView = WarningView()
    let spinner = Spinner()

    let detailViewController = DetailViewController()
    let mediaItemCellIdentifier = "mediaItemCell"

    let mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []

    var state: MediaItemViewControllerState = .ready {
        willSet {
            updateScreenState(newValue: newValue)
        }
    }

    init(mediaItemProvider: MediaItemProvider) {
        self.mediaItemProvider =  mediaItemProvider
        super.init(nibName: nil, bundle: nil)
        title = ControllerName.home

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        appyTheme()
        setupLayout()

        collection.register(MediaItemCollectionViewCell.self, forCellWithReuseIdentifier: mediaItemCellIdentifier)
        collection.dataSource = self
        collection.delegate = self

        state = .loading
        spinner.showActivityIndicatory(view: view)

        mediaItemProvider.getHomeMediaItems(onSuccess: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.collection.reloadData()
            self?.state = !mediaItems.isEmpty ? .ready: .noResults

        }) { [weak self] (_) in self?.state =  .failure}
    }

}

extension HomeCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mediaItem =  mediaItems[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider
        present(detailViewController, animated: true, completion: nil)
    }
}

// MARK: Data Source

extension HomeCollectionViewController: UICollectionViewDataSource {

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

// MARK: Set Up Layout

extension HomeCollectionViewController {

    func  setupLayout () {

        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false

        warningView.layoutParentView(parentView: view)

        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: Sizes.collectionWidth, height: Sizes.collectionHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

    }

    func appyTheme() {
        view.backgroundColor = .white
        collection.backgroundColor = .white
    }

}

// MARK: Screen update state

extension HomeCollectionViewController {

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
