//
//  AppDelegate.swift
//  Base
//
//  Created by Maria on 10/12/2020.
//

import UIKit
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let mediaProvider = MediaItemProvider(withMediaItemType: .book)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()

        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = Colors.brokeWhite

        let homeViewController = HomeCollectionViewController(mediaItemProvider: mediaProvider)
        let  searchViewController = SearchCollectionViewController(mediaItemProvider: mediaProvider)
        let favoritesTableViewController = FavoritesTableViewController()

        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favoritesTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let  homeViewControllerNavigation = homeViewController.wrappedInNavigation()
        let  searchViewControllerNavigation =  searchViewController.wrappedInNavigation()
        let  favoritesTableViewControllerNavigation =   favoritesTableViewController.wrappedInNavigation()

        [homeViewControllerNavigation, searchViewControllerNavigation, favoritesTableViewControllerNavigation].forEach {
          $0.navigationBar.barTintColor = Colors.brokeWhite
            $0.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkGray]
        }

        tabBarController.viewControllers = [
            homeViewControllerNavigation,
            searchViewControllerNavigation,
            favoritesTableViewControllerNavigation ]
        window?.rootViewController = tabBarController

        return true
    }

}
