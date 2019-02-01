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

let downloader = ImageDownloader(configuration: .default, downloadPrioritization: .fifo, maximumActiveDownloads: 5, imageCache: AutoPurgingImageCache())

extension UIImageView {
    
    func downloadImage(url: URL?) {
        guard let urlRequest = url else {return}
        
        image = nil
        
        downloader.download(URLRequest(url: urlRequest)) { response in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
