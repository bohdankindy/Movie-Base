//
//  AppDelegate.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 07.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FavoriteMovies.shared.restoreFavoriteMovies()
        return true
    }
}

