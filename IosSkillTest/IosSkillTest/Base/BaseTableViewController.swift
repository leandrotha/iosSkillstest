//
//  BaseTableViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    //MARK: - Methods
    
    func showAlertWithCancel(message: String, title: String? = "Atenção!" , okHandler: Action? = nil, cancelHandler: Action? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: okHandler ?? { action in
            self.dismiss(animated: true, completion: nil)
            })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: cancelHandler ?? { action in
            self.dismiss(animated: true, completion: nil)
            })
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String, title: String? = "Atenção!" , okHandler: Action? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: okHandler ?? { action in
            self.dismiss(animated: true, completion: nil)
            })
        
        alert.addAction(action)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func handleDefaultError(_ error: Error) {
        print(error.localizedDescription)
        showAlert(message: "Algo de errado aconteceu, por favor, tente novamente mais tarde ):")
    }

}
