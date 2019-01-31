//
//  TabBarController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    //MARK: - Setup
    
    func setupTabBar() {
        let firstVc = UsuariosViewController()
        firstVc.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        let secondVc = AlbunsViewController()
        secondVc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)

        let controllers = [firstVc, secondVc]
        
        viewControllers = controllers.map {UINavigationController(rootViewController: $0)}
    }

}
