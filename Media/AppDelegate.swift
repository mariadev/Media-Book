//
//  AppDelegate.swift
//  Base
//
//  Created by Maria on 10/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let mediaProvider = MediaItemProvider(withMediaItemType: .book)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let tabBarController = TapBarController(mediaProvider: mediaProvider )

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }

}
