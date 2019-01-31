//
//  LoginViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 30/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: BaseViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    //MARK: - Properties
    
    var realm: Realm!
    var user: User?
    var users: Results<User>

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    //MARK: - View setup
    
    func setupView() {
        self.title = "Login"
        
        tfPassword.isSecureTextEntry = true
        tfPassword.layer.cornerRadius = 4.0
        
        tfEmail.keyboardType = .emailAddress
        tfEmail.layer.cornerRadius = 4.0
        
        do {
            realm = try Realm()
        } catch let error {
         //   handleDefaultError(error)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func onClickEntrar(sender: UIButton) {
        if let email = tfEmail.text {
            if email.isEmpty {
                tfEmail.invalidate()
                tfEmail.layer.borderColor = UIColor.red.cgColor
                showAlert(message: "O campo email é obrigatório!")
                
                return
            }
            
            if !email.isValidEmail() {
                tfEmail.invalidate()
                showAlert(message: "O email informado é inválido!")
                
                return
            }
        }
        
        tfEmail.validate()
        
        if let password = tfPassword.text, password.isEmpty {
            tfPassword.invalidate()
            showAlert(message: "O campo senha é obrigatório!")
            
            return
        }
        
        tfPassword.validate()
        
    }
    
    
    @IBAction func onClickCadastro(sender: UIButton) {
        self.navigationController?.pushViewController(CadastroViewController(), animated: true)
    }
    
}
