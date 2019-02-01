//
//  AppDelegate.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 30/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Properties
    
    var window: UIWindow?
    fileprivate var currentUser: User?
    
    //MARK: - Singleton
    
    static let shared = {
        return UIApplication.shared.delegate as! AppDelegate
    }()

    //MARK: - App Delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
    //MARK: - Getters
    
    func getUser() -> User? {
        return currentUser
    }
    
    //MARK: - Setters
    
    func setUser(_ user: User?) {
        if let u = user {
            currentUser = u
        }
    }

}

