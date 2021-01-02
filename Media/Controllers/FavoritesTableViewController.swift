//
//  favoritesTableViewController.swift
//  Media
//
//  Created by Maria on 29/12/2020.
//

import UIKit

class FavoritesTableViewController : UIViewController {
    
    var tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
    let customeTableViewCell = "CustomeTableViewCell"
    var favorites: [MediaItemDetailProvidable] = []
    let detailViewController = DetailViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        setupLayout ()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: customeTableViewCell)
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        return vw
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: customeTableViewCell , for: indexPath) as! CustomTableViewCell
        
        cell.mediaItem = favorites[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

//MARK: Set Up Layout

extension FavoritesTableViewController {
    
    func setupLayout () {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func appyTheme() {
        view.backgroundColor = .white
        tableView.backgroundColor = .systemPink
        
    }
    
}


