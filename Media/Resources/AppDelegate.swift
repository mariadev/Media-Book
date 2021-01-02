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
        
        let homeViewController = HomeViewController(mediaItemProvider: mediaProvider)
        let  searchViewController = SearchViewController(mediaItemProvider: mediaProvider)
        let favoritesTableViewController = FavoritesTableViewController()
        
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favoritesTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        tabBarController.viewControllers = [
            homeViewController.wrappedInNavigation(),
            searchViewController.wrappedInNavigation(),
            favoritesTableViewController.wrappedInNavigation() ]
        
        window?.rootViewController = tabBarController
        return true
    }

}

