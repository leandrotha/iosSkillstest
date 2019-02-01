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
        firstVc.tabBarItem = UITabBarItem(title: "Usuários", image: UIImage(named: "Users"), selectedImage: UIImage(named: "Users"))
        
        let secondVc = AlbunsViewController()
        secondVc.tabBarItem = UITabBarItem(title: "Álbuns", image: UIImage(named: "Albuns"), selectedImage: UIImage(named: "Albuns"))
        
        let thirdVc = CadastroViewController()
        thirdVc.tabBarItem = UITabBarItem(title: "Cadastro", image: UIImage(named: "Add Users"), selectedImage: UIImage(named: "Add Users"))
        thirdVc.shouldSuper = true

        let controllers = [firstVc, secondVc, thirdVc]
        
        viewControllers = controllers.map {UINavigationController(rootViewController: $0)}
    }

}
