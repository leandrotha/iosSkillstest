//
//  ImageViewExtension.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 01/02/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    func downloadImage(url: URL?) {
        guard let requestUrl = url else {return}
        
        URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            data, respone, error in
            if let err = error {
                print(err.localizedDescription)
            }
            
            if let imageData = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }).resume()
    }
}
