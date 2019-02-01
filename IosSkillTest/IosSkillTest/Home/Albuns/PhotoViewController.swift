//
//  PhotoViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 01/02/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

class PhotoViewController: BaseViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var ivPhoto: UIImageView!
    
    //MARKL - Properties
    
    var url: String?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Foto"
        fetchPhoto()
    }
    
    //MARK: - Methods
    
    func fetchPhoto() {
        guard let request = url, let urlRequest = URL(string: request) else {
            handleDefaultError(NSError())
            return
        }
        
        ivPhoto.downloadImage(url: urlRequest)
    }
}
