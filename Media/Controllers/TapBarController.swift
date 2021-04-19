//
//  TapBarController.swift
//  Media
//
//  Created by Maria on 19/04/2021.
//

import UIKit

final class TapBarController: UITabBarController {

    let mediaProvider: MediaItemProvider!

    init(mediaProvider: MediaItemProvider) {
        self.mediaProvider =  mediaProvider
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.tabBar.barTintColor = Colors.brokeWhite
        
        let homeViewController = HomeCollectionViewController(mediaItemProvider: mediaProvider)
        let searchViewController = SearchCollectionViewController(mediaItemProvider: mediaProvider)
        let favoritesTableViewController = FavoritesViewController()

        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favoritesTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let  homeViewControllerNavigation = UINavigationController(rootViewController: homeViewController)
        let  searchViewControllerNavigation = UINavigationController(rootViewController: searchViewController)
        let  favoritesTableViewControllerNavigation = UINavigationController(rootViewController: favoritesTableViewController)

        [homeViewControllerNavigation, searchViewControllerNavigation, favoritesTableViewControllerNavigation].forEach {
            $0.navigationBar.barTintColor = Colors.brokeWhite
            $0.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkGray]
        }

       self.viewControllers = [
            homeViewControllerNavigation,
            searchViewControllerNavigation,
            favoritesTableViewControllerNavigation ]
    }

}
