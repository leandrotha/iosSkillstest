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

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
        setupTextFields()
    }
    
    //MARK: - View setup
    
    func setupTextFields() {
        tfPassword.isSecureTextEntry = true
        tfPassword.layer.cornerRadius = 4.0
        
        tfEmail.keyboardType = .emailAddress
        tfEmail.layer.cornerRadius = 4.0
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
                showAlert(message: "O emaiil informado é inválido!")
                
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
