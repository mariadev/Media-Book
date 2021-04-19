//
//  favoritesTableViewController.swift
//  Media
//
//  Created by Maria on 29/12/2020.
//

import UIKit

final class FavoritesViewController: UIViewController {

    var tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
    let customeTableViewCell = "CustomeTableViewCell"
    var favorites: [MediaItemDetailProvidable] = []
    let detailViewController = DetailViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
        title = ControllerName.favorites
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

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaItem =  favorites[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        present(detailViewController, animated: true, completion: nil)
    }
}

// MARK: - Table view data source

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: customeTableViewCell, for: indexPath) as! CustomFavoritesTableViewCell
        cell.update(model: favorites[indexPath.row])
        cell.contentView.backgroundColor =  UIColor.white
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Sizes.tableView
    }

}

// MARK: Set Up Layout

extension FavoritesViewController {

    func setupLayout () {
        view.addSubview(tableView)
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: Margins.large, bottom: 0, right: Margins.large)
    }

    func appyTheme() {
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

    }

}
