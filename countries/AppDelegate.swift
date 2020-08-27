//
//  AppDelegate.swift
//  countries
//
//  Created by Кирилл Баюков on 25.08.2020.
//  Copyright © 2020 bayukov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupWindow()
        return true
    }
    
    func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = CountryListAssembly.createVC()
        let nav = UINavigationController(rootViewController: vc)
        CountryListAssembly.configureVC(vc: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }

}

