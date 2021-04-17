//
//  favoritesTableViewController.swift
//  Media
//
//  Created by Maria on 29/12/2020.
//

import UIKit

class FavoritesTableViewController: UIViewController {

    var tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
    let customeTableViewCell = "CustomeTableViewCell"
    var favorites: [MediaItemDetailProvidable] = []
    let detailViewController = DetailViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Favorites"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        if let storedFavorites = StorageManager.shared.getFavorites() {
            favorites = storedFavorites
            tableView.reloadData()
        }
        appyTheme()
        setupLayout()
        tableView.register(CustomFavoritesTableViewCell.self, forCellReuseIdentifier: customeTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension FavoritesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaItem =  favorites[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        present(detailViewController, animated: true, completion: nil)
    }
}

// MARK: - Table view data source

extension FavoritesTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: customeTableViewCell, for: indexPath) as! CustomFavoritesTableViewCell
        cell.update(model: favorites[indexPath.row])
        cell.contentView.backgroundColor =  UIColor.white
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

// MARK: Set Up Layout

extension FavoritesTableViewController {

    func setupLayout () {
        view.addSubview(tableView)
    }

    func appyTheme() {
        view.backgroundColor = UIColor.white
        view.frame =  view.frame.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .white

    }

}
